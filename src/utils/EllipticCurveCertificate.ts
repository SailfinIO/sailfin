import {
  ALGORITHM_DETAILS_MAP,
  CURVE_OIDS,
} from '../constants/algorithmConstants';
import {
  ISubjectPublicKeyInfo,
  ITbsCertificate,
  IValidity,
} from '../interfaces';
import { Certificate } from './Certificate';
import { derNull, objectIdentifier } from './derUtils';
import { ecJwkToSpki } from './ecKeyUtils';

export class EllipticCurveCertificate extends Certificate {
  private crv: string;
  private x: string;
  private y: string;

  constructor(
    subjectName: string,
    validity: IValidity,
    privateKeyPem: string,
    crv: string,
    x: string,
    y: string,
  ) {
    super(subjectName, validity, privateKeyPem);
    this.crv = crv;
    this.x = x;
    this.y = y;
  }

  buildSubjectPublicKeyInfo(): ISubjectPublicKeyInfo {
    // 1) Convert from JWK (crv, x, y) to an SPKI buffer
    const spkiBuffer = ecJwkToSpki(this.crv, this.x, this.y);

    // 2) In your code, you’re extracting the "BIT STRING" portion:
    const bitStringTag = 0x03;
    const index = spkiBuffer.indexOf(bitStringTag);
    if (index < 0) {
      throw new Error('BIT STRING not found in SPKI buffer');
    }
    const subjectPublicKey = spkiBuffer.subarray(index);

    // 3) Retrieve the OID to use in the SubjectPublicKeyInfo’s algorithm identifier.
    //    Typically "1.2.840.10045.2.1" for EC public keys.
    //    If the user’s chosen "algorithm" is ES256, ES384, etc., your map entry
    //    can store `publicKeyOid: '1.2.840.10045.2.1'`.
    const algDetails = ALGORITHM_DETAILS_MAP[this.algorithm];
    const publicKeyOid = algDetails.publicKeyOid || '1.2.840.10045.2.1'; // fallback if not defined

    // 4) Build the final SPKI representation
    return {
      algorithm: {
        algorithm: publicKeyOid, // e.g. "1.2.840.10045.2.1"
        // The "parameters" field is typically the specific curve OID,
        // e.g. "1.2.840.10045.3.1.7" for P-256
        parameters: objectIdentifier(CURVE_OIDS[this.crv]),
      },
      subjectPublicKey,
    };
  }

  buildTbsCertificate(spki: ISubjectPublicKeyInfo): ITbsCertificate {
    // 1) Grab the signature OID from the algorithm details map.
    //    For ES256, that’s typically "1.2.840.10045.4.3.2" (ecdsa-with-SHA256).
    const algDetails = ALGORITHM_DETAILS_MAP[this.algorithm];
    if (!algDetails.signatureOid) {
      throw new Error(
        `Algorithm ${this.algorithm} does not specify a valid ECDSA signature OID.`,
      );
    }
    const signatureOID = algDetails.signatureOid;

    // 2) ECDSA typically uses NULL or zero-length parameters
    const signatureParams = derNull();

    // 3) Delegate the rest to the shared base method
    return this.buildBaseTbsCertificate(spki, signatureOID, signatureParams);
  }
}
