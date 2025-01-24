/**
 * @fileoverview
 * Defines the `StoreOptions` interface, which provides configuration options
 * for session stores. This interface supports configuring storage mechanisms,
 * session cookies, and custom session store implementations.
 *
 * @module src/interfaces/StoreOptions
 */

import { CookieOptions } from './CookieOptions';
import { ISessionStore } from './ISessionStore';

/**
 * Represents the configuration options for creating a session store.
 *
 * The `StoreOptions` interface allows customization of session behavior,
 * including storage TTL, cookie properties, and the ability to use a custom session store.
 *
 * @interface
 */
export interface StoreOptions {
  /**
   * Configures the storage mechanism for the session store.
   *
   * @property {number} [ttl] - The time-to-live (TTL) for stored session data, in milliseconds.
   *
   * @example
   * const options: StoreOptions = {
   *   storage: {
   *     ttl: 3600000, // 1 hour
   *   },
   * };
   */
  storage?: {
    ttl?: number;
  };

  /**
   * Configures session-specific options, including cookies and custom stores.
   *
   * @property {Object} [cookie] - Options related to session cookies.
   * @property {string} [cookie.name] - The name of the session cookie.
   * @property {CookieOptions} [cookie.options] - Additional attributes for the session cookie.
   * @property {ISessionStore} [store] - A custom session store implementation.
   *
   * @example
   * const options: StoreOptions = {
   *   session: {
   *     cookie: {
   *       name: 'mySessionCookie',
   *       options: {
   *         secure: true,
   *         httpOnly: true,
   *         sameSite: 'strict',
   *       },
   *     },
   *     store: myCustomSessionStore,
   *   },
   * };
   */
  session?: {
    cookie?: {
      name?: string;
      options?: CookieOptions;
    };
    store?: ISessionStore;
  };
}
