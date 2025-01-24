// src/classes/Store.test.ts

import { Store } from './Store';
import { MemoryStore } from './MemoryStore';
import { CookieStore } from './CookieStore';
import { SessionStore } from './SessionStore';
import { StorageMechanism } from '../enums';
import { ILogger, StoreOptions, ISessionStore } from '../interfaces';

jest.mock('./MemoryStore');
jest.mock('./CookieStore');
jest.mock('./SessionStore');

describe('Store', () => {
  let logger: ILogger;

  beforeEach(() => {
    logger = {
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
      debug: jest.fn(),
      setLogLevel: jest.fn(),
    };

    jest.clearAllMocks();
  });

  describe('create', () => {
    it('should create and return a SessionStore for MEMORY', () => {
      const options: StoreOptions = { storage: { ttl: 3600 } };

      const result = Store.create(StorageMechanism.MEMORY, options, logger);

      // Verify that SessionStore was called with (logger, 3600)
      expect(SessionStore).toHaveBeenCalledWith(logger, 3600);
      // The resulting sessionStore is a SessionStore instance
      expect(result.sessionStore).toBeInstanceOf(SessionStore);

      // MemoryStore is NOT called directly in this code path,
      // so we shouldn't expect(MemoryStore).toHaveBeenCalled.
    });

    it('should create and return a CookieStore for COOKIE', () => {
      const options: StoreOptions = {
        storage: { ttl: 3600 },
        session: {
          cookie: {
            name: 'session',
            options: { path: '/', httpOnly: true },
          },
        },
      };

      const result = Store.create(StorageMechanism.COOKIE, options, logger);

      // We expect MemoryStore to have been constructed internally
      expect(MemoryStore).toHaveBeenCalledWith(logger, 3600);

      // Then CookieStore is constructed with (name, cookieOptions, internalStore)
      expect(CookieStore).toHaveBeenCalledWith(
        'session',
        { path: '/', httpOnly: true },
        expect.any(MemoryStore),
      );
      expect(result.sessionStore).toBeInstanceOf(CookieStore);

      // SessionStore is NOT called in this path
      expect(SessionStore).not.toHaveBeenCalled();
    });

    it('should return the user’s custom store if provided, regardless of mechanism', () => {
      const customStore: ISessionStore = {
        set: jest.fn(),
        get: jest.fn(),
        destroy: jest.fn(),
        touch: jest.fn(),
      };

      const options: StoreOptions = {
        session: {
          store: customStore,
          cookie: {
            name: 'custom-session',
            options: { path: '/custom', httpOnly: false },
          },
        },
      };

      const result = Store.create(StorageMechanism.COOKIE, options, logger);

      // Because the code short-circuits, it won't call CookieStore or SessionStore
      expect(CookieStore).not.toHaveBeenCalled();
      expect(SessionStore).not.toHaveBeenCalled();

      // The result is exactly the user’s custom store
      expect(result.sessionStore).toBe(customStore);
    });

    it('should default to a SessionStore (Memory) with default TTL if no options are provided', () => {
      // With no options, code passes 3600000 (1 hour) to the SessionStore
      const result = Store.create(StorageMechanism.MEMORY, undefined, logger);

      expect(SessionStore).toHaveBeenCalledWith(logger, 3600000);
      expect(result.sessionStore).toBeInstanceOf(SessionStore);
    });

    it('should throw an error for unsupported storage types', () => {
      expect(() => {
        Store.create('unsupported' as StorageMechanism, undefined, logger);
      }).toThrowError(/Unsupported storage type: unsupported/);
    });
  });

  describe('Integration with logger', () => {
    it('should pass the logger to MemoryStore in COOKIE mode', () => {
      // This test makes sense only for the COOKIE path,
      // because that's the only time we do new MemoryStore(...) in Store.create()
      const options: StoreOptions = {
        storage: { ttl: 3600 },
        session: {
          cookie: {
            name: 'test-cookie',
            options: { path: '/', httpOnly: true },
          },
        },
      };

      Store.create(StorageMechanism.COOKIE, options, logger);

      expect(MemoryStore).toHaveBeenCalledWith(logger, 3600);
      expect(logger.info).not.toHaveBeenCalled();
    });

    // If you'd like, you can add a test for SessionStore or check
    // that the logger is used inside the SessionStore constructor.
    // But typically, you'd do that in SessionStore.test.ts if needed.
  });
});
