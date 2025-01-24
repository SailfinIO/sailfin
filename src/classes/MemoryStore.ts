/**
 * @fileoverview
 * Implements the `MemoryStore` class, an in-memory session store that supports
 * concurrent access control, session expiration, and session management operations.
 *
 * @module src/classes/MemoryStore
 */

import { IStore, ISessionData, ILogger } from '../interfaces';
import { Cache } from '../cache/Cache';
import { Mutex } from '../utils/Mutex';

/**
 * Represents an in-memory session store.
 *
 * The `MemoryStore` class provides a lightweight implementation for managing
 * session data in memory. It is designed for environments where persistence
 * across server restarts is not required. It includes support for TTL (time-to-live)
 * values and ensures thread-safe operations using a mutex.
 *
 * @class
 * @implements {IStore}
 */
export class MemoryStore implements IStore {
  private readonly cache: Cache<ISessionData>;
  private readonly mutex: Mutex;
  private readonly ttl: number = 3600000; // 1 hour in milliseconds

  /**
   * Creates an instance of `MemoryStore`.
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
    this.cache = new Cache<ISessionData>(this.logger, this.ttl);
    this.mutex = new Mutex({
      logger: this.logger,
      defaultTimeout: 5000,
      backoff: { maxAttempts: 5, initialDelay: 10, factor: 2, maxDelay: 1000 },
    });
  }

  /**
   * Stores session data with the provided session ID (SID).
   *
   * @param {string} sid - The session ID.
   * @param {ISessionData} data - The session data to store.
   * @returns {Promise<void>} Resolves when the data is successfully stored.
   */
  public async set(sid: string, data: ISessionData): Promise<void> {
    return this.mutex.runExclusive(async () => {
      this.cache.set(sid, data);
      this.logger.debug('Session created', { sid });
    });
  }

  /**
   * Retrieves the session data for the specified session ID (SID).
   *
   * @param {string} sid - The session ID.
   * @returns {Promise<ISessionData | null>} Resolves with the session data or `null` if not found.
   */
  public async get(sid: string): Promise<ISessionData | null> {
    return this.mutex.runExclusive(() => {
      const session = this.cache.get(sid) || null;
      this.logger.debug('Session retrieved', { sid, session });
      return session;
    });
  }

  /**
   * Destroys the session associated with the specified session ID (SID).
   *
   * @param {string} sid - The session ID.
   * @returns {Promise<void>} Resolves when the session is successfully destroyed.
   */
  public async destroy(sid: string): Promise<void> {
    return this.mutex.runExclusive(() => {
      this.cache.delete(sid);
      this.logger.debug('Session deleted', { sid });
    });
  }

  /**
   * Updates the session's expiration time without altering its data.
   *
   * @param {string} sid - The session ID.
   * @param {ISessionData} session - The current session data.
   * @returns {Promise<void>} Resolves when the session expiration is updated.
   */
  public async touch(sid: string, session: ISessionData): Promise<void> {
    return this.mutex.runExclusive(() => {
      this.cache.set(sid, session);
      this.logger.debug('Session updated', { sid });
    });
  }
}
