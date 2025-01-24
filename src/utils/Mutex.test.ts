import { Mutex } from './Mutex';
import {
  DeadlockStrategy,
  ILogger,
  ITimer,
  MutexOperation,
  SchedulingStrategy,
} from '../interfaces';
import { MutexError, ClientError } from '../errors';
import { MutexRegistry } from './MutexRegistry';
import { defaultMutexOptions } from '../constants/defaultMutexOptions';

describe('Mutex', () => {
  let logger: ILogger;
  let timer: ITimer;
  let mutex: Mutex;

  beforeAll(() => {
    jest.useFakeTimers();
  });

  afterAll(() => {
    jest.useRealTimers();
  });

  beforeEach(() => {
    logger = {
      debug: jest.fn(),
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
      setLogLevel: jest.fn(),
    };
    timer = {
      setTimeout: jest.fn((fn, delay) => setTimeout(fn, delay)),
      clearTimeout: jest.fn((id) => clearTimeout(id)),
    };
    mutex = new Mutex<string>({
      logger,
      timer,
    });
  });

  afterEach(() => {
    jest.clearAllTimers();
    jest.clearAllMocks();
  });

  describe('Constructor', () => {
    it('should create a Mutex instance with default timer if none provided', () => {
      const defaultMutex = new Mutex({ logger });
      expect(defaultMutex).toBeInstanceOf(Mutex);
      expect(logger.debug).toHaveBeenCalledWith('Mutex instance created', {
        initialLocked: false,
        initialQueueLength: 0,
      });
    });

    it('should create a Mutex instance with provided timer', () => {
      const customMutex = new Mutex({ logger, timer });
      expect(customMutex).toBeInstanceOf(Mutex);
      expect(logger.debug).toHaveBeenCalledWith('Mutex instance created', {
        initialLocked: false,
        initialQueueLength: 0,
      });
    });

    it('should have correct default values', () => {
      expect(defaultMutexOptions.defaultTimeout).toBe(0);
      expect(defaultMutexOptions.fairness).toBe(true);
      expect(defaultMutexOptions.reentrant).toBe(false);
      expect(defaultMutexOptions.priority).toMatchObject({
        adjustmentFactor: 1,
        adjustmentExponent: 1,
        maxIncrement: Infinity,
      });
      expect(defaultMutexOptions.cancelOnError).toBe(false);
      expect(defaultMutexOptions.backoff).toMatchObject({
        maxAttempts: 1,
        initialDelay: 0,
        factor: 1,
        maxDelay: 0,
      });
      expect(defaultMutexOptions.schedulingStrategy).toBe(
        SchedulingStrategy.FIFO,
      );
      expect(defaultMutexOptions.deadlock.strategy).toBe(
        DeadlockStrategy.ForceRelease,
      );
      // Check logger functions exist
      expect(typeof defaultMutexOptions.logger.debug).toBe('function');
      expect(typeof defaultMutexOptions.timer.setTimeout).toBe('function');
    });

    it('should have default scheduling strategy', () => {
      // Access the private options via casting for testing purposes.
      const options = (mutex as any).options;
      expect(options.schedulingStrategy).toBe(SchedulingStrategy.FIFO);
    });

    // Additional tests to verify behavior based on defaults:
    it('should use default timeout when not specified', async () => {
      const spySetTimeout = jest.spyOn(defaultMutexOptions.timer, 'setTimeout');

      // Acquire with no explicit timeout should use defaultTimeout (0)
      const unlock = await mutex.acquire();
      expect(spySetTimeout).not.toHaveBeenCalled(); // since defaultTimeout = 0, no timer setup

      unlock();
      spySetTimeout.mockRestore();
    });
  });

  describe('Acquire', () => {
    it('should acquire the mutex when it is not locked', async () => {
      const unlock = await mutex.acquire();
      expect(mutex.locked).toBe(true);
      expect(logger.debug).toHaveBeenCalledWith('Attempting to acquire mutex', {
        timeout: 0,
      });
      expect(logger.debug).toHaveBeenCalledWith('Trying to acquire mutex lock');
      expect(logger.info).toHaveBeenCalledWith('Mutex lock acquired', {
        currentQueueLength: 0,
      });

      unlock();
      // After unlock, check the log
      expect(logger.debug).toHaveBeenCalledWith(
        'Mutex released via unlock function',
      );
      expect(mutex.locked).toBe(false);
    });

    it('should queue the acquire request when mutex is already locked', async () => {
      const unlock1 = await mutex.acquire();
      const acquirePromise = mutex.acquire();

      expect(mutex.queue).toBe(1);
      expect(logger.info).toHaveBeenCalledWith(
        'Mutex is locked, adding to queue',
        {
          queueLengthBefore: 0,
        },
      );
      expect(logger.debug).toHaveBeenCalledWith('Current queue length', {
        queueLength: 1,
      });

      unlock1();

      // After first unlock, the second acquire should proceed
      const unlock2 = await acquirePromise;
      expect(mutex.locked).toBe(true);
      unlock2();
      expect(mutex.locked).toBe(false);
    });

    it('should handle multiple queued acquire requests', async () => {
      const unlock1 = await mutex.acquire();
      const acquirePromise2 = mutex.acquire();
      const acquirePromise3 = mutex.acquire();
      expect(mutex.queue).toBe(2);

      unlock1();

      const unlock2 = await acquirePromise2;
      expect(mutex.locked).toBe(true);

      unlock2();

      const unlock3 = await acquirePromise3;
      expect(mutex.locked).toBe(true);

      unlock3();
      expect(mutex.locked).toBe(false);
      expect(mutex.queue).toBe(0);
    });

    it('should timeout if acquire takes too long', async () => {
      const unlock = await mutex.acquire();
      const acquirePromise = mutex.acquire(100);

      // Fast-forward time to trigger timeout
      jest.advanceTimersByTime(100);

      await expect(acquirePromise).rejects.toThrow(MutexError);
      expect(logger.warn).toHaveBeenCalledWith(
        'Mutex acquisition timed out and request removed from queue',
        { queueLengthAfter: 0 },
      );

      unlock();
      expect(mutex.locked).toBe(false);
    });

    it('should call clearTimeout when timerId is truthy', async () => {
      const timeout = 1000;
      const unlock = await mutex.acquire(timeout);
      expect(mutex.locked).toBe(true);
      expect(timer.setTimeout).toHaveBeenCalledWith(
        expect.any(Function),
        timeout,
      );
      expect(timer.clearTimeout).toHaveBeenCalledTimes(1);
      unlock();
      expect(mutex.locked).toBe(false);
    });

    it('should not call clearTimeout when timerId is falsy', async () => {
      const unlock = await mutex.acquire(); // No timeout provided
      expect(mutex.locked).toBe(true);
      expect(timer.clearTimeout).not.toHaveBeenCalled();

      unlock();
      expect(mutex.locked).toBe(false);
    });

    it('should clear the timeout after successful acquire', async () => {
      const unlock1 = await mutex.acquire(500);
      expect(timer.setTimeout).toHaveBeenCalledTimes(1);
      expect(timer.setTimeout).toHaveBeenCalledWith(expect.any(Function), 500);

      // Since acquire is immediate, clearTimeout should have been called
      expect(timer.clearTimeout).toHaveBeenCalledTimes(1);

      unlock1();
      expect(mutex.locked).toBe(false);
    });

    it('should clear timeout when an error is thrown in tryAcquire with a defined timeout', async () => {
      // 1) Acquire once so that the mutex is locked
      //    This ensures the next acquire() goes into the "enqueue" path.
      const unlockFirst = await mutex.acquire();

      // 2) Mock logger.info (which is called inside enqueue()) to throw.
      //    This will force an error in the same call stack that sets timerId.
      (logger.info as jest.Mock).mockImplementationOnce(() => {
        throw new Error('Simulated error during enqueue');
      });

      // 3) Call acquire with a timeout to set timerId
      const acquirePromise = mutex.acquire(500);

      // 4) Because `logger.info` threw inside `enqueue`,
      //    the Promise should reject with a MutexError (handleAcquireError).
      await expect(acquirePromise).rejects.toThrow(MutexError);

      // 5) Verify clearTimeout was invoked
      expect(timer.clearTimeout).toHaveBeenCalledTimes(1);

      // 6) Finally unlock the first one
      unlockFirst();
    });

    it('should handle errors during acquire and reject appropriately', async () => {
      // To simulate an error during acquire, we'll mock the logger.debug to throw an error
      const originalDebug = logger.debug;
      const mockError = new MutexError('Acquire failed', 'MUTEX_ERROR');

      // First call to logger.debug is from constructor; second call is from acquire
      (logger.debug as jest.Mock)
        .mockImplementationOnce(() => {}) // constructor's debug
        .mockImplementationOnce(() => {
          throw mockError;
        }); // acquire's debug

      const acquirePromise = mutex.acquire();

      await expect(acquirePromise).rejects.toThrow(MutexError);
      await expect(acquirePromise).rejects.toHaveProperty(
        'message',
        'Failed to acquire the mutex lock',
      );
      await expect(acquirePromise).rejects.toHaveProperty(
        'code',
        'ACQUIRE_FAILED',
      );

      // Restore original logger.debug
      logger.debug = originalDebug;
    });

    it('should handle errors thrown by logger.error in handleAcquireError', async () => {
      // Spy on console.error
      const consoleErrorSpy = jest
        .spyOn(console, 'error')
        .mockImplementation(() => {});

      // Mock logger.error to throw an error
      const loggerError = new Error('Logger failed');
      (logger.error as jest.Mock).mockImplementationOnce(() => {
        throw loggerError;
      });

      // Mock logger.debug to throw an error to trigger handleAcquireError
      const originalDebug = logger.debug;
      (logger.debug as jest.Mock)
        .mockImplementationOnce(() => {}) // constructor's debug
        .mockImplementationOnce(() => {
          throw new Error('Acquire failed');
        }); // acquire's debug

      const acquirePromise = mutex.acquire();

      await expect(acquirePromise).rejects.toThrow(MutexError);

      // Verify that console.error was called with the expected message
      expect(consoleErrorSpy).toHaveBeenCalledWith(
        'Logger error in handleAcquireError:',
        loggerError,
      );

      // Restore the original console.error and logger.debug
      consoleErrorSpy.mockRestore();
      logger.debug = originalDebug;
    });
  });

  describe('Release', () => {
    it('should release the mutex when no queue is present', async () => {
      const unlock = await mutex.acquire();
      unlock();

      expect(mutex.locked).toBe(false);
      expect(logger.debug).toHaveBeenCalledWith('Releasing mutex lock', {
        currentQueueLength: 0,
      });
      expect(logger.info).toHaveBeenCalledWith(
        'Mutex lock released, no pending requests',
      );
    });

    it('should release the mutex and pass lock to next in queue', async () => {
      const unlock1 = await mutex.acquire();
      const acquirePromise = mutex.acquire();
      expect(mutex.queue).toBe(1);
      unlock1();

      expect(logger.debug).toHaveBeenCalledWith('Releasing mutex lock', {
        currentQueueLength: 1,
      });
      expect(logger.info).toHaveBeenCalledWith(
        'Mutex lock released, passing to next request in queue',
        {
          remainingQueueLength: 0,
        },
      );

      const unlock2 = await acquirePromise;
      expect(mutex.locked).toBe(true);
      unlock2();
      expect(mutex.locked).toBe(false);
    });
    it('should log error and unlock when release fails', async () => {
      // Arrange: Acquire the mutex lock
      const unlock = await mutex.acquire();

      // Mock a logger method within the try block to throw an error.
      // In the `release` method, `logger.info` is called, so we'll mock it to throw.
      const releaseError = new Error('Release failed');
      (logger.info as jest.Mock).mockImplementation(() => {
        throw releaseError;
      });

      // Act: Attempt to release the mutex
      expect(() => unlock()).not.toThrow();

      // Assert: Verify that logger.error was called with the correct arguments
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to release the mutex lock',
        { error: releaseError },
      );

      // Assert: Ensure the mutex is unlocked
      expect(mutex.locked).toBe(false);
    });
    it('should handle errors during release gracefully', async () => {
      // To simulate an error during release, we'll mock the logger.error to throw
      const originalRelease = (mutex as any).release;
      const releaseMock = jest.fn(() => {
        try {
          throw new Error('Release failed');
        } catch (error) {
          logger.error('Failed to release the mutex lock', { error });
        } finally {
          (mutex as any)._locked = false;
        }
      });
      (mutex as any).release = releaseMock;

      const unlock = await mutex.acquire();

      // Call unlock and ensure it doesn't throw
      expect(() => unlock()).not.toThrow();

      // Check that logger.error was called
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to release the mutex lock',
        {
          error: new Error('Release failed'),
        },
      );

      expect(mutex.locked).toBe(false);

      // Restore original release method
      (mutex as any).release = originalRelease;
    });
  });

  describe('runExclusive', () => {
    it('should execute the function exclusively and release the mutex', async () => {
      const fn = jest.fn().mockResolvedValue('result');
      const result = await mutex.runExclusive(fn);
      expect(result).toBe('result');
      expect(fn).toHaveBeenCalled();
      expect(mutex.locked).toBe(false);
      expect(logger.debug).toHaveBeenCalledWith('runExclusive called', {
        timeout: 0,
      });
      expect(logger.debug).toHaveBeenCalledWith(
        'runExclusive acquired mutex lock',
      );
      expect(logger.debug).toHaveBeenCalledWith(
        'runExclusive function executed successfully',
        { result: 'result' },
      );
      expect(logger.debug).toHaveBeenCalledWith(
        'runExclusive released mutex lock',
      );
    });

    it('should handle synchronous functions', async () => {
      const fn = jest.fn().mockReturnValue('sync result');
      const result = await mutex.runExclusive(fn);
      expect(result).toBe('sync result');
      expect(fn).toHaveBeenCalled();
      expect(mutex.locked).toBe(false);
    });

    it('should handle errors thrown by the function and release the mutex', async () => {
      const error = new Error('Function failed');
      const fn = jest.fn().mockRejectedValue(error);
      await expect(mutex.runExclusive(fn)).rejects.toThrow(MutexError);
      expect(fn).toHaveBeenCalled();
      expect(mutex.locked).toBe(false);
      expect(logger.error).toHaveBeenCalledWith(
        'Error during exclusive execution',
        { error },
      );
    });

    it('should handle errors during unlock in runExclusive', async () => {
      // Simulate an error during unlock by mocking release to throw
      const originalRelease = (mutex as any).release;
      const releaseMock = jest.fn(() => {
        throw new Error('Unlock failed');
      });
      (mutex as any).release = releaseMock;

      const fn = jest.fn().mockResolvedValue('test');
      const result = await mutex.runExclusive(fn);
      expect(result).toBe('test');
      expect(fn).toHaveBeenCalled();
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to release the mutex lock after execution',
        {
          error: new Error('Unlock failed'),
        },
      );

      // Restore original release method
      (mutex as any).release = originalRelease;
    });

    it('should log error and throw when acquiring the mutex lock fails', async () => {
      // Arrange: Create a Mutex instance already locked
      const unlock = await mutex.acquire();

      // Create a MutexError to be thrown
      const mockError = new MutexError('Acquire failed', 'ACQUIRE_FAILED');

      // Mock the acquire method to throw the MutexError
      const acquireSpy = jest
        .spyOn(mutex, 'acquire')
        .mockRejectedValue(mockError);

      // Act & Assert: runExclusive should throw the same error
      await expect(
        mutex.runExclusive(() => Promise.resolve('test')),
      ).rejects.toThrow(mockError);

      // Assert: logger.error should be called with the correct arguments
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to acquire mutex lock in runExclusive',
        {
          error: mockError,
        },
      );

      // Clean up: Restore the original acquire method
      acquireSpy.mockRestore();

      // Release the initially acquired lock
      unlock();
    });
  });

  describe('Getters', () => {
    it('should return the correct locked state', async () => {
      expect(mutex.locked).toBe(false);
      expect(logger.debug).toHaveBeenCalledWith('Getter accessed: locked', {
        locked: false,
      });

      const unlock = await mutex.acquire();
      expect(mutex.locked).toBe(true);
      expect(logger.debug).toHaveBeenCalledWith('Getter accessed: locked', {
        locked: true,
      });
      unlock();
    });

    it('should return the correct queue length', async () => {
      expect(mutex.queue).toBe(0);
      expect(logger.debug).toHaveBeenCalledWith('Getter accessed: queue', {
        queueLength: 0,
      });

      const unlock1 = await mutex.acquire();
      const acquirePromise = mutex.acquire();
      expect(mutex.queue).toBe(1);
      expect(logger.debug).toHaveBeenCalledWith('Getter accessed: queue', {
        queueLength: 1,
      });

      unlock1();
      const unlock2 = await acquirePromise;
      expect(mutex.queue).toBe(0);
      expect(logger.debug).toHaveBeenCalledWith('Getter accessed: queue', {
        queueLength: 0,
      });
      unlock2();
    });
  });
  describe('tryAcquire', () => {
    it('should acquire lock immediately when unlocked', () => {
      const unlock = mutex.tryAcquire('owner1');
      expect(typeof unlock).toBe('function');
      expect(mutex.locked).toBe(true);
      unlock!();
      expect(mutex.locked).toBe(false);
    });

    it('should return null if mutex is already locked', async () => {
      const unlock = await mutex.acquire();
      const result = mutex.tryAcquire('owner2');
      expect(result).toBeNull();
      unlock();
    });

    it('should handle reentrant acquisition when enabled', async () => {
      // Enable reentrant option
      mutex = new Mutex<string>({ logger, timer, reentrant: true });
      const unlock1 = await mutex.acquire(0, 'owner1');
      const reentrantUnlock = mutex.tryAcquire('owner1');
      expect(typeof reentrantUnlock).toBe('function');
      reentrantUnlock!();
      // Still locked due to original lock
      expect(mutex.locked).toBe(true);
      unlock1();
      expect(mutex.locked).toBe(false);
    });
  });

  describe('readLock and writeLock', () => {
    it('should allow multiple simultaneous read locks when no writer is active', async () => {
      const unlockRead1 = await mutex.readLock(0, 'reader1');
      const unlockRead2 = await mutex.readLock(0, 'reader2');
      // Access private readerCount via casting for testing purposes
      expect((mutex as any).readerCount).toBe(2);
      unlockRead1();
      expect((mutex as any).readerCount).toBe(1);
      unlockRead2();
      expect((mutex as any).readerCount).toBe(0);
    });

    it('should defer readLock if writer is active', async () => {
      const unlockWrite = await mutex.writeLock(0, 'writer1');

      // Start readLock while writer is active
      const readPromise = mutex.readLock(500, 'reader1');

      expect((mutex as any).readerCount).toBe(0);
      expect((mutex as any).writerActive).toBe(true);

      // Release the writer to allow the read lock to proceed
      unlockWrite();

      // Advance timers to process any pending callbacks
      jest.runAllTimers();

      // Await the readPromise resolution
      const unlockRead = await readPromise;
      expect((mutex as any).readerCount).toBeGreaterThanOrEqual(1);

      unlockRead();

      // Optionally, advance timers again if there are any further timeouts
      jest.runAllTimers();

      expect((mutex as any).readerCount).toBe(0);
    });

    it('should allow writeLock when no readers or writers', async () => {
      const unlock = await mutex.writeLock(0, 'writer1');
      expect((mutex as any).writerActive).toBe(true);
      unlock();
      expect((mutex as any).writerActive).toBe(false);
    });

    it('should defer writeLock if readers are active', async () => {
      const unlockRead = await mutex.readLock(0, 'reader1');

      let writeLockAcquired = false;
      const writePromise = mutex.writeLock(0, 'writer1').then((unlock) => {
        writeLockAcquired = true;
        return unlock;
      });

      // Write lock should not be acquired while reader is active.
      expect(writeLockAcquired).toBe(false);

      // Release reader to allow writer to proceed.
      unlockRead();
      const writeUnlock = await writePromise;
      expect(writeLockAcquired).toBe(true);
      writeUnlock();
      expect((mutex as any).writerActive).toBe(false);
    }, 10000); // Extend timeout for this test

    it('should process a read queue entry when no writer is active and no writer waiting', () => {
      // Prepare a read type queue entry
      const resolver = jest.fn();
      const readEntry = {
        resolver,
        priority: 0,
        owner: 'reader',
        type: MutexOperation.Read,
        weight: 1,
        enqueuedAt: Date.now(),
      };

      // Ensure no writer is active and no waiting writer in queue.
      (mutex as any).writerActive = false;
      (mutex as any)._queue = []; // empty queue; no other writer waiting

      // Call handleQueueEntry with the read entry.
      (mutex as any).handleQueueEntry(readEntry);

      // It should call resolver and increment readerCount.
      expect(resolver).toHaveBeenCalled();
      expect((mutex as any).readerCount).toBe(1);
    });

    it('should skip a read queue entry when a writer is active', () => {
      const resolver = jest.fn();
      const readEntry = {
        resolver,
        priority: 0,
        owner: 'reader',
        type: MutexOperation.Read,
        weight: 1,
        enqueuedAt: Date.now(),
      };

      (mutex as any).writerActive = true; // Simulate active writer

      (mutex as any).handleQueueEntry(readEntry);

      // Resolver should not be called because writer is active.
      expect(resolver).not.toHaveBeenCalled();
      // readerCount should remain unchanged.
      expect((mutex as any).readerCount).toBe(0);
    });

    it('should process a write queue entry when no writer active and no readers', () => {
      const resolver = jest.fn();
      const writeEntry = {
        resolver,
        priority: 0,
        owner: 'writer',
        type: MutexOperation.Write,
        weight: 1,
        enqueuedAt: Date.now(),
      };

      // Ensure no writer and no readers
      (mutex as any).writerActive = false;
      (mutex as any).readerCount = 0;

      (mutex as any).handleQueueEntry(writeEntry);

      // For a write, it should call resolver and set writerActive true.
      expect(resolver).toHaveBeenCalled();
      expect((mutex as any).writerActive).toBe(true);
    });

    it('should skip a write queue entry if readers are active', () => {
      const resolver = jest.fn();
      const writeEntry = {
        resolver,
        priority: 0,
        owner: 'writer',
        type: MutexOperation.Write,
        weight: 1,
        enqueuedAt: Date.now(),
      };

      // Simulate active readers
      (mutex as any).writerActive = false;
      (mutex as any).readerCount = 1;

      (mutex as any).handleQueueEntry(writeEntry);

      // Resolver should not be called because readers are active.
      expect(resolver).not.toHaveBeenCalled();
      expect((mutex as any).writerActive).toBe(false);
    });
  });

  describe('Reentrant Behavior', () => {
    it('should handle reentrant locks correctly without deadlock', async () => {
      mutex = new Mutex<string>({
        logger,
        timer,
        reentrant: true,
        deadlock: { strategy: DeadlockStrategy.ForceRelease, gracePeriod: 10 },
      });
      try {
        const unlock1 = await mutex.acquire(undefined, 'owner1');
        expect(mutex.locked).toBe(true);
        const reentrantUnlock1 = await mutex.acquire(undefined, 'owner1');
        expect(mutex.locked).toBe(true);
        reentrantUnlock1();
        // Still locked because original acquisition hasn't been released
        expect(mutex.locked).toBe(true);
        unlock1();
        expect(mutex.locked).toBe(false);
      } catch (e) {
        throw new Error(`Unexpected deadlock error: ${e}`);
      }
    });
  });

  describe('dump', () => {
    it('should return a snapshot of the current mutex state', async () => {
      const unlock = await mutex.acquire(undefined, 'owner1');
      // Enqueue a readLock to populate the queue.
      const pendingReadPromise = mutex.readLock(100, 'reader1');

      const state = mutex.dump();

      expect(state.locked).toBe(true);
      expect(state.currentOwner).toBe('owner1');
      // Check that queueLength is a non-negative number.
      expect(state.queueLength).toBeGreaterThanOrEqual(0);
      expect(Array.isArray(state.queue)).toBe(true);
      expect(Array.isArray(state.priorityQueue)).toBe(true);
      expect(state.dependencyGraph).toBeInstanceOf(Object);
      expect(state.ownerHolds).toBeInstanceOf(Object);

      unlock();
      try {
        const readUnlock = await pendingReadPromise;
        readUnlock();
      } catch {
        // ignore readLock timeouts
      }
    });
  });

  describe('forceRelease', () => {
    it('should forcefully release mutex and clear queues', async () => {
      mutex = new Mutex<string>({
        logger,
        timer,
        deadlock: { strategy: DeadlockStrategy.ForceRelease, gracePeriod: 10 },
      });

      const unlock = await mutex.acquire(undefined, 'owner1');
      const acquirePromise = mutex.acquire(0, 'owner2');
      expect(mutex.locked).toBe(true);

      (mutex as any).forceRelease();

      expect(mutex.locked).toBe(false);
      expect(logger.warn).toHaveBeenCalledWith(
        'Forcefully released mutex to resolve deadlock',
      );
      expect((mutex as any)._queue.length).toBe(0);
      await expect(acquirePromise).rejects.toThrow(MutexError);

      try {
        unlock();
      } catch {}
    }, 10000); // Extend timeout for this test
  });

  describe('Dependency and Deadlock Detection', () => {
    it('should detect cycle and throw Deadlock error', async () => {
      const mutex1 = new Mutex<string>({
        logger,
        timer,
        deadlock: { strategy: DeadlockStrategy.ForceRelease },
      });
      const mutex2 = new Mutex<string>({
        logger,
        timer,
        deadlock: { strategy: DeadlockStrategy.ForceRelease },
      });

      const registry = MutexRegistry.instance;
      // Simulate that owner1 holds mutex2 and is waiting for mutex1
      registry.addHold('owner1', mutex2);
      registry.addWaiter(mutex1, 'owner1');
      // Try detecting a cycle.
      const cycleDetected = (mutex as any).detectCycle('owner1', mutex2);
      // If cycle isn't detected as expected, log current state for debugging.
      if (!cycleDetected) {
        console.warn(
          'Cycle was not detected as expected. Check dependency graph setup.',
        );
      }
      expect(cycleDetected).toBe(true);
    });
  });

  describe('Priority Adjustment', () => {
    it('should adjust priorities based on waiting time', () => {
      // Create entries in priority queue for testing adjustPriorities
      const entry = {
        resolver: jest.fn(),
        priority: 1,
        owner: 'owner1',
        type: MutexOperation.Write,
        weight: 1,
        enqueuedAt: Date.now() - 5000, // 5 seconds ago
      };
      (mutex as any)._priorityQueue.insert(entry);

      // Setup minimal priority options for calculation
      mutex['options'].priority = {
        adjustmentInterval: 1000,
        adjustmentFactor: 1,
        adjustmentExponent: 1,
        maxIncrement: 10,
      };

      (mutex as any).adjustPriorities();

      const adjustedEntry = (mutex as any)._priorityQueue.toArray()[0];
      // Since waitingTime ~ 5s, adjustment ~ 5*factor = 5; new priority should be 1+5
      expect(adjustedEntry.priority).toBeGreaterThanOrEqual(6);
    });

    it('should calculate adjustment correctly', () => {
      mutex['options'].priority = {
        adjustmentFactor: 2,
        adjustmentExponent: 2,
        maxIncrement: 20,
      };

      const adjustment = (mutex as any).calculateAdjustment(4000); // 4 sec waiting
      // adjustment = factor * (4^2) = 2 * 16 = 32, but maxIncrement is 20
      expect(adjustment).toBe(20);
    });
  });

  describe('safeRelease and clearTimer', () => {
    it('should safely release without throwing', () => {
      const unlock = jest.fn();
      (mutex as any).safeRelease(unlock);
      expect(unlock).toHaveBeenCalled();
    });

    it('should handle error in safeRelease gracefully', () => {
      const errorFn = jest.fn(() => {
        throw new Error('Fail');
      });
      expect(() => (mutex as any).safeRelease(errorFn)).not.toThrow();
    });

    it('should clear timer and log debug message', () => {
      const fakeTimerId = 123;
      (mutex as any).clearTimer(fakeTimerId);
      expect(timer.clearTimeout).toHaveBeenCalledWith(fakeTimerId);
      expect(logger.debug).toHaveBeenCalledWith(
        'Timeout cleared after acquiring mutex',
      );
    });
  });

  describe('handleExecutionError', () => {
    it('should throw MutexError wrapping non-ClientError', () => {
      const error = new Error('random error');
      expect(() => {
        (mutex as any).handleExecutionError(error);
      }).toThrow(MutexError);
    });

    it('should rethrow ClientError', () => {
      const clientError = new ClientError('client error');
      expect(() => {
        (mutex as any).handleExecutionError(clientError);
      }).toThrow(clientError);
    });
  });
});
