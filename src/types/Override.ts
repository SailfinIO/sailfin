/**
 * @fileoverview
 * Defines the `Override` type, a utility type for merging two types `T1` and `T2`.
 * It ensures that properties from `T2` override those in `T1`, while preserving
 * explicitly defined keys from both types.
 *
 * @module src/types/Override
 */

import { KnownKeys } from './KnownKeys';

/**
 * Combines two types `T1` and `T2`, with properties in `T2` overriding those in `T1`.
 *
 * The `Override` type merges two types, ensuring that explicitly defined keys in `T2`
 * take precedence over those in `T1`. This is especially useful for creating derived
 * types that selectively override properties while retaining the structure of the base type.
 *
 * @template T1 The base type.
 * @template T2 The overriding type.
 *
 * @typedef {Override<T1, T2>}
 * @type {Omit<T1, keyof Omit<T2, keyof KnownKeys<T2>>> & T2}
 *
 * @example
 * ```typescript
 * import { Override } from './types/Override';
 *
 * interface Base {
 *   id: string;
 *   name: string;
 *   description: string;
 * }
 *
 * interface Overrides {
 *   name: number; // Overrides `name` from Base
 *   additionalField: boolean;
 * }
 *
 * type Combined = Override<Base, Overrides>;
 *
 * const obj: Combined = {
 *   id: '123',
 *   name: 42, // `name` is overridden as number
 *   description: 'A sample description',
 *   additionalField: true,
 * };
 * ```
 */
export type Override<T1, T2> = Omit<T1, keyof Omit<T2, keyof KnownKeys<T2>>> &
  T2;
