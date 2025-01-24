// src/decorators/KeyFactory.ts

/**
 * @fileoverview Helper to generate unique string keys for constructors.
 * This helper maps a constructor (Function) to a unique string key.
 * We use a WeakMap so once the constructor is GC-ed, it won't leak memory.
 */

/**
 *
 * @class KeyFactory
 * @classdesc Helper to generate unique string keys for constructors.
 * This helper maps a constructor (Function) to a unique string key.
 * We use a WeakMap so once the constructor is GC-ed, it won't leak memory.
 * @example
 * import { KeyFactory } from './KeyFactory';
 * class MyClass {
 *  // Your class code here
 * }
 */
export class KeyFactory {
  private static readonly functionKeyMap = new WeakMap<Function, string>();
  private static counter = 0;

  /**
   * Get or generate a unique string key for the given constructor.
   * @param {Function} target - The constructor function.
   * @returns {string} A unique string key for the constructor.
   */
  public static getKeyForFunction(target: Function): string {
    if (!this.functionKeyMap.has(target)) {
      this.counter += 1;
      const uniqueKey = `ctor_${this.counter}`;
      this.functionKeyMap.set(target, uniqueKey);
    }
    return this.functionKeyMap.get(target)!;
  }
}
