// src/utils/createSailfinClient.test.ts

import { createSailfinClient } from './createSailfinClient';
import { Client } from '../classes/Client';
import { SAILFIN_CLIENT } from '../constants/sailfinClientToken';
import { IClientConfig } from '../interfaces/IClientConfig';
import {
  LogLevel,
  SameSite,
  SessionMode,
  StorageMechanism,
  GrantType,
  ResponseType,
  ResponseMode,
} from '../enums';

// Mock the Client class
jest.mock('../classes/Client', () => {
  return {
    Client: jest.fn().mockImplementation((config: IClientConfig) => {
      return {
        // Mock methods as needed
        someMethod: jest.fn(),
      };
    }),
  };
});

// Mock isProduction helper
jest.mock('./helpers', () => ({
  isProduction: jest.fn(),
}));

import { isProduction } from './helpers';

describe('createSailfinClient', () => {
  const originalEnv = process.env;

  beforeAll(() => {
    // Set required environment variables
    process.env.SSO_CLIENT_ID = 'test-client-id';
    process.env.SSO_CLIENT_SECRET = 'test-client-secret';
    process.env.SSO_DISCOVERY_URL =
      'https://login.test.com/.well-known/openid-configuration';
    process.env.SSO_CALLBACK_URL = 'https://localhost:9443/auth/sso/callback';
    process.env.SSO_LOGOUT_URL = 'https://localhost:9443/auth/sso/logout';
    process.env.SESS_SECRET = 'test-session-secret';
    process.env.DOMAIN = 'localhost';
    // You can set other environment variables as needed
  });

  afterAll(() => {
    // Restore original environment variables
    process.env = originalEnv;
  });

  beforeEach(() => {
    jest.resetModules();
    (isProduction as jest.Mock).mockReturnValue(false);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should provide the SAILFIN_CLIENT token', () => {
    const result = createSailfinClient({});
    expect(result.provide).toBe(SAILFIN_CLIENT);
  });

  it('should create a Client instance with default config', async () => {
    const result = createSailfinClient({});
    const client = await result.useFactory();

    expect(Client).toHaveBeenCalledWith(
      expect.objectContaining({
        clientId: 'test-client-id',
        clientSecret: 'test-client-secret',
        discoveryUrl: 'https://login.test.com/.well-known/openid-configuration',
        redirectUri: 'https://localhost:9443/auth/sso/callback',
        postLogoutRedirectUri: 'https://localhost:9443/auth/sso/logout',
        scopes: expect.arrayContaining([
          'openid',
          'profile',
          'email',
          'offline_access',
        ]),
        grantType: GrantType.AuthorizationCode,
        responseType: ResponseType.Code,
        responseMode: ResponseMode.Query,
        session: expect.objectContaining({
          mode: SessionMode.HYBRID,
          serverStorage: StorageMechanism.MEMORY,
          clientStorage: StorageMechanism.COOKIE,
          useSilentRenew: true,
          ttl: 3600,
          cookie: expect.objectContaining({
            name: 'sailfin.sid',
            secret: 'test-session-secret',
            options: expect.objectContaining({
              secure: false,
              httpOnly: false,
              sameSite: SameSite.LAX,
              path: '/',
              maxAge: 86400,
              domain: 'localhost',
              encode: encodeURIComponent,
            }),
          }),
        }),
        logging: expect.objectContaining({ logLevel: LogLevel.INFO }),
      }),
    );

    expect(client).toBeDefined();
  });

  it('should merge provided config with default config', async () => {
    const customConfig: Partial<IClientConfig> = {
      clientId: 'custom-client-id',
      clientSecret: 'custom-client-secret',
      session: {
        useSilentRenew: false,
      },
      logging: {
        logLevel: LogLevel.DEBUG,
      },
    };

    const result = createSailfinClient(customConfig);
    const client = await result.useFactory();

    expect(Client).toHaveBeenCalledWith(
      expect.objectContaining({
        clientId: 'custom-client-id',
        clientSecret: 'custom-client-secret',
        session: expect.objectContaining({
          useSilentRenew: false,
        }),
        logging: expect.objectContaining({
          logLevel: LogLevel.DEBUG,
        }),
      }),
    );

    expect(client).toBeDefined();
  });

  it('should throw an error if client initialization fails', async () => {
    // Mock the Client constructor to throw an error
    (Client as jest.Mock).mockImplementationOnce(() => {
      throw new Error('Initialization failed');
    });

    const result = createSailfinClient({});

    await expect(result.useFactory()).rejects.toThrow('Initialization failed');
  });
});
