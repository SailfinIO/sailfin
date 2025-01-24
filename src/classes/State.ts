/**
 * @fileoverview
 * Service class for managing OAuth2/OIDC state and nonce pairs.
 * This class provides thread-safe operations for storing, retrieving, and
 * deleting state-nonce pairs, ensuring data consistency using a mutex lock.
 *
 * @module src/classes/State
 */

import { Mutex } from '../utils';
import { ClientError } from '../errors/ClientError';
import { IState, IStateEntry } from '../interfaces';

/**
 * Service for managing OAuth2/OIDC state-nonce mappings.
 *
 * The `State` class provides methods to securely add and retrieve
 * state-nonce pairs, ensuring that the state is matched and valid during the
 * authentication flow. All operations are thread-safe, preventing race conditions
 * using a mutex.
 *
 * @example
 * ```typescript
 * const stateManager = new State();
 * await stateManager.addState('state123', 'nonce456');
 * const nonce = await stateManager.getNonce('state123'); // 'nonce456'
 * ```
 */
export class State implements IState {
  private readonly stateMap: Map<string, IStateEntry> = new Map();
  private readonly stateMapLock = new Mutex({
    defaultTimeout: 5000,
    backoff: { maxAttempts: 5, initialDelay: 10, factor: 2, maxDelay: 1000 },
  });

  /**
   * Adds a state-nonce pair to the manager.
   *
   * @param {string} state - The unique state string.
   * @param {string} nonce - The nonce associated with the state.
   * @throws {ClientError} If the state already exists.
   * @returns {Promise<void>} Resolves when the state-nonce pair has been added.
   */
  async addState(
    state: string,
    nonce: string,
    codeVerifier?: string,
  ): Promise<void> {
    await this.stateMapLock.runExclusive(() => {
      if (this.stateMap.has(state)) {
        throw new ClientError(
          `State "${state}" already exists`,
          'STATE_ALREADY_EXISTS',
        );
      }
      this.stateMap.set(state, { nonce, codeVerifier, createdAt: Date.now() });
    });
  }

  /**
   * Retrieves and deletes the nonce associated with a state.
   *
   * @param {string} state - The state string to look up.
   * @throws {ClientError} If the state is not found or does not match.
   * @returns {Promise<string>} Resolves with the associated nonce.
   */
  async getStateEntry(state: string): Promise<IStateEntry | undefined> {
    return this.stateMapLock.runExclusive(() => {
      const nonce = this.stateMap.get(state);
      if (!nonce) {
        throw new ClientError(
          `State "${state}" does not match or was not found`,
          'STATE_MISMATCH',
        );
      }
      this.stateMap.delete(state);
      return nonce;
    });
  }

  /**
   * Removes a state-nonce pair from the manager.
   *
   * @param {string} state - The state string to remove.
   * @returns {Promise<void>} Resolves when the state has been removed.
   */
  async removeState(state: string): Promise<void> {
    return this.stateMapLock.runExclusive(() => {
      this.stateMap.delete(state);
    });
  }
}
