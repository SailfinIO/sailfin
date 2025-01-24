import { KeyOps, KeyType, Algorithm, ExtentionOid } from '../enums';
import { AlgorithmDetails } from './AlgorithmDetails';
/**
 * Represents a X.509 certificate structure.
 */
export interface IX509Certificate {
  tbsCertificate: ITbsCertificate;
  signatureAlgorithm: IAlgorithmIdentifier;
  signatureValue: Buffer;
}

export interface ITbsCertificate {
  version?: number;
  serialNumber: Buffer;
  signature: IAlgorithmIdentifier;
  issuer: IName;
  validity: IValidity;
  subject: IName;
  subjectPublicKeyInfo: ISubjectPublicKeyInfo;
  issuerUniqueID?: Buffer;
  subjectUniqueID?: Buffer;
  extensions?: IExtension[];
}

export interface IAlgorithmIdentifier {
  algorithm: string; // OID as string
  parameters?: Buffer; // Additional parameters if any
}

export interface IName {
  // For simplicity, represent as a sequence of RDNs.
  rdnSequence: IRelativeDistinguishedName[];
}

export interface IRelativeDistinguishedName {
  attributes: AttributeTypeAndValue[];
}

/**
 * Base interface for AttributeTypeAndValue.
 */
export interface IBaseAttributeTypeAndValue {
  type: string; // OID
  value?: string | number | Buffer;
}

/**
 * Interface for string-based AttributeTypeAndValue.
 */
export interface IStringAttributeTypeAndValue
  extends IBaseAttributeTypeAndValue {
  type: string; // Specific OID
  value: string;
}

/**
 * Interface for integer-based AttributeTypeAndValue.
 */
export interface IIntegerAttributeTypeAndValue
  extends IBaseAttributeTypeAndValue {
  type: string; // Specific OID
  value: number;
}

/**
 * Union type for AttributeTypeAndValue.
 */
export type AttributeTypeAndValue =
  | IStringAttributeTypeAndValue
  | IIntegerAttributeTypeAndValue
  | IBaseAttributeTypeAndValue; // Fallback for other types

export interface IValidity {
  notBefore: Date;
  notAfter: Date;
}

export interface ISubjectPublicKeyInfo {
  algorithm: IAlgorithmIdentifier;
  subjectPublicKey: Buffer; // Raw public key bytes (BIT STRING content)
}

export interface IExtension {
  extnID: ExtentionOid;
  critical: boolean;
  value: Buffer;

  // Optional property to store parsed extension data
  parsedData?: any;
}

export interface BasicConstraints {
  cA: boolean;
  pathLenConstraint?: number;
}

export interface KeyUsage {
  usages: string[]; // Raw key usage strings (e.g., ["digitalSignature", "keyEncipherment"])
}

export interface SubjectAltName {
  names: string[]; // List of subject alternative names
  dnsNames?: string[];
  ipAddresses?: string[];
  emailAddresses?: string[];
  uris?: string[];
}

export interface ExtendedKeyUsage {
  purposes: string[]; // List of extended key usages
}

export interface SubjectKeyIdentifier {
  keyIdentifier: Buffer;
}

export interface AuthorityKeyIdentifier {
  keyIdentifier: Buffer;
  authorityCertIssuer?: string[];
  authorityCertSerialNumber?: Buffer;
}

export interface CRLDistributionPoints {
  distributionPoints: string[];
}

export interface AccessDescription {
  method: string;
  location: string;
}

export interface AuthorityInfoAccess {
  accessDescriptions: AccessDescription[];
}

export type ParsedExtensionData =
  | BasicConstraints
  | ParsedKeyUsage
  | SubjectAltName
  | ExtendedKeyUsage
  | SubjectKeyIdentifier
  | AuthorityKeyIdentifier
  | CRLDistributionPoints
  | AuthorityInfoAccess;

export type ExtensionParser = (
  extnValue: Buffer,
  critical: boolean,
) => ParsedExtensionData;

export interface CertificateOptions {
  /**
   * Common Name (CN) for the certificate subject. If omitted, defaults to 'Example'.
   */
  subjectCN?: string;

  validity: IValidity;
  tbsCertificate: ITbsCertificate;
  signAlgorithm: AlgorithmDetails;
  privateKeyPem: string;
}

export interface ParsedKeyUsage {
  digitalSignature: boolean;
  nonRepudiation: boolean;
  keyEncipherment: boolean;
  dataEncipherment: boolean;
  keyAgreement: boolean;
  keyCertSign: boolean;
  cRLSign: boolean;
  encipherOnly: boolean;
  decipherOnly: boolean;
}

export interface KeyData {
  privateKey: string; // PEM-encoded private key
  publicKey: string; // PEM-encoded public key
  kid: string; // Key identifier
  kty: KeyType; // Key type (e.g., 'RSA', 'EC')
  alg: string; // Algorithm (e.g., 'RS256')
  createdAt: Date; // Timestamp when the key was created
  activatedAt: Date; // Timestamp when the key became active
  deactivatedAt: Date | null; // Timestamp when the key was deactivated
  x5c: string[]; // Certificate chain in base64-encoded DER format
  x5t: string; // SHA-1 thumbprint of the certificate
  keyOps: KeyOps[]; // Key operations (e.g., ['sign', 'verify'])
}

export interface CreateSelfSignedCertificateOptions {
  /**
   * If provided, the method will use these keys rather than generate new ones.
   * If omitted, the method will generate new keys internally.
   */
  keyPair?: {
    publicKey: string; // PEM-encoded
    privateKey: string; // PEM-encoded
  };

  /**
   * If you want to generate new keys internally, specify a KeyType ('RSA' or 'EC').
   * Ignored if `keyPair` is already provided.
   */
  type?: KeyType;

  /**
   * Common Name (CN) for the certificate subject. If omitted, defaults to 'Example'.
   */
  subjectCN?: string;

  /**
   * Validity period for the certificate. If omitted, defaults to "now until +1 year".
   */
  validity?: IValidity;

  /**
   * Whether this cert acts as a CA certificate (set BasicConstraints cA = true).
   * You can add logic to incorporate this into the TBS Certificate’s `extensions`.
   */
  isCA?: boolean;

  /**
   * Optional array of custom X.509 extensions if you want more than a basic self-signed cert.
   */
  extensions?: IExtension[];

  /**
   * Optional: user can specify RS256, RS384, PS256, ES256, etc.
   * If omitted, use a default based on the key type
   */
  algorithm?: Algorithm;

  /**
   * If provided, we merge or override these fields into our TBS.
   * For example: { version, serialNumber, issuer, subject, etc. }
   */
  tbs?: Partial<ITbsCertificate>;
}
