// src/enums/CookieAttribute.ts

/**
 * @fileoverview
 * Enumeration of cookie attribute keys.
 * This module defines the `CookieAttribute` enum, which standardizes the keys used
 * for cookie attributes during serialization and parsing.
 *
 * @module src/enums/CookieAttribute
 */

/**
 * Represents the keys for cookie attributes.
 *
 * The `CookieAttribute` enum provides a standardized set of keys used to define
 * various attributes associated with a cookie, such as `Max-Age`, `Domain`, `Path`,
 * `Expires`, and security-related flags.
 *
 * @enum {string}
 */
export enum CookieAttribute {
  MaxAge = 'maxAge',
  Domain = 'domain',
  Path = 'path',
  Expires = 'expires',
  HttpOnly = 'httpOnly',
  Secure = 'secure',
  Partitioned = 'partitioned',
  Priority = 'priority',
  SameSite = 'sameSite',
}
