// src/utils/deepMerge.test.ts

import { deepMerge, validateConfig } from './deepMerge';
import { IClientConfig } from '../interfaces/IClientConfig';
import {
  GrantType,
  ResponseMode,
  ResponseType,
  SameSite,
  LogLevel,
  SessionMode,
  StorageMechanism,
} from '../enums';
import { ClientError } from '../errors';

describe('deepMerge', () => {
  // Define a base configuration that includes all required fields
  const baseConfig: IClientConfig = {
    clientId: 'default-client-id',
    clientSecret: 'default-client-secret',
    discoveryUrl: 'https://example.com/.well-known/openid-configuration',
    redirectUri: 'https://localhost:9443/auth/sso/callback',
    postLogoutRedirectUri: 'https://localhost:9443/auth/sso/logout',
    scopes: ['openid', 'profile', 'email', 'offline_access'],
    grantType: GrantType.AuthorizationCode,
    responseType: ResponseType.Code,
    responseMode: ResponseMode.Query,
    session: {
      mode: SessionMode.HYBRID,
      serverStorage: StorageMechanism.MEMORY,
      clientStorage: StorageMechanism.COOKIE,
      useSilentRenew: true,
      ttl: 3600, // 1 hour in seconds
      cookie: {
        name: 'sailfin.sid',
        secret: 'default-secret',
        options: {
          secure: false,
          httpOnly: false,
          sameSite: SameSite.LAX,
          path: '/',
          maxAge: 86400, // 24 hours in seconds
          domain: 'localhost',
          encode: encodeURIComponent,
        },
      },
    },
    logging: {
      logLevel: LogLevel.INFO,
      logger: {
        setLogLevel: jest.fn(),
        debug: jest.fn(),
        info: jest.fn(),
        warn: jest.fn(),
        error: jest.fn(),
      },
    },
  };

  it('should merge two flat objects and override properties', () => {
    const target: Partial<IClientConfig> = {
      ...baseConfig,
      clientId: 'test-client-id',
    };

    const source: Partial<IClientConfig> = {
      clientSecret: 'test-client-secret',
      logging: { logLevel: LogLevel.DEBUG },
    };

    const expected: IClientConfig = {
      ...baseConfig,
      clientId: 'test-client-id',
      clientSecret: 'test-client-secret',
      logging: {
        logLevel: LogLevel.DEBUG,
        logger: baseConfig.logging!.logger, // Preserve existing logger
      },
    };

    expect(deepMerge(target, source)).toEqual(expected);
  });

  it('should merge nested objects and override specific properties', () => {
    const target: Partial<IClientConfig> = {
      ...baseConfig,
      session: {
        useSilentRenew: true,
        cookie: {
          name: 'sailfin.sid',
          secret: 'test-secret',
          options: {
            sameSite: SameSite.LAX,
            // Include all other necessary properties to fully represent the target's session.cookie
            secure: false,
            httpOnly: false,
            path: '/',
            maxAge: 86400,
            domain: 'localhost',
            encode: encodeURIComponent,
          },
        },
        // Ensure other session properties are present
        mode: SessionMode.HYBRID,
        serverStorage: StorageMechanism.MEMORY,
        clientStorage: StorageMechanism.COOKIE,
        ttl: 3600,
      },
    };

    const source: Partial<IClientConfig> = {
      session: {
        useSilentRenew: false,
        cookie: {
          options: { sameSite: SameSite.NONE, secure: true },
        },
      },
    };

    const expected: IClientConfig = {
      ...baseConfig,
      session: {
        mode: SessionMode.HYBRID,
        serverStorage: StorageMechanism.MEMORY,
        clientStorage: StorageMechanism.COOKIE,
        useSilentRenew: false, // overridden
        ttl: 3600,
        cookie: {
          name: 'sailfin.sid',
          secret: 'test-secret',
          options: {
            secure: true, // overridden
            httpOnly: false,
            sameSite: SameSite.NONE, // overridden
            path: '/',
            maxAge: 86400,
            domain: 'localhost',
            encode: encodeURIComponent,
          },
        },
      },
      logging: baseConfig.logging, // Preserve existing logging
    };

    expect(deepMerge(target, source)).toEqual(expected);
  });

  it('should override non-object properties', () => {
    const target: Partial<IClientConfig> = {
      ...baseConfig,
      clientId: 'initial-client-id',
      grantType: GrantType.AuthorizationCode,
    };

    const source: Partial<IClientConfig> = {
      clientId: 'overridden-client-id',
      grantType: GrantType.ClientCredentials,
    };

    const expected: IClientConfig = {
      ...baseConfig,
      clientId: 'overridden-client-id', // overridden
      grantType: GrantType.ClientCredentials, // overridden
    };

    expect(deepMerge(target, source)).toEqual(expected);
  });

  it('should handle array properties by overriding', () => {
    const target: Partial<IClientConfig> = {
      ...baseConfig,
      scopes: ['openid', 'profile'],
    };

    const source: Partial<IClientConfig> = {
      scopes: ['email', 'offline_access'],
    };

    const expected: IClientConfig = {
      ...baseConfig,
      scopes: ['email', 'offline_access'], // overridden
    };

    expect(deepMerge(target, source)).toEqual(expected);
  });

  it('should not mutate the original objects', () => {
    // Create deep copies without functions
    const target: Partial<IClientConfig> = { ...baseConfig };
    const source: Partial<IClientConfig> = {
      logging: { logLevel: LogLevel.DEBUG },
    };

    // Create copies that exclude functions for comparison
    const targetCopy: Partial<IClientConfig> = {
      ...target,
      logging: { ...target.logging },
    };
    const sourceCopy: Partial<IClientConfig> = {
      ...source,
      logging: { ...source.logging },
    };

    const result = deepMerge(target, source);

    // Check that target and source are unchanged
    expect(target).toEqual(targetCopy);
    expect(source).toEqual(sourceCopy);

    // Ensure result is a new object
    expect(result).not.toBe(target);
    expect(result).not.toBe(source);

    // Additionally, ensure nested objects are also new objects where necessary
    if (target.session && source.session) {
      expect(result.session).not.toBe(target.session);
      expect(result.session).not.toBe(source.session);
    }

    if (target.logging && source.logging) {
      expect(result.logging).not.toBe(target.logging);
      expect(result.logging).not.toBe(source.logging);
      // Functions inside logger should remain the same
      expect(result.logging.logger).toBe(target.logging.logger);
    }
  });

  it('should handle empty source object by returning target as IClientConfig', () => {
    const target: Partial<IClientConfig> = { ...baseConfig };
    const source: Partial<IClientConfig> = {};

    const expected: IClientConfig = { ...baseConfig };

    expect(deepMerge(target, source)).toEqual(expected);
  });

  it('should handle empty target object by returning source as IClientConfig', () => {
    const target: Partial<IClientConfig> = {};
    const source: Partial<IClientConfig> = { ...baseConfig };

    const expected: IClientConfig = { ...baseConfig };

    expect(deepMerge(target, source)).toEqual(expected);
  });

  it('should ignore undefined and null properties in source', () => {
    const target: Partial<IClientConfig> = { ...baseConfig };
    const source: Partial<IClientConfig> = {
      clientId: undefined,
      clientSecret: null,
      logging: { logLevel: undefined },
    };

    const expected: IClientConfig = { ...baseConfig };

    expect(deepMerge(target, source)).toEqual(expected);
  });
});

describe('validateConfig', () => {
  // Define a valid base configuration
  const validConfig: Partial<IClientConfig> = {
    clientId: 'test-client-id',
    clientSecret: 'test-client-secret',
    discoveryUrl: 'https://example.com/.well-known/openid-configuration',
    redirectUri: 'https://localhost:9443/auth/sso/callback',
    // Additional optional fields can be added here if necessary
  };

  it('should pass validation when all required fields are present and valid', () => {
    expect(() => validateConfig(validConfig)).not.toThrow();
  });

  it('should throw ClientError when a required field is missing', () => {
    const configMissingClientId: Partial<IClientConfig> = {
      ...validConfig,
      clientId: undefined,
    };

    expect(() => validateConfig(configMissingClientId)).toThrow(ClientError);
    expect(() => validateConfig(configMissingClientId)).toThrow(
      'Missing required configuration field(s): clientId',
    );
  });

  it('should throw ClientError when multiple required fields are missing', () => {
    const configMissingMultiple: Partial<IClientConfig> = {
      clientId: undefined,
      clientSecret: undefined,
      discoveryUrl: 'https://example.com/.well-known/openid-configuration',
      redirectUri: 'https://localhost:9443/auth/sso/callback',
    };

    expect(() => validateConfig(configMissingMultiple)).toThrow(ClientError);
    expect(() => validateConfig(configMissingMultiple)).toThrow(
      'Missing required configuration field(s): clientId, clientSecret',
    );
  });

  it('should throw ClientError when a required field is an empty string', () => {
    const configEmptyClientSecret: Partial<IClientConfig> = {
      ...validConfig,
      clientSecret: '',
    };

    expect(() => validateConfig(configEmptyClientSecret)).toThrow(ClientError);
    expect(() => validateConfig(configEmptyClientSecret)).toThrow(
      'Missing required configuration field(s): clientSecret',
    );
  });

  it('should throw ClientError when multiple required fields are empty or missing', () => {
    const configMixedIssues: Partial<IClientConfig> = {
      clientId: '',
      clientSecret: undefined,
      discoveryUrl: 'https://example.com/.well-known/openid-configuration',
      redirectUri: '',
    };

    expect(() => validateConfig(configMixedIssues)).toThrow(ClientError);
    expect(() => validateConfig(configMixedIssues)).toThrow(
      'Missing required configuration field(s): clientId, clientSecret, redirectUri',
    );
  });

  it('should throw ClientError when all required fields are missing', () => {
    const configAllMissing: Partial<IClientConfig> = {};

    expect(() => validateConfig(configAllMissing)).toThrow(ClientError);
    expect(() => validateConfig(configAllMissing)).toThrow(
      'Missing required configuration field(s): clientId, clientSecret, discoveryUrl, redirectUri',
    );
  });

  it('should pass validation when additional optional fields are present', () => {
    const configWithOptional: Partial<IClientConfig> = {
      ...validConfig,
      postLogoutRedirectUri: 'https://localhost:9443/auth/sso/logout',
      scopes: ['openid', 'profile'],
      // Add other optional fields as needed
    };

    expect(() => validateConfig(configWithOptional)).not.toThrow();
  });

  it('should ignore optional fields and validate required fields only', () => {
    const configWithOptionalButValid: Partial<IClientConfig> = {
      ...validConfig,
      // Optional fields are present
      grantType: GrantType.AuthorizationCode,
      responseType: ResponseType.Code,
    };

    expect(() => validateConfig(configWithOptionalButValid)).not.toThrow();
  });

  it('should throw ClientError when required fields are null', () => {
    const configWithNullFields: Partial<IClientConfig> = {
      clientId: null,
      clientSecret: null,
      discoveryUrl: 'https://example.com/.well-known/openid-configuration',
      redirectUri: 'https://localhost:9443/auth/sso/callback',
    };

    expect(() => validateConfig(configWithNullFields)).toThrow(ClientError);
    expect(() => validateConfig(configWithNullFields)).toThrow(
      'Missing required configuration field(s): clientId, clientSecret',
    );
  });

  it('should handle whitespace-only strings as empty values', () => {
    const configWithWhitespace: Partial<IClientConfig> = {
      ...validConfig,
      clientId: '   ',
      clientSecret: '\t',
    };

    expect(() => validateConfig(configWithWhitespace)).toThrow(ClientError);
    expect(() => validateConfig(configWithWhitespace)).toThrow(
      'Missing required configuration field(s): clientId, clientSecret',
    );
  });
});
