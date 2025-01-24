/**
 * @fileoverview
 * Interface for defining options when parsing cookies.
 * This module provides the `ParseOptions` interface, which allows customization
 * of how cookie values are decoded during parsing.
 *
 * @module src/interfaces/ParseOptions
 */

/**
 * Represents the options for parsing cookies.
 *
 * The `ParseOptions` interface defines a customizable structure for handling the
 * decoding of cookie values, allowing flexibility for different encoding/decoding
 * schemes or handling of non-standard cookie formats.
 *
 * @interface ParseOptions
 */
export interface ParseOptions {
  /**
   * Specifies a function that will be used to decode a [cookie-value](https://datatracker.ietf.org/doc/html/rfc6265#section-4.1.1).
   *
   * The value of a cookie has a limited character set and must be a simple string.
   * This function enables decoding a previously encoded cookie value into a JavaScript string.
   *
   * By default, the global `decodeURIComponent` function is used, wrapped in a `try..catch` block
   * to ensure errors are handled gracefully. If decoding fails, the function returns the original
   * cookie value. If a custom decoding scheme is provided, the implementation must handle errors
   * appropriately.
   *
   * @type {(str: string) => string | undefined}
   * @default decodeURIComponent
   *
   * @example
   * // Example with a custom decoding function:
   * const options: ParseOptions = {
   *   decode: (value) => {
   *     try {
   *       return atob(value); // Decode Base64-encoded cookie values
   *     } catch {
   *       return value; // Return the original value if decoding fails
   *     }
   *   },
   * };
   */
  decode?: (str: string) => string | undefined;
}
