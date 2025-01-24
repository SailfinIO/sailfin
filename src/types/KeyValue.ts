/**
 * @fileoverview
 * Defines the `KeyValue` type, a generic key-value mapping where both keys and values are strings.
 * This type can be used across various parts of the application for different categorization or mapping needs.
 *
 * @module src/types/KeyValue
 */

/**
 * Represents a generic key-value mapping where both keys and values are strings.
 *
 * The `KeyValue` type is versatile and can be used to define mappings for various purposes,
 * such as configuration settings, metadata, or any other scenario requiring key-value pairs.
 *
 * @typedef {KeyValue}
 * @type {Record<string, string>}
 *
 * @example
 * ```typescript
 * const config: KeyValue = {
 *   apiUrl: 'https://api.example.com',
 *   timeout: '5000',
 *   retryAttempts: '3',
 * };
 * ```
 */
export type KeyValue = Record<string, string>;
