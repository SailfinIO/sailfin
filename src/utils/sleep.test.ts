/**
 * @fileoverview
 * Test suite for the `sleep` utility function.
 * This suite ensures that the `sleep` function behaves correctly under various scenarios,
 * including valid delays and handling of invalid input parameters.
 *
 * @module src/utils/sleep.test
 */

import { sleep } from './sleep';
import { ClientError } from '../errors/ClientError';

describe('sleep', () => {
  beforeAll(() => {
    jest.useFakeTimers();
  });

  afterAll(() => {
    jest.useRealTimers();
  });

  it('should resolve after the specified delay', async () => {
    const ms = 1000;
    const sleepPromise = sleep(ms);

    // Fast-forward time
    jest.advanceTimersByTime(ms);

    await expect(sleepPromise).resolves.toBeUndefined();
  });

  it('should handle zero milliseconds correctly', async () => {
    const ms = 0;
    const sleepPromise = sleep(ms);

    // Fast-forward time
    jest.advanceTimersByTime(ms);

    await expect(sleepPromise).resolves.toBeUndefined();
  });

  it('should resolve immediately for very short delays', async () => {
    const ms = 1;
    const sleepPromise = sleep(ms);

    jest.advanceTimersByTime(ms);

    await expect(sleepPromise).resolves.toBeUndefined();
  });

  it('should throw ClientError if ms is not a number', async () => {
    // @ts-expect-error Testing runtime behavior with invalid input
    await expect(sleep('1000')).rejects.toThrow(ClientError);

    await expect(sleep(null)).rejects.toThrow(ClientError);

    await expect(sleep(undefined)).rejects.toThrow(ClientError);
    // @ts-expect-error Testing runtime behavior with invalid input
    await expect(sleep({})).rejects.toThrow(ClientError);
  });

  it('should throw ClientError if ms is not finite', async () => {
    await expect(sleep(Infinity)).rejects.toThrow(ClientError);

    await expect(sleep(-Infinity)).rejects.toThrow(ClientError);

    await expect(sleep(NaN)).rejects.toThrow(ClientError);
  });

  it('should throw ClientError if ms is negative', async () => {
    await expect(sleep(-100)).rejects.toThrow(ClientError);
  });

  it('should throw ClientError if ms is not an integer', async () => {
    await expect(sleep(100.5)).rejects.toThrow(ClientError);
    await expect(sleep(0.1)).rejects.toThrow(ClientError);
  });

  it('should throw ClientError if ms exceeds the maximum allowed value', async () => {
    const MAX_MS = 2 ** 31 - 1;
    const excessiveMs = MAX_MS + 1;
    await expect(sleep(excessiveMs)).rejects.toThrow(ClientError);
  });

  it('should handle multiple sleep calls independently', async () => {
    const sleep1 = sleep(1000);
    const sleep2 = sleep(2000);

    jest.advanceTimersByTime(1000);
    await expect(sleep1).resolves.toBeUndefined();
    // sleep2 should not have resolved yet
    // Removed the line because 'toHaveResolved' is not a valid Jest matcher

    jest.advanceTimersByTime(1000);
    await expect(sleep2).resolves.toBeUndefined();
  });
});
