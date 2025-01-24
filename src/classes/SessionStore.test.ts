// src/classes/SessionStore.test.ts

// 1. Mock 'crypto' module before importing SessionStore
jest.mock('crypto', () => {
  const originalCrypto = jest.requireActual('crypto');
  return {
    ...originalCrypto,
    randomUUID: jest.fn(),
  };
});

// 2. Now import dependencies
import { SessionStore } from './SessionStore';
import { ISessionData, ILogger } from '../interfaces';
import { MemoryStore } from './MemoryStore';
import * as crypto from 'crypto'; // Import after jest.mock

jest.mock('./MemoryStore'); // Mock MemoryStore module

describe('SessionStore', () => {
  let sessionStore: SessionStore;
  let logger: ILogger;
  let memoryStoreMock: jest.Mocked<MemoryStore>;

  const data: ISessionData = {
    cookie: {
      access_token: 'test-access-token',
      refresh_token: 'test-refresh-token',
      token_type: 'Bearer',
      expires_in: 3600,
    },
    user: { sub: '1234567890', name: 'testname' },
  };

  beforeEach(() => {
    // Initialize logger with jest.fn()
    logger = {
      debug: jest.fn(),
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
      setLogLevel: jest.fn(),
    };

    // Initialize SessionStore (which internally creates a mocked MemoryStore)
    sessionStore = new SessionStore(logger);

    // Retrieve the mocked MemoryStore instance that SessionStore is using
    const MemoryStoreMock = MemoryStore as jest.MockedClass<typeof MemoryStore>;
    memoryStoreMock = MemoryStoreMock.mock
      .instances[0] as jest.Mocked<MemoryStore>;

    // 3. Mock crypto.randomUUID to return a valid UUID-like string
    (crypto.randomUUID as jest.Mock).mockReturnValue(
      '123e4567-e89b-12d3-a456-426614174000',
    );
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should set session data and return a session id', async () => {
    const sid = '123e4567-e89b-12d3-a456-426614174000'; // Valid UUID format
    memoryStoreMock.set.mockResolvedValueOnce();

    const result = await sessionStore.set(data);

    expect(result).toBe(sid);
    expect(logger.debug).toHaveBeenCalledWith(
      `Setting session data for sid: ${sid}`,
    );
    expect(memoryStoreMock.set).toHaveBeenCalledWith(sid, data);
  });

  it('should get session data by session id', async () => {
    const sid = '123e4567-e89b-12d3-a456-426614174000'; // Valid UUID format
    memoryStoreMock.get.mockResolvedValueOnce(data);

    const result = await sessionStore.get(sid);

    expect(result).toBe(data);
    expect(logger.debug).toHaveBeenCalledWith(
      `Getting session data for sid: ${sid}`,
    );
    expect(memoryStoreMock.get).toHaveBeenCalledWith(sid);
  });

  it('should return null if session data is not found', async () => {
    const sid = '123e4567-e89b-12d3-a456-426614174000'; // Valid UUID format
    memoryStoreMock.get.mockResolvedValueOnce(null);

    const result = await sessionStore.get(sid);

    expect(result).toBeNull();
    expect(logger.debug).toHaveBeenCalledWith(
      `Getting session data for sid: ${sid}`,
    );
    expect(memoryStoreMock.get).toHaveBeenCalledWith(sid);
  });

  it('should destroy session data by session id', async () => {
    const sid = '123e4567-e89b-12d3-a456-426614174000'; // Valid UUID format
    memoryStoreMock.destroy.mockResolvedValueOnce();

    await sessionStore.destroy(sid);

    expect(logger.debug).toHaveBeenCalledWith(
      `Destroying session data for sid: ${sid}`,
    );
    expect(memoryStoreMock.destroy).toHaveBeenCalledWith(sid);
  });

  it('should touch session data by session id', async () => {
    const sid = '123e4567-e89b-12d3-a456-426614174000'; // Valid UUID format
    memoryStoreMock.touch.mockResolvedValueOnce();

    await sessionStore.touch(sid, data);

    expect(logger.debug).toHaveBeenCalledWith(
      `Touching session data for sid: ${sid}`,
    );
    expect(memoryStoreMock.touch).toHaveBeenCalledWith(sid, data);
  });
});
