/**
 * @fileoverview
 * Provides the default configuration for an OAuth/OIDC client.
 * The `defaultClientConfig` object specifies default values for authentication,
 * session management, and logging settings.
 *
 * @module src/config/defaultClientConfig
 */

import { isProduction } from '../utils/helpers';
import {
  LogLevel,
  GrantType,
  ResponseType,
  PkceMethod,
  ResponseMode,
  StorageMechanism,
  Display,
  LoginPrompt,
  UILocales,
  SameSite,
  SessionMode,
} from '../enums';
import { IClientConfig } from '../interfaces';
import { Logger } from '../utils/Logger';

/**
 * Default configuration for the OAuth/OIDC client.
 *
 * The `defaultClientConfig` object defines default settings for authentication flows,
 * session management, logging, and various other client behaviors. It serves as a baseline
 * configuration that can be overridden as needed.
 *
 * @constant
 * @type {Partial<IClientConfig>}
 */
export const defaultClientConfig: Partial<IClientConfig> = {
  /** Authentication Settings */
  responseType: ResponseType.Code, // Default to 'code' flow
  grantType: GrantType.AuthorizationCode, // Use Authorization Code Grant
  pkce: true, // Enable Proof Key for Code Exchange (PKCE) by default
  pkceMethod: PkceMethod.S256, // Use SHA-256 as the PKCE method
  prompt: LoginPrompt.Consent, // Default login prompt is 'consent'
  display: Display.PAGE, // Default display mode for login interface
  maxAge: 3600, // Max authentication age in seconds (1 hour)
  uiLocales: [UILocales.EN_US], // Default UI locale is English (US)
  additionalParams: {}, // No additional parameters by default
  responseMode: ResponseMode.Query, // Use 'query' as the response mode
  clockSkew: 60, // Allowable clock skew of 60 seconds
  tokenRefreshThreshold: 300, // Refresh tokens 5 minutes (300 seconds) before expiration
  timeout: 5000, // Network request timeout of 5 seconds
  retryAttempts: 3, // Retry failed requests up to 3 times

  /** Session Management Configuration */
  session: {
    mode: SessionMode.SERVER, // Default to server-side session management
    serverStorage: StorageMechanism.MEMORY,
    clientStorage: StorageMechanism.COOKIE, // For client-side tokens
    useSilentRenew: true, // Enable silent renewal of tokens
    store: undefined, // No custom session store by default
    ttl: 3600000, // Session TTL of 1 hour (in milliseconds)
    cookie: {
      name: 'sailfin.sid', // Default session ID cookie name
      secret: process.env.SESSION_SECRET || 'default-secret', // Replace with a secure secret in production
      options: {
        secure: isProduction(), // Use secure cookies in production
        httpOnly: isProduction(), // Use HTTP-only cookies in production
        sameSite: isProduction() ? SameSite.NONE : SameSite.LAX,
        path: '/', // Default cookie path
        maxAge: 3600, // Cookie expiration in seconds (1 hour)
        domain: undefined, // No specific domain by default
        encode: encodeURIComponent, // Use default URL encoding for cookies
      },
    },
  },

  /** Logging Configuration */
  logging: {
    logLevel: LogLevel.INFO, // Default log level is INFO
    logger: new Logger('Client', LogLevel.INFO, true), // Default logger instance
  },
};
