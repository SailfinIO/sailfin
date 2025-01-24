/**
 * @fileoverview
 * Implements the `Mutex` class, a utility for controlling access to asynchronous resources.
 * The mutex ensures mutual exclusion by allowing only one execution thread to acquire the lock
 * at a time. It supports timeouts, queueing, and error handling.
 *
 * @module src/utils/Mutex
 */

import {
  ILogger,
  IMutex,
  MutexOptions,
  QueueEntry,
  ITimer,
  TimerId,
  MutexOperation,
  BackoffOptions,
  SchedulingStrategy,
  MutexState,
  DeadlockStrategy,
  Owner,
  IMutexRegistry,
} from '../interfaces';
import { MutexError, ClientError } from '../errors';
import EventEmitter from 'events';
import { defaultMutexOptions } from '../constants/defaultMutexOptions';
import { MaxHeap } from '../utils/MaxHeap';
import { MutexRegistry } from './MutexRegistry';
import { deepMerge } from './deepMerge';

/**
 * Represents a mutex (mutual exclusion) utility for controlling access to asynchronous resources.
 *
 * The `Mutex` class provides a thread-safe mechanism for exclusive access, with support for queueing,
 * timeouts, and structured logging.
 *
 * @class
 * @implements {IMutex}
 */
export class Mutex<MutexOwner extends Owner = Owner>
  extends EventEmitter
  implements IMutex<MutexOwner>
{
  private readonly _queue: QueueEntry<MutexOwner>[] = [];
  private readonly timer: ITimer;
  private readonly logger: ILogger;
  private readonly options: MutexOptions;
  private readonly registry: IMutexRegistry;
  private _locked: boolean = false;
  private _owner: MutexOwner | null = null;
  private _reentrantCount: number = 0;
  private readerCount: number = 0;
  private writerActive: boolean = false;

  private _priorityQueue = new MaxHeap<QueueEntry<MutexOwner>>(
    (a, b) => a.priority - b.priority,
  );

  /**
   * Creates an instance of `Mutex`.
   *
   * @param {MutexOptions} [options] - Optional configuration options for the mutex.
   *
   */
  constructor(options: MutexOptions = defaultMutexOptions) {
    super();
    this.options = deepMerge(defaultMutexOptions, options) as MutexOptions;
    if (!this.options.logger) {
      this.options.logger = defaultMutexOptions.logger;
    }

    this.logger = this.options.logger;
    this.timer = this.options.timer!;

    this.registry = MutexRegistry.instance;
    this.logger.debug('Mutex instance created', {
      initialLocked: this._locked,
      initialQueueLength: this._queue.length,
    });

    // Set up periodic priority adjustment if interval is provided
    const adjustmentInterval = this.options.priority?.adjustmentInterval;
    if (typeof adjustmentInterval === 'number' && adjustmentInterval > 0) {
      setInterval(() => {
        this.adjustPriorities();
      }, adjustmentInterval);
    }
  }

  /**
   * Acquires the mutex lock, waiting if necessary.
   *
   * @param {number} [timeout] - Optional timeout in milliseconds. If specified, the lock will not be acquired after the timeout expires.
   * @param {MutexOwner} [owner] - Optional owner identifier for reentrant lock support.
   * @param {number} [priority] - Optional priority for the acquisition request.
   * @returns {Promise<() => void>} A promise that resolves to a function to release the lock.
   * @throws {MutexError} If the lock cannot be acquired within the timeout.
   */
  public async acquire(
    timeout?: number,
    owner?: MutexOwner,
    priority?: number,
    signal?: AbortSignal,
    backoffOptions?: BackoffOptions,
  ): Promise<() => void> {
    const {
      maxAttempts = 1,
      initialDelay = 0,
      factor = 1,
      maxDelay = 0,
    } = backoffOptions || this.options.backoff || {};

    let attempt = 0;
    let delay = initialDelay;
    let lastError: any;

    // Early return for reentrant acquisition if enabled
    if (this.options.reentrant && this.isReentrant(owner)) {
      return Promise.resolve(this.handleReentrant(owner));
    }

    // Before attempting to wait on this mutex, record the dependency and check for deadlock
    if (owner) {
      this.registry.addWaiter(this, owner);

      if (this.detectCycle(owner, this)) {
        // Build deadlock information
        const deadlockInfo = { owner, mutex: this };

        switch (this.options.deadlock.strategy) {
          case DeadlockStrategy.ForceRelease:
            const gracePeriod = this.options.deadlock.gracePeriod ?? 1000;
            setTimeout(() => {
              this.forceRelease();
              // Clean up waiter entry related to this mutex and owner using the global registry
              this.registry.removeWaiter(this, owner);
            }, gracePeriod);

            throw new MutexError(
              'Deadlock detected. Initiating force release.',
              'DEADLOCK',
            );

          case DeadlockStrategy.PriorityElevation:
            // Implement priority elevation logic here.
            // For example, elevate the priority for the current request:
            // (You may need additional logic to identify which queue entry to boost.)
            this.logger.warn(
              'Priority elevation strategy triggered due to deadlock.',
            );
            // Optionally re-attempt acquisition here or throw an error.
            throw new MutexError(
              'Deadlock detected. Priority elevation strategy not fully implemented.',
              'DEADLOCK',
            );

          case DeadlockStrategy.Custom:
            if (this.options.deadlock.onDeadlock) {
              this.options.deadlock.onDeadlock(deadlockInfo);
            }
            // Fall through or throw after custom handler
            throw new MutexError(
              'Deadlock detected. Custom handler invoked.',
              'DEADLOCK',
            );

          default:
            // Default behavior: throw error without special handling
            throw new MutexError('Deadlock detected', 'DEADLOCK');
        }
      }
    }

    const attemptAcquire = (): Promise<() => void> => {
      const effectiveTimeout = timeout ?? this.options.defaultTimeout;
      // Immediately reject if an explicit zero timeout was provided and the mutex is locked
      if (timeout === 0 && this._locked) {
        return Promise.reject(
          new MutexError('Acquire timed out', 'ACQUIRE_TIMEOUT'),
        );
      }
      this.logger.debug('Attempting to acquire mutex', {
        timeout: effectiveTimeout,
      });
      this.emit('acquireAttempt', { timeout: effectiveTimeout });

      if (this.options.reentrant && this.isReentrant(owner)) {
        return Promise.resolve(this.handleReentrant(owner));
      }

      return new Promise<() => void>((resolve, reject) => {
        // Abort handling setup
        if (signal?.aborted) {
          return reject(new MutexError('Aborted', 'ABORTED'));
        }
        const abortHandler = () => {
          reject(new MutexError('Aborted', 'ABORTED'));
        };
        signal?.addEventListener('abort', abortHandler);

        let released = false;
        let timerId: TimerId | null = null;

        const cleanup = () => {
          signal?.removeEventListener('abort', abortHandler);
        };

        const unlock = () => {
          if (released) {
            this.logger.warn(
              'Attempt to release mutex that is already released',
            );
            return;
          }
          released = true;
          this.logger.debug('Mutex released via unlock function');
          this.release();
        };

        const tryAcquire = () => {
          this.logger.debug('Trying to acquire mutex lock');
          if (!this._locked) {
            this.lock(owner);
            if (timerId) this.clearTimer(timerId);
            cleanup(); // remove abort listener on success
            resolve(unlock);
          } else {
            this.enqueueRequest(owner, priority, tryAcquire);
          }
        };

        if (effectiveTimeout > 0) {
          timerId = this.setupTimeout(
            effectiveTimeout,
            owner,
            tryAcquire,
            reject,
          );
        }

        try {
          tryAcquire();
        } catch (error) {
          this.handleAcquireError(error, timerId, reject);
        }
      });
    };

    while (attempt < maxAttempts) {
      try {
        return await attemptAcquire();
      } catch (error) {
        lastError = error;
        // If aborted, exit early without retrying.
        if (error instanceof MutexError && error.code === 'ABORTED') {
          throw error;
        }
        attempt++;
        if (attempt >= maxAttempts) break;
        this.logger.warn(
          `Acquire attempt ${attempt} failed. Retrying in ${delay}ms...`,
        );
        await new Promise((res) => setTimeout(res, delay));
        delay = Math.min(delay * factor, maxDelay);
      }
    }

    throw new MutexError('Failed to acquire the mutex lock', 'ACQUIRE_FAILED', {
      error: lastError,
    });
  }

  private forceRelease(): void {
    this._locked = false;
    this._owner = null;
    this._reentrantCount = 0;
    // Reject all queued promises before clearing queues
    for (const entry of this._queue) {
      entry.reject?.(new MutexError('Forcefully released', 'FORCE_RELEASE'));
    }
    this.clearQueue();
    this._priorityQueue.clear();
    this.logger.warn('Forcefully released mutex to resolve deadlock');
    this.emit('forceReleased');
  }

  private clearQueue(): void {
    while (this._queue.length) {
      this._queue.pop();
    }
  }

  private detectCycle(owner: MutexOwner, targetMutex: Mutex<any>): boolean {
    const { mutexWaiters, ownerHolds } = this.registry.graph;
    const visited = new Set<Owner>();

    const dfs = (currentOwner: Owner): boolean => {
      if (visited.has(currentOwner)) return false;
      visited.add(currentOwner);

      const heldMutexes = ownerHolds.get(currentOwner) || new Set();

      // Immediate cycle detection if targetMutex is held by currentOwner
      if (heldMutexes.has(targetMutex)) {
        return true;
      }

      for (const mutex of heldMutexes) {
        const waitingOwners = mutexWaiters.get(mutex) || new Set();
        for (const waiter of waitingOwners) {
          if (waiter === owner) return true;
          if (dfs(waiter)) return true;
        }
      }

      return false;
    };

    return dfs(owner);
  }

  /**
   * Tries to acquire the mutex without waiting.
   * @returns {(() => void) | null} The unlock function if acquired, or null if not.
   */
  public tryAcquire(owner?: MutexOwner): (() => void) | null {
    this.logger.debug('Attempting tryAcquire on mutex');

    // Handle reentrant acquisition if enabled and the same owner is requesting.
    if (this.options.reentrant && this.isReentrant(owner)) {
      return this.handleReentrant(owner);
    }

    // Attempt immediate acquisition if the mutex is not locked.
    if (!this._locked) {
      this.lock(owner);
      let released = false;
      return () => {
        if (released) return;
        released = true;
        this.logger.debug('Mutex released via tryAcquire unlock function');
        this.release();
      };
    }

    this.logger.debug('tryAcquire failed: Mutex already locked');
    return null;
  }

  public async readLock(
    timeout?: number,
    owner?: MutexOwner,
    priority?: number,
  ): Promise<() => void> {
    return new Promise<() => void>((resolve, reject) => {
      const effectiveTimeout = timeout ?? this.options.defaultTimeout;
      let timerId: TimerId | null = null;
      let acquired = false;

      // Clean up all listeners and timers once done (either success or failure)
      const cleanup = () => {
        this.off('released', tryAcquireRead);
        if (timerId) {
          this.clearTimer(timerId);
          timerId = null;
        }
      };

      const unlock = () => {
        if (!acquired) return;
        acquired = false;
        this.readerCount = Math.max(this.readerCount - 1, 0);
        this.logger.debug('Reader lock released', {
          readerCount: this.readerCount,
        });
        cleanup();
        this.processQueue();
        this.emit('released');
      };

      const tryAcquireRead = () => {
        const writerWaiting = this._queue.some(
          (entry) =>
            entry.type === MutexOperation.Write &&
            (!this.options.fairness || entry.priority >= (priority ?? 0)),
        );

        if (!this.writerActive && !writerWaiting) {
          // Acquire read lock
          acquired = true;
          this.readerCount++;
          this.logger.debug('Reader lock acquired', {
            readerCount: this.readerCount,
          });
          cleanup();
          resolve(unlock);
        }
        // If not acquired, wait for a 'released' event to re-attempt
      };

      this.on('released', tryAcquireRead);

      // Setup timeout if needed
      if (effectiveTimeout > 0) {
        timerId = this.setupTimeout(
          effectiveTimeout,
          owner,
          tryAcquireRead,
          (error) => {
            cleanup();
            reject(error);
          },
        );
      }

      // Initial attempt
      tryAcquireRead();
    });
  }

  public async writeLock(
    timeout?: number,
    owner?: MutexOwner,
    priority?: number,
  ): Promise<() => void> {
    return new Promise<() => void>((resolve, reject) => {
      const effectiveTimeout = timeout ?? this.options.defaultTimeout;
      let timerId: TimerId | null = null;
      let acquired = false;

      const cleanup = () => {
        this.off('released', tryAcquireWrite);
        if (timerId) {
          this.clearTimer(timerId);
          timerId = null;
        }
      };

      const unlock = () => {
        if (!acquired) return;
        acquired = false;
        this.writerActive = false;
        this.logger.debug('Writer lock released');
        cleanup();
        this.processQueue();
        // Schedule next 'released' event emission after processing queue
        setImmediate(() => this.emit('released'));
      };

      const tryAcquireWrite = () => {
        // Can acquire if no active writer and no readers
        if (!this.writerActive && this.readerCount === 0) {
          acquired = true;
          this.writerActive = true;
          this.logger.debug('Writer lock acquired');
          cleanup();
          resolve(unlock);
        }
        // If not acquired, wait for a 'released' event to re-attempt
      };

      this.on('released', tryAcquireWrite);

      if (effectiveTimeout > 0) {
        timerId = this.setupTimeout(
          effectiveTimeout,
          owner,
          tryAcquireWrite,
          (error) => {
            cleanup();
            reject(error);
          },
        );
      }

      tryAcquireWrite();
    });
  }

  private processQueue(): void {
    // Determine which scheduling strategy to use
    const strategy = this.options.schedulingStrategy || 'fifo';

    // Use different processing logic based on strategy
    if (strategy === 'priorityQueue' || strategy === 'weighted') {
      if (this._priorityQueue.isEmpty()) return;
      const nextEntry = this._priorityQueue.extract();
      // Process the extracted entry:
      this.handleQueueEntry(nextEntry);
    } else if (strategy === 'roundRobin') {
      // For round-robin, rotate the _queue array
      if (this._queue.length === 0) return;
      const nextEntry = this._queue.shift()!;
      this._queue.push(nextEntry); // rotate to end
      this.handleQueueEntry(nextEntry);
    } else {
      // Default FIFO behavior
      if (this._queue.length === 0) return;
      const nextEntry = this._queue.shift()!;
      this.handleQueueEntry(nextEntry);
    }
  }

  private handleQueueEntry(next: QueueEntry<MutexOwner>): void {
    if (next.type === MutexOperation.Read) {
      // If a writer is active or higher-priority writer waiting, skip processing.
      const writerWaiting = this._queue.some(
        (entry) =>
          entry.type === MutexOperation.Write &&
          (!this.options.fairness || entry.priority >= (next.priority ?? 0)),
      );
      if (this.writerActive || writerWaiting) return;

      this.readerCount++;
      next.resolver();
    } else if (next.type === MutexOperation.Write) {
      if (!this.writerActive && this.readerCount === 0) {
        this.writerActive = true;
        next.resolver();
      }
    }
  }

  private adjustPriorities(): void {
    // Iterate through all entries in the priority queue
    const allEntries = this._priorityQueue.toArray();
    for (const entry of allEntries) {
      // Increase priority based on waiting time using enqueuedAt
      const waitingTime = Date.now() - (entry.enqueuedAt || Date.now());
      entry.priority += this.calculateAdjustment(waitingTime);
    }
    this._priorityQueue.buildHeap(allEntries);
  }

  private calculateAdjustment(waitingTime: number): number {
    const factor = this.options.priority.adjustmentFactor ?? 1;
    const exponent = this.options.priority.adjustmentExponent ?? 1;
    const maxIncrement = this.options.priority.maxIncrement ?? Infinity;

    // Non-linear adjustment: factor * (waitingTime in seconds)^exponent
    let adjustment = factor * Math.pow(waitingTime / 1000, exponent);

    // Cap the adjustment to the maximum allowed increment if specified
    return Math.min(Math.floor(adjustment), maxIncrement);
  }

  /**
   * Releases the mutex lock and allows the next queued resolver (if any) to acquire it.
   *
   * @emits {released} Emits a 'released' event when the lock is released.
   * @emits {releaseAttempt} Emits a 'releaseAttempt' event when attempting to release the lock.
   * @emits {error} Emits an 'error' event if an error occurs during the release process.
   * @emits {reentrantReleased} Emits a 'reentrantReleased' event when a reentrant lock is released.
   * @returns {void}
   */
  private release(): void {
    const owner = this._owner;
    if (owner) {
      this.registry.removeHold(owner, this);
    }
    this.logger.debug('Releasing mutex lock', {
      currentQueueLength: this._queue.length,
    });
    this.emit('releaseAttempt', {
      owner: this._owner,
      queueLength: this._queue.length,
    });

    try {
      if (this._queue.length > 0) {
        this._locked = false;
        const nextEntry = this._queue.shift();
        this.logger.info(
          'Mutex lock released, passing to next request in queue',
          {
            remainingQueueLength: this._queue.length,
          },
        );
        nextEntry?.resolver();
      } else {
        this._locked = false;
        this.logger.info('Mutex lock released, no pending requests');
      }
      this.emit('released', {
        owner: this._owner,
        remainingQueueLength: this._queue.length,
      });
    } catch (error) {
      this.logger.error('Failed to release the mutex lock', { error });
      this._locked = false;
    }
  }
  /**
   * Executes a function exclusively, ensuring it has the mutex lock.
   *
   * @param {() => Promise<T> | T} fn - The function to execute.
   * @param {number} [timeout] - Optional timeout in milliseconds for acquiring the lock.
   * @returns {Promise<T>} A promise that resolves to the result of the function.
   * @template T
   * @throws {MutexError} If the lock cannot be acquired or an error occurs during execution.
   */
  public async runExclusive<T>(
    fn: () => Promise<T> | T,
    timeout?: number,
  ): Promise<T> {
    const effectiveTimeout = timeout ?? this.options.defaultTimeout;
    this.logger.debug('runExclusive called', { timeout: effectiveTimeout });

    let unlock: () => void;
    try {
      unlock = await this.acquire(effectiveTimeout);
      this.logger.debug('runExclusive acquired mutex lock');
    } catch (error) {
      this.logger.error('Failed to acquire mutex lock in runExclusive', {
        error,
      });
      throw error;
    }

    try {
      const result = await fn();
      this.logger.debug('runExclusive function executed successfully', {
        result,
      });
      return result;
    } catch (error) {
      this.logger.error('Error during exclusive execution', { error });
      this.handleExecutionError(error);
    } finally {
      this.safeRelease(unlock);
      this.logger.debug('runExclusive released mutex lock');
    }
  }
  /**
   * Returns whether the mutex is currently locked.
   *
   * @returns {boolean} True if the mutex is locked, false otherwise.
   */
  public get locked(): boolean {
    this.logger.debug('Getter accessed: locked', { locked: this._locked });
    return this._locked;
  }

  /**
   * Returns the number of requests waiting in the queue.
   *
   * @returns {number} The length of the mutex queue.
   */
  public get queue(): number {
    this.logger.debug('Getter accessed: queue', {
      queueLength: this._queue.length,
    });
    return this._queue.length;
  }

  /**
   * Returns the current owner of the mutex lock.
   *
   * @returns {MutexOwner | null} The current owner of the mutex lock.
   */
  public get owner(): MutexOwner | null {
    this.logger.debug('Getter accessed: owner', { owner: this._owner });
    return this._owner;
  }

  /**
   * Handles errors during the mutex acquisition process.
   *
   * @private
   * @param {any} error - The error encountered.
   * @param {TimerId | null} timerId - The timeout ID to clear.
   * @param {(reason?: any) => void} reject - The rejection callback.
   */
  private handleAcquireError(
    error: any,
    timerId: TimerId | null,
    reject: (reason?: any) => void,
  ): void {
    if (timerId) this.clearTimer(timerId);
    try {
      this.logger.error('Error while trying to acquire mutex', { error });
    } catch (loggerErr) {
      console.error('Logger error in handleAcquireError:', loggerErr);
    }
    this.emit('error', { phase: 'acquire', error });
    reject(
      new MutexError('Failed to acquire the mutex lock', 'ACQUIRE_FAILED', {
        error,
      }),
    );
  }

  /**
   * Returns true if the mutex is currently locked by the same owner.
   *
   * @remarks
   * By default, this comparison uses strict equality. For complex owner types,
   * provide a custom `ownerEqualityFn` in `MutexOptions`.
   *
   * @param {owner} MutexOwner | undefined
   * @returns {boolean} True if the mutex is currently locked by the same owner, false otherwise.
   */
  private isReentrant(owner: MutexOwner | undefined): boolean {
    return this._locked && this._owner === owner;
  }

  /**
   * Handles reentrant lock requests.
   *
   * @param {MutexOwner} owner - The owner of the reentrant lock.
   * @returns {() => void} A function to release the reentrant lock.
   */
  private handleReentrant(owner: MutexOwner | undefined): () => void {
    this._reentrantCount++;
    this.logger.debug('Reentrant lock acquired', {
      count: this._reentrantCount,
    });
    this.emit('reentrantAcquired', { owner, count: this._reentrantCount });
    return () => {
      this._reentrantCount--;
      this.logger.debug('Reentrant unlock', { count: this._reentrantCount });
      if (this._reentrantCount === 0) {
        this.release();
        this._owner = null;
      }
    };
  }

  /**
   * Locks the mutex for the specified owner.
   *
   * @param {MutexOwner | undefined} owner - The owner of the lock.
   * @returns {void}
   */
  private lock(owner: MutexOwner | undefined): void {
    this._locked = true;
    this._owner = owner;
    this._reentrantCount = 1;

    if (owner) {
      this.registry.removeWaiter(this, owner);
      this.registry.addHold(owner, this);
    }

    this.logger.info('Mutex lock acquired', {
      currentQueueLength: this._queue.length,
    });
    this.emit('acquired', { queueLength: this._queue.length });
  }

  /**
   * Enqueues a request for the mutex lock.
   *
   * @param {MutexOwner} owner - The owner of the lock.
   * @param {number | undefined} priority - The priority of the request.
   * @param {() => void} resolver - The resolver function for the request.
   * @returns {void}
   */
  private enqueueRequest(
    owner: MutexOwner,
    priority: number | undefined,
    resolver: () => void,
    type: MutexOperation = MutexOperation.Write,
  ): void {
    const entry: QueueEntry<MutexOwner> = {
      resolver,
      priority: this.options.priority ? (priority ?? 0) : 0,
      owner,
      type,
      weight: 1,
      enqueuedAt: Date.now(),
    };

    // Always insert into the priority queue for strategies that require it.
    if (
      this.options.schedulingStrategy === SchedulingStrategy.PriorityQueue ||
      this.options.schedulingStrategy === SchedulingStrategy.Weighted
    ) {
      this._priorityQueue.insert(entry);
    }

    // For FIFO or round-robin, maintain the simple array.
    this._queue.push(entry);

    this.logger.info('Mutex is locked, adding to queue', {
      queueLengthBefore: this._queue.length - 1,
    });
    this.logger.debug('Current queue length', {
      queueLength: this._queue.length,
    });
  }

  /**
   * Sets up a timeout for the mutex acquisition.
   *
   * @param {number} timeout - The timeout in milliseconds.
   * @param {MutexOwner | undefined} owner - The owner of the lock.
   * @param {() => void} resolver - The resolver function for the request.
   * @param {(reason?: any) => void} reject - The rejection callback.
   * @returns {TimerId} The ID of the timeout.
   */
  private setupTimeout(
    timeout: number,
    owner: MutexOwner | undefined,
    resolver: () => void,
    reject: (reason?: any) => void,
  ): TimerId {
    this.logger.debug('Setting timeout for mutex acquisition', { timeout });
    return this.timer.setTimeout(() => {
      const index = this._queue.findIndex(
        (entry) => entry.resolver === resolver,
      );
      if (index > -1) {
        this._queue.splice(index, 1);
        this.logger.warn(
          'Mutex acquisition timed out and request removed from queue',
          {
            queueLengthAfter: this._queue.length,
          },
        );
      }
      this.emit('timeout', { owner, timeout, queueLength: this._queue.length });
      reject(new MutexError('Acquire timed out', 'ACQUIRE_TIMEOUT'));
    }, timeout);
  }

  /**
   * Handles errors during exclusive execution
   *
   * @param {error | any} error
   * @returns {never}
   */
  private handleExecutionError(error: any): never {
    if (this.options.cancelOnError) {
      this._queue.length = 0;
    }
    if (error instanceof ClientError) {
      throw error;
    }
    throw new MutexError(
      'Error during exclusive execution',
      'EXECUTION_FAILED',
      { error },
    );
  }

  /**
   * Safely releases the mutex lock after execution.
   *
   * @param {unlock} () => void
   * @returns {void}
   */
  private safeRelease(unlock: () => void): void {
    try {
      unlock();
    } catch (error) {
      this.logger.error('Failed to release the mutex lock after execution', {
        error,
      });
    }
  }

  /**
   * Clears the timeout for the specified ID.
   *
   * @param {TimerId} timerId - The ID of the timeout to clear.
   * @returns {void}
   */
  private clearTimer(timerId: TimerId) {
    this.timer.clearTimeout(timerId);
    this.logger.debug('Timeout cleared after acquiring mutex');
  }

  /**
   * Returns a snapshot of the current mutex state for debugging purposes.
   *
   * @returns {MutexState<MutexOwner>} A snapshot of the mutex state.
   */
  public dump(): MutexState<MutexOwner> {
    // Snapshot of the queue entries
    const queueSnapshot = this._queue.map((entry) => ({
      owner: entry.owner,
      priority: entry.priority,
      type: entry.type,
      weight: entry.weight,
      enqueuedAt: entry.enqueuedAt,
    }));

    // Snapshot of the priority queue entries, if used
    const priorityQueueSnapshot = this._priorityQueue
      .toArray()
      .map((entry) => ({
        owner: entry.owner,
        priority: entry.priority,
        type: entry.type,
        weight: entry.weight,
        enqueuedAt: entry.enqueuedAt,
      }));

    // Retrieve dependency graph and owner holds from the global registry
    const { mutexWaiters, ownerHolds } = this.registry.graph;

    // Snapshot of the dependency graph
    const dependencyGraphSnapshot: Record<string, string[]> = {};
    for (const [mutex, owners] of mutexWaiters.entries()) {
      const mutexId =
        mutex.constructor.name + '@' + (mutex.owner?.toString() || 'unowned');
      dependencyGraphSnapshot[mutexId] = Array.from(owners).map((owner) =>
        owner?.toString(),
      );
    }

    // Snapshot of owner holdings
    const ownerHoldsSnapshot: Record<string, string[]> = {};
    for (const [owner, mutexes] of ownerHolds.entries()) {
      ownerHoldsSnapshot[owner?.toString()] = Array.from(mutexes).map(
        (m) => m.constructor.name + '@' + (m.owner?.toString() || 'unowned'),
      );
    }

    return {
      locked: this._locked,
      currentOwner: this._owner,
      reentrantCount: this._reentrantCount,
      readerCount: this.readerCount,
      writerActive: this.writerActive,
      queueLength: this._queue.length,
      queue: queueSnapshot,
      priorityQueue: priorityQueueSnapshot,
      dependencyGraph: dependencyGraphSnapshot,
      ownerHolds: ownerHoldsSnapshot,
    };
  }
}
