/**
 * @fileoverview
 * Interface for defining options when serializing cookies.
 * This module provides the `CookieOptions` interface, which allows customization
 * of how cookies are serialized into a string for the `Set-Cookie` header.
 *
 * @module src/interfaces/CookieOptions
 */

import { Priority, SameSite } from '../enums';

/**
 * Represents the options for serializing cookies.
 *
 * The `CookieOptions` interface defines a customizable structure for creating
 * cookies with specific attributes that control their behavior, storage, and security.
 *
 * @interface CookieOptions
 */
export interface CookieOptions {
  /**
   * Specifies a function used to encode a [cookie-value](https://datatracker.ietf.org/doc/html/rfc6265#section-4.1.1).
   *
   * Since the value of a cookie has a limited character set (and must be a simple string),
   * this function can encode a value into a format suitable for a cookie's value.
   * It should mirror the decoding function used during parsing to ensure consistency.
   *
   * @type {(str: string) => string}
   * @default encodeURIComponent
   *
   * @example
   * // Custom encoding function:
   * const options: CookieOptions = {
   *   encode: (value) => btoa(value), // Base64 encode the value
   * };
   */
  encode?: (str: string) => string;

  /**
   * Specifies the `Max-Age` attribute in seconds for the cookie.
   *
   * This defines how long the cookie should persist before it expires. If both `maxAge`
   * and `expires` are set, `maxAge` takes precedence as per the [cookie storage model specification](https://tools.ietf.org/html/rfc6265#section-5.3).
   * However, some clients may not honor this behavior, so it is advisable to keep them in sync.
   *
   * @type {number}
   *
   * @example
   * const options: CookieOptions = {
   *   maxAge: 3600, // Cookie expires after 1 hour
   * };
   */
  maxAge?: number;

  /**
   * Specifies the `Expires` attribute for the cookie as a `Date` object.
   *
   * If no expiration is set, the cookie is considered a "session cookie" and will
   * be deleted when the current session ends. If both `maxAge` and `expires` are set,
   * `maxAge` takes precedence.
   *
   * @type {Date}
   *
   * @example
   * const options: CookieOptions = {
   *   expires: new Date(Date.now() + 3600 * 1000), // Cookie expires in 1 hour
   * };
   */
  expires?: Date;

  /**
   * Specifies the `Domain` attribute for the cookie.
   *
   * If not set, the cookie applies only to the current domain.
   *
   * @type {string}
   *
   * @example
   * const options: CookieOptions = {
   *   domain: 'example.com',
   * };
   */
  domain?: string;

  /**
   * Specifies the `Path` attribute for the cookie.
   *
   * If not set, the default path is determined as per the [cookie storage model specification](https://tools.ietf.org/html/rfc6265#section-5.1.4).
   *
   * @type {string}
   *
   * @example
   * const options: CookieOptions = {
   *   path: '/app',
   * };
   */
  path?: string;

  /**
   * Enables the `HttpOnly` attribute for the cookie.
   *
   * When set to `true`, the cookie will not be accessible via client-side JavaScript (e.g., `document.cookie`).
   *
   * @type {boolean}
   * @default false
   *
   * @example
   * const options: CookieOptions = {
   *   httpOnly: true,
   * };
   */
  httpOnly?: boolean;

  /**
   * Enables the `Secure` attribute for the cookie.
   *
   * When set to `true`, the cookie will only be sent over HTTPS connections.
   *
   * @type {boolean}
   * @default false
   *
   * @example
   * const options: CookieOptions = {
   *   secure: true,
   * };
   */
  secure?: boolean;

  /**
   * Enables the `Partitioned` attribute for the cookie.
   *
   * When enabled, the cookie is scoped to both the current domain and the top-level domain.
   * This is a proposed attribute that may not be fully supported in all clients yet.
   *
   * @type {boolean}
   *
   * @example
   * const options: CookieOptions = {
   *   partitioned: true,
   * };
   */
  partitioned?: boolean;

  /**
   * Specifies the `Priority` attribute for the cookie.
   *
   * This determines the priority level of the cookie:
   * - `'low'`: Low priority.
   * - `'medium'`: Default priority when not set.
   * - `'high'`: High priority.
   *
   * @type {Priority}
   *
   * @example
   * const options: CookieOptions = {
   *   priority: Priority.HIGH,
   * };
   */
  priority?: Priority;

  /**
   * Specifies the `SameSite` attribute for the cookie.
   *
   * Controls how cookies are sent with cross-site requests:
   * - `true` or `'strict'`: Strict enforcement.
   * - `'lax'`: Lax enforcement.
   * - `'none'`: Explicitly allows cross-site cookies (requires `Secure` to be `true`).
   *
   * @type {boolean | SameSite}
   *
   * @example
   * const options: CookieOptions = {
   *   sameSite: SameSite.LAX,
   * };
   */
  sameSite?: boolean | SameSite;
}
