/**
 * @fileoverview
 * Defines the `Cookie` class for parsing and serializing HTTP cookies.
 * This class provides methods to parse cookie headers and serialize cookie objects
 * into strings suitable for the `Set-Cookie` HTTP header.
 *
 * @module src/utils/Cookie
 */

import { Priority, SameSite, CookieAttribute } from '../enums';
import { ParseOptions, CookieOptions } from '../interfaces';
import { NullObject } from './NullObject';
import {
  validateCookieName,
  validateCookieValue,
  validateDomain,
  validatePath,
} from './validators';
import { isDate } from './typeGuards';
import { capitalize } from './helpers';
import { CookieError } from '../errors/CookieError';

/**
 * Represents a collection of parsed cookies.
 *
 * The `ParsedCookies` interface defines a mapping from cookie names to their values.
 *
 */
export interface ParsedCookies {
  [name: string]: string;
}

/**
 * Defines the structure of attribute handlers for serialization.
 *
 * Each handler is a function that takes the attribute value and modifies the
 * serialized cookie string accordingly.
 */
type AttributeHandler = (value: any) => void;

/**
 * Parses a cookie header string into a `ParsedCookies` object.
 *
 * @param {string} cookieHeader - The raw `Cookie` header string.
 * @param {ParseOptions} [options] - Optional parsing options.
 * @returns {ParsedCookies} An object mapping cookie names to their values.
 * @throws {CookieError} Throws an error if parsing fails.
 */
export const parse = (
  cookieHeader: string,
  options?: ParseOptions,
): ParsedCookies => {
  const cookies: ParsedCookies = new NullObject() as ParsedCookies;
  const headerLength = cookieHeader.length;

  if (headerLength < 2) return cookies;

  const decodeValue = options?.decode || decodeURIComponent;
  let currentIndex = 0;

  do {
    const equalsIndex = cookieHeader.indexOf('=', currentIndex);
    if (equalsIndex === -1) break;

    const semicolonIndex = cookieHeader.indexOf(';', currentIndex);
    const segmentEndIndex =
      semicolonIndex === -1 ? headerLength : semicolonIndex;

    if (equalsIndex > segmentEndIndex) {
      currentIndex = cookieHeader.lastIndexOf(';', equalsIndex - 1) + 1;
      continue;
    }

    const keyStartIndex = skipWhitespace(
      cookieHeader,
      currentIndex,
      equalsIndex,
      true,
    );
    const keyEndIndex = skipWhitespace(
      cookieHeader,
      equalsIndex,
      keyStartIndex,
      false,
    );
    const cookieName = cookieHeader.slice(keyStartIndex, keyEndIndex);

    if (cookies[cookieName] === undefined) {
      const valueStartIndex = skipWhitespace(
        cookieHeader,
        equalsIndex + 1,
        segmentEndIndex,
        true,
      );
      const valueEndIndex = skipWhitespace(
        cookieHeader,
        segmentEndIndex,
        valueStartIndex,
        false,
      );

      const rawValue = cookieHeader.slice(valueStartIndex, valueEndIndex);
      const cookieValue = decodeValue(rawValue);
      cookies[cookieName] = cookieValue;
    }

    currentIndex = segmentEndIndex + 1;
  } while (currentIndex < headerLength);

  return cookies;
};

/**
 * Serializes a cookie name, value, and options into a `Set-Cookie` header string.
 *
 * @param {string} cookieName - The name of the cookie.
 * @param {string} cookieValue - The value of the cookie.
 * @param {CookieOptions} [options] - Optional serialization options.
 * @returns {string} The serialized `Set-Cookie` header string.
 * @throws {CookieError} Throws an error if serialization fails.
 */
export const serialize = (
  cookieName: string,
  cookieValue: string,
  options: CookieOptions = {},
): string => {
  const encodeValue = options.encode || encodeURIComponent;

  validateCookieName(cookieName);
  const encodedValue = encodeValue(cookieValue);
  validateCookieValue(encodedValue);

  let cookieString = `${cookieName}=${encodedValue}`;

  const attributeHandlers: Record<CookieAttribute, AttributeHandler> = {
    [CookieAttribute.MaxAge]: (value) => {
      if (!Number.isInteger(value)) {
        throw new CookieError(`Invalid Max-Age: ${value}`);
      }
      cookieString += `; Max-Age=${value}`;
    },
    [CookieAttribute.Domain]: (value: string) => {
      const trimmedValue = value.trim();
      validateDomain(trimmedValue);
      cookieString += `; Domain=${trimmedValue}`;
    },
    [CookieAttribute.Path]: (value: string) => {
      const trimmedValue = value.trim();
      validatePath(trimmedValue);
      cookieString += `; Path=${trimmedValue}`;
    },
    [CookieAttribute.Expires]: (value: Date) => {
      if (isDate(value)) {
        cookieString += `; Expires=${value.toUTCString()}`;
      } else {
        throw new CookieError(`Invalid Expires: ${value}`);
      }
    },
    [CookieAttribute.HttpOnly]: () => {
      if (options.httpOnly) cookieString += '; HttpOnly';
    },
    [CookieAttribute.Secure]: () => {
      if (options.secure) cookieString += '; Secure';
    },
    [CookieAttribute.Partitioned]: () => {
      if (options.partitioned) cookieString += '; Partitioned';
    },
    [CookieAttribute.Priority]: (value: Priority) => {
      const normalizedPriority = value.toLowerCase();
      if (
        [Priority.LOW, Priority.MEDIUM, Priority.HIGH].includes(
          normalizedPriority as Priority,
        )
      ) {
        const capitalizedPriority = capitalize(normalizedPriority);
        cookieString += `; Priority=${capitalizedPriority}`;
      } else {
        throw new CookieError(`Invalid Priority: ${value}`);
      }
    },
    [CookieAttribute.SameSite]: (value: SameSite) => {
      if (Object.values(SameSite).includes(value)) {
        const capitalizedSameSite = capitalize(value);
        cookieString += `; SameSite=${capitalizedSameSite}`;
      } else {
        throw new CookieError(`Invalid SameSite: ${value}`);
      }
    },
  };

  Object.keys(options).forEach((optionKey) => {
    const attributeKey = optionKey as CookieAttribute;
    if (attributeHandlers[attributeKey]) {
      attributeHandlers[attributeKey](options[attributeKey]);
    }
  });

  return cookieString;
};

/**
 * Skips whitespace characters in the input string.
 *
 * @param {string} input - The input string to process.
 * @param {number} index - The starting index.
 * @param {number} limit - The limit index.
 * @param {boolean} forward - Direction to move (true for forward, false for backward).
 * @returns {number} The new index after skipping whitespace.
 */
const skipWhitespace = (
  input: string,
  index: number,
  limit: number,
  forward: boolean,
): number => {
  const CharCode = {
    Space: 0x20,
    Tab: 0x09,
  };

  while (forward ? index < limit : index > limit) {
    const charCode = input.charCodeAt(forward ? index : --index);
    if (charCode !== CharCode.Space && charCode !== CharCode.Tab) {
      return forward ? index : index + 1;
    }
    if (forward) index++;
  }
  return limit;
};

/**
 * Represents a single HTTP cookie with name, value, and optional attributes.
 *
 * The `Cookie` class provides methods to serialize the cookie into a string suitable
 * for the `Set-Cookie` HTTP header and to parse a raw cookie string into a `Cookie` instance.
 *
 * @class
 */
export class Cookie {
  private readonly _name: string;
  private _value: string;
  private _options: CookieOptions;

  /**
   * Creates an instance of `Cookie`.
   *
   * @param {string} name - The name of the cookie.
   * @param {string} value - The value of the cookie.
   * @param {CookieOptions} [options={}] - Optional cookie attributes.
   * @throws {CookieError} Throws an error if the name or value is invalid.
   */
  constructor(name: string, value: string, options: CookieOptions = {}) {
    validateCookieName(name);
    validateCookieValue(value);

    this._name = name;
    this._value = value;
    this._options = options;
  }

  /**
   * Serializes the cookie into a string suitable for the `Set-Cookie` header.
   *
   * @returns {string} The serialized `Set-Cookie` string.
   */
  public serialize(): string {
    return serialize(this._name, this._value, this._options);
  }

  /**
   * Parses a raw cookie string into a `Cookie` instance.
   *
   * @param {string} cookieString - The raw cookie string to parse.
   * @param {ParseOptions} [options] - Optional parsing options.
   * @returns {Cookie} The parsed `Cookie` instance.
   * @throws {CookieError} Throws an error if parsing fails.
   */
  static parse(cookieString: string, options?: ParseOptions): Cookie {
    const parsed = parse(cookieString, options);
    const names = Object.keys(parsed);

    if (names.length === 0) {
      throw new CookieError(
        'Failed to parse cookie string: No valid cookies found.',
      );
    }

    const name = names[0];
    const value = parsed[name];

    if (!name || value === undefined) {
      throw new CookieError(
        'Failed to parse cookie string: Missing name or value.',
      );
    }

    const attributeOptions: CookieOptions = {};
    const attributes = cookieString
      .split(';')
      .slice(1)
      .map((attr) => attr.trim());

    const attributeParsers: Record<string, (value?: string) => void> = {
      'max-age': (value) => {
        if (value !== undefined) {
          const parsedValue = Number(value);
          if (Number.isNaN(parsedValue)) {
            throw new CookieError(`Invalid Max-Age value: ${value}`);
          }
          attributeOptions.maxAge = parsedValue;
        }
      },
      domain: (value) => {
        if (value) {
          validateDomain(value);
          attributeOptions.domain = value;
        }
      },
      path: (value) => {
        if (value) {
          validatePath(value);
          attributeOptions.path = value;
        }
      },
      expires: (value) => {
        if (value) {
          const date = new Date(value);
          if (isNaN(date.getTime())) {
            throw new CookieError(`Invalid Expires value: ${value}`);
          }
          attributeOptions.expires = date;
        }
      },
      httponly: () => {
        attributeOptions.httpOnly = true;
      },
      secure: () => {
        attributeOptions.secure = true;
      },
      partitioned: () => {
        attributeOptions.partitioned = true;
      },
      priority: (value) => {
        if (value) {
          const lowerValue = value.toLowerCase() as Priority;
          if (
            [Priority.LOW, Priority.MEDIUM, Priority.HIGH].includes(lowerValue)
          ) {
            attributeOptions.priority = lowerValue;
          } else {
            throw new CookieError(`Invalid Priority value: ${value}`);
          }
        }
      },
      samesite: (value) => {
        if (value) {
          const lowerValue = value.toLowerCase() as SameSite;
          if (Object.values(SameSite).includes(lowerValue)) {
            attributeOptions.sameSite = lowerValue;
          } else {
            throw new CookieError(`Invalid SameSite value: ${value}`);
          }
        }
      },
    };

    attributes.forEach((attr) => {
      const [attrName, attrValue] = attr.split('=');
      const handler = attributeParsers[attrName.toLowerCase()];
      if (handler) {
        handler(attrValue);
      }
    });

    return new Cookie(name, value, attributeOptions);
  }

  /**
   * Converts the `Cookie` instance to a JSON representation.
   *
   * @returns {{ name: string; value: string; options?: CookieOptions }} The JSON representation.
   */
  public toJSON(): {
    name: string;
    value: string;
    options?: CookieOptions;
  } {
    return {
      name: this._name,
      value: this._value,
      options: this._options,
    };
  }

  /**
   * Updates the value of the cookie.
   *
   * @param {string} newValue - The new value to set.
   * @throws {CookieError} Throws an error if the new value is invalid.
   */
  public setValue(newValue: string): void {
    validateCookieValue(newValue);
    this._value = newValue;
  }

  /**
   * Updates the options (attributes) of the cookie.
   *
   * @param {CookieOptions} newOptions - The new options to set.
   * @throws {CookieError} Throws an error if any new option is invalid.
   */
  public setOptions(newOptions: CookieOptions): void {
    if (newOptions.domain) {
      validateDomain(newOptions.domain);
    }
    if (newOptions.path) {
      validatePath(newOptions.path);
    }

    this._options = { ...this._options, ...newOptions };
  }

  /**
   * Retrieves the name of the cookie.
   *
   * @returns {string} The cookie name.
   */
  public get name(): string {
    return this._name;
  }

  /**
   * Retrieves the value of the cookie.
   *
   * @returns {string} The cookie value.
   */
  public get value(): string {
    return this._value;
  }

  /**
   * Retrieves the options (attributes) of the cookie.
   *
   * @returns {CookieOptions} The cookie options.
   */
  public get options(): CookieOptions {
    return this._options;
  }
}
