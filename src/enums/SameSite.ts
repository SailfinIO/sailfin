/**
 * @fileoverview
 * Enumeration of supported SameSite attribute values for cookies.
 * This module defines the `SameSite` enum, which specifies how cookies
 * should be restricted in cross-site scenarios. The `SameSite` attribute
 * is used to prevent CSRF attacks and enhance cookie security.
 *
 * @module src/enums/SameSite
 */

/**
 * Represents the SameSite attribute values for cookies.
 *
 * The `SameSite` enum defines the allowable values for the `SameSite` attribute,
 * which controls how cookies are sent with cross-site requests. This attribute
 * helps prevent CSRF attacks and protects sensitive cookie data.
 *
 * @enum {string}
 */
export enum SameSite {
  /**
   * The `None` value indicates that cookies are sent with both same-site and cross-site requests.
   * This option requires the cookie to be marked as `Secure` to work in modern browsers.
   *
   * @member {string} SameSite.NONE
   * @example
   * // Example usage:
   * {
   *   sameSite: SameSite.NONE,
   *   secure: true, // Required for SameSite.None
   * }
   */
  NONE = 'none',

  /**
   * The `Lax` value allows cookies to be sent with same-site requests and
   * with top-level navigation cross-site requests (e.g., following a link).
   * However, cookies are not sent with cross-origin subresource requests (e.g., images or iframes).
   *
   * @member {string} SameSite.LAX
   * @example
   * // Example usage:
   * {
   *   sameSite: SameSite.LAX,
   * }
   */
  LAX = 'lax',

  /**
   * The `Strict` value ensures that cookies are only sent with same-site requests.
   * Cookies with this value are not sent with any cross-site requests, including
   * top-level navigation.
   *
   * @member {string} SameSite.STRICT
   * @example
   * // Example usage:
   * {
   *   sameSite: SameSite.STRICT,
   * }
   */
  STRICT = 'strict',
}
