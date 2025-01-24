/**
 * @fileoverview
 * Implements the `CookieStore` class, which provides a server-side session store
 * utilizing cookies for session management. It allows setting, retrieving,
 * destroying, and updating sessions using a secure cookie mechanism.
 *
 * @module src/classes/CookieStore
 */

import {
  ISessionStore,
  ISessionData,
  IStoreContext,
  CookieOptions,
  ILogger,
  IMutex,
  IStore,
} from '../interfaces';
import { randomUUID } from 'crypto';
import { Mutex, Logger, parseCookies } from '../utils';
import { SameSite } from '../enums';
import { MemoryStore } from './MemoryStore';

/**
 * Represents a server-side session store implemented using cookies.
 *
 * The `CookieStore` class provides a secure and flexible mechanism for
 * managing sessions through HTTP cookies, with support for concurrent access
 * control, session expiration, and session persistence using an internal data store.
 *
 * @class
 * @implements {ISessionStore}
 */
export class CookieStore implements ISessionStore {
  private readonly logger: ILogger;
  private readonly cookieName: string;
  private readonly cookieOptions: CookieOptions;
  private readonly mutex: IMutex;
  private readonly dataStore: IStore;

  /**
   * Creates an instance of `CookieStore`.
   *
   * @param {string} [cookieName='sid'] - The name of the session cookie.
   * @param {CookieOptions} [cookieOptions] - Options for the cookie attributes.
   * @param {IStore} [dataStore] - Optional internal data store for session persistence.
   * @throws {Error} Throws an error if the logger or data store initialization fails.
   */
  constructor(
    cookieName: string = 'sid',
    cookieOptions: CookieOptions = {
      httpOnly: true,
      secure: true,
      sameSite: SameSite.STRICT,
      path: '/',
      maxAge: 3600, // in seconds
    },
    dataStore?: IStore,
  ) {
    this.logger = new Logger(CookieStore.name);
    this.cookieName = cookieName;
    this.cookieOptions = cookieOptions;
    this.mutex = new Mutex({
      defaultTimeout: 5000,
      backoff: { maxAttempts: 5, initialDelay: 10, factor: 2, maxDelay: 1000 },
    });
    this.dataStore =
      dataStore || new MemoryStore(this.logger, cookieOptions.maxAge * 1000);
  }

  /**
   * Sets a session by storing session data and issuing a session cookie.
   *
   * @param {ISessionData} data - The session data to store.
   * @param {IStoreContext} [context] - The store context, including the HTTP response.
   * @returns {Promise<string>} Resolves with the session ID (SID) string.
   * @throws {Error} Throws an error if the response object is not provided.
   */
  public async set(
    data: ISessionData,
    context?: IStoreContext,
  ): Promise<string> {
    if (!context?.response) {
      throw new Error('Response object is required to set cookies.');
    }

    return this.mutex.runExclusive(async () => {
      const sid = randomUUID();
      await this.dataStore.set(sid, data, context);
      context.response.cookie(this.cookieName, sid, this.cookieOptions);
      this.logger.debug('Session set with SID', { sid });
      return sid;
    });
  }

  /**
   * Retrieves session data for the specified session ID (SID).
   *
   * @param {string} sid - The session ID.
   * @param {IStoreContext} [context] - The store context, including the HTTP request.
   * @returns {Promise<ISessionData | null>} Resolves with the session data or `null` if not found.
   * @throws {Error} Throws an error if the request object is not provided.
   */
  public async get(
    sid: string,
    context?: IStoreContext,
  ): Promise<ISessionData | null> {
    if (!context?.request) {
      throw new Error('Request object is required to get cookies.');
    }

    return this.mutex.runExclusive(async () => {
      const cookies = parseCookies(context.request.headers);
      const sessionId = cookies[this.cookieName];

      if (!sessionId) {
        return null;
      }

      if (sessionId !== sid) {
        this.logger.warn('SID mismatch', { expected: sid, actual: sessionId });
        return null;
      }

      try {
        const sessionData = await this.dataStore.get(sid, context);
        this.logger.debug('Session retrieved', { sid, sessionData });
        return sessionData;
      } catch (error) {
        this.logger.error('Error retrieving session data', { error });
        return null;
      }
    });
  }

  /**
   * Destroys the session for the specified session ID (SID).
   *
   * @param {string} sid - The session ID to destroy.
   * @param {IStoreContext} [context] - The store context, including the HTTP response.
   * @returns {Promise<void>} Resolves when the session is destroyed.
   * @throws {Error} Throws an error if the response object is not provided.
   */
  public async destroy(sid: string, context?: IStoreContext): Promise<void> {
    if (!context?.response) {
      throw new Error('Response object is required to destroy cookies.');
    }

    return this.mutex.runExclusive(async () => {
      await this.dataStore.destroy(sid, context);

      context.response.clearCookie(this.cookieName, this.cookieOptions);
      this.logger.debug('Session destroyed', { sid });
    });
  }

  /**
   * Updates the session and resets the cookie's expiration time.
   *
   * @param {string} sid - The session ID to touch.
   * @param {ISessionData} session - The updated session data.
   * @param {IStoreContext} [context] - The store context, including the HTTP response.
   * @returns {Promise<void>} Resolves when the session is updated.
   * @throws {Error} Throws an error if the response object is not provided.
   */
  public async touch(
    sid: string,
    session: ISessionData,
    context?: IStoreContext,
  ): Promise<void> {
    if (!context?.response) {
      throw new Error('Response object is required to touch cookies.');
    }

    return this.mutex.runExclusive(async () => {
      await this.dataStore.touch(sid, session, context);

      context.response.cookie(this.cookieName, sid, {
        ...this.cookieOptions,
        maxAge: this.cookieOptions.maxAge,
      });

      this.logger.debug('Session touched', { sid });
    });
  }
}
