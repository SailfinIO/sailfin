// src/classes/Issuer.test.ts

import { Issuer } from './Issuer';
import { ILogger, ICache, ClientMetadata, IIssuer } from '../interfaces';
import { ClientError } from '../errors/ClientError';
import { Response } from 'node-fetch'; // Ensure you have node-fetch installed for the Response type

// Mock the global fetch function
global.fetch = jest.fn();

describe('Issuer', () => {
  let issuer: IIssuer;
  let logger: ILogger;
  let cache: ICache<ClientMetadata>;

  const discoveryUrl = 'https://example.com/.well-known/openid-configuration';
  const sampleConfig: Partial<ClientMetadata> = {
    issuer: 'https://example.com/',
    authorization_endpoint: 'https://example.com/oauth2/authorize',
    token_endpoint: 'https://example.com/oauth2/token',
    userinfo_endpoint: 'https://example.com/userinfo',
    jwks_uri: 'https://example.com/.well-known/jwks.json',
  };

  beforeEach(() => {
    // Reset all mocks before each test
    jest.resetAllMocks();

    // Reset the fetch mock
    (global.fetch as jest.Mock).mockReset();

    // Mock ILogger
    logger = {
      debug: jest.fn(),
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
      setLogLevel: jest.fn(),
    };

    // Mock ICache<ClientMetadata>
    cache = {
      get: jest.fn(),
      set: jest.fn(),
      delete: jest.fn(),
      clear: jest.fn(),
      size: jest.fn(),
    };
  });

  describe('Constructor', () => {
    it('should initialize with provided dependencies', () => {
      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);
      expect(issuer).toBeInstanceOf(Issuer);
    });

    it('should throw ClientError if discoveryUrl is invalid', () => {
      expect(() => new Issuer('', logger)).toThrowError(ClientError);
      expect(() => new Issuer('', logger)).toThrow(
        'Invalid discovery URL provided',
      );
    });

    it('should use default Cache if not provided', () => {
      issuer = new Issuer(discoveryUrl, logger);
      expect(issuer).toBeInstanceOf(Issuer);
      // Further checks can be added if necessary
    });
  });

  describe('discover', () => {
    // Changed from 'getDiscoveryConfig' to 'discover' to match the method name
    it('should fetch config and cache it if cache is empty', async () => {
      (cache.get as jest.Mock).mockReturnValue(undefined);

      // Mock the fetch response
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        new Response(JSON.stringify(sampleConfig), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        }),
      );

      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      const config = await issuer.discover();
      expect(config).toStrictEqual(sampleConfig);
      expect(cache.get).toHaveBeenCalledWith('discoveryConfig');
      expect(logger.debug).toHaveBeenCalledWith(
        'Cache miss for discovery config.',
      );
      expect(logger.debug).toHaveBeenCalledWith(
        'Fetching discovery configuration.',
        {
          discoveryUrl,
        },
      );
      expect(global.fetch).toHaveBeenCalledWith(discoveryUrl);
      expect(cache.set).toHaveBeenCalledWith(
        'discoveryConfig',
        sampleConfig,
        3600000,
      );
      expect(logger.info).toHaveBeenCalledWith(
        'Discovery configuration fetched and cached successfully.',
      );
    });

    it('should return cached config if available', async () => {
      // Mock the cache to return a valid cached configuration
      (cache.get as jest.Mock).mockReturnValue(sampleConfig);

      // Instantiate the Issuer with mocks
      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      // Call the discover method
      const config = await issuer.discover();

      // Assertions
      expect(config).toStrictEqual(sampleConfig); // The returned config should match the cached config
      expect(cache.get).toHaveBeenCalledWith('discoveryConfig'); // Ensure cache.get was called
      expect(logger.debug).toHaveBeenCalledWith(
        'Cache hit for discovery config.',
      ); // Ensure the debug log was made
      expect(global.fetch).not.toHaveBeenCalled(); // Ensure fetch was not called
    });

    it('should force refresh the config even if cached', async () => {
      (cache.get as jest.Mock).mockReturnValue(sampleConfig);

      // Mock the fetch response
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        new Response(JSON.stringify(sampleConfig), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        }),
      );

      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      const config = await issuer.discover(true);
      expect(config).toStrictEqual(sampleConfig); // Changed from toBe to toStrictEqual

      // Change expectation: cache.get should NOT be called when forceRefresh is true
      expect(cache.get).not.toHaveBeenCalled();

      expect(logger.debug).toHaveBeenCalledWith(
        'Force refresh enabled. Fetching discovery config.',
      );
      expect(global.fetch).toHaveBeenCalledWith(discoveryUrl);
      expect(cache.set).toHaveBeenCalledWith(
        'discoveryConfig',
        sampleConfig,
        3600000,
      );
    });

    it('should handle concurrent fetches gracefully', async () => {
      (cache.get as jest.Mock).mockReturnValue(undefined);

      // Mock the fetch response
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        new Response(JSON.stringify(sampleConfig), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        }),
      );

      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      // Initiate two simultaneous fetches
      const [config1, config2] = await Promise.all([
        issuer.discover(),
        issuer.discover(),
      ]);

      expect(config1).toStrictEqual(sampleConfig); // Changed from toBe to toStrictEqual
      expect(config2).toStrictEqual(sampleConfig); // Changed from toBe to toStrictEqual
      expect(global.fetch).toHaveBeenCalledTimes(1);
      expect(cache.set).toHaveBeenCalledTimes(1);
    });
  });

  describe('Error Handling', () => {
    it('should throw ClientError if discovery config is missing authorization_endpoint', async () => {
      // Create an invalid config missing the authorization_endpoint
      const invalidConfig = { ...sampleConfig };
      delete invalidConfig.authorization_endpoint;

      // Mock the cache to return undefined (simulate no cached config)
      (cache.get as jest.Mock).mockReturnValue(undefined);

      // Mock fetch to return the invalid configuration
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        new Response(JSON.stringify(invalidConfig), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        }),
      );

      // Instantiate the Issuer with mocks
      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      // Expect the discover method to throw a ClientError
      await expect(issuer.discover()).rejects.toMatchObject({
        message:
          'Invalid discovery configuration: Missing or invalid authorization_endpoint.',
        code: 'INVALID_DISCOVERY_CONFIG',
      });

      // Assertions
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to fetch discovery configuration.',
        {
          error: expect.any(ClientError),
        },
      );
      expect(cache.set).not.toHaveBeenCalled(); // Ensure the invalid config is not cached
    });
    it('should throw ClientError if discovery config is missing token_endpoint', async () => {
      // Create an invalid config missing the token_endpoint
      const invalidConfig = { ...sampleConfig };
      delete invalidConfig.token_endpoint;

      // Mock the cache to return undefined (simulate no cached config)
      (cache.get as jest.Mock).mockReturnValue(undefined);

      // Mock fetch to return the invalid configuration
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        new Response(JSON.stringify(invalidConfig), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        }),
      );

      // Instantiate the Issuer with mocks
      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      // Expect the discover method to throw a ClientError
      await expect(issuer.discover()).rejects.toMatchObject({
        message:
          'Invalid discovery configuration: Missing or invalid token_endpoint.',
        code: 'INVALID_DISCOVERY_CONFIG',
      });

      // Assertions
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to fetch discovery configuration.',
        {
          error: expect.any(ClientError),
        },
      );
      expect(cache.set).not.toHaveBeenCalled(); // Ensure the invalid config is not cached
    });
    it('should throw ClientError if token_endpoint is not a string', async () => {
      // Create an invalid config with a non-string token_endpoint
      const invalidConfig = { ...sampleConfig, token_endpoint: 123 };

      // Mock the cache to return undefined (simulate no cached config)
      (cache.get as jest.Mock).mockReturnValue(undefined);

      // Mock fetch to return the invalid configuration
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        new Response(JSON.stringify(invalidConfig), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        }),
      );

      // Instantiate the Issuer with mocks
      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      // Expect the discover method to throw a ClientError
      await expect(issuer.discover()).rejects.toMatchObject({
        message:
          'Invalid discovery configuration: Missing or invalid token_endpoint.',
        code: 'INVALID_DISCOVERY_CONFIG',
      });

      // Assertions
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to fetch discovery configuration.',
        {
          error: expect.any(ClientError),
        },
      );
      expect(cache.set).not.toHaveBeenCalled(); // Ensure the invalid config is not cached
    });

    it('should throw ClientError if fetch fails', async () => {
      (cache.get as jest.Mock).mockReturnValue(undefined);
      (global.fetch as jest.Mock).mockRejectedValueOnce(
        new Error('Network failure'),
      );

      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      await expect(issuer.discover()).rejects.toMatchObject({
        message: 'Unable to fetch discovery configuration',
        code: 'DISCOVERY_ERROR',
        context: { originalError: expect.any(Error) },
      });

      expect(logger.error).toHaveBeenCalledWith(
        'Failed to fetch discovery configuration.',
        {
          error: expect.any(Error),
        },
      );
      expect(cache.set).not.toHaveBeenCalled();
    });

    it('should throw ClientError if response is invalid JSON', async () => {
      (cache.get as jest.Mock).mockReturnValue(undefined);

      // Mock the fetch response to throw a SyntaxError when json() is called
      (global.fetch as jest.Mock).mockResolvedValueOnce({
        json: jest
          .fn()
          .mockRejectedValue(new SyntaxError('Unexpected token i in JSON')),
      });

      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      await expect(issuer.discover()).rejects.toMatchObject({
        message: 'Unable to fetch discovery configuration',
        code: 'DISCOVERY_ERROR',
        context: { originalError: expect.any(SyntaxError) },
      });

      expect(logger.error).toHaveBeenCalledWith(
        'Failed to fetch discovery configuration.',
        {
          error: expect.any(SyntaxError),
        },
      );
      expect(cache.set).not.toHaveBeenCalled();
    });

    it('should throw ClientError if discovery config is missing issuer', async () => {
      const invalidConfig = { ...sampleConfig };
      delete invalidConfig.issuer;

      (cache.get as jest.Mock).mockReturnValue(undefined);
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        new Response(JSON.stringify(invalidConfig), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        }),
      );

      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      await expect(issuer.discover()).rejects.toMatchObject({
        message: 'Invalid discovery configuration: Missing or invalid issuer.',
        code: 'INVALID_DISCOVERY_CONFIG',
      });

      expect(logger.error).toHaveBeenCalledWith(
        'Failed to fetch discovery configuration.',
        {
          error: expect.any(ClientError),
        },
      );
      expect(cache.set).not.toHaveBeenCalled();
    });

    it('should throw ClientError if discovery config is missing jwks_uri', async () => {
      const invalidConfig = { ...sampleConfig };
      delete invalidConfig.jwks_uri;

      (cache.get as jest.Mock).mockReturnValue(undefined);
      (global.fetch as jest.Mock).mockResolvedValueOnce(
        new Response(JSON.stringify(invalidConfig), {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
        }),
      );

      issuer = new Issuer(discoveryUrl, logger, cache, 3600000);

      await expect(issuer.discover()).rejects.toMatchObject({
        message:
          'Invalid discovery configuration: Missing or invalid jwks_uri.',
        code: 'INVALID_DISCOVERY_CONFIG',
      });

      expect(logger.error).toHaveBeenCalledWith(
        'Failed to fetch discovery configuration.',
        {
          error: expect.any(ClientError),
        },
      );
      expect(cache.set).not.toHaveBeenCalled();
    });
  });
});
