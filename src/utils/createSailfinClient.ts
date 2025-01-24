// src/providers/oidc-client-provider.ts

import {
  GrantType,
  LogLevel,
  ResponseMode,
  ResponseType,
  SameSite,
  Scopes,
  SessionMode,
  StorageMechanism,
} from '../enums';
import { Client } from '../classes/Client';
import { IClientConfig } from '../interfaces/IClientConfig';
import { SAILFIN_CLIENT } from '../constants/sailfinClientToken';
import { deepMerge, validateConfig } from '../utils/deepMerge';
import { defaultClientConfig } from '../config/defaultClientConfig';
import { isProduction } from './helpers';
import { ClientError } from '../errors/ClientError';

/**
 * Creates a Sailfin OIDC client provider.
 *
 * @param {Partial<IClientConfig>} config - User-provided configuration overrides.
 * @returns {Provider} - The NestJS provider for the Sailfin client.
 */
export const createSailfinClient = (
  config: Partial<IClientConfig>,
): { provide: symbol; useFactory: () => Promise<Client> } => ({
  provide: SAILFIN_CLIENT,
  useFactory: async (): Promise<Client> => {
    try {
      // Environment-based configurations
      const envConfig: Partial<IClientConfig> = {
        clientId: process.env.SSO_CLIENT_ID || '',
        clientSecret: process.env.SSO_CLIENT_SECRET || '',
        discoveryUrl:
          process.env.SSO_DISCOVERY_URL ||
          'https://login.sailfin.io/oidc/endpoint/default/.well-known/openid-configuration',
        redirectUri:
          process.env.SSO_CALLBACK_URL ||
          'https://localhost:9443/auth/sso/callback',
        postLogoutRedirectUri:
          process.env.SSO_LOGOUT_URL ||
          'https://localhost:9443/auth/sso/logout',
        scopes: [
          Scopes.OpenId,
          Scopes.Profile,
          Scopes.Email,
          Scopes.OfflineAccess,
        ],
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
            secret: process.env.SESS_SECRET || '', // Enforce setting via config or env
            options: {
              secure: isProduction(),
              httpOnly: isProduction(),
              sameSite: isProduction() ? SameSite.NONE : SameSite.LAX, // Adjust SameSite as needed
              path: '/',
              maxAge: 86400, // 24 hours in seconds
              domain: process.env.DOMAIN || undefined,
              encode: encodeURIComponent,
            },
          },
        },
        logging: { logLevel: LogLevel.INFO },
      };

      // Deep merge default, environment, and user configurations
      const mergedConfig: IClientConfig = deepMerge(
        deepMerge(defaultClientConfig, envConfig),
        config,
      ) as IClientConfig;

      validateConfig(mergedConfig);

      // Validate that a secure secret is provided in production
      if (
        isProduction() &&
        (!mergedConfig.session?.cookie?.secret ||
          mergedConfig.session.cookie.secret === '')
      ) {
        throw new ClientError(
          'A secure session cookie secret must be provided in production environments.',
          'CONFIG_ERROR',
        );
      }

      // Runtime validation of required fields
      const requiredFields: (keyof IClientConfig)[] = [
        'clientId',
        'clientSecret',
        'discoveryUrl',
        'redirectUri',
        'postLogoutRedirectUri',
        'scopes',
        'grantType',
        'responseType',
        'responseMode',
        'session',
      ];

      const missingFields = requiredFields.filter(
        (field) =>
          mergedConfig[field] === undefined || mergedConfig[field] === '',
      );

      if (missingFields.length > 0) {
        throw new ClientError(
          `Missing required configuration field(s): ${missingFields.join(', ')}`,
          'CONFIG_ERROR',
        );
      }

      const sailfinClient = new Client(mergedConfig);
      return sailfinClient;
    } catch (error) {
      // Optionally, add more detailed error handling or logging here
      throw error;
    }
  },
});
