import { AlgorithmType } from '../enums';

export interface AlgorithmDetails {
  cryptoAlg: string; // e.g. "RSA-SHA256", "ecdsa-with-SHA256"
  hashName: string; // e.g. "sha256"
  signatureOid?: string; // OID for "signatureAlgorithm" in the certificate
  publicKeyOid?: string; // OID for "SubjectPublicKeyInfo" (for "type=key" or combined usage)
  type: AlgorithmType;
  options?: {
    saltLength?: number;
  };
}
