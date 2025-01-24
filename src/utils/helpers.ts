// src/utils/helpers.ts

/**
 * @fileoverview
 * Provides utility helper functions for cookie operations.
 *
 * @module src/utils/helpers
 */

/**
 * Capitalizes the first letter of a string.
 *
 * @param {string} s - The string to capitalize.
 * @returns {string} The capitalized string.
 *
 * @example
 * capitalize("hello"); // "Hello"
 */
export const capitalize = (s: string): string =>
  s.charAt(0).toUpperCase() + s.slice(1);

/**
 * Converts a camelCase string to kebab-case.
 *
 * @param {string} s - The camelCase string.
 * @returns {string} The kebab-case string.
 *
 * @example
 * camelToKebab("maxAge"); // "max-age"
 */
export const camelToKebab = (s: string): string =>
  s.replace(/([A-Z])/g, '-$1').toLowerCase();

/**
 * Checks the environment to determinem, i.e. production or development.
 *
 * @returns {boolean} True if the environment is production, false otherwise.
 */
export const isProduction = (): boolean => {
  // create a new RegExp object to match the environment
  const prodRegExp = new RegExp(/production|prod|PROD|Prod|PRODUCTION|prd/);
  // return the result of the match
  return prodRegExp.test(process.env.NODE_ENV);
};
