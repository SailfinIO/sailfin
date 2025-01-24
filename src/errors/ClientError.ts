/**
 * @fileoverview
 * Custom error class for client-related errors.
 * This module defines the `ClientError` class, which extends the native `Error` class.
 * It provides additional properties such as an error code and contextual information
 * to facilitate more precise error handling and debugging in client-side operations.
 *
 * @module src/errors/ClientError
 */

/**
 * Represents errors that occur on the client side.
 *
 * The `ClientError` class extends the native `Error` class by adding a `code` property
 * to categorize the error type and an optional `context` property to provide
 * additional information related to the error. This facilitates more granular error handling
 * and better debugging capabilities.
 *
 * @class ClientError
 * @extends {Error}
 */
export class ClientError extends Error {
  /**
   * A short string code identifying the type of error.
   *
   * @type {string}
   */
  public code: string;

  /**
   * Optional contextual information related to the error.
   *
   * @type {*}
   */
  public context?: any;

  /**
   * Creates an instance of `ClientError`.
   *
   * @param {string} message - A human-readable description of the error.
   * @param {string} [code='CLIENT_ERROR'] - A short string code identifying the error type.
   * @param {*} [context] - Optional additional context or data related to the error.
   *
   * @example
   * ```typescript
   * throw new ClientError('Invalid user input', 'INVALID_INPUT', { field: 'email' });
   * ```
   */
  constructor(message: string, code: string = 'CLIENT_ERROR', context?: any) {
    super(message);
    this.name = this.constructor.name;
    this.code = code;
    this.context = context;
    Object.setPrototypeOf(this, new.target.prototype);

    if (Error.captureStackTrace) {
      Error.captureStackTrace(this, this.constructor);
    }
  }
}
