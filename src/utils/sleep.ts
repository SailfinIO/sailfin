/**
 * @fileoverview
 * Utility function for pausing execution for a specified duration.
 * This module provides a `sleep` function that returns a promise which resolves
 * after a given number of milliseconds. It includes input validation to ensure
 * the delay duration is within acceptable bounds.
 *
 * @module src/utils/sleep
 */

import { ClientError } from '../errors/ClientError';

/**
 * The maximum allowed milliseconds for the sleep function.
 * This is set to the maximum delay allowed by Node.js's `setTimeout`.
 */
const MAX_MS = 2 ** 31 - 1; // 2147483647 ms (~24.8 days)

/**
 * Pauses execution for the specified number of milliseconds.
 *
 * This function returns a promise that resolves after the given delay.
 * It includes input validation to ensure the delay is a non-negative integer
 * and does not exceed the maximum allowed duration.
 *
 * @param {number} ms - The number of milliseconds to sleep.
 * @returns {Promise<void>} A promise that resolves after the specified delay.
 * @throws {ClientError} If `ms` is not a finite number, not an integer, negative, or exceeds the maximum allowed duration.
 *
 * @example
 * ```typescript
 * await sleep(1000); // Sleeps for 1 second
 * console.log('Slept for 1 second');
 * ```
 */
export const sleep = async (ms: number): Promise<void> => {
  // Validate that ms is a finite number
  if (typeof ms !== 'number' || !Number.isFinite(ms)) {
    throw new ClientError('Milliseconds must be a finite number', 'INVALID_MS');
  }

  // Validate that ms is a non-negative integer
  if (!Number.isInteger(ms) || ms < 0) {
    throw new ClientError(
      'Milliseconds must be a non-negative integer',
      'INVALID_MS',
    );
  }

  // Validate that ms does not exceed the maximum allowed duration
  if (ms > MAX_MS) {
    throw new ClientError(
      `Milliseconds must not exceed ${MAX_MS}`,
      'MS_EXCEEDED',
    );
  }

  return new Promise((resolve) => setTimeout(resolve, ms));
};
