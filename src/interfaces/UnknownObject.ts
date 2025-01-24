/**
 * @fileoverview
 * Defines the `UnknownObject` interface, representing a generic key-value mapping
 * where keys are strings and values are of type `unknown`. This type is commonly
 * used to represent dynamic or loosely-typed objects in TypeScript.
 *
 * @module src/interfaces/UnknownObject
 */

/**
 * Represents a generic object with string keys and `unknown` values.
 *
 * The `UnknownObject` interface is used to define dynamic or loosely-typed objects
 * where the structure and types of the values are not predetermined. It is useful
 * in scenarios where objects may have arbitrary properties with varying types.
 *
 * @interface UnknownObject
 * @typedef {UnknownObject}
 * @type {Record<string, unknown>}
 *
 * @example
 * ```typescript
 * const data: UnknownObject = {
 *   key1: 'value1',
 *   key2: 42,
 *   key3: { nestedKey: 'nestedValue' },
 *   key4: [1, 2, 3],
 * };
 * ```
 */
export interface UnknownObject {
  /**
   * A generic key-value pair where the key is a string and the value is of type `unknown`.
   *
   * @type {unknown}
   */
  [key: string]: unknown;
}
