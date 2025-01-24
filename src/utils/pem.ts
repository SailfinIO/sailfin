/**
 * @fileoverview
 * Utility functions for handling Privacy-Enhanced Mail (PEM) encoding.
 * This module provides functionality to format Base64-encoded strings
 * into PEM format by adding appropriate headers and footers. PEM format
 * is commonly used for encoding cryptographic keys and certificates.
 *
 * @module src/utils/pem
 */

import { BinaryToTextEncoding, CertificateLabel } from '../enums';

/**
 * Formats a Base64-encoded string into PEM format by adding
 * the appropriate header and footer lines.
 *
 * This function takes a Base64-encoded string and a label, splits the
 * string into lines of up to 64 characters, and wraps it with
 * `-----BEGIN {label}-----` and `-----END {label}-----` lines.
 * PEM format is widely used for encoding cryptographic keys and certificates.
 *
 * @param {string} b64 - The Base64-encoded string to wrap into PEM format.
 * @param {string} label - The label indicating the type of PEM content
 *                          (e.g., "PUBLIC KEY", "PRIVATE KEY", "CERTIFICATE").
 * @returns {string} The PEM-formatted string.
 *
 * @example
 * ```typescript
 * const base64Key = "MIIBIjANBgkqhkiG9w0BAQEFAAOC...";
 * const pemKey = wrapPem(base64Key, "PUBLIC KEY");
 * console.log(pemKey);
 * // Outputs:
 * // -----BEGIN PUBLIC KEY-----
 * // MIIBIjANBgkqhkiG9w0BAQEFAAOC...
 * // -----END PUBLIC KEY-----
 * ```
 */
export const wrapPem = (b64: string, label: CertificateLabel): string => {
  // Split the Base64 string into lines of up to 64 characters
  const lines = b64.match(/.{1,64}/g) || [];

  // Construct the PEM-formatted string with headers and footers
  return `-----BEGIN ${label}-----\n${lines.join('\n')}\n-----END ${label}-----`;
};

/**
 * Removes the header and footer lines from a PEM-formatted string
 * and returns the Base64-encoded content.
 *
 * This function takes a PEM-formatted string, removes the header and footer
 * lines (e.g., `-----BEGIN {label}-----` and `-----END {label}-----`),
 * and returns the Base64-encoded content. PEM format is widely used for
 * encoding cryptographic keys and certificates.
 *
 * @param {string} pem - The PEM-formatted string to unwrap.
 * @returns {string} The Base64-encoded content.
 *
 * @example
 * ```typescript
 * const pemKey = `-----BEGIN PUBLIC KEY-----
 * MIIBIjANBgkqhkiG9w0BAQEFAAOC...
 * -----END PUBLIC KEY-----`;
 * const base64Key = unwrapPem(pemKey);
 * console.log(base64Key);
 * // Outputs: "MIIBIjANBgkqhkiG9w0BAQEFAAOC..."
 * ```
 */
export const unwrapPem = (pem: string): string => {
  // Remove PEM header/footer and decode Base64 to DER buffer
  const pemLines = pem
    .trim()
    .split('\n')
    .filter((line) => !line.startsWith('-----'));
  return pemLines.join('');
};

/**
 * Converts a DER-encoded buffer to PEM format.
 *
 * @param {Buffer} derBuffer - The DER-encoded buffer.
 * @param {string} label - The label indicating the type of PEM content
 *                         (e.g., "CERTIFICATE", "PUBLIC KEY", "PRIVATE KEY").
 * @returns {string} The PEM-formatted string.
 *
 * @example
 * ```typescript
 * const derCert: Buffer = ...; // DER-encoded certificate buffer
 * const pemCert = derToPem(derCert, "CERTIFICATE");
 * console.log(pemCert);
 * // Outputs:
 * // -----BEGIN CERTIFICATE-----
 * // MIIBIjANBgkqhkiG9w0BAQEFAAOC...
 * // -----END CERTIFICATE-----
 * ```
 */
export const derToPem = (
  derBuffer: Buffer,
  label: CertificateLabel,
): string => {
  const base64Content = derBuffer.toString(BinaryToTextEncoding.BASE_64);
  return wrapPem(base64Content, label);
};

/**
 * Parses a PEM-formatted string and returns the DER-encoded buffer.
 *
 * @param {string} pem - The PEM-formatted string.
 * @returns {Buffer} The DER-encoded buffer.
 *
 * @example
 * ```typescript
 * const pemCert = `-----BEGIN CERTIFICATE-----
 * MIIBIjANBgkqhkiG9w0BAQEFAAOC...
 * -----END CERTIFICATE-----`;
 * const derCert = pemToDer(pemCert);
 * console.log(derCert);
 * // Outputs: <Buffer 30 82 01 0a 02 ...>
 * ```
 */
export const pemToDer = (pem: string): Buffer => {
  const base64Content = unwrapPem(pem);
  return Buffer.from(base64Content, BinaryToTextEncoding.BASE_64);
};
