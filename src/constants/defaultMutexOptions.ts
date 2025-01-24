/**
 * @fileoverview Default options for the Mutex class.
 *
 * @packageDocumentation Default options for the Mutex class.
 * @module constants defaultMutexOptions
 * @preferred Default options for the Mutex class.
 * @see {@link Mutex}
 * @see {@link MutexOptions}
 */

import {
  DeadlockStrategy,
  MutexOptions,
  SchedulingStrategy,
} from '../interfaces';

/**
 * Default options for the Mutex class.
 *
 * @type {MutexOptions}
 * @default
 * @example
 *
 * ```typescript
 * const mutex = new Mutex(defaultMutexOptions);
 * ```
 */
export const defaultMutexOptions: MutexOptions = {
  defaultTimeout: 0,
  fairness: true,
  reentrant: false,
  priority: {
    //   adjustmentInterval: 1000,
    adjustmentFactor: 1,
    adjustmentExponent: 1,
    maxIncrement: Infinity,
  },
  cancelOnError: false,
  backoff: {
    maxAttempts: 1,
    initialDelay: 0,
    factor: 1,
    maxDelay: 0,
  },
  schedulingStrategy: SchedulingStrategy.FIFO,
  deadlock: {
    strategy: DeadlockStrategy.ForceRelease,
    gracePeriod: 0,
  },
  logger: {
    debug: console.debug.bind(console),
    info: console.info.bind(console),
    warn: console.warn.bind(console),
    error: console.error.bind(console),
    setLogLevel: () => {},
  },
  timer: {
    setTimeout: setTimeout.bind(globalThis),
    clearTimeout: clearTimeout.bind(globalThis),
  },
};
