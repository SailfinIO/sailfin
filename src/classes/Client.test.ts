// src/classes/Client.test.ts

// 1. Declare mockLoggerInstance before jest.mock
let mockLoggerInstance: any;

// 2. Mock '../utils' before importing modules that depend on it
jest.mock('../utils', () => {
  // Initialize mockLoggerInstance within the mock factory
  mockLoggerInstance = {
    setLogLevel: jest.fn(),
    debug: jest.fn(),
    info: jest.fn(),
    warn: jest.fn(),
    error: jest.fn(),
  };

  const originalModule = jest.requireActual('../utils');
  return {
    __esModule: true, // Use it when dealing with ES6 modules
    ...originalModule, // Spread the original exports
    Logger: jest.fn(() => mockLoggerInstance), // Mock only the Logger
    // Do not mock 'parse' here
  };
});

// 3. Import modules after jest.mock
import { Client } from './Client';
import { Auth } from './Auth';
import { UserInfo } from './UserInfo';
import { Token } from './Token';
import { ClientError } from '../errors';
import { LogLevel, TokenTypeHint, StorageMechanism, GrantType } from '../enums';
import { Issuer } from './Issuer';
import {
  IStore,
  ISessionStore,
  IResponse,
  ISessionData,
  IClientConfig,
} from '../interfaces';
import { Store } from './Store';
import * as utils from '../utils';
import { Session } from './Session';
import { defaultClientConfig } from '../config/defaultClientConfig';
import { Request } from './Request';

// 4. Set environment variables if needed
process.env.OIDC_CLIENT_LOG_LEVEL = 'DEBUG';

// 5. Mock other dependencies
jest.mock('./Auth');
jest.mock('./UserInfo');
jest.mock('./Session');
jest.mock('./Issuer');
jest.mock('./Store');
jest.mock('./Token');

// 6. Define mock instances before they are used
const createMockResponse = (init: Partial<IResponse> = {}): IResponse => {
  return {
    // Mock the redirect method
    redirect: jest.fn(),

    // Mock the status method
    status: jest.fn().mockReturnThis(),

    // Mock the send method
    send: jest.fn().mockReturnThis(),

    // Additional properties if needed
    headers: new Headers(),
    body: null,
    bodyUsed: false,
    ok: true,
    redirected: false,
    statusText: 'OK',
    type: 'basic',
    url: 'http://localhost',
    clone: jest.fn(),
    arrayBuffer: jest.fn().mockResolvedValue(new ArrayBuffer(0)),
    blob: jest.fn().mockResolvedValue(new Blob()),
    formData: jest.fn().mockResolvedValue(new FormData()),
    json: jest.fn().mockResolvedValue({}),
    text: jest.fn().mockResolvedValue(''),
  } as unknown as IResponse;
};

const createMockRequest = (
  url: string = 'http://localhost',
  init: Partial<RequestInit> = {},
  query: Record<string, any> = {},
  session?: ISessionData,
): Request => {
  //@ts-ignore
  const request = new Request();
  request
    .setUrl(url)
    .setQuery(query)
    .setMethod(init.method || 'GET');
  if (session) request.setSession(session);
  return request;
};

// 7. Mock the 'parse' function using jest.spyOn in beforeEach
beforeEach(() => {
  // Reset all mock implementations and calls before each test
  jest.clearAllMocks();

  // Mock the 'parse' function using jest.spyOn
  jest.spyOn(utils, 'parse').mockImplementation((cookieHeader: string) => {
    // Simple parser for 'key=value' pairs
    const cookies: Record<string, string> = {};
    cookieHeader.split(';').forEach((cookie) => {
      const [key, value] = cookie.trim().split('=');
      if (key && value) {
        cookies[key] = value;
      }
    });
    return cookies;
  });
});

// 8. Define other mock instances
const mockTokenInstance = {
  getTokens: jest.fn().mockReturnValue({
    access_token: 'access_token',
    refresh_token: 'refresh_token',
    expires_in: 3600,
    token_type: 'Bearer',
  }),
  introspectToken: jest.fn().mockResolvedValue({
    active: true,
    scope: 'openid profile',
  }),
  revokeToken: jest.fn().mockResolvedValue(undefined),
  getAccessToken: jest.fn().mockResolvedValue('access_token'),
  clearTokens: jest.fn(),
  refreshAccessToken: jest.fn().mockResolvedValue(undefined),
  getClaims: jest.fn(), // Added for getClaims tests
};

// Configure the mocked Token class to return the mockTokenInstance
(Token as jest.Mock).mockImplementation(() => mockTokenInstance);

// Define a mock Issuer instance
const mockIssuerInstance = {
  discover: jest.fn().mockResolvedValue({
    issuer: 'https://example.com',
    authorization_endpoint: 'https://example.com/auth',
    token_endpoint: 'https://example.com/token',
    userinfo_endpoint: 'https://example.com/userinfo',
    introspection_endpoint: 'https://example.com/introspect',
    revocation_endpoint: 'https://example.com/revoke',
  }),
};

// Configure the mocked Issuer class to return the mockIssuerInstance
(Issuer as jest.Mock).mockImplementation(() => mockIssuerInstance);

// Define a mock Auth instance
const mockAuthInstance = {
  getAuthorizationUrl: jest.fn().mockResolvedValue({
    url: 'https://example.com/auth',
    state: 'random-state',
  }),
  handleRedirect: jest.fn().mockResolvedValue(undefined),
  handleRedirectForImplicitFlow: jest.fn().mockResolvedValue(undefined),
  startDeviceAuthorization: jest.fn().mockResolvedValue({
    device_code: 'device_code',
    user_code: 'user_code',
    verification_uri: 'https://example.com/verify',
    expires_in: 1800,
    interval: 5,
  }),
  pollDeviceToken: jest.fn().mockResolvedValue(undefined),
  getLogoutUrl: jest.fn().mockResolvedValue('https://example.com/logout'),
};

// Configure the mocked Auth class to return the mockAuthInstance
(Auth as jest.Mock).mockImplementation(() => mockAuthInstance);

// Define a mock UserInfo instance
const mockUserInfoInstance = {
  getUserInfo: jest.fn().mockResolvedValue({
    id: 'user123',
    name: 'Test User',
  }),
};

// Configure the mocked UserInfo class to return the mockUserInfoInstance
(UserInfo as jest.Mock).mockImplementation(() => mockUserInfoInstance);

// Mock the Session class
jest.mock('./Session');

// Define a mock Session instance
const mockSessionInstance = {
  sid: 'mock_sid',
  start: jest.fn(),
  stop: jest.fn(),
};

// Configure the mocked Session class to return the mockSessionInstance
(Session as jest.Mock).mockImplementation(() => mockSessionInstance);

// Implement an in-memory mock store
const mockStore: IStore = {
  set: jest.fn().mockResolvedValue(undefined),
  get: jest.fn().mockResolvedValue(null),
  destroy: jest.fn().mockResolvedValue(undefined),
  touch: jest.fn().mockResolvedValue(undefined),
};

// Define a mock SessionStore instance
const mockSessionStore: ISessionStore = {
  set: jest.fn().mockResolvedValue('mock_sid'),
  get: jest.fn().mockResolvedValue({
    cookie: {
      access_token: 'access_token',
      refresh_token: 'refresh_token',
      expires_in: 3600,
    },
    user: { id: 'user123', name: 'Test User' },
  }),
  destroy: jest.fn().mockResolvedValue(undefined),
  touch: jest.fn().mockResolvedValue(undefined),
};

// Mock the Store.create static method to return both store and sessionStore
(Store as any).create = jest.fn().mockReturnValue({
  store: mockStore,
  sessionStore: mockSessionStore,
});

// 9. Create mock request and response
const mockRequest = createMockRequest('http://localhost', {
  headers: {
    cookie: 'sid=mock_sid',
  },
});

const mockResponse = createMockResponse();

// Define a mock context to be used in tests
const mockContext = { request: mockRequest, response: mockResponse };

// 10. Define the test suite
describe('Client', () => {
  let client: Client;
  let mockConfig: Partial<IClientConfig>;

  beforeEach(() => {
    // Reset all mock implementations and calls before each test
    jest.clearAllMocks();

    // Mock the 'parse' function
    jest.spyOn(utils, 'parse').mockImplementation((cookieHeader: string) => {
      const cookies: Record<string, string> = {};
      cookieHeader.split(';').forEach((cookie) => {
        const [key, value] = cookie.trim().split('=');
        if (key && value) {
          cookies[key] = value;
        }
      });
      return cookies;
    });

    // Define mockConfig with logger
    mockConfig = {
      clientId: 'test-client-id',
      clientSecret: 'test-client',
      redirectUri: 'https://example.com/callback',
      scopes: ['openid', 'profile'],
      discoveryUrl: 'https://example.com/.well-known/openid-configuration',
      session: {
        useSilentRenew: true,
        cookie: {
          name: 'sid',
          secret: 'cookie-secret',
        },
      },
      logging: {
        logLevel: LogLevel.INFO,
        logger: mockLoggerInstance, // Inject the mocked logger
      },
    };

    // Instantiate the Client with the mockConfig
    client = new Client(mockConfig as IClientConfig);
  });

  it('should initialize with default config', () => {
    expect(client).toBeDefined();
    // Additional initialization assertions can be added here
  });

  it('should throw error if required config is missing', () => {
    expect(() => new Client({ clientId: 'test' } as any)).toThrow(ClientError);
  });

  it('should log an error and throw ClientError if initialization fails', async () => {
    // Mock the Issuer's discover method to throw an error
    const discoveryError = new Error('Discovery failed');
    mockIssuerInstance.discover.mockRejectedValueOnce(discoveryError);

    // Expect the client to throw an error during initialization
    await expect(client.getAuthorizationUrl()).rejects.toThrow(
      'Initialization failed',
    );

    // Verify that the logger.error was called with the appropriate message and error
    expect(mockLoggerInstance.error).toHaveBeenCalledWith(
      'Failed to initialize OIDC Client',
      { error: discoveryError },
    );
  });

  describe('Client configuration validation', () => {
    it('should throw ClientError if clientId is missing', () => {
      const configWithoutClientId = {
        redirectUri: 'https://example.com/callback',
        scopes: ['openid', 'profile'],
        discoveryUrl: 'https://example.com/.well-known/openid-configuration',
        logging: {
          logLevel: LogLevel.INFO,
          logger: mockLoggerInstance,
        },
      };

      expect(() => new Client(configWithoutClientId as any)).toThrow(
        new ClientError('Missing required field(s): clientId', 'CONFIG_ERROR'),
      );
    });

    it('should throw ClientError if redirectUri is missing', () => {
      const configWithoutRedirectUri = {
        clientId: 'test-client-id',
        scopes: ['openid', 'profile'],
        discoveryUrl: 'https://example.com/.well-known/openid-configuration',
        logging: {
          logLevel: LogLevel.INFO,
          logger: mockLoggerInstance,
        },
      };

      expect(() => new Client(configWithoutRedirectUri as any)).toThrow(
        new ClientError(
          'Missing required field(s): redirectUri',
          'CONFIG_ERROR',
        ),
      );
    });

    it('should throw ClientError if scopes are missing', () => {
      const configWithoutScopes = {
        clientId: 'test-client-id',
        redirectUri: 'https://example.com/callback',
        discoveryUrl: 'https://example.com/.well-known/openid-configuration',
        logging: {
          logLevel: LogLevel.INFO,
          logger: mockLoggerInstance,
        },
      };

      expect(() => new Client(configWithoutScopes as any)).toThrow(
        new ClientError('At least one scope is required', 'CONFIG_ERROR'),
      );
    });

    it('should throw ClientError if discoveryUrl is missing', () => {
      const configWithoutDiscoveryUrl = {
        clientId: 'test-client-id',
        redirectUri: 'https://example.com/callback',
        scopes: ['openid', 'profile'],
        logging: {
          logLevel: LogLevel.INFO,
          logger: mockLoggerInstance,
        },
      };

      expect(() => new Client(configWithoutDiscoveryUrl as any)).toThrow(
        new ClientError(
          'Missing required field(s): discoveryUrl',
          'CONFIG_ERROR',
        ),
      );
    });
  });

  it('should get authorization URL', async () => {
    const result = await client.getAuthorizationUrl();
    expect(result).toEqual({
      url: 'https://example.com/auth',
      state: 'random-state',
    });
    expect(mockAuthInstance.getAuthorizationUrl).toHaveBeenCalled();
  });

  it('should handle redirect with valid code and state', async () => {
    await expect(
      client.handleRedirect('auth-code', 'state', mockContext),
    ).resolves.toBeUndefined();
    expect(mockAuthInstance.handleRedirect).toHaveBeenCalledWith(
      'auth-code',
      'state',
    );

    // Now that session logic is handled by Session, we simply ensure it was called:
    expect(mockSessionInstance.start).toHaveBeenCalledWith(mockContext);
  });

  it('should handle redirect for implicit flow', async () => {
    await expect(
      client.handleRedirectForImplicitFlow('fragment', mockContext),
    ).resolves.toBeUndefined();
    expect(mockAuthInstance.handleRedirectForImplicitFlow).toHaveBeenCalledWith(
      'fragment',
    );

    // Again, we check that session start was called:
    expect(mockSessionInstance.start).toHaveBeenCalledWith(mockContext);
  });

  it('should handle redirect for implicit flow with silent renew enabled', async () => {
    await expect(
      client.handleRedirectForImplicitFlow('fragment', mockContext),
    ).resolves.toBeUndefined();

    expect(mockAuthInstance.handleRedirectForImplicitFlow).toHaveBeenCalledWith(
      'fragment',
    );

    // Verify that session.start was called since useSilentRenew is true
    expect(mockSessionInstance.start).toHaveBeenCalledWith(mockContext);
  });

  it('should handle redirect for implicit flow without silent renew', async () => {
    // Update the config to disable silent renew
    const configWithoutSilentRenew = {
      ...mockConfig,
      session: {
        ...mockConfig.session,
        useSilentRenew: false,
      },
    };

    // Instantiate a new Client with the updated configuration
    const clientWithoutSilentRenew = new Client(
      configWithoutSilentRenew as IClientConfig,
    );

    await expect(
      clientWithoutSilentRenew.handleRedirectForImplicitFlow(
        'fragment',
        mockContext,
      ),
    ).resolves.toBeUndefined();

    expect(mockAuthInstance.handleRedirectForImplicitFlow).toHaveBeenCalledWith(
      'fragment',
    );

    // Verify that session.start was still called even without silent renew
    expect(mockSessionInstance.start).toHaveBeenCalledWith(mockContext);
  });

  it('should retrieve user info', async () => {
    const userInfo = await client.getUserInfo();
    expect(userInfo).toEqual({ id: 'user123', name: 'Test User' });
    expect(mockUserInfoInstance.getUserInfo).toHaveBeenCalled();
  });

  it('should introspect token', async () => {
    const response = await client.introspectToken('token123');
    expect(response).toEqual({ active: true, scope: 'openid profile' });
    expect(mockTokenInstance.introspectToken).toHaveBeenCalledWith('token123');
  });

  it('should revoke token', async () => {
    await expect(
      client.revokeToken('token123', TokenTypeHint.AccessToken),
    ).resolves.toBeUndefined();
    expect(mockTokenInstance.revokeToken).toHaveBeenCalledWith(
      'token123',
      TokenTypeHint.AccessToken,
    );
  });

  it('should start device authorization', async () => {
    const result = await client.startDeviceAuthorization();
    expect(result).toEqual({
      device_code: 'device_code',
      user_code: 'user_code',
      verification_uri: 'https://example.com/verify',
      expires_in: 1800,
      interval: 5,
    });
    expect(mockAuthInstance.startDeviceAuthorization).toHaveBeenCalled();
  });

  it('should poll device token', async () => {
    await expect(
      client.pollDeviceToken('device_code', 5, undefined, mockContext),
    ).resolves.toBeUndefined();
    expect(mockAuthInstance.pollDeviceToken).toHaveBeenCalledWith(
      'device_code',
      5,
      undefined,
    );

    // And session start should have been called
    expect(mockSessionInstance.start).toHaveBeenCalledWith(mockContext);
  });

  it('should get access token', async () => {
    const accessToken = await client.getAccessToken();
    expect(accessToken).toBe('access_token');
    expect(mockTokenInstance.getAccessToken).toHaveBeenCalled();
  });

  it('should get tokens', async () => {
    const tokens = await client.getTokens();
    expect(tokens).toEqual({
      access_token: 'access_token',
      refresh_token: 'refresh_token',
      expires_in: 3600,
      token_type: 'Bearer',
    });
    expect(mockTokenInstance.getTokens).toHaveBeenCalled();
  });

  it('should clear tokens', async () => {
    await expect(client.clearTokens(mockContext)).resolves.toBeUndefined();
    expect(mockTokenInstance.clearTokens).toHaveBeenCalled();
    // The Client no longer calls sessionStore.destroy directly; instead it calls session.stop()
    expect(mockSessionInstance.stop).toHaveBeenCalledWith(mockContext);
  });

  it('should initiate logout', async () => {
    const logoutUrl = await client.logout('id_token_hint');
    expect(logoutUrl).toBe('https://example.com/logout');
    expect(mockAuthInstance.getLogoutUrl).toHaveBeenCalledWith('id_token_hint');
  });

  it('should set log level', () => {
    client.setLogLevel(LogLevel.DEBUG);
    expect(mockLoggerInstance.setLogLevel).toHaveBeenCalledWith(LogLevel.DEBUG);
  });

  it('should throw an error when startDeviceAuthorization fails', async () => {
    const authError = new Error('Auth failed');
    mockAuthInstance.startDeviceAuthorization.mockRejectedValueOnce(authError);

    await expect(client.startDeviceAuthorization()).rejects.toThrow(authError);
    expect(mockAuthInstance.startDeviceAuthorization).toHaveBeenCalled();
  });

  it('should return null access token when tokenClient.getAccessToken returns null', async () => {
    mockTokenInstance.getAccessToken.mockResolvedValueOnce(null);
    const accessToken = await client.getAccessToken();
    expect(accessToken).toBeNull();
    expect(mockTokenInstance.getAccessToken).toHaveBeenCalled();
  });

  it('should handle timeout in pollDeviceToken', async () => {
    const timeoutError = new Error('Polling timed out');
    mockAuthInstance.pollDeviceToken.mockRejectedValueOnce(timeoutError);

    await expect(
      client.pollDeviceToken('device_code', 5, 10, mockContext),
    ).rejects.toThrow(timeoutError);
    expect(mockAuthInstance.pollDeviceToken).toHaveBeenCalledWith(
      'device_code',
      5,
      10,
    );
    expect(mockSessionInstance.start).not.toHaveBeenCalled();
  });

  it('should handle redirect without silent renew', async () => {
    // Update the config to disable silent renew
    const configWithoutSilentRenew = {
      ...mockConfig,
      session: {
        ...mockConfig.session,
        useSilentRenew: false,
      },
    };
    client = new Client(configWithoutSilentRenew as IClientConfig);

    await expect(
      client.handleRedirect('auth-code', 'state', mockContext),
    ).resolves.toBeUndefined();
    expect(mockAuthInstance.handleRedirect).toHaveBeenCalledWith(
      'auth-code',
      'state',
    );
    expect(mockSessionInstance.start).toHaveBeenCalledWith(mockContext);
  });

  it('should have grantType set to AuthorizationCode by default', () => {
    const config = client.getConfig();
    expect(config.grantType).toBe(GrantType.AuthorizationCode);
    // Optionally, verify that the logger.debug was not called
    expect(mockLoggerInstance.debug).not.toHaveBeenCalled();
  });

  // ------------------ Additional Tests for getConfig ------------------
  describe('getConfig', () => {
    it('should return the correct configuration', () => {
      const config = client.getConfig();

      // Check individual properties
      expect(config.clientId).toBe('test-client-id');
      expect(config.clientSecret).toBe('test-client');
      expect(config.redirectUri).toBe('https://example.com/callback');
      expect(config.scopes).toEqual(['openid', 'profile']);
      expect(config.discoveryUrl).toBe(
        'https://example.com/.well-known/openid-configuration',
      );

      // Check session properties using toMatchObject
      expect(config.session).toMatchObject({
        useSilentRenew: true,
        cookie: {
          name: 'sid',
          secret: 'cookie-secret',
        },
      });

      // Check logging properties
      expect(config.logging.logLevel).toBe(LogLevel.INFO);
      expect(config.logging.logger).toMatchObject({
        setLogLevel: expect.any(Function),
        debug: expect.any(Function),
        info: expect.any(Function),
        warn: expect.any(Function),
        error: expect.any(Function),
      });

      // Optionally, verify that additional properties exist
      expect(config.session).toHaveProperty('mode', 'server');
      expect(config.session).toHaveProperty('serverStorage', 'memory');
      expect(config.session).toHaveProperty('clientStorage', 'cookie');
      expect(config.session).toHaveProperty('ttl', 3600000);
    });

    it('should correctly merge default config with partial user config', () => {
      const partialConfig = {
        clientId: 'partial-client-id',
        redirectUri: 'https://partial.example.com/callback',
        discoveryUrl:
          'https://partial.example.com/.well-known/openid-configuration',
        scopes: ['openid'],
        logging: {
          logLevel: LogLevel.DEBUG,
          logger: mockLoggerInstance,
        },
        // No session property provided
      };

      const partialClient = new Client(partialConfig as IClientConfig);
      const config = partialClient.getConfig();

      // Check individual properties
      expect(config.clientId).toBe('partial-client-id');
      expect(config.redirectUri).toBe('https://partial.example.com/callback');
      expect(config.discoveryUrl).toBe(
        'https://partial.example.com/.well-known/openid-configuration',
      );
      expect(config.scopes).toEqual(['openid']);

      // Check session properties using toMatchObject
      // Since session isn't provided, expect default values
      expect(config.session).toMatchObject({
        useSilentRenew: true, // From defaultClientConfig
        cookie: {
          name: 'sailfin.sid', // Default value
          secret: 'default-secret', // Default value
        },
      });

      // Check logging properties
      expect(config.logging.logLevel).toBe(LogLevel.DEBUG);
      expect(config.logging.logger).toMatchObject({
        setLogLevel: expect.any(Function),
        debug: expect.any(Function),
        info: expect.any(Function),
        warn: expect.any(Function),
        error: expect.any(Function),
      });

      // Optionally, verify that additional properties exist
      expect(config.session).toHaveProperty('mode', 'server');
      expect(config.session).toHaveProperty('serverStorage', 'memory');
      expect(config.session).toHaveProperty('clientStorage', 'cookie');
      expect(config.session).toHaveProperty('ttl', 3600000);

      // Check that other default properties are present
      expect(config.maxAge).toBe(defaultClientConfig.maxAge);
      expect(config.pkce).toBe(defaultClientConfig.pkce);
      expect(config.pkceMethod).toBe(defaultClientConfig.pkceMethod);
      // Add other fields as necessary
    });
  });

  // ------------------ Additional Tests for getClaims ------------------

  describe('getClaims', () => {
    it('should retrieve claims successfully', async () => {
      const mockClaims = { sub: 'user123', email: 'user@example.com' };

      // Mock tokenClient.getClaims to return mockClaims
      mockTokenInstance.getClaims = jest.fn().mockResolvedValue(mockClaims);

      const claims = await client.getClaims();

      expect(claims).toEqual(mockClaims);
      expect(mockTokenInstance.getClaims).toHaveBeenCalled();
      expect(mockLoggerInstance.debug).toHaveBeenCalledWith(
        'Initializing OIDC Client',
      );
    });

    it('should ensure initialization before retrieving claims', async () => {
      // Spy on ensureInitialized
      const ensureInitSpy = jest.spyOn(client as any, 'ensureInitialized');

      const mockClaims = { sub: 'user123', email: 'user@example.com' };
      mockTokenInstance.getClaims = jest.fn().mockResolvedValue(mockClaims);

      await client.getClaims();

      expect(ensureInitSpy).toHaveBeenCalled();
      expect(mockTokenInstance.getClaims).toHaveBeenCalled();
    });

    it('should throw an error if initialization fails during getClaims', async () => {
      const initializationError = new ClientError(
        'Initialization failed',
        'INITIALIZATION_ERROR',
      );

      // Mock ensureInitialized to throw an error
      jest
        .spyOn(client as any, 'ensureInitialized')
        .mockRejectedValueOnce(initializationError);

      await expect(client.getClaims()).rejects.toThrow('Initialization failed');

      // Ensure that getClaims on tokenClient was never called
      expect(mockTokenInstance.getClaims).not.toHaveBeenCalled();
    });

    it('should propagate errors from tokenClient.getClaims', async () => {
      const tokenError = new Error('Failed to retrieve claims');

      mockTokenInstance.getClaims = jest.fn().mockRejectedValueOnce(tokenError);

      await expect(client.getClaims()).rejects.toThrow(
        'Failed to retrieve claims',
      );

      expect(mockTokenInstance.getClaims).toHaveBeenCalled();
    });
  });
});
