/**
 * @fileoverview
 * Implements the `Store` class, which provides a factory method for creating
 * session store instances based on a specified storage mechanism. Supports
 * memory-based and cookie-based storage.
 *
 * @module src/classes/Store
 */

import { ILogger } from '../interfaces/ILogger';
import { ISessionStore } from '../interfaces/ISessionStore';
import { MemoryStore } from './MemoryStore';
import { CookieStore } from './CookieStore';
import { StorageMechanism } from '../enums';
import { StoreOptions } from '../interfaces';
import { SessionStore } from './SessionStore';

/**
 * Represents the result of the `Store.create` method.
 *
 * The object includes a `sessionStore` property that holds the created session
 * store instance or `null` if none is created.
 *
 * @interface StoreInstances
 */
export interface StoreInstances {
  sessionStore: ISessionStore | null;
}

/**
 * Factory class for creating session stores based on a specified storage mechanism.
 *
 * The `Store` class supports memory-based and cookie-based session stores and can
 * be extended to support additional mechanisms in the future.
 *
 * @class
 */
export class Store {
  /**
   * Creates a session store instance based on the specified storage mechanism.
   *
   * @param {StorageMechanism} storageType - The type of storage mechanism (e.g., MEMORY or COOKIE).
   * @param {StoreOptions} [options] - Configuration options for the store.
   * @param {ILogger} [logger] - Optional logger instance for logging store operations.
   * @returns {StoreInstances} An object containing the `sessionStore` instance.
   * @throws {Error} Throws an error if the specified storage type is unsupported.
   */
  public static create(
    storageType: StorageMechanism,
    options?: StoreOptions,
    logger?: ILogger,
  ): StoreInstances {
    // 1) If the user provides a custom session store, use it directly.
    if (options?.session?.store) {
      return { sessionStore: options.session.store };
    }

    const DEFAULT_TTL = 3600000; // 1 hour

    switch (storageType) {
      case StorageMechanism.COOKIE: {
        const ttl = options?.storage?.ttl ?? DEFAULT_TTL;
        const internalStore = new MemoryStore(logger, ttl);
        const sessionStore = new CookieStore(
          options?.session?.cookie?.name,
          options?.session?.cookie?.options,
          internalStore,
        );
        return { sessionStore };
      }

      case StorageMechanism.MEMORY: {
        const ttl = options?.storage?.ttl ?? DEFAULT_TTL;
        const sessionStore = new SessionStore(logger, ttl);
        return { sessionStore };
      }

      default:
        throw new Error(`Unsupported storage type: ${storageType}`);
    }
  }
}
