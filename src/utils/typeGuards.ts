// src/utils/typeGuards.ts

/**
 * @fileoverview
 * Provides type guard functions for cookie operations.
 *
 * @module src/utils/typeGuards
 */

/**
 * Type guard to check if a value is a `Date` instance.
 *
 * @param {any} value - The value to check.
 * @returns {value is Date} `true` if the value is a `Date`, otherwise `false`.
 */
export const isDate = (value: any): value is Date => value instanceof Date;
