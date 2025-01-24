/**
 * @fileoverview
 * Updated test suite for the `State` service class.
 * This suite verifies the correct handling of state-nonce mappings, ensuring
 * thread-safe operations and proper error handling for invalid scenarios.
 *
 * @module src/classes/State.test
 */

import { State } from './State';
import { ClientError } from '../errors/ClientError';
import { IState, IStateEntry } from '../interfaces';

describe('State', () => {
  let stateManager: IState;

  beforeEach(() => {
    stateManager = new State();
  });

  it('should add a state-nonce pair and retrieve the nonce', async () => {
    const state = 'state123';
    const nonce = 'nonce456';

    await stateManager.addState(state, nonce);
    const stateEntry = await stateManager.getStateEntry(state);

    expect(stateEntry).toBeDefined();
    expect(stateEntry?.nonce).toBe(nonce);
  });

  it('should throw ClientError if adding a duplicate state', async () => {
    const state = 'state123';
    const nonce = 'nonce456';

    await stateManager.addState(state, nonce);

    await expect(stateManager.addState(state, 'nonce789')).rejects.toThrow(
      ClientError,
    );
    await expect(stateManager.addState(state, 'nonce789')).rejects.toThrowError(
      new ClientError(
        `State "${state}" already exists`,
        'STATE_ALREADY_EXISTS',
      ),
    );
  });

  it('should throw ClientError if retrieving a state entry for a nonexistent state', async () => {
    const state = 'nonexistent-state';

    await expect(stateManager.getStateEntry(state)).rejects.toThrow(
      ClientError,
    );
    await expect(stateManager.getStateEntry(state)).rejects.toThrowError(
      new ClientError(
        `State "${state}" does not match or was not found`,
        'STATE_MISMATCH',
      ),
    );
  });

  it('should throw ClientError if retrieving a state entry for a deleted state', async () => {
    const state = 'state123';
    const nonce = 'nonce456';

    await stateManager.addState(state, nonce);
    await stateManager.getStateEntry(state); // This deletes the state

    await expect(stateManager.getStateEntry(state)).rejects.toThrow(
      ClientError,
    );
    await expect(stateManager.getStateEntry(state)).rejects.toThrowError(
      new ClientError(
        `State "${state}" does not match or was not found`,
        'STATE_MISMATCH',
      ),
    );
  });

  it('should handle multiple states independently', async () => {
    const state1 = 'state1';
    const nonce1 = 'nonce1';
    const state2 = 'state2';
    const nonce2 = 'nonce2';

    await stateManager.addState(state1, nonce1);
    await stateManager.addState(state2, nonce2);

    const stateEntry1 = await stateManager.getStateEntry(state1);
    const stateEntry2 = await stateManager.getStateEntry(state2);

    expect(stateEntry1).toBeDefined();
    expect(stateEntry1?.nonce).toBe(nonce1);
    expect(stateEntry2).toBeDefined();
    expect(stateEntry2?.nonce).toBe(nonce2);
  });

  it('should be thread-safe for concurrent operations', async () => {
    const state1 = 'state1';
    const nonce1 = 'nonce1';
    const state2 = 'state2';
    const nonce2 = 'nonce2';

    const addState1 = stateManager.addState(state1, nonce1);
    const addState2 = stateManager.addState(state2, nonce2);

    await Promise.all([addState1, addState2]);

    const [stateEntry1, stateEntry2] = await Promise.all([
      stateManager.getStateEntry(state1),
      stateManager.getStateEntry(state2),
    ]);

    expect(stateEntry1).toBeDefined();
    expect(stateEntry1?.nonce).toBe(nonce1);
    expect(stateEntry2).toBeDefined();
    expect(stateEntry2?.nonce).toBe(nonce2);
  });

  it('should store and retrieve codeVerifier if provided', async () => {
    const state = 'stateWithVerifier';
    const nonce = 'nonceWithVerifier';
    const codeVerifier = 'codeVerifier123';

    await stateManager.addState(state, nonce, codeVerifier);
    const stateEntry = await stateManager.getStateEntry(state);

    expect(stateEntry).toBeDefined();
    expect(stateEntry?.nonce).toBe(nonce);
    expect(stateEntry?.codeVerifier).toBe(codeVerifier);
  });

  it('should delete the state entry after retrieval', async () => {
    const state = 'stateToDelete';
    const nonce = 'nonceToDelete';

    await stateManager.addState(state, nonce);
    const stateEntry = await stateManager.getStateEntry(state);

    expect(stateEntry).toBeDefined();
    expect(stateEntry?.nonce).toBe(nonce);

    // Attempt to retrieve again should throw
    await expect(stateManager.getStateEntry(state)).rejects.toThrow(
      ClientError,
    );
  });
});
