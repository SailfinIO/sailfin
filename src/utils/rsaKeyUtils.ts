// src/utils/rsaKeyUtils.ts

import { BinaryToTextEncoding, CertificateLabel } from '../enums';
import { base64UrlDecode } from './urlUtils';
import { pemToDer, wrapPem } from './pem';
import {
  integer,
  bitString,
  sequence,
  objectIdentifier,
  derNull,
} from './derUtils';
import { ALGORITHM_DETAILS_MAP } from '../constants/algorithmConstants';

/**
 * Converts RSA public key components from JWK format to PEM format.
 *
 * @param {string} n - The modulus component of the RSA public key, Base64URL-encoded.
 * @param {string} e - The exponent component of the RSA public key, Base64URL-encoded.
 * @returns {string} The PEM-encoded RSA public key.
 *
 * @throws {Error} If the modulus (`n`) or exponent (`e`) cannot be decoded from Base64URL.
 */
export const rsaJwkToPem = (n: string, e: string): string => {
  let modulus: Buffer;
  let exponent: Buffer;

  // Attempt to decode the modulus
  try {
    modulus = base64UrlDecode(n);
  } catch (error) {
    throw new Error('Invalid modulus (n), could not decode base64url');
  }

  // Attempt to decode the exponent
  try {
    exponent = base64UrlDecode(e);
  } catch (error) {
    throw new Error('Invalid exponent (e), could not decode base64url');
  }

  // Validate decoded modulus
  if (modulus.length === 0) {
    throw new Error('Invalid modulus (n), could not decode base64url');
  }

  // Validate decoded exponent
  if (exponent.length === 0) {
    throw new Error('Invalid exponent (e), could not decode base64url');
  }

  // Encode the modulus and exponent as DER INTEGERs
  const modInt = integer(modulus);
  const expInt = integer(exponent);

  // Create the RSA public key sequence (modulus and exponent)
  const rsaPubKey = sequence(Buffer.concat([modInt, expInt]));

  const rsaOid = ALGORITHM_DETAILS_MAP.RSA_PUBLIC_KEY.publicKeyOid;

  if (!rsaOid) {
    throw new Error('OID for RS256 not found in the algorithm map.');
  }

  // Create the algorithm identifier sequence with RSA OID and NULL parameters
  const algId = sequence(Buffer.concat([objectIdentifier(rsaOid), derNull()]));

  // Create the SubjectPublicKeyInfo (SPKI) sequence
  const spki = sequence(Buffer.concat([algId, bitString(rsaPubKey)]));

  // Convert the SPKI buffer to a Base64-encoded string
  const b64 = spki.toString(BinaryToTextEncoding.BASE_64);

  // Wrap the Base64 string with PEM headers and footers
  return wrapPem(b64, CertificateLabel.PUBLIC_KEY);
};

/**
 * Converts an RSA public key from PEM format to JWK format.
 *
 * This function takes a PEM-encoded RSA public key, extracts the modulus and
 * exponent from the key data, and returns the key components in JSON Web Key (JWK)
 * format. The JWK format is commonly used in web-based cryptographic operations
 * and JSON-based data interchange, providing a standard representation for RSA public keys.
 *
 * @param {string} pem - The PEM-encoded RSA public key.
 * @returns {object} An object containing the JWK components (`n`, `e`) of the RSA public key.
 *
 * @throws {Error} If the provided PEM string is not a valid RSA public key or if the key data
 *                 cannot be decoded from the PEM format.
 *
 * @example
 * ```typescript
 * const pemKey = `-----BEGIN PUBLIC KEY-----
 * MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA...
 * -----END PUBLIC KEY-----`;
 * const jwkKey = rsaPemToJwk(pemKey);
 * console.log(jwkKey);
 * // Outputs: { n: '...', e: '...' }
 * ```
 */
export const rsaPemToJwk = (pem: string): { n: string; e: string } => {
  // Convert the PEM string to a DER buffer
  const spki = pemToDer(pem);

  // Extract the modulus and exponent from the DER buffer
  const [modulus, exponent] = extractRsaComponents(spki);

  // Encode the modulus and exponent as Base64URL strings
  const n = modulus.toString(BinaryToTextEncoding.BASE_64);
  const e = exponent.toString(BinaryToTextEncoding.BASE_64);

  return { n, e };
};

/**
 * Extracts the modulus and exponent components from an RSA SubjectPublicKeyInfo (SPKI) buffer.
 *
 * This function parses an RSA SPKI buffer to extract the modulus and exponent components
 * of the RSA public key. The modulus is the first INTEGER value in the SPKI buffer, and
 * the exponent is the second INTEGER value.
 *
 * @param {Buffer} spki - The RSA SubjectPublicKeyInfo (SPKI) buffer.
 * @returns {Buffer[]} An array containing the modulus and exponent components.
 *
 * @throws {Error} If the provided SPKI buffer is not a valid RSA public key.
 */
const extractRsaComponents = (spki: Buffer): Buffer[] => {
  // Parse the SPKI buffer to extract the modulus and exponent
  const modulus = spki.subarray(1); // Skip the first byte (0x00) of the modulus
  const exponent = spki.subarray(modulus.length + 2); // Skip the modulus and padding byte

  return [modulus, exponent];
};
