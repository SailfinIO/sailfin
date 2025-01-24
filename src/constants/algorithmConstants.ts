import { AlgorithmDetails } from '../interfaces';
import { Algorithm, AlgorithmType, DERTag } from '../enums';

/**
 * Mapping of supported Elliptic Curve names to their corresponding OIDs.
 * These OIDs are used to identify the specific curve in DER-encoded structures.
 *
 * @constant {Record<string, string>}
 */
export const CURVE_OIDS: Record<string, string> = {
  'P-256': '1.2.840.10045.3.1.7',
  'P-384': '1.3.132.0.34',
  'P-521': '1.3.132.0.35',
};

export const ATTRIBUTE_DETAILS: Record<
  string,
  { oid: string; asn1Type: DERTag }
> = {
  CN: { oid: '2.5.4.3', asn1Type: DERTag.UTF8_STRING }, // Common Name
  C: { oid: '2.5.4.6', asn1Type: DERTag.PRINTABLE_STRING }, // Country Name
  L: { oid: '2.5.4.7', asn1Type: DERTag.UTF8_STRING }, // Locality Name
  ST: { oid: '2.5.4.8', asn1Type: DERTag.UTF8_STRING }, // State or Province Name
  O: { oid: '2.5.4.10', asn1Type: DERTag.UTF8_STRING }, // Organization Name
  OU: { oid: '2.5.4.11', asn1Type: DERTag.UTF8_STRING }, // Organizational Unit Name
  SERIALNUMBER: { oid: '2.5.4.5', asn1Type: DERTag.UTF8_STRING }, // Serial Number
  SN: { oid: '2.5.4.4', asn1Type: DERTag.UTF8_STRING }, // Surname
  GIVENNAME: { oid: '2.5.4.42', asn1Type: DERTag.UTF8_STRING }, // Given Name
  INITIALS: { oid: '2.5.4.43', asn1Type: DERTag.UTF8_STRING }, // Initials
  GENERATIONQUALIFIER: { oid: '2.5.4.44', asn1Type: DERTag.UTF8_STRING }, // Generation Qualifier
  PSEUDONYM: { oid: '2.5.4.65', asn1Type: DERTag.UTF8_STRING }, // Pseudonym
  STREET: { oid: '2.5.4.9', asn1Type: DERTag.UTF8_STRING }, // Street Address
  DNQUALIFIER: { oid: '2.5.4.46', asn1Type: DERTag.UTF8_STRING }, // Distinguished Name Qualifier
  E: { oid: '1.2.840.113549.1.9.1', asn1Type: DERTag.IA5_STRING }, // Email Address
  DC: { oid: '0.9.2342.19200300.100.1.25', asn1Type: DERTag.UTF8_STRING }, // Domain Component
  UID: { oid: '0.9.2342.19200300.100.1.1', asn1Type: DERTag.UTF8_STRING }, // User ID or User Identifier
};

/**
 * Comprehensive mapping of cryptographic algorithms to their properties.
 *
 * - For RSA/EC signature algorithms (e.g. RS256, ES256),
 *   "signatureOid" is typically used in the certificate’s signatureAlgorithm field.
 * - For raw key algorithms (e.g. RSA_PUBLIC_KEY, EC_PUBLIC_KEY),
 *   "publicKeyOid" is for SubjectPublicKeyInfo.
 * - For ECDSA, if you want one entry to handle both the signature OID and the key OID,
 *   you can store both (see ES256, ES384, ES512).
 */
export const ALGORITHM_DETAILS_MAP: Record<Algorithm, AlgorithmDetails> = {
  // ---------------------------------------------------------------------------
  // RSA Signatures (PKCS#1 v1.5)
  // ---------------------------------------------------------------------------
  RS256: {
    cryptoAlg: 'RSA-SHA256',
    hashName: 'sha256',
    signatureOid: '1.2.840.113549.1.1.11', // sha256WithRSAEncryption
    type: AlgorithmType.SIGNATURE,
  },
  RS384: {
    cryptoAlg: 'RSA-SHA384',
    hashName: 'sha384',
    signatureOid: '1.2.840.113549.1.1.12', // sha384WithRSAEncryption
    type: AlgorithmType.SIGNATURE,
  },
  RS512: {
    cryptoAlg: 'RSA-SHA512',
    hashName: 'sha512',
    signatureOid: '1.2.840.113549.1.1.13', // sha512WithRSAEncryption
    type: AlgorithmType.SIGNATURE,
  },

  // ---------------------------------------------------------------------------
  // RSA-PSS Signatures
  // ---------------------------------------------------------------------------
  PS256: {
    cryptoAlg: 'RSA-PSS',
    hashName: 'sha256',
    signatureOid: '1.2.840.113549.1.1.10', // RSASSA-PSS
    type: AlgorithmType.SIGNATURE,
    options: { saltLength: 32 },
  },
  PS384: {
    cryptoAlg: 'RSA-PSS',
    hashName: 'sha384',
    signatureOid: '1.2.840.113549.1.1.10', // RSASSA-PSS
    type: AlgorithmType.SIGNATURE,
    options: { saltLength: 48 },
  },
  PS512: {
    cryptoAlg: 'RSA-PSS',
    hashName: 'sha512',
    signatureOid: '1.2.840.113549.1.1.10', // RSASSA-PSS
    type: AlgorithmType.SIGNATURE,
    options: { saltLength: 64 },
  },

  // ---------------------------------------------------------------------------
  // HMAC Algorithms (not for certificates, but for JWTs or other uses)
  // ---------------------------------------------------------------------------
  HS256: {
    cryptoAlg: 'sha256',
    hashName: 'sha256',
    type: AlgorithmType.HASH,
  },
  HS384: {
    cryptoAlg: 'sha384',
    hashName: 'sha384',
    type: AlgorithmType.HASH,
  },
  HS512: {
    cryptoAlg: 'sha512',
    hashName: 'sha512',
    type: AlgorithmType.HASH,
  },

  // ---------------------------------------------------------------------------
  // ECDSA Signatures
  // ---------------------------------------------------------------------------
  ES256: {
    cryptoAlg: 'ecdsa-with-SHA256',
    hashName: 'sha256',

    // Standard OID for ecdsa-with-SHA256
    signatureOid: '1.2.840.10045.4.3.2',

    // Public Key OID for "EC PUBLIC KEY" if you also want to handle SPKI from here
    // 1.2.840.10045.2.1
    publicKeyOid: '1.2.840.10045.2.1',
    type: AlgorithmType.SIGNATURE,
  },
  ES384: {
    cryptoAlg: 'ecdsa-with-SHA384',
    hashName: 'sha384',

    // Standard OID for ecdsa-with-SHA384
    signatureOid: '1.2.840.10045.4.3.3',

    publicKeyOid: '1.2.840.10045.2.1',
    type: AlgorithmType.SIGNATURE,
  },
  ES512: {
    cryptoAlg: 'ecdsa-with-SHA512',
    hashName: 'sha512',

    // Standard OID for ecdsa-with-SHA512
    signatureOid: '1.2.840.10045.4.3.4',

    publicKeyOid: '1.2.840.10045.2.1',
    type: AlgorithmType.SIGNATURE,
  },

  // ---------------------------------------------------------------------------
  // Standalone Hash (SHA) Algorithms
  // ---------------------------------------------------------------------------
  SHA1: {
    cryptoAlg: 'sha1',
    hashName: 'sha1',
    // e.g. '1.3.14.3.2.26' is the OID for sha1, if you need it
    signatureOid: '1.3.14.3.2.26',
    type: AlgorithmType.HASH,
  },
  SHA256: {
    cryptoAlg: 'sha256',
    hashName: 'sha256',
    signatureOid: '2.16.840.1.101.3.4.2.1',
    type: AlgorithmType.HASH,
  },
  SHA384: {
    cryptoAlg: 'sha384',
    hashName: 'sha384',
    signatureOid: '2.16.840.1.101.3.4.2.2',
    type: AlgorithmType.HASH,
  },
  SHA512: {
    cryptoAlg: 'sha512',
    hashName: 'sha512',
    signatureOid: '2.16.840.1.101.3.4.2.3',
    type: AlgorithmType.HASH,
  },

  // ---------------------------------------------------------------------------
  // Legacy / MD5
  // ---------------------------------------------------------------------------
  MD5: {
    cryptoAlg: 'MD5',
    hashName: 'md5',
    signatureOid: '1.2.840.113549.2.5',
    type: AlgorithmType.HASH,
  },

  // ---------------------------------------------------------------------------
  // Public Key Algorithms (Stand-alone)
  // ---------------------------------------------------------------------------
  EC_PUBLIC_KEY: {
    cryptoAlg: 'EC_PUBLIC_KEY',
    hashName: '',
    publicKeyOid: '1.2.840.10045.2.1',
    type: AlgorithmType.KEY,
  },
  RSA_PUBLIC_KEY: {
    cryptoAlg: 'RSA_PUBLIC_KEY',
    hashName: '',
    publicKeyOid: '1.2.840.113549.1.1.1',
    type: AlgorithmType.KEY,
  },
};
