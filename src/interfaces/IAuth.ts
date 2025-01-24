/**
 * @fileoverview
 * Defines the `IAuth` interface for handling authentication flows.
 * This interface provides a contract for implementing OAuth2/OIDC operations,
 * including authorization URL generation, token exchange, device authorization,
 * polling, handling redirects, and logout processes.
 *
 * @module src/interfaces/IAuth
 */

/**
 * Represents the response from generating an authorization URL.
 *
 * @interface IAuthorizationUrlResponse
 */
export interface IAuthorizationUrlResponse {
  /**
   * The generated authorization URL to initiate the OAuth2/OIDC flow.
   */
  url: string;

  /**
   * The state parameter used for CSRF protection.
   */
  state: string;

  /**
   * The code verifier used for PKCE.
   */
  codeVerifier: string | null;
}

/**
 * Represents the response from initiating device authorization.
 *
 * @interface IDeviceAuthorizationResponse
 */
export interface IDeviceAuthorizationResponse {
  /**
   * The device code issued by the authorization server.
   */
  device_code: string;

  /**
   * The user code that the user must enter to authorize the device.
   */
  user_code: string;

  /**
   * The verification URI where the user can enter the user code.
   */
  verification_uri: string;

  /**
   * The lifetime of the device code in seconds.
   */
  expires_in: number;

  /**
   * The interval in seconds at which the device should poll the token endpoint.
   */
  interval: number;
}

/**
 * Defines the `IAuth` interface for managing authentication flows.
 *
 * The `IAuth` interface provides methods for generating authorization URLs,
 * handling redirect callbacks, exchanging authorization codes for tokens,
 * managing device authorization flows, polling for tokens, and generating
 * logout URLs. Implementations of this interface can support various
 * OAuth2/OIDC grant types and PKCE configurations.
 */
export interface IAuth {
  /**
   * Generates the authorization URL to initiate the OAuth2/OIDC flow.
   *
   * This method constructs the URL that the client application should redirect
   * the user to in order to begin the authentication process. It internally
   * generates and stores a unique state and nonce for CSRF protection and
   * ID token validation, respectively.
   *
   * @returns {Promise<IAuthorizationUrlResponse>} An object containing the authorization URL and the generated state.
   *
   * @throws {ClientError} If the grant type does not support authorization URLs.
   *
   * @example
   * ```typescript
   * const { url, state } = await authClient.getAuthorizationUrl();
   * window.location.href = url;
   * // Store `state` to validate upon redirect
   * ```
   */
  getAuthorizationUrl(
    additionalParams?: Record<string, string>,
  ): Promise<IAuthorizationUrlResponse>;

  /**
   * Handles the redirect callback from the authorization server for authorization code flow.
   *
   * This method processes the authorization response, including validating the
   * returned state to prevent CSRF attacks, exchanging the authorization code
   * for tokens, and validating the ID token's nonce.
   *
   * @param {string} code - The authorization code received from the authorization server.
   * @param {string} returnedState - The state returned in the redirect to validate against CSRF.
   * @returns {Promise<void>} Resolves when the redirect has been successfully handled.
   *
   * @throws {ClientError} If state validation fails or token exchange fails.
   *
   * @example
   * ```typescript
   * const code = 'authorization-code-from-redirect';
   * const returnedState = 'state-from-redirect';
   * await authClient.handleRedirect(code, returnedState);
   * ```
   */
  handleRedirect(code: string, returnedState: string): Promise<void>;

  /**
   * Handles the redirect callback for implicit flow.
   *
   * This method processes the authorization response by extracting tokens directly
   * from the URL fragment, validates the returned state, and stores the tokens securely.
   *
   * @param {string} fragment - The URL fragment containing tokens (e.g., access_token, id_token).
   * @returns {Promise<void>} Resolves when tokens are successfully extracted and stored.
   *
   * @throws {ClientError} If token extraction fails or state validation fails.
   *
   * @example
   * ```typescript
   * const fragment = window.location.hash;
   * await authClient.handleRedirectForImplicitFlow(fragment);
   * ```
   */
  handleRedirectForImplicitFlow(fragment: string): Promise<void>;

  /**
   * Initiates the device authorization request to obtain device and user codes.
   *
   * This method starts the Device Authorization Grant flow by requesting device
   * and user codes from the authorization server. It is used in scenarios where
   * the client device has limited input capabilities.
   *
   * @returns {Promise<IDeviceAuthorizationResponse>} The device authorization details.
   *
   * @throws {ClientError} If device authorization initiation fails or the grant type is unsupported.
   *
   * @example
   * ```typescript
   * const deviceAuth = await authClient.startDeviceAuthorization();
   * console.log(`Please visit ${deviceAuth.verification_uri} and enter code ${deviceAuth.user_code}`);
   * ```
   */
  startDeviceAuthorization(): Promise<IDeviceAuthorizationResponse>;

  /**
   * Polls the token endpoint until the device is authorized or the process times out.
   *
   * This method repeatedly requests tokens using the device code until the user
   * authorizes the device or the polling process exceeds the specified timeout.
   *
   * @param {string} device_code - The device code obtained from device authorization.
   * @param {number} [interval=5] - Polling interval in seconds.
   * @param {number} [timeout] - Maximum time to wait in milliseconds.
   * @returns {Promise<void>} Resolves when tokens are successfully obtained.
   *
   * @throws {ClientError} If polling fails, the device code expires, or the process times out.
   *
   * @example
   * ```typescript
   * await authClient.pollDeviceToken(deviceAuth.device_code, deviceAuth.interval, 60000);
   * ```
   */
  pollDeviceToken(
    device_code: string,
    interval?: number,
    timeout?: number,
  ): Promise<void>;

  /**
   * Generates the logout URL to initiate the logout flow.
   *
   * This method constructs the URL that the client application should redirect
   * the user to in order to log out from the authentication server. It supports
   * passing an ID token hint and state parameters.
   *
   * @param {string} [idTokenHint] - Optional ID token to hint the logout request.
   * @param {string} [state] - Optional state for logout.
   * @returns {Promise<string>} The generated logout URL.
   *
   * @throws {ClientError} If the logout endpoint is missing in the discovery configuration.
   *
   * @example
   * ```typescript
   * const logoutUrl = await authClient.getLogoutUrl(idToken, 'logoutState');
   * window.location.href = logoutUrl;
   * ```
   */
  getLogoutUrl(idTokenHint?: string, state?: string): Promise<string>;
}
