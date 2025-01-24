import { ALGORITHM_DETAILS_MAP } from '../constants/algorithmConstants';
import {
  ISubjectPublicKeyInfo,
  ITbsCertificate,
  IValidity,
} from '../interfaces';
import { Certificate } from './Certificate';
import { base64UrlDecode } from './urlUtils';
import {
  integer,
  bitString,
  sequence,
  objectIdentifier,
  derNull,
} from './derUtils';
import { buildRSAPSSParams } from './certUtils';
import { DERTag } from '../enums';

export class RSACertificate extends Certificate {
  private n: string;
  private e: string;

  constructor(
    subjectName: string,
    validity: IValidity,
    privateKeyPem: string,
    n: string,
    e: string,
  ) {
    super(subjectName, validity, privateKeyPem);
    this.n = n;
    this.e = e;
  }

  buildSubjectPublicKeyInfo(): ISubjectPublicKeyInfo {
    // 1) Decode modulus and exponent from base64url
    const modulus = base64UrlDecode(this.n);
    const exponent = base64UrlDecode(this.e);

    // 2) Build a small DER INTEGER sequence: SEQUENCE { modulus, exponent }
    const modInt = integer(modulus);
    const expInt = integer(exponent);
    const rsaPubKeySeq = sequence(Buffer.concat([modInt, expInt]));

    // 3) Get the publicKeyOid (e.g., "1.2.840.113549.1.1.1" for rsaEncryption)
    //    from your map. If the user is using "RS256", you can do:
    const algDetails = ALGORITHM_DETAILS_MAP[this.algorithm];
    const publicKeyOid =
      algDetails.publicKeyOid ||
      ALGORITHM_DETAILS_MAP.RSA_PUBLIC_KEY.publicKeyOid;
    // (fallback to "RSA_PUBLIC_KEY" if the chosen algorithm has no publicKeyOid)

    if (!publicKeyOid) {
      throw new Error(
        `No publicKeyOid found for algorithm: ${this.algorithm} (RSA).`,
      );
    }

    // 4) Create the algorithm identifier for the SPKI:
    //    SEQUENCE { OBJECT IDENTIFIER rsaEncryption, NULL }
    const algId = sequence(
      Buffer.concat([objectIdentifier(publicKeyOid), derNull()]),
    );

    // 5) Wrap the RSA public key bits in a DER BIT STRING and embed them in SPKI
    const rsaPubKeyBitString = bitString(rsaPubKeySeq);
    const spkiBuffer = sequence(Buffer.concat([algId, rsaPubKeyBitString]));

    // 6) Extract the BIT STRING portion (simplistic approach)
    const bitStringTag = DERTag.BIT_STRING;
    const index = spkiBuffer.indexOf(bitStringTag);
    if (index < 0) {
      throw new Error('BIT STRING not found in SPKI buffer');
    }
    const subjectPublicKey = spkiBuffer.subarray(index);

    return {
      algorithm: {
        algorithm: publicKeyOid,
        parameters: derNull(),
      },
      subjectPublicKey,
    };
  }

  buildTbsCertificate(spki: ISubjectPublicKeyInfo): ITbsCertificate {
    // 1) Look up the signature details (for the cert's signatureAlgorithm)
    const algDetails = ALGORITHM_DETAILS_MAP[this.algorithm];
    if (!algDetails.signatureOid) {
      throw new Error(
        `Algorithm ${this.algorithm} does not specify a valid RSA signature OID.`,
      );
    }

    let signatureOID = algDetails.signatureOid;
    let signatureParams = derNull();

    // 2) Handle RSA-PSS
    if (algDetails.cryptoAlg === 'RSA-PSS') {
      // Build the PSS parameter block
      const saltLen = algDetails.options?.saltLength ?? 32;
      signatureParams = buildRSAPSSParams(algDetails.hashName, saltLen);
    }

    // 3) Delegate to the parent for the "base" TBS structure
    return this.buildBaseTbsCertificate(spki, signatureOID, signatureParams);
  }
}
