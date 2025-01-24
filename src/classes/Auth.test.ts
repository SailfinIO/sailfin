// src/classes/Auth.test.ts

import { Auth } from './Auth';
import { Token } from './Token';
import {
  IIssuer,
  ClientMetadata,
  IClientConfig,
  ILogger,
  IToken,
  IAuth,
  IPkce,
} from '../interfaces';
import { ClientError } from '../errors/ClientError';
import {
  buildLogoutUrl,
  sleep,
  parseFragment,
  generateRandomString,
} from '../utils';
import { PkceMethod, Scopes, GrantType, UILocales } from '../enums';
import { Jwt } from './Jwt';

// Mock utilities
jest.mock('../utils', () => ({
  ...jest.requireActual('../utils'),
  sleep: jest.fn(),
  generateRandomString: jest.fn(),
  parseFragment: jest.fn(),
  buildLogoutUrl: jest.fn(),
}));

// Constants for reuse
const MOCK_CLIENT_ID = 'test-client-id';
const MOCK_REDIRECT_URI = 'https://example.com/callback';
const MOCK_POST_LOGOUT_URI = 'https://example.com/logout-callback';
const MOCK_DISCOVERY_URL =
  'https://example.com/.well-known/openid-configuration';
const MOCK_CLIENT_METADATA: Partial<ClientMetadata> = {
  issuer: 'https://example.com/',
  authorization_endpoint: 'https://example.com/oauth2/authorize',
  token_endpoint: 'https://example.com/oauth2/token',
  end_session_endpoint: 'https://example.com/oauth2/logout',
  jwks_uri: 'https://example.com/.well-known/jwks.json',
  userinfo_endpoint: 'https://example.com/oauth2/userinfo',
  device_authorization_endpoint: 'https://example.com/oauth2/device_authorize',
};

// Helper function to create Auth instances
const createAuthInstance = (
  grantType: GrantType,
  configOverrides?: Partial<IClientConfig>,
  pkceService?: IPkce,
): IAuth => {
  const config: IClientConfig = {
    clientId: MOCK_CLIENT_ID,
    redirectUri: MOCK_REDIRECT_URI,
    scopes: [Scopes.OpenId, Scopes.Profile],
    discoveryUrl: MOCK_DISCOVERY_URL,
    grantType,
    pkce: grantType === GrantType.AuthorizationCode,
    pkceMethod: PkceMethod.S256,
    postLogoutRedirectUri: MOCK_POST_LOGOUT_URI,
    ...configOverrides,
  };
  return new Auth(config, mockLogger, mockIssuer, mockTokenClient, pkceService);
};

// Helper function to mock fetch responses
const mockFetchResponse = (data: any, status: number = 200) => {
  (global.fetch as jest.Mock).mockResolvedValueOnce(
    new Response(JSON.stringify(data), {
      status,
      headers: { 'Content-Type': 'application/json' },
    }),
  );
};

// Initialize mocks
let mockIssuer: jest.Mocked<IIssuer>;
let mockLogger: jest.Mocked<ILogger>;
let mockTokenClient: jest.Mocked<IToken>;

describe('Auth', () => {
  let auth: IAuth;

  beforeEach(() => {
    // Initialize mocks
    mockLogger = {
      debug: jest.fn(),
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
      setLogLevel: jest.fn(),
    };

    mockIssuer = {
      discover: jest.fn().mockResolvedValue(MOCK_CLIENT_METADATA),
    };

    mockTokenClient = {
      getAccessToken: jest.fn(),
      refreshAccessToken: jest.fn(),
      setTokens: jest.fn(),
      getTokens: jest.fn(),
      clearTokens: jest.fn(),
      introspectToken: jest.fn(),
      revokeToken: jest.fn(),
      exchangeCodeForToken: jest.fn(),
      getClaims: jest.fn(),
    };

    // Mock TokenClient methods
    jest
      .spyOn(Token.prototype, 'setTokens')
      .mockImplementation(mockTokenClient.setTokens);
    jest
      .spyOn(Token.prototype, 'getTokens')
      .mockImplementation(mockTokenClient.getTokens);
    jest
      .spyOn(Token.prototype, 'getAccessToken')
      .mockImplementation(mockTokenClient.getAccessToken);
    jest
      .spyOn(Token.prototype, 'refreshAccessToken')
      .mockImplementation(mockTokenClient.refreshAccessToken);
    jest
      .spyOn(Token.prototype, 'clearTokens')
      .mockImplementation(mockTokenClient.clearTokens);
    jest
      .spyOn(Token.prototype, 'introspectToken')
      .mockImplementation(mockTokenClient.introspectToken);
    jest
      .spyOn(Token.prototype, 'revokeToken')
      .mockImplementation(mockTokenClient.revokeToken);

    // Mock fetch globally
    global.fetch = jest.fn();
  });

  afterEach(() => {
    jest.resetAllMocks();
    jest.useRealTimers();
  });

  describe('Constructor', () => {
    it('should create an instance of Auth', () => {
      auth = createAuthInstance(GrantType.AuthorizationCode);
      expect(auth).toBeInstanceOf(Auth);
    });
  });

  describe('Authorization URL Generation', () => {
    beforeEach(() => {
      auth = createAuthInstance(GrantType.AuthorizationCode);
    });

    it('should generate an authorization URL with PKCE', async () => {
      const utils = require('../utils');
      (utils.generateRandomString as jest.Mock)
        .mockReturnValueOnce('state123')
        .mockReturnValueOnce('nonce123');

      const buildAuthorizationUrlSpy = jest
        .spyOn(require('../utils'), 'buildAuthorizationUrl')
        .mockReturnValue(
          'https://example.com/oauth2/authorize?client_id=test-client-id',
        );

      const result = await auth.getAuthorizationUrl();

      expect(result.url).toContain(
        `client_id=${encodeURIComponent(MOCK_CLIENT_ID)}`,
      );
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Authorization URL generated',
        {
          url: result.url,
        },
      );

      buildAuthorizationUrlSpy.mockRestore();
    });

    it('should include ui_locales in additionalParams when uiLocales is set in config', async () => {
      const utils = require('../utils');
      (utils.generateRandomString as jest.Mock)
        .mockReturnValueOnce('state123')
        .mockReturnValueOnce('nonce123');

      // Create an instance of Auth with uiLocales set
      const authWithUiLocales = createAuthInstance(
        GrantType.AuthorizationCode,
        {
          uiLocales: [UILocales.EN_US, UILocales.ES_ES, UILocales.FR_FR],
        },
      );

      // Spy on buildAuthorizationUrl to verify the URL parameters
      const buildAuthorizationUrlSpy = jest
        .spyOn(require('../utils'), 'buildAuthorizationUrl')
        .mockReturnValue(
          'https://example.com/oauth2/authorize?client_id=test-client-id',
        );

      // Call getAuthorizationUrl
      await authWithUiLocales.getAuthorizationUrl();

      // Verify that buildAuthorizationUrl was called with the correct ui_locales
      expect(buildAuthorizationUrlSpy).toHaveBeenCalledWith(
        expect.objectContaining({
          clientId: MOCK_CLIENT_ID,
          redirectUri: MOCK_REDIRECT_URI,
          responseType: 'code',
          scope: expect.any(String),
          state: 'state123',
        }),
        expect.objectContaining({
          ui_locales: 'en-US es-ES fr-FR',
        }),
      );

      buildAuthorizationUrlSpy.mockRestore();
    });

    it('should generate an authorization URL without PKCE', async () => {
      auth = createAuthInstance(GrantType.AuthorizationCode, {
        pkce: false,
      });

      const utils = require('../utils');
      (utils.generateRandomString as jest.Mock)
        .mockReturnValueOnce('state123')
        .mockReturnValueOnce('nonce123');

      const buildAuthorizationUrlSpy = jest
        .spyOn(require('../utils'), 'buildAuthorizationUrl')
        .mockReturnValue(
          'https://example.com/oauth2/authorize?client_id=test-client-id',
        );

      const result = await auth.getAuthorizationUrl();

      expect(result.url).toContain(
        `client_id=${encodeURIComponent(MOCK_CLIENT_ID)}`,
      );
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Authorization URL generated',
        {
          url: result.url,
        },
      );

      buildAuthorizationUrlSpy.mockRestore();
    });

    it('should not generate PKCE details if grantType does not support it', async () => {
      auth = createAuthInstance(GrantType.ClientCredentials, {
        pkce: true,
      });

      await expect(auth.getAuthorizationUrl()).rejects.toThrow(ClientError);

      expect(mockLogger.error).toHaveBeenCalledWith(
        'Failed to generate authorization URL',
        {
          error: expect.any(ClientError),
        },
      );
      expect(mockLogger.debug).not.toHaveBeenCalledWith(
        'Authorization URL generated',
        expect.anything(),
      );
    });

    it('should throw ClientError if authorization_endpoint is missing', async () => {
      mockIssuer.discover.mockResolvedValueOnce({
        ...MOCK_CLIENT_METADATA,
        authorization_endpoint: undefined,
      } as ClientMetadata);

      await expect(auth.getAuthorizationUrl()).rejects.toThrow(ClientError);

      expect(mockLogger.error).toHaveBeenCalledWith(
        'Failed to generate authorization URL',
        {
          error: expect.any(ClientError),
        },
      );
    });
  });

  describe('DeviceCode Flow', () => {
    beforeEach(() => {
      auth = createAuthInstance(GrantType.DeviceCode);
    });

    describe('startDeviceAuthorization', () => {
      it('should initiate device authorization successfully', async () => {
        const deviceResponse = {
          device_code: 'device-code',
          user_code: 'user-code',
          verification_uri: 'https://example.com/verify',
          expires_in: 1800,
          interval: 5,
        };

        mockIssuer.discover.mockResolvedValueOnce({
          ...MOCK_CLIENT_METADATA,
          device_authorization_endpoint:
            'https://example.com/oauth2/device_authorize',
        } as ClientMetadata);

        mockFetchResponse(deviceResponse);

        const result = await auth.startDeviceAuthorization();

        expect(mockIssuer.discover).toHaveBeenCalledTimes(1);
        expect(global.fetch).toHaveBeenCalledWith(
          'https://example.com/oauth2/device_authorize',
          {
            method: 'POST',
            body: expect.stringContaining(
              `client_id=${encodeURIComponent(MOCK_CLIENT_ID)}`,
            ),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
          },
        );
        expect(result).toEqual(deviceResponse);
        expect(mockLogger.info).toHaveBeenCalledWith(
          'Device authorization initiated',
        );
      });

      it('should throw ClientError if device_authorization_endpoint is missing', async () => {
        mockIssuer.discover.mockResolvedValueOnce({
          ...MOCK_CLIENT_METADATA,
          device_authorization_endpoint: undefined,
        } as ClientMetadata);

        await expect(auth.startDeviceAuthorization()).rejects.toThrow(
          ClientError,
        );

        expect(mockLogger.error).toHaveBeenCalledWith(
          'Failed to start device authorization',
          {
            error: expect.any(ClientError),
          },
        );
      });

      it('should handle errors during device authorization initiation', async () => {
        mockIssuer.discover.mockResolvedValueOnce({
          ...MOCK_CLIENT_METADATA,
          device_authorization_endpoint:
            'https://example.com/oauth2/device_authorize',
        } as ClientMetadata);

        const mockError = new Error('Device authorization failed');
        (global.fetch as jest.Mock).mockRejectedValueOnce(mockError);

        await expect(auth.startDeviceAuthorization()).rejects.toThrow(
          ClientError,
        );
        expect(mockLogger.error).toHaveBeenCalledWith(
          'Failed to start device authorization',
          {
            error: mockError,
          },
        );
      });
    });

    describe('pollDeviceToken', () => {
      beforeEach(() => {
        jest.useFakeTimers();
        (sleep as jest.Mock).mockResolvedValue(Promise.resolve());
      });

      afterEach(() => {
        jest.useRealTimers();
      });

      it('should handle "authorization_pending" by sleeping and continuing polling', async () => {
        const device_code = 'test-device-code';

        // First fetch attempt: simulate "authorization_pending" error
        (global.fetch as jest.Mock).mockRejectedValueOnce(
          Object.assign(new Error('authorization_pending'), {
            context: {
              body: JSON.stringify({ error: 'authorization_pending' }),
            },
          }),
        );

        // Second fetch attempt: return a valid token to exit the loop
        (global.fetch as jest.Mock).mockResolvedValueOnce(
          new Response(
            JSON.stringify({
              access_token: 'access-token',
              token_type: 'Bearer',
              expires_in: 3600,
            }),
            {
              status: 200,
              headers: { 'Content-Type': 'application/json' },
            },
          ),
        );

        const pollPromise = auth.pollDeviceToken(device_code, 5, 30000);

        // Advance timers to allow polling to proceed
        await Promise.resolve();
        jest.advanceTimersByTime(5000); // 5 seconds

        await pollPromise;

        expect(global.fetch).toHaveBeenCalledTimes(2);
        expect(sleep).toHaveBeenCalledWith(5 * 1000);
        expect(mockTokenClient.setTokens).toHaveBeenCalledWith({
          access_token: 'access-token',
          token_type: 'Bearer',
          expires_in: 3600,
        });
        expect(mockLogger.info).toHaveBeenCalledWith(
          'Device authorized and tokens obtained',
        );
      });

      it('should handle "slow_down" by adding 5 to interval, sleeping, then continuing polling', async () => {
        const device_code = 'test-device-code';

        // First fetch attempt: simulate "slow_down" error
        (global.fetch as jest.Mock).mockRejectedValueOnce(
          Object.assign(new Error('slow_down'), {
            context: { body: JSON.stringify({ error: 'slow_down' }) },
          }),
        );

        // Second fetch attempt: return a valid token to exit the loop
        (global.fetch as jest.Mock).mockResolvedValueOnce(
          new Response(
            JSON.stringify({
              access_token: 'access-token',
              token_type: 'Bearer',
              expires_in: 3600,
            }),
            {
              status: 200,
              headers: { 'Content-Type': 'application/json' },
            },
          ),
        );

        const pollPromise = auth.pollDeviceToken(device_code, 5, 30000);

        // Advance timers to allow polling to proceed
        await Promise.resolve();
        jest.advanceTimersByTime(10000); // Initial interval + 5 seconds

        await pollPromise;

        expect(global.fetch).toHaveBeenCalledTimes(2);
        expect(sleep).toHaveBeenCalledWith(10 * 1000); // 5 + 5
        expect(mockTokenClient.setTokens).toHaveBeenCalledWith({
          access_token: 'access-token',
          token_type: 'Bearer',
          expires_in: 3600,
        });
        expect(mockLogger.info).toHaveBeenCalledWith(
          'Device authorized and tokens obtained',
        );
      });

      it('should handle "expired_token" by logging an error and throwing ClientError', async () => {
        const device_code = 'test-device-code';

        // Simulate "expired_token" error
        (global.fetch as jest.Mock).mockRejectedValueOnce(
          Object.assign(new Error('expired_token'), {
            context: { body: JSON.stringify({ error: 'expired_token' }) },
          }),
        );

        await expect(
          auth.pollDeviceToken(device_code, 5, 30000),
        ).rejects.toThrowError('Device code expired');

        expect(mockLogger.error).toHaveBeenCalledWith('Device code expired', {
          error: expect.any(ClientError),
        });
        expect(mockTokenClient.setTokens).not.toHaveBeenCalled();
      });

      it('should throw ClientError when polling times out', async () => {
        const device_code = 'device-code';
        const interval = 1; // seconds
        const timeout = 3000; // 3 seconds

        // Mock fetch to always return 'authorization_pending'
        const pendingError = Object.assign(new Error('authorization_pending'), {
          context: { body: JSON.stringify({ error: 'authorization_pending' }) },
        });
        (global.fetch as jest.Mock).mockRejectedValue(pendingError);

        const pollPromise = auth.pollDeviceToken(
          device_code,
          interval,
          timeout,
        );

        // Simulate the passage of time by advancing timers
        for (let i = 0; i < 4; i++) {
          await Promise.resolve(); // Allow any pending promises to resolve
          jest.advanceTimersByTime(interval * 1000); // Advance time by interval
          await Promise.resolve(); // Allow any pending promises to resolve
        }

        await expect(pollPromise).rejects.toThrow(
          'Device code polling timed out',
        );

        expect(mockLogger.error).toHaveBeenCalledWith(
          'Device token polling timed out',
          {
            error: expect.any(ClientError),
          },
        );
      });

      it('should successfully obtain tokens when polling succeeds', async () => {
        const device_code = 'device-code';
        const tokenResponse = {
          access_token: 'access-token',
          id_token: 'id-token',
          token_type: 'Bearer',
          expires_in: 3600,
        };

        mockFetchResponse(tokenResponse);

        const pollPromise = auth.pollDeviceToken(device_code, 5, 10000);

        jest.runAllTimers();

        await pollPromise;

        expect(global.fetch).toHaveBeenCalledTimes(1);
        expect(global.fetch).toHaveBeenCalledWith(
          MOCK_CLIENT_METADATA.token_endpoint!,
          {
            method: 'POST',
            body: expect.stringContaining(
              `grant_type=${encodeURIComponent(GrantType.DeviceCode)}`,
            ),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
          },
        );
        expect(mockTokenClient.setTokens).toHaveBeenCalledWith(tokenResponse);
        expect(mockLogger.info).toHaveBeenCalledWith(
          'Device authorized and tokens obtained',
        );
      });

      it('should handle unexpected errors during polling', async () => {
        const device_code = 'device-code';
        const unexpectedError = Object.assign(new Error('Unexpected error'), {
          context: { body: JSON.stringify({ error: 'unexpected_error' }) },
        });

        (global.fetch as jest.Mock).mockRejectedValueOnce(unexpectedError);

        const pollPromise = auth.pollDeviceToken(device_code, 5, 10000);

        await expect(pollPromise).rejects.toThrow(ClientError);

        expect(global.fetch).toHaveBeenCalledTimes(1);
        expect(mockLogger.error).toHaveBeenCalledWith(
          'Device token polling failed',
          {
            originalError: unexpectedError,
          },
        );
      });

      it('should log warnings when error response is invalid JSON and throw TOKEN_POLLING_ERROR', async () => {
        const device_code = 'device-code';
        const interval = 1; // seconds
        const timeout = 3000; // 3 seconds

        // Mock fetch to throw an error with invalid JSON in context.body
        const invalidJsonError = Object.assign(new Error('Invalid JSON'), {
          context: { body: 'invalid-json' },
        });
        (global.fetch as jest.Mock).mockRejectedValueOnce(invalidJsonError);

        // Initiate the polling
        const pollPromise = auth.pollDeviceToken(
          device_code,
          interval,
          timeout,
        );

        // Since handlePollingError throws immediately, no need to advance timers
        await expect(pollPromise).rejects.toThrow(
          'Device token polling failed',
        );

        // Verify that the logger.warn was called with a SyntaxError
        expect(mockLogger.warn).toHaveBeenCalledWith(
          'Failed to parse error response as JSON',
          {
            originalError: expect.any(SyntaxError),
          },
        );

        // Verify that the logger.warn was called with the response body
        expect(mockLogger.warn).toHaveBeenCalledWith(
          'Error response from token endpoint',
          {
            response: 'invalid-json',
          },
        );

        // Verify that the logger.error was called with 'Device token polling failed'
        expect(mockLogger.error).toHaveBeenCalledWith(
          'Device token polling failed',
          {
            originalError: invalidJsonError,
          },
        );
      });
    });

    describe('getLogoutUrl', () => {
      it('should generate logout URL with idTokenHint and state', async () => {
        const idTokenHint = 'id-token';
        const state = 'logout-state';
        const expectedLogoutUrl = buildLogoutUrl({
          endSessionEndpoint: MOCK_CLIENT_METADATA.end_session_endpoint!,
          clientId: MOCK_CLIENT_ID,
          postLogoutRedirectUri: MOCK_POST_LOGOUT_URI,
          idTokenHint,
          state,
        });

        const result = await auth.getLogoutUrl(idTokenHint, state);

        expect(mockIssuer.discover).toHaveBeenCalledTimes(1);
        expect(result).toBe(expectedLogoutUrl);
        expect(mockLogger.debug).toHaveBeenCalledWith('Logout URL generated', {
          logoutUrl: result,
        });
      });

      it('should generate logout URL without idTokenHint and state', async () => {
        const expectedLogoutUrl = buildLogoutUrl({
          endSessionEndpoint: MOCK_CLIENT_METADATA.end_session_endpoint!,
          clientId: MOCK_CLIENT_ID,
          postLogoutRedirectUri: MOCK_POST_LOGOUT_URI,
          idTokenHint: undefined,
          state: undefined,
        });

        const result = await auth.getLogoutUrl();

        expect(result).toBe(expectedLogoutUrl);
        expect(mockLogger.debug).toHaveBeenCalledWith('Logout URL generated', {
          logoutUrl: result,
        });
      });

      it('should throw ClientError if end_session_endpoint is missing', async () => {
        mockIssuer.discover.mockResolvedValueOnce({
          ...MOCK_CLIENT_METADATA,
          end_session_endpoint: undefined,
        } as ClientMetadata);

        await expect(auth.getLogoutUrl()).rejects.toThrow(ClientError);

        expect(mockLogger.error).toHaveBeenCalledWith(
          'Failed to generate logout URL',
          {
            error: expect.any(ClientError),
          },
        );
      });
    });
  });

  describe('Implicit Flow', () => {
    beforeEach(() => {
      auth = createAuthInstance(GrantType.Implicit, { pkce: false });
    });

    describe('handleRedirectForImplicitFlow', () => {
      it('should handle redirect successfully and validate ID token', async () => {
        const fragment =
          '#access_token=access-token&id_token=id-token&state=valid-state&token_type=Bearer&expires_in=3600';

        // Mock parseFragment
        (parseFragment as jest.Mock).mockReturnValue({
          access_token: 'access-token',
          id_token: 'id-token',
          state: 'valid-state',
          token_type: 'Bearer',
          expires_in: '3600',
        });

        // Mock state retrieval
        (auth as Auth)['state'].addState('valid-state', 'expected-nonce');
        jest.spyOn((auth as Auth)['state'], 'getStateEntry').mockResolvedValue({
          nonce: 'expected-nonce',
          codeVerifier: undefined,
        });

        // Mock issuer discovery
        mockIssuer.discover.mockResolvedValueOnce(
          MOCK_CLIENT_METADATA as ClientMetadata,
        );

        // Mock JWT verification
        const jwtPayload = {
          sub: '12345',
          iss: 'https://example.com/',
          aud: MOCK_CLIENT_ID,
          nonce: 'expected-nonce',
          exp: Math.floor(Date.now() / 1000) + 3600,
        };
        jest.spyOn(Jwt, 'verify').mockResolvedValueOnce(jwtPayload);

        // Mock token storage
        mockTokenClient.setTokens.mockImplementation();

        await auth.handleRedirectForImplicitFlow(fragment);

        expect(parseFragment).toHaveBeenCalledWith(fragment);
        expect((auth as Auth)['state'].getStateEntry).toHaveBeenCalledWith(
          'valid-state',
        );
        expect(mockIssuer.discover).toHaveBeenCalledTimes(1);
        expect(Jwt.verify).toHaveBeenCalledWith('id-token', {
          logger: mockLogger,
          client: MOCK_CLIENT_METADATA,
          clientId: MOCK_CLIENT_ID,
          nonce: 'expected-nonce',
        });
        expect(mockLogger.info).toHaveBeenNthCalledWith(
          1,
          'ID token validated successfully',
          { payload: jwtPayload },
        );
        expect(mockLogger.info).toHaveBeenNthCalledWith(
          2,
          'Tokens obtained and stored successfully',
        );
        expect(mockTokenClient.setTokens).toHaveBeenCalledWith({
          access_token: 'access-token',
          id_token: 'id-token',
          token_type: 'Bearer',
          expires_in: 3600,
        });
      });

      it('should handle redirect successfully without id_token', async () => {
        const fragment =
          '#access_token=access-token&state=valid-state&token_type=Bearer&expires_in=3600';

        // Mock parseFragment
        (parseFragment as jest.Mock).mockReturnValue({
          access_token: 'access-token',
          state: 'valid-state',
          token_type: 'Bearer',
          expires_in: '3600',
        });

        // Mock state retrieval
        (auth as Auth)['state'].addState('valid-state', 'expected-nonce');
        jest.spyOn((auth as Auth)['state'], 'getStateEntry').mockResolvedValue({
          nonce: 'expected-nonce',
          codeVerifier: undefined,
        });

        // Mock token storage
        mockTokenClient.setTokens.mockImplementation();

        await auth.handleRedirectForImplicitFlow(fragment);

        expect(parseFragment).toHaveBeenCalledWith(fragment);
        expect((auth as Auth)['state'].getStateEntry).toHaveBeenCalledWith(
          'valid-state',
        );
        expect(mockIssuer.discover).not.toHaveBeenCalled();
        expect(Jwt.verify).not.toHaveBeenCalled();
        expect(mockTokenClient.setTokens).toHaveBeenCalledWith({
          access_token: 'access-token',
          id_token: undefined,
          token_type: 'Bearer',
          expires_in: 3600,
        });
        expect(mockLogger.warn).toHaveBeenCalledWith(
          'No ID token returned to validate',
        );
        expect(mockLogger.info).toHaveBeenCalledWith(
          'Tokens obtained and stored successfully',
        );
      });

      it('should throw ClientError if fragment contains an error', async () => {
        const fragment =
          '#error=access_denied&error_description=User denied access';

        // Mock parseFragment
        (parseFragment as jest.Mock).mockReturnValue({
          error: 'access_denied',
          error_description: 'User denied access',
        });

        await expect(
          auth.handleRedirectForImplicitFlow(fragment),
        ).rejects.toThrow(ClientError);

        expect(parseFragment).toHaveBeenCalledWith(fragment);
        expect(mockLogger.error).toHaveBeenCalledWith(
          'Error in implicit flow redirect',
          {
            error: 'access_denied',
            error_description: 'User denied access',
          },
        );
      });

      it('should throw ClientError if access_token is missing', async () => {
        const fragment =
          '#id_token=id-token&state=valid-state&token_type=Bearer&expires_in=3600';

        // Mock parseFragment
        (parseFragment as jest.Mock).mockReturnValue({
          id_token: 'id-token',
          state: 'valid-state',
          token_type: 'Bearer',
          expires_in: '3600',
        });

        await expect(
          auth.handleRedirectForImplicitFlow(fragment),
        ).rejects.toThrow(ClientError);

        expect(parseFragment).toHaveBeenCalledWith(fragment);
        expect(mockLogger.error).not.toHaveBeenCalled();
      });

      it('should throw ClientError if state is missing', async () => {
        const fragment =
          '#access_token=access-token&id_token=id-token&token_type=Bearer&expires_in=3600';

        // Mock parseFragment
        (parseFragment as jest.Mock).mockReturnValue({
          access_token: 'access-token',
          id_token: 'id-token',
          token_type: 'Bearer',
          expires_in: '3600',
        });

        await expect(
          auth.handleRedirectForImplicitFlow(fragment),
        ).rejects.toThrow(ClientError);

        expect(parseFragment).toHaveBeenCalledWith(fragment);
        expect(mockLogger.error).not.toHaveBeenCalled();
      });

      it('should throw ClientError if state does not match any stored state', async () => {
        const fragment =
          '#access_token=access-token&id_token=id-token&state=invalid-state&token_type=Bearer&expires_in=3600';

        // Mock parseFragment
        (parseFragment as jest.Mock).mockReturnValue({
          access_token: 'access-token',
          id_token: 'id-token',
          state: 'invalid-state',
          token_type: 'Bearer',
          expires_in: '3600',
        });

        // Mock state retrieval to return null
        jest
          .spyOn((auth as Auth)['state'], 'getStateEntry')
          .mockResolvedValue(null);

        await expect(
          auth.handleRedirectForImplicitFlow(fragment),
        ).rejects.toThrow(ClientError);

        expect(parseFragment).toHaveBeenCalledWith(fragment);
        expect((auth as Auth)['state'].getStateEntry).toHaveBeenCalledWith(
          'invalid-state',
        );
        expect(mockLogger.error).not.toHaveBeenCalled();
      });
    });
  });

  describe('PKCE Generation', () => {
    let authWithPkce: Auth;
    let pkceServiceMock: jest.Mocked<IPkce>;

    beforeEach(() => {
      pkceServiceMock = {
        generatePkce: jest.fn(),
      };

      // Mock generateRandomString
      (generateRandomString as jest.Mock).mockReturnValue('test-random-string');

      authWithPkce = new Auth(
        {
          clientId: MOCK_CLIENT_ID,
          redirectUri: MOCK_REDIRECT_URI,
          scopes: [Scopes.OpenId, Scopes.Profile],
          discoveryUrl: MOCK_DISCOVERY_URL,
          grantType: GrantType.AuthorizationCode,
          pkce: true,
          pkceMethod: PkceMethod.S256,
          postLogoutRedirectUri: MOCK_POST_LOGOUT_URI,
        },
        mockLogger,
        mockIssuer,
        mockTokenClient,
        pkceServiceMock,
      );
    });

    it('should generate PKCE successfully with valid pkceMethod', async () => {
      pkceServiceMock.generatePkce.mockReturnValue({
        codeVerifier: 'test_verifier',
        codeChallenge: 'test_challenge',
      });

      mockIssuer.discover.mockResolvedValue({
        ...MOCK_CLIENT_METADATA,
        authorization_endpoint: 'https://example.com/oauth2/authorize',
      } as ClientMetadata);

      const { url, state, codeVerifier } =
        await authWithPkce.getAuthorizationUrl();

      expect(state).toBeDefined();
      expect(url).toContain('test_challenge');
      expect(mockLogger.warn).not.toHaveBeenCalled();
      expect(codeVerifier).toBe('test_verifier');
    });

    it('should log a warning and omit code_challenge_method if pkceMethod is invalid', async () => {
      // Re-instantiate Auth with an invalid pkceMethod
      authWithPkce = new Auth(
        {
          clientId: MOCK_CLIENT_ID,
          redirectUri: MOCK_REDIRECT_URI,
          scopes: [Scopes.OpenId, Scopes.Profile],
          discoveryUrl: MOCK_DISCOVERY_URL,
          grantType: GrantType.AuthorizationCode,
          pkce: true,
          pkceMethod: 'INVALID_METHOD' as PkceMethod, // Force invalid method
          postLogoutRedirectUri: MOCK_POST_LOGOUT_URI,
        },
        mockLogger,
        mockIssuer,
        mockTokenClient,
        pkceServiceMock,
      );

      pkceServiceMock.generatePkce.mockReturnValue({
        codeVerifier: 'test_verifier',
        codeChallenge: 'test_challenge',
      });

      mockIssuer.discover.mockResolvedValue({
        ...MOCK_CLIENT_METADATA,
        authorization_endpoint: 'https://example.com/oauth2/authorize',
      } as ClientMetadata);

      await authWithPkce.getAuthorizationUrl();

      expect(mockLogger.warn).toHaveBeenCalledWith(
        'Invalid pkceMethod provided. Omitting code_challenge_method.',
      );
    });

    it('should throw ClientError if pkceService.generatePkce() fails', async () => {
      const pkceError = new Error('PKCE generation failed');
      pkceServiceMock.generatePkce.mockImplementation(() => {
        throw pkceError;
      });

      mockIssuer.discover.mockResolvedValue({
        ...MOCK_CLIENT_METADATA,
        authorization_endpoint: 'https://example.com/oauth2/authorize',
      } as ClientMetadata);

      await expect(authWithPkce.getAuthorizationUrl()).rejects.toThrow(
        ClientError,
      );

      expect(mockLogger.error).toHaveBeenCalledWith('Failed to generate PKCE', {
        error: pkceError,
      });
    });
  });
});
