/**
 * @fileoverview
 * Utility functions for encoding data using Distinguished Encoding Rules (DER).
 * This module provides functions to encode and decode various data types into DER format,
 * such as integers, bit strings, sequences, object identifiers, and ECDSA signatures.
 * It is primarily used for cryptographic operations where DER encoding/decoding is required.
 *
 * @module src/utils/derUtils
 */

import { ClientError } from '../errors';
import { Algorithm, DERTag } from '../enums';

/**
 * Represents a continuation bit
 * @constant {number}
 */
export const CONTINUATION_BIT = 0x80;

/**
 * Represents the last byte of a DER-encoded element
 * @constant {number}
 */
export const SEVEN_BITS_MASK = 0x7f;

/**
 * Represents a full byte (0xff)
 * @constant {number}
 */
export const FULL_BYTE = 0xff;

/**
 * Encodes the length in DER format.
 *
 * @param {number} length - The length to encode.
 * @returns {Buffer} The DER-encoded length.
 *
 * @throws {RangeError} If the length is negative.
 */
export const encodeLength = (length: number): Buffer => {
  if (length < 0) {
    throw new RangeError('Length cannot be negative');
  }

  if (length < 128) {
    return Buffer.from([length]);
  }
  const lenBytes: number[] = [];
  let temp = length;
  while (temp > 0) {
    lenBytes.unshift(temp & FULL_BYTE);
    temp >>= 8;
  }
  return Buffer.from([CONTINUATION_BIT | lenBytes.length, ...lenBytes]);
};

/**
 * Encodes a boolean value as a DER BOOLEAN.
 *
 * @param {boolean} value - The boolean value to encode.
 * @returns {Buffer} The DER-encoded BOOLEAN.
 */
export const asn1Boolean = (value: boolean): Buffer => {
  return Buffer.from([DERTag.BOOLEAN, value ? FULL_BYTE : 0]);
};

/**
 * Encodes a DER element with the given tag and content.
 *
 * @param {number} tag - The DER tag to use for encoding.
 * @param {Buffer} content - The content to encode.
 * @returns {Buffer} The DER-encoded element.
 */
export const encodeDER = (tag: DERTag | number, content: Buffer): Buffer => {
  return Buffer.concat([
    Buffer.from([tag]),
    encodeLength(content.length),
    content,
  ]);
};

/**
 * Generates a DER-encoded NULL value.
 *
 * @returns {Buffer} The DER-encoded NULL.
 */
export const derNull = (): Buffer => {
  return Buffer.from([DERTag.NULL, DERTag.NONE]);
};

/**
 * Formats a buffer representing an integer to ensure it adheres to DER encoding rules.
 * If the highest bit is set, a leading zero byte is added to prevent it from being interpreted as negative.
 *
 * @param {Buffer} numBuffer - The buffer representing the integer.
 * @returns {Buffer} The formatted integer buffer.
 */
const formatIntegerBuffer = (numBuffer: Buffer): Buffer => {
  if ((numBuffer[0] & CONTINUATION_BIT) === CONTINUATION_BIT) {
    return Buffer.concat([Buffer.from([DERTag.NONE]), numBuffer]);
  }
  return numBuffer;
};

/**
 * Encodes a buffer as a DER INTEGER.
 *
 * @param {Buffer} numBuffer - The buffer representing the integer to encode.
 * @returns {Buffer} The DER-encoded INTEGER.
 */
export const integer = (numBuffer: Buffer): Buffer => {
  const formatted = formatIntegerBuffer(numBuffer);
  return encodeDER(DERTag.INTEGER, formatted);
};

/**
 * Encodes data as a DER BIT STRING.
 *
 * @param {Buffer} data - The data to encode as a bit string.
 * @returns {Buffer} The DER-encoded BIT STRING.
 */
export const bitString = (data: Buffer): Buffer => {
  const full = Buffer.concat([Buffer.from([DERTag.NONE]), data]);
  return encodeDER(DERTag.BIT_STRING, full);
};

/**
 * Encodes contents as a DER SEQUENCE.
 *
 * @param {Buffer} contents - The concatenated DER-encoded elements to include in the sequence.
 * @returns {Buffer} The DER-encoded SEQUENCE.
 */
export const sequence = (contents: Buffer): Buffer => {
  return encodeDER(DERTag.SEQUENCE, contents);
};

/**
 * Encodes a single value of an Object Identifier (OID) using DER rules.
 *
 * @param {number} value - The value to encode.
 * @returns {number[]} An array of bytes representing the encoded OID value.
 */
const encodeOidValue = (value: number): number[] => {
  const stack: number[] = [];
  let val = value;
  stack.push(val & SEVEN_BITS_MASK);
  val >>= 7;
  while (val > 0) {
    stack.unshift((val & SEVEN_BITS_MASK) | CONTINUATION_BIT);
    val >>= 7;
  }
  return stack;
};

/**
 * Encodes a string representation of an Object Identifier (OID) into DER format.
 *
 * @param {string} oid - The OID string (e.g., "1.2.840.113549").
 * @returns {Buffer} The DER-encoded OBJECT IDENTIFIER.
 *
 * @throws {ClientError} If the OID is invalid or has fewer than two components.
 */
export const objectIdentifier = (oid: string): Buffer => {
  const parts = oid.split('.').map((p) => parseInt(p, 10));
  if (parts.length < 2 || parts.some(isNaN)) {
    throw new ClientError('Invalid OID', 'INVALID_OID');
  }

  const firstByte = 40 * parts[0] + parts[1];
  const rest = parts.slice(2);
  const oidBytes = [firstByte];
  for (const val of rest) {
    oidBytes.push(...encodeOidValue(val));
  }

  const buf = Buffer.from(oidBytes);
  return encodeDER(DERTag.OBJECT_IDENTIFIER, buf);
};

/**
 * Converts a raw ECDSA signature into DER format.
 *
 * The raw signature is expected to be a concatenation of the `r` and `s` values.
 * This function splits the raw signature, encodes each component as a DER INTEGER,
 * and combines them into a DER SEQUENCE.
 *
 * @param {Buffer} rawSig - The raw ECDSA signature (r || s).
 * @param {Algorithm} alg - The ECDSA algorithm used (e.g., ES256, ES384, ES512).
 * @returns {Buffer} The DER-encoded ECDSA signature.
 *
 * @throws {ClientError} If the algorithm is unsupported or the signature length is invalid.
 */
export const ecDsaSignatureFromRaw = (
  rawSig: Buffer,
  alg: Algorithm,
): Buffer => {
  let keyLength: number;
  switch (alg) {
    case Algorithm.ES256:
      keyLength = 32;
      break;
    case Algorithm.ES384:
      keyLength = 48;
      break;
    case Algorithm.ES512:
      keyLength = 66;
      break;
    default:
      throw new ClientError(
        `Unsupported ECDSA algorithm: ${alg}`,
        'INVALID_ALGORITHM',
      );
  }

  if (rawSig.length !== 2 * keyLength) {
    throw new ClientError(
      'Invalid ECDSA signature length',
      'INVALID_SIGNATURE',
    );
  }

  const r = rawSig.subarray(0, keyLength);
  const s = rawSig.subarray(keyLength);

  const derR = integer(r);
  const derS = integer(s);

  return sequence(Buffer.concat([derR, derS]));
};

/**
 * Decodes the DER length field starting from the given buffer offset.
 * Returns the length and the number of bytes read for the length encoding.
 *
 * @param {Buffer} buffer - The buffer containing the DER-encoded data.
 * @param {number} offset - The starting offset to decode the length.
 * @returns {{ length: number; bytesRead: number }} The decoded length and bytes read.
 *
 * @throws {ClientError} If the length encoding is invalid.
 */
export const decodeLength = (
  buffer: Buffer,
  offset: number = 0,
): { length: number; bytesRead: number } => {
  const firstByte = buffer[offset];
  if (firstByte < CONTINUATION_BIT) {
    // Short form: length is the first byte.
    return { length: firstByte, bytesRead: 1 };
  }
  // Long form: lower 7 bits indicate the number of subsequent bytes.
  const numBytes = firstByte & SEVEN_BITS_MASK;
  if (numBytes === 0 || numBytes > 4) {
    // Limit length to 4 bytes for safety.
    throw new ClientError('Invalid DER length encoding', 'DECODE_ERROR');
  }
  let length = 0;
  for (let i = 0; i < numBytes; i++) {
    length = (length << 8) | buffer[offset + 1 + i];
  }
  return { length, bytesRead: 1 + numBytes };
};

/**
 * Decodes a DER element starting at the given offset.
 * Returns the tag, length, content, and total bytes consumed.
 *
 * @param {Buffer} buffer - The buffer containing the DER-encoded element.
 * @param {number} offset - The starting offset to decode.
 * @returns {{ tag: number; length: number; content: Buffer; totalBytes: number }} The decoded element.
 *
 * @throws {ClientError} If the element cannot be decoded.
 */
export const decodeDER = (
  buffer: Buffer,
  offset: number = 0,
): { tag: number; length: number; content: Buffer; totalBytes: number } => {
  const tag = buffer[offset];
  const { length, bytesRead: lenBytes } = decodeLength(buffer, offset + 1);
  const contentStart = offset + 1 + lenBytes;
  const content = buffer.subarray(contentStart, contentStart + length);
  return { tag, length, content, totalBytes: 1 + lenBytes + length };
};

/**
 * Decodes a DER INTEGER from the given buffer and offset.
 *
 * @param {Buffer} buffer - The buffer containing the DER INTEGER.
 * @param {number} offset - The starting offset to decode.
 * @returns {{ value: Buffer; totalBytes: number }} The integer value and bytes consumed.
 *
 * @throws {ClientError} If the tag is not INTEGER.
 */
export const decodeInteger = (
  buffer: Buffer,
  offset: number = 0,
): { value: Buffer; totalBytes: number } => {
  const { tag, content, totalBytes } = decodeDER(buffer, offset);
  if (tag !== DERTag.INTEGER) {
    throw new ClientError('Expected INTEGER tag', 'DECODE_ERROR');
  }
  // Remove any leading zero added during encoding.
  let value = content;
  if (value[0] === DERTag.NONE) {
    value = value.subarray(1);
  }
  return { value, totalBytes };
};

/**
 * Decodes a DER BIT STRING from the given buffer and offset.
 *
 * @param {Buffer} buffer - The buffer containing the DER BIT STRING.
 * @param {number} offset - The starting offset to decode.
 * @returns {{ bits: Buffer; totalBytes: number }} The bit string content and bytes consumed.
 *
 * @throws {ClientError} If the tag is not BIT STRING.
 */
export const decodeBitString = (
  buffer: Buffer,
  offset: number = 0,
): { bits: Buffer; totalBytes: number } => {
  const { tag, content, totalBytes } = decodeDER(buffer, offset);
  if (tag !== DERTag.BIT_STRING) {
    throw new ClientError('Expected BIT STRING tag', 'DECODE_ERROR');
  }
  // First byte indicates number of unused bits in final byte.
  const unusedBits = content[0];
  if (unusedBits !== 0) {
    // Typically unusedBits should be 0 for most encodings.
    throw new ClientError(
      'Unsupported BIT STRING with unused bits',
      'DECODE_ERROR',
    );
  }
  // The rest is the actual bit string.
  return { bits: content.subarray(1), totalBytes };
};

/**
 * Decodes a DER SEQUENCE from the given buffer and offset.
 *
 * @param {Buffer} buffer - The buffer containing the DER SEQUENCE.
 * @param {number} offset - The starting offset to decode.
 * @returns {{
 *   elements: { tag: number; length: number; content: Buffer; totalBytes: number }[];
 *   totalBytes: number
 * }} The list of decoded elements within the sequence and total bytes consumed.
 *
 * @throws {ClientError} If the tag is not SEQUENCE or if decoded length mismatches expected length.
 */
export const decodeSequence = (
  buffer: Buffer,
  offset: number = 0,
): { elements: ReturnType<typeof decodeDER>[]; totalBytes: number } => {
  // Decode the sequence header to get the expected length and content.
  const {
    tag,
    length,
    content,
    totalBytes: seqHeaderBytes,
  } = decodeDER(buffer, offset);

  if (tag !== DERTag.SEQUENCE) {
    throw new ClientError('Expected SEQUENCE tag', 'DECODE_ERROR');
  }

  const elements = [];
  let cursor = 0;

  // Decode each element in the sequence.
  while (cursor < content.length) {
    const element = decodeDER(content, cursor);
    elements.push(element);
    cursor += element.totalBytes;
  }

  // Ensure that we've consumed exactly 'length' bytes of content.
  if (cursor !== length) {
    throw new ClientError(
      'Sequence length mismatch: decoded bytes do not match expected length',
      'DECODE_ERROR',
    );
  }

  return { elements, totalBytes: seqHeaderBytes };
};

/**
 * Decodes a DER OBJECT IDENTIFIER from the given buffer and offset.
 *
 * @param {Buffer} buffer - The buffer containing the DER OBJECT IDENTIFIER.
 * @param {number} offset - The starting offset to decode.
 * @returns {{ oid: string; totalBytes: number }} The OID string and bytes consumed.
 *
 * @throws {ClientError} If the tag is not OBJECT IDENTIFIER.
 */
export const decodeObjectIdentifier = (
  buffer: Buffer,
  offset: number = 0,
): { oid: string; totalBytes: number } => {
  const { tag, content, totalBytes } = decodeDER(buffer, offset);
  if (tag !== DERTag.OBJECT_IDENTIFIER) {
    throw new ClientError('Expected OBJECT IDENTIFIER tag', 'DECODE_ERROR');
  }

  // Decode first byte into first two OID components.
  const firstByte = content[0];
  const first = Math.floor(firstByte / 40);
  const second = firstByte % 40;
  const values = [first, second];
  let value = 0;
  for (let i = 1; i < content.length; i++) {
    const byte = content[i];
    value = (value << 7) | (byte & SEVEN_BITS_MASK);
    if ((byte & CONTINUATION_BIT) === 0) {
      // End of this OID subidentifier.
      values.push(value);
      value = 0;
    }
  }
  return { oid: values.join('.'), totalBytes };
};

/**
 * Encodes a buffer as a DER OCTET STRING.
 *
 * @param {Buffer} data - The data to encode as an octet string.
 * @returns {Buffer} The DER-encoded OCTET STRING.
 *
 * @throws {ClientError} If the data is not a Buffer.
 */
export const octetString = (data: Buffer): Buffer => {
  if (!Buffer.isBuffer(data)) {
    throw new ClientError('Expected Buffer data', 'INVALID_DATA');
  }
  return encodeDER(DERTag.OCTET_STRING, data);
};

/**
 * Decodes a DER-encoded ECDSA signature sequence into its raw r||s format.
 *
 * @param {Buffer} buffer - The buffer containing the DER-encoded ECDSA signature.
 * @param {number} offset - The starting offset to decode.
 * @param {Algorithm} alg - The ECDSA algorithm used (e.g., ES256, ES384, ES512).
 * @returns {{ rawSignature: Buffer; totalBytes: number }} The raw signature and bytes consumed.
 *
 * @throws {ClientError} If the DER structure is invalid.
 */
export const decodeEcDsaSignature = (
  buffer: Buffer,
  offset: number = 0,
  alg: Algorithm,
): { rawSignature: Buffer; totalBytes: number } => {
  const { elements, totalBytes } = decodeSequence(buffer, offset);

  // Expect exactly two INTEGERs inside the SEQUENCE.
  if (elements.length !== 2) {
    throw new ClientError('Invalid ECDSA signature structure', 'DECODE_ERROR');
  }
  const { value: r } = decodeInteger(elements[0].content, 0);
  const { value: s } = decodeInteger(elements[1].content, 0);

  let keyLength: number;
  switch (alg) {
    case Algorithm.ES256:
      keyLength = 32;
      break;
    case Algorithm.ES384:
      keyLength = 48;
      break;
    case Algorithm.ES512:
      keyLength = 66;
      break;
    default:
      throw new ClientError(
        `Unsupported ECDSA algorithm: ${alg}`,
        'INVALID_ALGORITHM',
      );
  }

  // Pad r and s to ensure they have the correct length.
  const pad = (buf: Buffer) => {
    if (buf.length < keyLength) {
      const padding = Buffer.alloc(keyLength - buf.length, 0);
      return Buffer.concat([padding, buf]);
    }
    return buf;
  };

  const rawSignature = Buffer.concat([pad(r), pad(s)]);
  return { rawSignature, totalBytes };
};
