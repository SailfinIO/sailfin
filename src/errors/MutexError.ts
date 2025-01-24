import { ClientError } from './ClientError';

/**
 * Custom error class for mutex-related errors.
 *
 * The `MutexError` class extends the native `Error` class by adding a `code` property
 * to categorize the error type. This facilitates more granular error handling
 * and better debugging capabilities specific to mutex operations.
 *
 * @class MutexError
 * @extends {ClientError}
 */
export class MutexError extends ClientError {
  /**
   * Creates an instance of `MutexError`.
   *
   * @param {string} message - A human-readable description of the error.
   * @param {string} [code='MUTEX_ERROR'] - A short string code identifying the error type.
   * @param {*} [context] - Optional additional context or data related to the error.
   *
   * @example
   * ```typescript
   * throw new MutexError('Failed to acquire lock', 'ACQUIRE_FAILED', { resource: 'database' });
   * ```
   */
  constructor(message: string, code: string = 'MUTEX_ERROR', context?: any) {
    super(message, code, context);
  }
}
