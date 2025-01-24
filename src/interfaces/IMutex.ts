/**
 * @fileoverview
 * Defines the `IMutex` interface for managing mutual exclusion in asynchronous operations.
 * This interface provides a contract for implementing mutex utilities that control access
 * to shared resources, ensuring that only one asynchronous operation can access the resource
 * at a time.
 *
 * @module src/interfaces/IMutex
 */

import { ILogger } from './ILogger';

/**
 * Represents a function that resolves the mutex acquisition.
 */
export type Resolver = () => void;

/**
 * Represents the ID of a timer created with `setTimeout`.
 */
export type TimerId = NodeJS.Timeout;

/**
 * Represents a timer utility with `setTimeout` and `clearTimeout` methods.
 */
export interface ITimer {
  /**
   * Schedules a function to be executed after a specified delay.
   *
   * @param {(...args: any[]) => void} handler - The function to execute.
   * @param {number} [timeout] - The delay in milliseconds before executing the handler.
   * @returns {TimerId} The identifier of the timer.
   */
  setTimeout: (handler: (...args: any[]) => void, timeout?: number) => TimerId;

  /**
   * Cancels a previously scheduled function execution.
   *
   * @param {TimerId} timerId - The identifier of the timer to cancel.
   */
  clearTimeout: (timerId: TimerId) => void;
}

/**
 * Defines the `IMutex` interface for managing mutual exclusion in asynchronous operations.
 *
 * The `IMutex` interface provides methods for acquiring and releasing a mutex lock,
 * ensuring that only one asynchronous operation can access a shared resource at a time.
 * It also offers a utility method to execute a function exclusively within the mutex lock.
 */
export interface IMutex<MutexOwner = unknown> {
  /**
   * Acquires the mutex lock.
   *
   * This method attempts to acquire the mutex. If the mutex is already locked, the
   * method will wait until the lock becomes available or until the optional timeout
   * is reached. Upon successful acquisition, it resolves with a release function
   * that must be called to release the mutex.
   *
   * @param {number} [timeout] - Optional timeout in milliseconds after which the acquisition attempt is aborted.
   * @returns {Promise<() => void>} A promise that resolves to a release function.
   *
   * @throws {MutexError} If the mutex acquisition fails or times out.
   *
   * @example
   * ```typescript
   * const release = await mutex.acquire(5000); // Wait up to 5 seconds to acquire the mutex
   * try {
   *   // Critical section: perform operations that require mutual exclusion
   * } finally {
   *   release(); // Always release the mutex
   * }
   * ```
   */
  acquire(
    timeout?: number,
    owner?: MutexOwner,
    priority?: number,
  ): Promise<() => void>;

  /**
   * Executes a function exclusively within the mutex lock.
   *
   * This method acquires the mutex, executes the provided function, and then releases
   * the mutex, ensuring that the function runs in a mutually exclusive context. If a
   * timeout is specified, the method will wait up to the specified duration to acquire
   * the mutex before throwing an error.
   *
   * @param {() => Promise<T> | T} fn - The function to execute exclusively.
   * @param {number} [timeout] - Optional timeout in milliseconds for acquiring the mutex.
   * @returns {Promise<T>} A promise that resolves to the result of the executed function.
   *
   * @throws {MutexError} If the mutex acquisition fails or the executed function throws an error.
   *
   * @example
   * ```typescript
   * const result = await mutex.runExclusive(async () => {
   *   // Critical section: perform operations that require mutual exclusion
   *   return await someAsyncOperation();
   * }, 5000); // Wait up to 5 seconds to acquire the mutex
   * console.log('Operation result:', result);
   * ```
   */
  runExclusive<T>(fn: () => Promise<T> | T, timeout?: number): Promise<T>;

  /**
   * Indicates whether the mutex is currently locked.
   *
   * @readonly
   * @type {boolean}
   *
   * @example
   * ```typescript
   * if (mutex.locked) {
   *   console.log('Mutex is currently locked.');
   * } else {
   *   console.log('Mutex is available.');
   * }
   * ```
   */
  readonly locked: boolean;

  /**
   * Returns the number of pending mutex acquisition requests.
   *
   * @readonly
   * @type {number}
   *
   * @example
   * ```typescript
   * console.log(`Number of queued requests: ${mutex.queue}`);
   * ```
   */
  readonly queue: number;

  /**
   * Returns the current owner of the mutex lock.
   *
   * @readonly
   * @type {MutexOwner}
   *
   * @example
   * ```typescript
   * console.log(`Current mutex owner: ${mutex.owner}`);
   * ```
   */
  readonly owner: MutexOwner | undefined;

  /**
   * Returns the current state of the mutex.
   *
   * @returns {MutexState} The current state of the mutex.
   *
   * @example
   * ```typescript
   * const state = mutex.dump();
   * console.log('Mutex state:', state);
   * ```
   */
  dump(): MutexState<MutexOwner>;
}

/**
 * Represents the options for configuring a mutex instance.
 * 
 * @interface MutexOptions
 * @property {number} [defaultTimeout] - The default timeout in milliseconds for acquiring the mutex lock.
 * @property {boolean} [fairness] - A flag indicating whether to use a fair mutex algorithm.
 * @property {ILogger} [logger] - An optional logger instance for diagnostic logging.
 * @property {ITimer} [timer] - An optional timer utility for scheduling asynchronous operations.
 * @property {boolean} [reentrant] - A flag indicating whether the mutex is reentrant.
 * @property {boolean} [priority] - A flag indicating whether to prioritize queued requests.
 * @property {boolean} [cancelOnError] - A flag indicating whether to cancel queued requests on error.

 */
export interface MutexOptions {
  /**
   * The default timeout in milliseconds for acquiring the mutex lock.
   *
   * @type {number}
   * @default 0
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ defaultTimeout: 5000 });
   * ```
   *
   * @remarks The default timeout is set to zero (0) milliseconds.
   **/
  defaultTimeout?: number | 0;

  /**
   * A flag indicating whether to use a fair mutex algorithm.
   *
   * @type {boolean}
   * @default true
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ fairness: false });
   * ```
   *
   * @remarks The default value is `true`.
   **/
  fairness?: boolean | true;

  /**
   * An optional logger instance for diagnostic logging.
   *
   * @type {ILogger}
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ logger });
   * ```
   **/
  logger?: ILogger | undefined;

  /**
   * An optional timer utility for scheduling asynchronous operations.
   *
   * @type {ITimer}
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ timer });
   * ```
   **/
  timer?: ITimer | undefined;

  /**
   * @property {boolean} [reentrant] - A flag indicating whether the mutex is reentrant.
   * @remarks
   * When `reentrant` is true, the same owner can acquire the mutex multiple times.
   * For complex owner types (such as objects), consider providing a custom `ownerEqualityFn`
   * in the options to control how owner equality is determined.
   *
   * @type {boolean}
   * @default false
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ reentrant: true });
   * ```
   *
   **/
  reentrant?: boolean | false;

  /**
   * The options for adjusting mutex priorities.
   *
   * @type {PriorityOptions}
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ priority: { adjustmentInterval: 1000 } });
   * ```
   *
   **/
  priority?: PriorityOptions;

  /**
   * A flag indicating whether to cancel queued requests on error.
   *
   * @type {boolean}
   * @default false
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ cancelOnError: true });
   * ```
   *
   * @remarks The default value is `false`.
   **/
  cancelOnError?: boolean | false;

  /**
   * The backoff options for retrying queued requests.
   *
   * @type {BackoffOptions}
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ backoff: { maxAttempts: 5, initialDelay: 100 } });
   *```
   * @remarks The default backoff options are:
   * - `maxAttempts`: 1
   * - `initialDelay`: 0
   * - `factor`: 1
   * - `maxDelay`: 0
   * */
  backoff?: BackoffOptions;

  /**
   * Scheduling strategy: 'fifo' | 'roundRobin' | 'weighted' | 'priorityQueue'
   */
  schedulingStrategy?: SchedulingStrategy;

  /**
   * Deadlock options for handling mutex deadlocks.
   *
   * @type {DeadlockOptions}
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ deadlock: { strategy: 'DeadlockStrategy.ForceRelease', gracePeriod: 1000 } });
   * ```
   **/
  deadlock?: DeadlockOptions;
}

/**
 * Represents the deadlock options for handling mutex deadlocks.
 *
 * @interface DeadlockOptions
 * @property {DeadlockStrategy} strategy - The deadlock resolution strategy.
 * @property {number} gracePeriod - The grace period in milliseconds to resolve deadlocks.
 * @property {(info: { owner: Owner; mutex: IMutex<any> }) => void} onDeadlock - The callback function to invoke on deadlock.
 *
 * @example
 *
 * ```typescript
 * const mutex = new Mutex({ deadlock: { strategy: 'DeadlockStrategy.ForceRelease', gracePeriod: 1000 } });
 * ```
 */
export interface DeadlockOptions {
  /**
   * The deadlock resolution strategy.
   *
   * @type {DeadlockStrategy}
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ deadlock: { strategy: 'DeadlockStrategy.ForceRelease' } });
   * ```
   **/
  strategy?: DeadlockStrategy;

  /**
   * The grace period in milliseconds to resolve deadlocks.
   *
   * @type {number}
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ deadlock: { gracePeriod: 1000 } });
   * ```
   **/
  gracePeriod?: number;

  /**
   * The callback function to invoke on deadlock.
   *
   * @type {(info: { owner: Owner; mutex: IMutex<any> }) => void}
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ deadlock: { onDeadlock: ({ owner }) => console.log(`Deadlock detected for owner: ${owner}`) } });
   * ```
   **/
  onDeadlock?: (info: { owner: Owner; mutex: IMutex<any> }) => void;
}

/**
 * Represents the priority options for adjusting mutex priorities.
 *
 * @interface PriorityOptions
 * @property {number} [adjustmentInterval] - Interval in milliseconds to adjust priorities for dynamic adjustments.
 * @property {number} [adjustmentFactor] - Factor to adjust priorities for dynamic adjustments.
 * @property {number} [adjustmentExponent] - Exponent to adjust priorities for dynamic adjustments.
 * @property {number} [maxIncrement] - Maximum increment for dynamic adjustments.
 *
 * @example
 *
 * ```typescript
 * const mutex = new Mutex({ priority: { adjustmentInterval: 1000 } });
 * ```
 */
export interface PriorityOptions {
  /**
   * Interval in milliseconds to adjust priorities for dynamic adjustments.
   * If not set, dynamic priority adjustment is disabled.
   * @type {number}
   */
  adjustmentInterval?: number;

  /**
   * Factor to adjust priorities for dynamic adjustments.
   * @type {number}
   * @default 1
   */
  adjustmentFactor?: number;

  /**
   * Exponent to adjust priorities for dynamic adjustments.
   * @type {number}
   * @default 1
   */
  adjustmentExponent?: number;

  /**
   * Maximum increment for dynamic adjustments.
   * @type {number}
   * @default Infinity
   */
  maxIncrement?: number;
}

/**
 * Represents the backoff options for retrying queued requests.
 *
 * @interface BackoffOptions
 * @property {number} [maxAttempts] - The maximum number of retry attempts.
 * @property {number} [initialDelay] - The initial delay in milliseconds before the first retry.
 * @property {number} [factor] - The exponential backoff factor for each retry.
 * @property {number} [maxDelay] - The maximum delay in milliseconds between retries.
 *
 * @example
 *
 * ```typescript
 * const mutex = new Mutex({ backoff: { maxAttempts: 5, initialDelay: 100 } });
 * ```
 */
export interface BackoffOptions {
  /**
   * The maximum number of retry attempts.
   *
   * @type {number}
   * @default 1
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ backoff: { maxAttempts: 5 } });
   * ```
   *
   * @remarks The default value is `1`.
   **/
  maxAttempts?: number;

  /**
   * The initial delay in milliseconds before the first retry.
   *
   * @type {number}
   * @default 100
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ backoff: { initialDelay: 100 } });
   * ```
   *
   * @remarks The default value is `0`.
   **/
  initialDelay?: number;

  /**
   * The exponential backoff factor for each retry.
   *
   * @type {number}
   * @default 2
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ backoff: { factor: 2 } });
   * ```
   *
   * @remarks The default value is `1`.
   **/
  factor?: number;

  /**
   * The maximum delay in milliseconds between retries.
   *
   * @type {number}
   * @default 1000
   * @example
   *
   * ```typescript
   * const mutex = new Mutex({ backoff: { maxDelay: 1000 } });
   * ```
   *
   * @remarks The default value is `0`.
   **/
  maxDelay?: number;
}

/**
 * Represents a queue entry for a mutex request.
 *
 * @interface QueueEntry
 * @property {Resolver} resolver - The resolver function for the mutex request.
 * @property {number} priority - The priority of the request in the queue.
 *
 * @example
 *
 * ```typescript
 * const entry: QueueEntry = {
 *  resolver: () => {},
 * priority: 0,
 * };
 */
export interface QueueEntry<MutexOwner> {
  /**
   * The resolver function for the mutex request.
   *
   * @type {Resolver}
   * @example
   *
   * ```typescript
   * const entry: QueueEntry = {
   *  resolver: () => {},
   * priority: 0,
   * };
   */
  resolver: Resolver;

  /**
   * The priority of the request in the queue.
   *
   * @type {number}
   * @example
   *
   * ```typescript
   * const entry: QueueEntry = {
   *  resolver: () => {},
   * priority: 0,
   * };
   */
  priority: number;

  /**
   * The owner of the mutex lock.
   *
   * @type {MutexOwner}
   * @example
   *
   * ```typescript
   * const entry: QueueEntry = {
   *  resolver: () => {},
   * priority: 0,
   * owner: 'user123',
   * };
   */
  owner?: MutexOwner;

  /**
   * The type of mutex operation (read or write).
   *
   * @type {MutexOperation}
   * @example
   *
   * ```typescript
   * const entry: QueueEntry = {
   *  resolver: () => {},
   * priority: 0,
   * owner: 'user123',
   * type: 'write
   * };
   * ```
   * @remarks The default value is `'write'`.
   * */
  type?: MutexOperation;

  /**
   * The weight of the mutex request.
   *
   * @type {number}
   * @example
   *
   * ```typescript
   * const entry: QueueEntry = {
   *  resolver: () => {},
   * priority: 0,
   * owner: 'user123',
   * weight: 1
   * };
   * ```
   * @remarks The default value is `1`.
   * */
  weight?: number;

  /**
   * The timestamp when the request was enqueued.
   *
   * @type {number}
   * @example
   *
   * ```typescript
   * const entry: QueueEntry = {
   *  resolver: () => {},
   * priority: 0,
   * owner: 'user123',
   * enqueuedAt: Date.now()
   * };
   * */
  enqueuedAt?: number;

  /**
   * The callback function to resolve the mutex request.
   *
   * @type {(value?: any) => void}
   * @example
   *
   * ```typescript
   * const entry: QueueEntry = {
   *  resolver: () => {},
   * priority: 0,
   * owner: 'user123',
   * reject: (reason) => console.error(reason)
   * };
   * */
  reject?: (reason?: any) => void;
}

export type Owner = string | { id: string; name?: string };

export enum MutexOperation {
  Read = 'read',
  Write = 'write',
}

export enum SchedulingStrategy {
  FIFO = 'fifo',
  RoundRobin = 'roundRobin',
  Weighted = 'weighted',
  PriorityQueue = 'priorityQueue',
}

export enum DeadlockStrategy {
  ForceRelease = 'forceRelease',
  PriorityElevation = 'priorityElevation',
  Custom = 'custom',
}

export interface MutexState<MutexOwner = unknown> {
  locked: boolean;
  currentOwner: MutexOwner | null;
  reentrantCount: number;
  readerCount: number;
  writerActive: boolean;
  queueLength: number;
  queue: Array<{
    owner?: MutexOwner;
    priority: number;
    type?: string;
    weight?: number;
    enqueuedAt?: number;
  }>;
  priorityQueue: Array<{
    owner?: MutexOwner;
    priority: number;
    type?: string;
    weight?: number;
    enqueuedAt?: number;
  }>;
  dependencyGraph: Record<string, string[]>;
  ownerHolds: Record<string, string[]>;
}

export interface DependencyGraph {
  // Map from mutex to set of waiting owners
  mutexWaiters: Map<IMutex<any>, Set<Owner>>;
  // Map from owner to set of held mutexes
  ownerHolds: Map<Owner, Set<IMutex<any>>>;
}

export interface IMutexRegistry {
  /**
   * Provides a read-only snapshot of the dependency graph.
   */
  readonly graph: DependencyGraph;

  /**
   * Registers that an owner is waiting for a mutex.
   * @param mutex - The mutex instance the owner is waiting for.
   * @param owner - The owner waiting for the mutex.
   */
  addWaiter(mutex: IMutex<any>, owner: Owner): void;

  /**
   * Removes an owner from the waiting list of a mutex.
   * @param mutex - The mutex instance the owner was waiting for.
   * @param owner - The owner to remove from the waitlist.
   */
  removeWaiter(mutex: IMutex<any>, owner: Owner): void;

  /**
   * Records that an owner now holds a mutex.
   * @param owner - The owner that has acquired the mutex.
   * @param mutex - The mutex instance held by the owner.
   */
  addHold(owner: Owner, mutex: IMutex<any>): void;

  /**
   * Removes the record of an owner holding a mutex.
   * @param owner - The owner releasing the mutex.
   * @param mutex - The mutex instance being released.
   */
  removeHold(owner: Owner, mutex: IMutex<any>): void;
}
