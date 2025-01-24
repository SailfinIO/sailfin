// src/types/NextFunction.ts

/**
 * NextFunction type definition.
 * @typedef {(err?: any) => Promise<void>} NextFunction
 * @param {any} [err] - Optional error object.
 * @returns {Promise<void>} A promise that resolves when the function completes.
 * @example
 * const next: NextFunction = async (err) => {
 *  if (err) {
 *    // Handle error
 *  }
 *  // Proceed to next middleware
 * };
 */
export type NextFunction = (err?: any) => Promise<void>;
