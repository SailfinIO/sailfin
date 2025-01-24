/**
 * @fileoverview
 * Defines constants for regular expressions used to validate cookie attributes.
 * These constants follow the specifications outlined in RFC 6265 and related standards.
 * Each regular expression ensures compliance with the rules for cookie names, values, domains, and paths.
 *
 * @module src/constants/cookieConstants
 */

/**
 * Regular expression to validate cookie names as per RFC 6265 Section 4.1.1.
 *
 * The cookie name must conform to the `token` definition from RFC 7230 Appendix B,
 * allowing only specific ASCII characters. This implementation expands the
 * character range to match cookie values, except for the `=` character, which delimits the end of a name.
 *
 * @constant
 * @type {RegExp}
 *
 * @see [RFC 6265 Section 4.1.1](https://datatracker.ietf.org/doc/html/rfc6265#section-4.1.1)
 * @see [RFC 7230 Appendix B](https://datatracker.ietf.org/doc/html/rfc7230#appendix-B)
 *
 * @example
 * COOKIE_NAME_REG_EXP.test("valid_cookie_name"); // true
 * COOKIE_NAME_REG_EXP.test("invalid=name"); // false
 */
export const COOKIE_NAME_REG_EXP = /^[\u0021-\u003A\u003C\u003E-\u007E]+$/;

/**
 * Regular expression to validate cookie values as per RFC 6265 Section 4.1.1.
 *
 * The cookie value can be a sequence of valid `cookie-octet` characters or
 * a quoted string containing these characters. This regular expression ensures compliance
 * with US-ASCII character restrictions while allowing expanded characters as discussed in issues.
 *
 * @constant
 * @type {RegExp}
 *
 * @see [RFC 6265 Section 4.1.1](https://datatracker.ietf.org/doc/html/rfc6265#section-4.1.1)
 *
 * @example
 * COOKIE_VALUE_REG_EXP.test("valid_value"); // true
 * COOKIE_VALUE_REG_EXP.test("invalid,value"); // false
 */
export const COOKIE_VALUE_REG_EXP = /^[\u0021-\u003A\u003C-\u007E]*$/;

/**
 * Regular expression to validate domain values as per RFC 6265 Section 4.1.1.
 *
 * The domain value must adhere to the rules for subdomains, defined in RFC 1034 Section 3.5
 * and enhanced by RFC 1123 Section 2.1. It supports a leading dot (`.`) for backward compatibility,
 * though it will be ignored during validation as per the cookie specification.
 *
 * @constant
 * @type {RegExp}
 *
 * @see [RFC 6265 Section 4.1.1](https://datatracker.ietf.org/doc/html/rfc6265#section-4.1.1)
 * @see [RFC 1034 Section 3.5](https://datatracker.ietf.org/doc/html/rfc1034#section-3.5)
 * @see [RFC 1123 Section 2.1](https://datatracker.ietf.org/doc/html/rfc1123#section-2.1)
 *
 * @example
 * DOMAIN_VALUE_REG_EXP.test(".example.com"); // true
 * DOMAIN_VALUE_REG_EXP.test("invalid_domain."); // false
 */
export const DOMAIN_VALUE_REG_EXP =
  /^([.]?[a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?)([.][a-z0-9]([a-z0-9-]{0,61}[a-z0-9])?)*$/i;

/**
 * Regular expression to validate path values as per RFC 6265 Section 4.1.1.
 *
 * The path value must exclude control characters (`CTLs`), spaces, and semicolons (`;`).
 * This regular expression ensures compliance by only allowing characters defined
 * in the US-ASCII range, excluding forbidden characters.
 *
 * @constant
 * @type {RegExp}
 *
 * @see [RFC 6265 Section 4.1.1](https://datatracker.ietf.org/doc/html/rfc6265#section-4.1.1)
 * @see [RFC 5234 Appendix B.1](https://datatracker.ietf.org/doc/html/rfc5234#appendix-B.1)
 *
 * @example
 * PATH_VALUE_REG_EXP.test("/valid/path"); // true
 * PATH_VALUE_REG_EXP.test("invalid path"); // false
 * PATH_VALUE_REG_EXP.test("invalid;path"); // false
 */
export const PATH_VALUE_REG_EXP = /^[\u0021-\u003A\u003D-\u007E]*$/;
