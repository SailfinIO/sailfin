/**
 * @fileoverview
 * Defines the `IClientConfig` interface, which specifies the configuration options
 * for an OAuth/OIDC client. It includes settings for authentication, session
 * management, and logging.
 *
 * @module src/interfaces/IClientConfig
 */

import {
  LogLevel,
  LoginPrompt,
  GrantType,
  ResponseType,
  PkceMethod,
  ResponseMode,
  StorageMechanism,
  Scopes,
  Display,
  UILocales,
  AuthMethod,
  Algorithm,
  SessionMode,
} from '../enums';
import { ILogger } from './ILogger';
import { ISessionStore } from './ISessionStore';
import { StoreOptions } from './StoreOptions';
import { CookieOptions } from './CookieOptions';

/**
 * Represents the configuration for an OAuth/OIDC client.
 *
 * The `IClientConfig` interface defines the parameters required to initialize and manage
 * the client's authentication behavior, including session management, logging, and
 * additional options for advanced use cases.
 *
 * @interface
 */
export interface IClientConfig {
  /**
   * The client ID registered with the authorization server.
   *
   * @type {string}
   */
  clientId: string;

  /**
   * The client secret, if applicable (e.g., for confidential clients).
   *
   * @type {string | undefined}
   */
  clientSecret?: string;

  /**
   * The issuer's URL for the authorization server.
   *
   * @type {string | undefined}
   */
  issuer?: string;

  /**
   * The client's authentication method (e.g., 'client_secret_basic').
   *
   * @type {AuthMethod | undefined}

   */
  tokenEndpointAuthMethod?: AuthMethod;

  /**
   * The PEM-encoded private key, used for private_key_jwt client authentication.
   * If `tokenEndpointAuthMethod = AuthMethod.PRIVATE_KEY_JWT`, this is required.
   *
   * @type {string | Buffer}
   */
  privateKeyPem?: string | Buffer;

  /**
   * The client's certificate for mutual TLS authentication.
   *
   * @type {string | undefined}
   */
  tlsClientBoundAccessToken?: boolean;

  /**
   * The algorithm used to sign the request object.
   *
   * @type {Algorithm | undefined}
   */
  requestObjectSigningAlg?: Algorithm;

  // /**
  //  * The algorithm used to sign the ID token.
  //  *
  //  * @type {string | undefined}
  //  */
  // idTokenSignedResponseAlg?: Algorithm;

  // idTokenEncryptedResponseAlg?: Algorithm;

  // idTokenEncryptedResponseEnc?: string;

  // introspectionEndpointAuthMethod?: AuthMethod;

  // introspectionEndpointAuthSigningAlg?: Algorithm;

  // requestObjectEncryptionAlg?: Algorithm;

  // requestObjectEncryptionEnc?: string;

  // revocationEndpointAuthMethod?: AuthMethod;

  // revocationEndpointAuthSigningAlg?: Algorithm;

  // userinfoEndpointAuthMethod?: AuthMethod;

  // userinfoEndpointAuthSigningAlg?: Algorithm;

  // userinfoEncryptedResponseAlg?: Algorithm;

  // userinfoEncryptedResponseEnc?: string;

  // authorizationSignedResponseAlg?: Algorithm;

  // authorizationEncryptedResponseAlg?: Algorithm;

  // authorizationEncryptedResponseEnc?: string;

  /**
   * The URI to which the authorization server will redirect after authentication.
   *
   * @type {string | undefined}
   */
  redirectUri: string;

  /**
   * The URI to which the authorization server will redirect after logout.
   *
   * @type {string | undefined}
   */
  postLogoutRedirectUri?: string;

  /**
   * The scopes requested during authentication.
   *
   * @type {Scopes[] | string[]}
   */
  scopes: Scopes[] | string[];

  /**
   * The discovery URL for retrieving OIDC configuration.
   *
   * @type {string}
   */
  discoveryUrl: string;

  /**
   * The response type for the authentication flow (e.g., 'code').
   *
   * @type {ResponseType | undefined}
   */
  responseType?: ResponseType;

  /**
   * The grant type for token exchange (e.g., 'authorization_code').
   *
   * @type {GrantType | undefined}
   */
  grantType?: GrantType;

  /**
   * Enables PKCE (Proof Key for Code Exchange).
   *
   * @type {boolean | undefined}
   */
  pkce?: boolean;

  /**
   * The PKCE method to use (e.g., 'S256').
   *
   * @type {PkceMethod | undefined}
   */
  pkceMethod?: PkceMethod;

  /**
   * Specifies the login prompt behavior (e.g., 'login', 'consent').
   *
   * @type {LoginPrompt | undefined}
   */
  prompt?: LoginPrompt;

  /**
   * Specifies the display mode for the login interface (e.g., 'page', 'popup').
   *
   * @type {Display | undefined}
   */
  display?: Display;

  /**
   * The maximum age of an authentication in seconds.
   *
   * @type {number | undefined}
   */
  maxAge?: number;

  /**
   * Additional Authentication Context Class Reference (ACR) values.
   *
   * @type {string | undefined}
   */
  acrValues?: string | string[];

  /**
   * Preferred UI locales for the login interface.
   *
   * @type {UILocales[] | undefined}
   */
  uiLocales?: UILocales[];

  /**
   * Additional parameters to include in the authorization request.
   *
   * @type {Record<string, any> | undefined}
   */
  additionalParams?: Record<string, any>;

  /**
   * Specifies the response mode for token delivery.
   *
   * @type {ResponseMode | undefined}
   */
  responseMode?: ResponseMode;

  /**
   * Custom state parameter for the authorization request.
   *
   * @type {string | undefined}
   */
  state?: string;

  /**
   * Custom nonce parameter for the authorization request.
   *
   * @type {string | undefined}
   */
  nonce?: string;

  /**
   * Allowed clock skew in seconds for token validation.
   *
   * @type {number | undefined}
   */
  clockSkew?: number;

  /**
   * Threshold in seconds for refreshing tokens before they expire.
   *
   * @type {number | undefined}
   */
  tokenRefreshThreshold?: number;

  /**
   * Timeout for network requests in milliseconds.
   *
   * @type {number | undefined}
   */
  timeout?: number;

  /**
   * Number of retry attempts for failed network requests.
   *
   * @type {number | undefined}
   */
  retryAttempts?: number;

  /**
   * Session Management Configuration
   */
  session?: {
    /**
     * Specifies the session management mode: 'server', 'client', or 'hybrid'.
     *
     * @type {SessionMode}
     */
    mode?: SessionMode;

    /**
     * Storage mechanism for server-side sessions.
     *
     * @type {StorageMechanism | undefined}
     */
    serverStorage?: StorageMechanism;

    /**
     * Storage mechanism for client-side sessions.
     *
     * @type {StorageMechanism | undefined}
     */
    clientStorage?: StorageMechanism;

    /**
     * Specific options for session storage, based on the selected mechanism.
     *
     * @type {StoreOptions | undefined}
     */
    options?: StoreOptions;

    /**
     * Custom session store implementation for server-side sessions.
     *
     * @type {ISessionStore | undefined}
     */
    store?: ISessionStore;

    /**
     * Configuration for the session cookie.
     *
     * @property {string | undefined} name - The name of the session cookie (e.g., 'sid').
     * @property {CookieOptions | undefined} options - Additional cookie attributes.
     */
    cookie?: {
      name?: string;
      secret?: string;
      options?: CookieOptions;
    };

    /**
     * Enables silent token renewal.
     *
     * @type {boolean | undefined}
     */
    useSilentRenew?: boolean;

    /**
     * Time-to-live (TTL) for the session in milliseconds.
     *
     * @type {number | undefined}
     */
    ttl?: number;
  };

  /** Logger Configuration */
  logging?: {
    /**
     * Log level for the client (e.g., DEBUG, INFO, WARN, ERROR).
     *
     * @type {LogLevel | undefined}
     */
    logLevel?: LogLevel;

    /**
     * Custom logger implementation.
     *
     * @type {ILogger | undefined}
     */
    logger?: ILogger;
  };
}
