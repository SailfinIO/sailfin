// src/errors/CookieError.ts

import { ClientError } from './ClientError';

/**
 * @fileoverview
 * Defines custom error classes for cookie operations.
 * This module provides the `CookieError` class, which is used to throw
 * and handle errors specifically related to cookie parsing and serialization.
 *
 * @module src/errors/CookieError
 */

/**
 * Represents errors that occur during cookie operations.
 *
 * The `CookieError` class extends the  `ClientError` class to provide
 * more granular error handling for cookie-related issues. This allows consumers
 * of the library to catch and handle cookie-specific errors separately from other errors.
 *
 * @class CookieError
 * @extends {ClientError}
 */
export class CookieError extends ClientError {
  /**
   * Creates an instance of `CookieError`.
   *
   * @param {string} message - The error message.
   */
  constructor(message: string, code: string = 'COOKIE_ERROR', context?: any) {
    super(message, code, context);
  }
}
