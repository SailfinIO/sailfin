/**
 * @fileoverview
 * Defines the `ICache` interface for a generic caching mechanism.
 * This interface provides a contract for implementing cache operations,
 * including basic CRUD functionality and size management.
 *
 * @module src/interfaces/ICache
 */

/**
 * Represents a generic cache interface with CRUD operations and TTL (time-to-live) support.
 *
 * The `ICache` interface provides methods for storing, retrieving, deleting, and managing cache entries.
 * Implementations of this interface can use various storage mechanisms (e.g., in-memory, distributed caches).
 *
 * @template T The type of values to be stored in the cache.
 */
export interface ICache<T> {
  /**
   * Retrieves a value from the cache by key.
   *
   * @param {string} key - The key associated with the value.
   * @returns {T | undefined} The cached value, or `undefined` if the key does not exist or is expired.
   * @example
   * ```typescript
   * const value = cache.get('myKey');
   * if (value) {
   *   console.log('Cache hit:', value);
   * } else {
   *   console.log('Cache miss');
   * }
   * ```
   */
  get(key: string): T | undefined;

  /**
   * Stores a value in the cache with an optional TTL.
   *
   * @param {string} key - The key to associate with the value.
   * @param {T} value - The value to store in the cache.
   * @param {number} [ttl] - Optional time-to-live (TTL) in milliseconds. If not provided, the default TTL is used.
   * @example
   * ```typescript
   * cache.set('myKey', 'myValue', 60000); // Cache for 60 seconds
   * ```
   */
  set(key: string, value: T, ttl?: number): void;

  /**
   * Deletes a value from the cache by key.
   *
   * @param {string} key - The key of the value to delete.
   * @example
   * ```typescript
   * cache.delete('myKey');
   * ```
   */
  delete(key: string): void;

  /**
   * Clears all entries from the cache.
   *
   * @example
   * ```typescript
   * cache.clear();
   * console.log('Cache cleared');
   * ```
   */
  clear(): void;

  /**
   * Returns the number of entries currently stored in the cache.
   *
   * @returns {number} The number of cache entries.
   * @example
   * ```typescript
   * console.log(`Cache size: ${cache.size()}`);
   * ```
   */
  size(): number;
}
