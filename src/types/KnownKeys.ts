/**
 * @fileoverview
 * Defines the `KnownKeys` type, a utility type for extracting explicitly defined keys
 * from a given object type `T`. This excludes index signature keys like `string` or `number`.
 *
 * @module src/types/KnownKeys
 */

/**
 * Extracts explicitly defined keys from an object type `T`, excluding index signature keys.
 *
 * The `KnownKeys` type is useful for working with object types where you need to differentiate
 * explicitly defined keys from those introduced by index signatures (e.g., `[key: string]: any`).
 *
 * @template T The object type from which to extract keys.
 *
 * @typedef {KnownKeys<T>}
 * @type {keyof T}
 *
 * @example
 * ```typescript
 * interface MyObject {
 *   name: string;
 *   age: number;
 *   [key: string]: any; // Index signature
 * }
 *
 * type ExplicitKeys = KnownKeys<MyObject>; // 'name' | 'age'
 *
 * const obj: ExplicitKeys = 'name'; // Valid
 * const invalidKey: ExplicitKeys = 'randomKey'; // TypeScript Error
 * ```
 */
export type KnownKeys<T> = {
  [K in keyof T]: string extends K ? never : number extends K ? never : K;
} extends { [_ in keyof T]: infer U }
  ? {} extends U
    ? never
    : U
  : never;
