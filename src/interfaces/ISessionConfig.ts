import { SessionMode, StorageMechanism } from '../enums';
import { ICookieConfig } from './ICookieConfig';
import { ISessionStore } from './ISessionStore';
import { StoreOptions } from './StoreOptions';

export interface ISessionConfig {
  /**
   * Specifies the session management mode: 'server', 'client', or 'hybrid'.
   *
   * @type {SessionMode}
   */
  mode?: SessionMode;

  /**
   * Storage mechanism for server-side sessions.
   *
   * @type {StorageMechanism | undefined}
   */
  serverStorage?: StorageMechanism;

  /**
   * Storage mechanism for client-side sessions.
   *
   * @type {StorageMechanism | undefined}
   */
  clientStorage?: StorageMechanism;

  /**
   * Specific options for session storage, based on the selected mechanism.
   *
   * @type {StoreOptions | undefined}
   */
  options?: StoreOptions;

  /**
   * Custom session store implementation for server-side sessions.
   *
   * @type {ISessionStore | undefined}
   */
  store?: ISessionStore;

  /**
   * Enables silent token renewal.
   *
   * @type {boolean | undefined}
   */
  useSilentRenew?: boolean;

  /**
   * Time-to-live (TTL) for the session in milliseconds.
   *
   * @type {number | undefined}
   */
  ttl?: number;

  /**
   * Configuration for the session cookie.
   *
   * @property {string | undefined} name - The name of the session cookie (e.g., 'sid').
   * @property {CookieOptions | undefined} options - Additional cookie attributes.
   */
  cookie: ICookieConfig;
}
