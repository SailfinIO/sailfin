// src/classes/Jwks.test.ts

import { Jwks } from './Jwks'; // Adjust the import path as necessary
import { ILogger, ICache, Jwk, JwksResponse } from '../interfaces';
import { ClientError } from '../errors/ClientError';

// Helper to mock successful fetch responses
const mockFetchSuccess = (data: any, status: number = 200) => ({
  ok: status >= 200 && status < 300,
  status,
  json: jest.fn().mockResolvedValue(data),
});

// Helper to mock failed fetch responses
const mockFetchFailure = (error: any) => ({
  ok: false,
  status: 500,
  json: jest.fn().mockResolvedValue({ error: error.message }),
});

global.fetch = jest.fn();

describe('Jwks', () => {
  let client: Jwks;
  let logger: ILogger;
  let cache: ICache<Jwk[]>;

  const jwksUri = 'https://example.com/.well-known/jwks.json';
  const sampleJWKS: JwksResponse = {
    keys: [
      {
        kid: 'key1',
        kty: 'RSA',
        n: 'sXch6vZ3N9nndrQmbXEps2aiAFbWhM78LhWx4cbbfAAtQ9jYy5V9k7qJAsFDcQBUQM0E9sYbVjk40D19bXq9xLqGQ8GaPoVTVQeAUn0pFB1ZkWQQaTMeQFRt4ZtNTS7vkTl6T8tVQXoQoi8wS5fvAKX9uY4oVBcYecOgL',
        e: 'AQAB',
      },
      {
        kid: 'key2',
        kty: 'RSA',
        n: 'sXch6vZ3N9nndrQmbXEps2aiAFbWhM78LhWx4cbbfAAtQ9jYy5V9k7qJAsFDcQBUQM0E9sYbVjk40D19bXq9xLqGQ8GaPoVTVQeAUn0pFB1ZkWQQaTMeQFRt4ZtNTS7vkTl6T8tVQXoQoi8wS5fvAKX9uY4oVBcYecOgL',
        e: 'AQAB',
      },
    ],
  };

  beforeEach(() => {
    // Reset all mocks before each test
    jest.resetAllMocks();

    // Create fresh mock instances for each test
    logger = {
      debug: jest.fn(),
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
      setLogLevel: jest.fn(),
    };

    cache = {
      get: jest.fn(),
      set: jest.fn(),
      delete: jest.fn(),
      clear: jest.fn(),
      size: jest.fn(),
    };

    // Default mock for fetch to resolve with sampleJWKS
    (global.fetch as jest.Mock).mockResolvedValue(mockFetchSuccess(sampleJWKS));

    client = new Jwks(jwksUri, logger, cache, 3600000);
  });

  afterEach(() => {
    jest.clearAllMocks();
    (global.fetch as jest.Mock).mockReset();
  });

  describe('Constructor', () => {
    it('should initialize with provided dependencies', () => {
      expect(client).toBeInstanceOf(Jwks);
      expect(logger).toBeDefined();
      expect(cache).toBeDefined();
    });

    it('should throw ClientError if jwksUri is invalid', () => {
      expect(() => new Jwks('', logger)).toThrowError(ClientError);
      expect(() => new Jwks('', logger)).toThrow('Invalid JWKS URI provided');
    });

    it('should use default cache if not provided', () => {
      const newClient = new Jwks(jwksUri, logger);
      expect(newClient).toBeInstanceOf(Jwks);
      // Further checks can be added to ensure defaults are used
    });
  });

  describe('getKey', () => {
    const kid = 'key1';
    const jwk: Jwk = { kid, kty: 'RSA', n: '...', e: 'AQAB' } as Jwk;
    const jwksResponseWithKey: JwksResponse = { keys: [jwk] };
    const jwksResponseEmpty: JwksResponse = { keys: [] };

    it('should throw ClientError if kid is not provided', async () => {
      await expect(client.getKey('')).rejects.toThrow(ClientError);
      await expect(client.getKey('')).rejects.toThrow('kid must be provided');
      expect(logger.error).not.toHaveBeenCalled();
    });
    it('should throw ClientError if JWKS cache is empty after refresh', async () => {
      // Simulate the cache being empty after refreshCache is called
      (cache.get as jest.Mock)
        .mockReturnValueOnce(undefined) // Initial cache miss
        .mockReturnValueOnce(undefined); // Cache still empty after refresh

      // Mock fetch to simulate a successful fetch
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        mockFetchSuccess(sampleJWKS),
      );

      await expect(client.getKey('key1')).rejects.toMatchObject({
        message: 'JWKS cache is empty after refresh',
        code: 'JWKS_FETCH_ERROR',
      });

      expect(global.fetch).toHaveBeenCalledWith(jwksUri);
      expect(logger.error).not.toHaveBeenCalled();
      expect(logger.debug).toHaveBeenCalledWith('Fetching JWKS from URI', {
        jwksUri,
      });
    });

    it('should return key if found in cache', async () => {
      (cache.get as jest.Mock).mockReturnValue([jwk]);

      const result = await client.getKey(kid);
      expect(result).toBe(jwk);
      expect(cache.get).toHaveBeenCalledWith('jwks');
      expect(logger.debug).toHaveBeenCalledWith(`Cache hit for key: jwks`);
    });

    it('should fetch JWKS and update cache if cache is empty', async () => {
      (cache.get as jest.Mock)
        .mockReturnValueOnce(undefined) // Initial cache miss
        .mockReturnValueOnce(jwksResponseWithKey.keys); // After refresh

      (global.fetch as jest.Mock).mockResolvedValueOnce(
        mockFetchSuccess(jwksResponseWithKey),
      );

      const result = await client.getKey(kid);

      expect(cache.get).toHaveBeenCalledTimes(2);
      expect(cache.get).toHaveBeenNthCalledWith(1, 'jwks');
      expect(cache.get).toHaveBeenNthCalledWith(2, 'jwks');
      expect(logger.debug).toHaveBeenCalledWith('Fetching JWKS from URI', {
        jwksUri,
      });
      expect(global.fetch).toHaveBeenCalledWith(jwksUri);
      expect(cache.set).toHaveBeenCalledWith(
        'jwks',
        jwksResponseWithKey.keys,
        3600000,
      );
      expect(logger.debug).toHaveBeenCalledWith('JWKS cache refreshed', {
        numberOfKeys: jwksResponseWithKey.keys.length,
      });
      expect(result).toBe(jwk);
    });

    it('should throw ClientError if JWKS fetch fails', async () => {
      (cache.get as jest.Mock).mockReturnValue(undefined);
      (global.fetch as jest.Mock).mockRejectedValueOnce(
        new Error('Network error'),
      );

      await expect(client.getKey(kid)).rejects.toMatchObject({
        message: 'Failed to fetch JWKS',
        code: 'JWKS_FETCH_ERROR',
      });
      expect(logger.error).toHaveBeenCalledWith('Failed to fetch JWKS', {
        error: expect.any(Error),
      });
    });

    it('should throw ClientError if JWKS cache is empty after refresh', async () => {
      // Simulate refreshCache fetching successfully but setting an empty keys array
      (cache.get as jest.Mock)
        .mockReturnValueOnce(undefined) // Initial cache miss
        .mockReturnValueOnce(jwksResponseEmpty.keys) // After first refresh
        .mockReturnValueOnce(jwksResponseEmpty.keys); // After second refresh

      (global.fetch as jest.Mock).mockResolvedValueOnce(
        mockFetchSuccess(jwksResponseEmpty),
      );

      await expect(client.getKey(kid)).rejects.toMatchObject({
        message: `No matching key found for kid ${kid}`,
        code: 'JWKS_KEY_NOT_FOUND',
      });
      expect(logger.warn).toHaveBeenCalledWith(
        `Key with kid ${kid} not found. Refreshing JWKS.`,
      );
      expect(logger.error).not.toHaveBeenCalled();
    });

    it('should throw ClientError if key not found after refresh', async () => {
      (cache.get as jest.Mock)
        .mockReturnValueOnce(undefined) // Initial cache miss
        .mockReturnValueOnce(jwksResponseEmpty.keys) // After first refresh
        .mockReturnValueOnce(jwksResponseEmpty.keys); // After second refresh

      (global.fetch as jest.Mock).mockResolvedValueOnce(
        mockFetchSuccess(jwksResponseEmpty),
      );

      await expect(client.getKey(kid)).rejects.toMatchObject({
        message: `No matching key found for kid ${kid}`,
        code: 'JWKS_KEY_NOT_FOUND',
      });
      expect(logger.warn).toHaveBeenCalledWith(
        `Key with kid ${kid} not found. Refreshing JWKS.`,
      );
    });

    it('should handle concurrent getKey calls without multiple fetches', async () => {
      (cache.get as jest.Mock)
        .mockReturnValueOnce(undefined) // Initial cache miss
        .mockReturnValueOnce(jwksResponseWithKey.keys) // After first refresh
        .mockReturnValueOnce(jwksResponseWithKey.keys); // After second refresh for concurrent calls

      (global.fetch as jest.Mock).mockResolvedValueOnce(
        mockFetchSuccess(jwksResponseWithKey),
      );

      const promise1 = client.getKey(kid);
      const promise2 = client.getKey(kid);

      const [result1, result2] = await Promise.all([promise1, promise2]);

      expect(global.fetch).toHaveBeenCalledTimes(1);
      expect(cache.get).toHaveBeenCalledTimes(3);
      expect(cache.get).toHaveBeenNthCalledWith(1, 'jwks');
      expect(cache.get).toHaveBeenNthCalledWith(2, 'jwks');
      expect(cache.get).toHaveBeenNthCalledWith(3, 'jwks');
      expect(result1).toBe(jwk);
      expect(result2).toBe(jwk);
    });
  });

  describe('refreshCache', () => {
    const jwk: Jwk = {
      kid: 'key1',
      kty: 'RSA',
      n: '...',
      e: 'AQAB',
    } as Jwk;
    const jwksResponse: JwksResponse = { keys: [jwk] };

    it('should fetch JWKS and update cache', async () => {
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        mockFetchSuccess(jwksResponse),
      );

      await (client as any).refreshCache();

      expect(logger.debug).toHaveBeenCalledWith('Fetching JWKS from URI', {
        jwksUri,
      });
      expect(global.fetch).toHaveBeenCalledWith(jwksUri);
      expect(cache.set).toHaveBeenCalledWith(
        'jwks',
        jwksResponse.keys,
        3600000,
      );
      expect(logger.debug).toHaveBeenCalledWith('JWKS cache refreshed', {
        numberOfKeys: jwksResponse.keys.length,
      });
    });

    it('should throw ClientError if HTTPClient.get fails', async () => {
      (global.fetch as jest.Mock).mockRejectedValueOnce(
        new Error('Network failure'),
      );

      await expect((client as any).refreshCache()).rejects.toMatchObject({
        message: 'Failed to fetch JWKS',
        code: 'JWKS_FETCH_ERROR',
      });
      expect(logger.error).toHaveBeenCalledWith('Failed to fetch JWKS', {
        error: expect.any(Error),
      });
    });

    it('should throw ClientError if JWKS response is invalid JSON', async () => {
      // Mock fetch to return invalid JSON
      (global.fetch as jest.Mock).mockResolvedValueOnce({
        ok: true,
        status: 200,
        json: jest.fn().mockRejectedValueOnce(new Error('Invalid JSON')),
      });

      await expect((client as any).refreshCache()).rejects.toMatchObject({
        message: 'Invalid JWKS response format',
        code: 'JWKS_PARSE_ERROR',
      });
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to parse JWKS response',
        { parseError: expect.any(Error) },
      );
    });

    it('should throw ClientError if JWKS response does not contain keys array', async () => {
      const invalidJwksResponse = { notKeys: [] };
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        mockFetchSuccess(invalidJwksResponse),
      );

      await expect((client as any).refreshCache()).rejects.toMatchObject({
        message: 'JWKS response does not contain keys',
        code: 'JWKS_INVALID',
      });
      expect(logger.error).toHaveBeenCalledWith(
        'JWKS response does not contain keys array',
        { jwks: invalidJwksResponse },
      );
    });
  });
});
