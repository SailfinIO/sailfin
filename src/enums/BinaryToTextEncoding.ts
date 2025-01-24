/**
 * @fileoverview
 * Enumeration of binary-to-text encoding schemes.
 * This module defines the `BinaryToTextEncoding` enum, which lists supported
 * encoding formats for converting binary data to textual representations
 * and vice versa. These encodings are commonly used in cryptographic operations
 * and data serialization/deserialization processes.
 *
 * @module src/enums/BinaryToTextEncoding
 */

/**
 * Represents the supported binary-to-text encoding schemes.
 *
 * The `BinaryToTextEncoding` enum lists the encoding formats available
 * for converting binary data into text and decoding text back into binary data.
 * These encodings include Base64URL, Base64, and Hexadecimal.
 *
 * @enum {string}
 */
export enum BinaryToTextEncoding {
  /**
   * Base64URL encoding, which is URL-safe by replacing `+` with `-` and `/` with `_`,
   * and removing padding characters.
   *
   * @member {string} BinaryToTextEncoding.BASE_64_URL
   */
  BASE_64_URL = 'base64url',

  /**
   * Standard Base64 encoding, which uses `+` and `/` characters and may include padding.
   *
   * @member {string} BinaryToTextEncoding.BASE_64
   */
  BASE_64 = 'base64',

  /**
   * Hexadecimal encoding, representing binary data as a string of hexadecimal digits.
   *
   * @member {string} BinaryToTextEncoding.HEX
   */
  HEX = 'hex',

  /**
   * ASCII encoding, which maps each byte to a printable ASCII character.
   *
   * @member {string} BinaryToTextEncoding.ASCII
   */
  ASCII = 'ascii',

  /**
   * UTF-8 encoding, which represents binary data as a UTF-8-encoded string.
   *
   * @member {string} BinaryToTextEncoding.UTF8
   */
  UTF_8 = 'utf8',

  /**
   * UTF-16 encoding, which represents binary data as a UTF-16-encoded string.
   *
   * @member {string} BinaryToTextEncoding.UTF16
   */
  UTF16 = 'utf16',

  /**
   * UTF-16LE encoding, which represents binary data as a little-endian UTF-16-encoded string.
   *
   * @member {string} BinaryToTextEncoding.UTF16LE
   */
  UTF16LE = 'utf16le',

  /**
   * UTF-16BE encoding, which represents binary data as a big-endian UTF-16-encoded string.
   *
   * @member {string} BinaryToTextEncoding.UTF16BE
   */
  UTF16BE = 'utf16be',

  /**
   * Latin1 encoding, which represents binary data as a Latin-1-encoded string.
   *
   * @member {string} BinaryToTextEncoding.LATIN1
   */
  LATIN1 = 'latin1',
}
