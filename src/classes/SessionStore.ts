/**
 * @fileoverview
 * Implements the `SessionStore` class, a server-side session management utility
 * with a built-in in-memory store. Provides methods to create, retrieve, update,
 * and delete session data with support for customizable time-to-live (TTL) values.
 *
 * @module src/classes/SessionStore
 */

import { ISessionStore, ISessionData, ILogger } from '../interfaces';
import { randomUUID } from 'crypto';
import { MemoryStore } from './MemoryStore';

/**
 * Represents a session management store backed by an in-memory store.
 *
 * The `SessionStore` class provides a lightweight implementation for managing
 * session data, with default TTL and logging capabilities.
 *
 * @class
 * @implements {ISessionStore}
 */
export class SessionStore implements ISessionStore {
  private readonly store: MemoryStore;
  private readonly ttl: number = 3600000; // 1 hour in milliseconds

  /**
   * Creates an instance of `SessionStore`.
   *
   * @param {ILogger} [logger] - Optional logger instance for logging session operations.
   * @param {number} [ttl=3600000] - Optional time-to-live (TTL) in milliseconds for session data.
   */
  constructor(
    private readonly logger?: ILogger,
    ttl?: number,
  ) {
    this.logger = logger ?? {
      debug: console.debug.bind(console),
      info: console.info.bind(console),
      warn: console.warn.bind(console),
      error: console.error.bind(console),
      setLogLevel: () => {},
    };
    this.ttl = ttl || this.ttl;
    this.store = new MemoryStore(this.logger, this.ttl);
  }

  /**
   * Creates a new session and stores the provided session data.
   *
   * @param {ISessionData} data - The session data to store.
   * @returns {Promise<string>} Resolves with the session ID (SID).
   */
  public async set(data: ISessionData): Promise<string> {
    const sid = randomUUID();
    this.logger.debug(`Setting session data for sid: ${sid}`);
    await this.store.set(sid, data);
    return sid;
  }

  /**
   * Retrieves the session data for the specified session ID (SID).
   *
   * @param {string} sid - The session ID.
   * @returns {Promise<ISessionData | null>} Resolves with the session data or `null` if not found.
   */
  public async get(sid: string): Promise<ISessionData | null> {
    this.logger.debug(`Getting session data for sid: ${sid}`);
    return this.store.get(sid);
  }

  /**
   * Destroys the session data for the specified session ID (SID).
   *
   * @param {string} sid - The session ID.
   * @returns {Promise<void>} Resolves when the session data is destroyed.
   */
  public async destroy(sid: string): Promise<void> {
    this.logger.debug(`Destroying session data for sid: ${sid}`);
    return this.store.destroy(sid);
  }

  /**
   * Updates the session data and resets its TTL.
   *
   * @param {string} sid - The session ID to touch.
   * @param {ISessionData} data - The updated session data.
   * @returns {Promise<void>} Resolves when the session data is updated.
   */
  public async touch(sid: string, data: ISessionData): Promise<void> {
    this.logger.debug(`Touching session data for sid: ${sid}`);
    return this.store.touch(sid, data);
  }
}
