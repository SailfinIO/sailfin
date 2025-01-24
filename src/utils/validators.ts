// src/utils/validators.ts

import {
  COOKIE_NAME_REG_EXP,
  COOKIE_VALUE_REG_EXP,
  DOMAIN_VALUE_REG_EXP,
  PATH_VALUE_REG_EXP,
} from '../constants/cookieConstants';
import { CookieError } from '../errors/CookieError';

/**
 * @fileoverview
 * Provides validation functions for cookie attributes.
 *
 * @module src/utils/validators
 */

/**
 * Validates a string against a regular expression.
 *
 * @param {string} value - The string to validate.
 * @param {RegExp} regExp - The regular expression to test against.
 * @param {string} errorMessage - The error message to throw if validation fails.
 * @throws {CookieError} Throws an error if the validation fails.
 */
export const validateWithRegExp = (
  value: string,
  regExp: RegExp,
  errorMessage: string,
): void => {
  if (!regExp.test(value)) {
    throw new CookieError(errorMessage);
  }
};

/**
 * Validates the cookie name.
 *
 * @param {string} name - The cookie name to validate.
 * @throws {CookieError} Throws an error if the cookie name is invalid.
 */
export const validateCookieName = (name: string): void => {
  validateWithRegExp(name, COOKIE_NAME_REG_EXP, `Invalid cookie name: ${name}`);
};

/**
 * Validates the cookie value.
 *
 * @param {string} value - The cookie value to validate.
 * @throws {CookieError} Throws an error if the cookie value is invalid.
 */
export const validateCookieValue = (value: string): void => {
  validateWithRegExp(
    value,
    COOKIE_VALUE_REG_EXP,
    `Invalid cookie value: ${value}`,
  );
};

/**
 * Validates the domain attribute.
 *
 * @param {string} domain - The domain to validate.
 * @throws {CookieError} Throws an error if the domain is invalid.
 */
export const validateDomain = (domain: string): void => {
  validateWithRegExp(domain, DOMAIN_VALUE_REG_EXP, `Invalid domain: ${domain}`);
};

/**
 * Validates the path attribute.
 *
 * @param {string} path - The path to validate.
 * @throws {CookieError} Throws an error if the path is invalid.
 */
export const validatePath = (path: string): void => {
  validateWithRegExp(path, PATH_VALUE_REG_EXP, `Invalid path: ${path}`);
};
