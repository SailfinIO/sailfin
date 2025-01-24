import { createHash, createSign } from 'crypto';
import { CertificateOptions } from '../interfaces';
import { X509Certificate } from './x509';
import { pemToDer, wrapPem } from './pem';
import {
  Algorithm,
  BinaryToTextEncoding,
  CertificateLabel,
  DERTag,
} from '../enums';
import {
  asn1Boolean,
  derNull,
  encodeDER,
  integer,
  objectIdentifier,
  sequence,
} from './derUtils';

export const buildAndSignCertificate = (
  options: CertificateOptions,
): string => {
  const { tbsCertificate, signAlgorithm, privateKeyPem } = options;
  // Build TBS certificate DER
  const tbsDer = X509Certificate.buildTbsCertificate(tbsCertificate);

  // Sign TBSCertificate
  const signatureValue = (() => {
    const sign = createSign(signAlgorithm.hashName);
    sign.update(tbsDer);
    sign.end();
    return sign.sign(privateKeyPem);
  })();

  // Create final certificate
  const certInstance = X509Certificate.create(
    tbsCertificate,
    tbsCertificate.signature,
    signatureValue,
  );

  // Build DER-encoded certificate
  const derCert = certInstance.build();

  // Convert DER to PEM format
  const b64Cert = derCert.toString(BinaryToTextEncoding.BASE_64);
  return wrapPem(b64Cert, CertificateLabel.CERTIFICATE);
};

/**
 * Generates the x5t (X.509 Certificate Thumbprint) for JWKS usage.
 * @param pemCertificate - The PEM-encoded certificate.
 * @returns The x5t value as a Base64URL-encoded string.
 */
export const generateX5t = (pemCertificate: string): string => {
  const derCertificate = pemToDer(pemCertificate); // Convert PEM to DER
  const hash = createHash(Algorithm.SHA256).update(derCertificate).digest(); // SHA-256 hash
  return hash.toString(BinaryToTextEncoding.BASE_64_URL); // Base64URL-encode
};

/**
 * Generates the x5c (X.509 Certificate Chain) for JWKS usage.
 * @param pemCertificates - An array of PEM-encoded certificates, ordered from leaf to root.
 * @returns The x5c value as an array of Base64-encoded strings.
 */
export const generateX5c = (pemCertificates: string[]): string[] => {
  return pemCertificates.map((pem) => {
    const derCertificate = pemToDer(pem); // Convert PEM to DER
    return derCertificate.toString(BinaryToTextEncoding.BASE_64); // Base64-encode
  });
};

/**
 * A small helper to encode the BasicConstraints extension.
 * basicConstraints ::= SEQUENCE {
 *   cA                  BOOLEAN DEFAULT FALSE,
 *   pathLenConstraint   INTEGER (0..MAX) OPTIONAL
 * }
 * The extension’s extnValue must be an OCTET STRING around that SEQUENCE.
 */
export const buildBasicConstraints = (
  isCA: boolean,
  pathLenConstraint?: number,
): Buffer => {
  const elements: Buffer[] = [];

  // If cA is TRUE, encode the boolean (if cA is FALSE, some encoders omit it entirely).
  if (isCA) {
    elements.push(asn1Boolean(true)); // equivalent to encodeDER(DERTag.BOOLEAN, Buffer.from([0xff]))
  }

  // Only include pathLenConstraint if cA is true & user supplies a value.
  if (isCA && pathLenConstraint !== undefined) {
    // For an integer, you can build it with your existing integer(...) helper
    elements.push(integer(Buffer.from([pathLenConstraint])));
  }

  // Wrap the SEQUENCE
  const bcSequence = sequence(Buffer.concat(elements));

  // According to X.509, the extnValue itself should be an OCTET STRING containing that sequence
  return encodeDER(DERTag.OCTET_STRING, bcSequence);
};

const OID_RSASSA_PSS = '1.2.840.113549.1.1.10';
const OID_MGF1 = '1.2.840.113549.1.1.8';

// Common hash OIDs
const HASH_OIDS: Record<string, string> = {
  sha1: '1.3.14.3.2.26',
  sha256: '2.16.840.1.101.3.4.2.1',
  sha384: '2.16.840.1.101.3.4.2.2',
  sha512: '2.16.840.1.101.3.4.2.3',
};

/**
 * Builds the DER-encoded RSA-PSS parameters for a given hash algorithm and salt length.
 *
 * RSA-PSS-params ::= SEQUENCE  {
 *    hashAlgorithm      [0]    HashAlgorithm      DEFAULT sha1Identifier,
 *    maskGenAlgorithm   [1]    MaskGenAlgorithm   DEFAULT mgf1SHA1Identifier,
 *    saltLength         [2]    INTEGER            DEFAULT 20,
 *    trailerField       [3]    INTEGER            DEFAULT 1
 * }
 */
export function buildRSAPSSParams(
  hashName: string,
  saltLength: number,
): Buffer {
  // 1) hashAlgorithm ( [0] EXPLICIT AlgorithmIdentifier ) => e.g. sha256
  const hashOid = HASH_OIDS[hashName];
  if (!hashOid) {
    throw new Error(`Unsupported hash name: ${hashName}`);
  }
  const hashAlgSeq = sequence(
    Buffer.concat([objectIdentifier(hashOid), derNull()]),
  );
  const hashAlgField = encodeDER(0xa0, hashAlgSeq);

  // 2) maskGenAlgorithm ( [1] EXPLICIT AlgorithmIdentifier ) => MGF1 w/ same hash OID
  const mgfParams = sequence(
    Buffer.concat([objectIdentifier(hashOid), derNull()]),
  );
  const mgfAlgSeq = sequence(
    Buffer.concat([objectIdentifier(OID_MGF1), mgfParams]),
  );
  const mgfAlgField = encodeDER(0xa1, mgfAlgSeq);

  // 3) saltLength ( [2] EXPLICIT INTEGER )
  const saltInt = integer(Buffer.from([saltLength]));
  const saltLenField = encodeDER(0xa2, saltInt);

  // 4) trailerField ( [3] EXPLICIT INTEGER ), typically 1
  const trailerInt = integer(Buffer.from([0x01]));
  const trailerField = encodeDER(0xa3, trailerInt);

  // Return final sequence
  return sequence(
    Buffer.concat([hashAlgField, mgfAlgField, saltLenField, trailerField]),
  );
}
