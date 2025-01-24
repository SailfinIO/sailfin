/**
 * @fileoverview
 * Interface for managing OAuth2/OIDC state-nonce mappings.
 * Provides methods for securely adding, retrieving, and deleting state-nonce pairs.
 *
 * @module src/interfaces/IState
 */
export interface IStateEntry {
  nonce: string;
  codeVerifier?: string;
  createdAt?: number;
  [key: string]: any;
}
/**
 * Interface for managing state-nonce pairs in OAuth2/OIDC flows.
 *
 * The `IState` interface defines methods for adding and retrieving state-nonce pairs,
 * ensuring that states are unique and valid during authentication flows. Implementations
 * must ensure thread-safety and prevent race conditions.
 */
export interface IState {
  /**
   * Adds a state-nonce pair to the manager.
   *
   * This method securely stores a unique state and its associated nonce, ensuring
   * that the state does not already exist. It must throw an error if the state
   * already exists to prevent collisions.
   *
   * @param {string} state - The unique state string.
   * @param {string} nonce - The nonce associated with the state.
   * @throws {Error} If the state already exists.
   * @returns {Promise<void>} Resolves when the state-nonce pair has been added successfully.
   *
   * @example
   * ```typescript
   * await stateManager.addState('state123', 'nonce456');
   * ```
   */
  addState(state: string, nonce: string, codeVerifier?: string): Promise<void>;

  getStateEntry(state: string): Promise<IStateEntry | undefined>;

  removeState(state: string): Promise<void>;
}
