// src/classes/Auth.ts

import { Token } from './Token';
import { ClientError } from '../errors/ClientError';
import {
  buildAuthorizationUrl,
  buildLogoutUrl,
  buildUrlEncodedBody,
  parseFragment,
  sleep,
  generateRandomString,
} from '../utils';
import {
  ILogoutUrlParams,
  IIssuer,
  ILogger,
  IToken,
  IClientConfig,
  ClientMetadata,
  IAuth,
  IPkce,
  IState,
  IAuthorizationUrlResponse,
} from '../interfaces';
import { GrantType } from '../enums/GrantType';
import { PkceMethod } from '../enums';
import { Jwt } from './Jwt';
import { Pkce } from './Pkce';
import { State } from './State';

export class Auth implements IAuth {
  private readonly config: IClientConfig;
  private readonly issuer: IIssuer;
  private readonly tokenClient: IToken;
  private readonly logger: ILogger;
  private readonly pkceService: IPkce;
  private readonly state: IState;

  private clientMetadata: ClientMetadata | null = null;

  constructor(
    config: IClientConfig,
    logger: ILogger,
    issuer: IIssuer,
    tokenClient?: IToken,
    pkceService?: IPkce,
  ) {
    this.config = config;
    this.logger = logger;
    this.issuer = issuer;
    this.tokenClient =
      tokenClient || new Token(this.logger, this.config, this.issuer);
    this.pkceService = pkceService || new Pkce(this.config);
    this.state = new State();
  }

  private async getClientMetadata(): Promise<ClientMetadata> {
    if (this.clientMetadata === null) {
      this.clientMetadata = await this.issuer.discover();
    }
    return this.clientMetadata;
  }

  /**
   * Generates the authorization URL to initiate the OAuth2/OIDC flow.
   * Generates and stores state and nonce internally.
   * @returns The authorization URL and the generated state and codeVerifier.
   */
  public async getAuthorizationUrl(
    additionalParams?: Record<string, string>,
  ): Promise<IAuthorizationUrlResponse> {
    const state = generateRandomString();
    const nonce = generateRandomString();

    // if additional params are not provided, initialize as empty object
    if (!additionalParams) {
      additionalParams = {};
    }

    // If user has set uiLocales in config, convert array -> space-delimited string
    if (this.config.uiLocales && this.config.uiLocales.length > 0) {
      additionalParams.ui_locales = this.config.uiLocales.join(' ');
    }

    // 2) Pass these extraParams into generateAuthUrl
    const { url, codeVerifier } = await this.generateAuthUrl(
      state,
      nonce,
      additionalParams,
    );

    this.state.addState(state, nonce, codeVerifier);

    return { url, state, codeVerifier };
  }

  /**
   * Generates the authorization URL with the provided state and nonce.
   * @param state A unique state string for CSRF protection.
   * @param nonce Optional nonce for ID token validation.
   * @returns The authorization URL and the code verifier if PKCE is used.
   */
  private async generateAuthUrl(
    state: string,
    nonce?: string,
    extraParams?: Record<string, string>,
  ): Promise<{ url: string; codeVerifier?: string }> {
    try {
      // 1) Get client metadata and ensure the authorization endpoint is present
      const client = await this.checkAuthorizationEndpoint();

      // 2) Ensure we are using a valid grant type for building auth URLs
      this.ensureGrantTypeSupportsAuthUrl();

      // 3) Try to generate PKCE if configured
      const pkceResult = this.tryGeneratePkce();

      // 4) Optionally build acr_values
      const acrValues = this.buildAcrValues();

      // 5) Build the final URL
      const authUrlResult = this.buildAuthUrl({
        client,
        state,
        nonce,
        extraParams,
        acrValues,
        pkceResult,
      });

      this.logger.debug('Authorization URL generated', {
        url: authUrlResult.url,
      });
      return authUrlResult;
    } catch (error) {
      this.logger.error('Failed to generate authorization URL', { error });
      throw error;
    }
  }

  private async checkAuthorizationEndpoint(): Promise<ClientMetadata> {
    const client: ClientMetadata = await this.getClientMetadata();
    if (!client.authorization_endpoint) {
      const error = new ClientError(
        'Authorization endpoint is missing',
        'AUTH_ENDPOINT_MISSING',
      );
      this.logger.error('Failed to generate authorization URL', { error });
      throw error;
    }
    return client;
  }

  private tryGeneratePkce(): {
    codeVerifier?: string;
    codeChallenge?: string;
    codeChallengeMethod?: PkceMethod;
  } {
    // If PKCE is turned on and we are in Authorization Code flow, generate it
    if (
      this.config.pkce &&
      this.config.grantType === GrantType.AuthorizationCode
    ) {
      try {
        const pkce = this.pkceService.generatePkce();
        let codeChallengeMethod: PkceMethod | undefined;

        // Validate pkceMethod if provided
        if (
          this.config.pkceMethod &&
          Object.values(PkceMethod).includes(this.config.pkceMethod)
        ) {
          codeChallengeMethod = this.config.pkceMethod;
        } else {
          this.logger.warn(
            'Invalid pkceMethod provided. Omitting code_challenge_method.',
          );
        }

        return {
          codeVerifier: pkce.codeVerifier,
          codeChallenge: pkce.codeChallenge,
          codeChallengeMethod,
        };
      } catch (error) {
        this.logger.error('Failed to generate PKCE', { error });
        throw new ClientError('PKCE generation failed', 'PKCE_ERROR', {
          originalError: error,
        });
      }
    }
    return {};
  }

  private buildAcrValues(): string | undefined {
    if (!this.config.acrValues) {
      return undefined;
    }
    // Accept either a string or string[]
    return Array.isArray(this.config.acrValues)
      ? this.config.acrValues.join(' ')
      : this.config.acrValues;
  }

  private buildAuthUrl(options: {
    client: ClientMetadata;
    state: string;
    nonce?: string;
    extraParams?: Record<string, string>;
    acrValues?: string;
    pkceResult: {
      codeVerifier?: string;
      codeChallenge?: string;
      codeChallengeMethod?: PkceMethod;
    };
  }): { url: string; codeVerifier?: string } {
    const { client, state, nonce, extraParams, acrValues, pkceResult } =
      options;

    // Base params
    const authUrlParams = {
      authorizationEndpoint: client.authorization_endpoint,
      clientId: this.config.clientId,
      redirectUri: this.config.redirectUri,
      responseType: this.config.responseType || 'code',
      scope: this.config.scopes.join(' '),
      state,
      codeChallenge: pkceResult.codeChallenge,
      codeChallengeMethod: pkceResult.codeChallengeMethod,
      acrValues,
    };

    // Additional params (nonce, ui_locales, etc.)
    const mergedParams: Record<string, string> = {};
    if (nonce) {
      mergedParams.nonce = nonce;
    }
    if (extraParams) {
      Object.assign(mergedParams, extraParams);
    }

    // Finally, build the URL
    const url = buildAuthorizationUrl(authUrlParams, mergedParams);

    return {
      url,
      codeVerifier: pkceResult.codeVerifier,
    };
  }

  /**
   * Handles the redirect callback for authorization code flow.
   * Exchanges the authorization code for tokens and validates the ID token.
   *
   * @param code - The authorization code received from the provider.
   * @param returnedState - The state returned in the redirect to validate against CSRF.
   * @param codeVerifier - The PKCE code verifier associated with this authorization request.
   * @returns {Promise<void>}
   * @throws {ClientError} If state validation fails or token exchange/validation fails.
   */
  public async handleRedirect(
    code: string,
    returnedState: string,
  ): Promise<void> {
    const stateEntry = await this.state.getStateEntry(returnedState);
    if (!stateEntry) {
      throw new ClientError(
        'State mismatch or missing codeVerifier',
        'STATE_MISMATCH',
      );
    }

    const { nonce, codeVerifier } = stateEntry;
    if (!codeVerifier) {
      throw new ClientError(
        'Missing codeVerifier in state entry',
        'CODE_VERIFIER_MISSING',
      );
    }

    try {
      // Exchange code for tokens using the provided codeVerifier
      await this.tokenClient.exchangeCodeForToken(code, codeVerifier);
    } catch (error) {
      this.logger.error('Failed to exchange authorization code for tokens', {
        error,
      });
      throw new ClientError('Token exchange failed', 'TOKEN_EXCHANGE_ERROR', {
        originalError: error,
      });
    }

    try {
      // Validate ID token if present
      const tokens = this.tokenClient.getTokens();
      const client = await this.getClientMetadata();
      if (tokens?.id_token) {
        const payload = await Jwt.verify(tokens.id_token, {
          logger: this.logger,
          client: client,
          clientId: this.config.clientId,
          nonce: nonce,
        });
        this.logger.info('ID token validated successfully', { payload });
      } else {
        this.logger.warn('No ID token returned to validate');
      }
    } catch (error) {
      this.logger.error('Failed to validate ID token', { error });
      throw new ClientError(
        'ID token validation failed',
        'ID_TOKEN_VALIDATION_ERROR',
        { originalError: error },
      );
    }
  }

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
   */
  public async handleRedirectForImplicitFlow(fragment: string): Promise<void> {
    // Parse the fragment into an object
    const params = parseFragment(fragment);

    // Handle potential OAuth2 errors
    if (params.error) {
      this.logger.error('Error in implicit flow redirect', {
        error: params.error,
        error_description: params.error_description,
      });
      throw new ClientError(
        params.error_description || 'Implicit flow error',
        params.error.toUpperCase(),
      );
    }

    const { access_token, id_token, state, token_type, expires_in } = params;

    if (!access_token) {
      throw new ClientError(
        'Access token not found in fragment',
        'TOKEN_NOT_FOUND',
      );
    }

    if (!state) {
      throw new ClientError(
        'State parameter missing in fragment',
        'STATE_MISSING',
      );
    }

    const stateEntry = await this.state.getStateEntry(state);
    if (!stateEntry) {
      throw new ClientError(
        'State mismatch or missing codeVerifier',
        'STATE_MISMATCH',
      );
    }

    const { nonce } = stateEntry;
    if (!nonce) {
      throw new ClientError(
        'State does not match or not found',
        'STATE_MISMATCH',
      );
    }

    // Optionally handle ID token validation
    if (id_token) {
      const client = await this.getClientMetadata();
      const payload = await Jwt.verify(id_token, {
        logger: this.logger,
        client: client,
        clientId: this.config.clientId,
        nonce: nonce,
      });
      this.logger.info('ID token validated successfully', { payload });
    } else {
      this.logger.warn('No ID token returned to validate');
    }
    // Convert expires_in from string to number
    const expiresInNumber = expires_in ? parseInt(expires_in, 10) : undefined;

    // Store the tokens
    this.tokenClient.setTokens({
      access_token,
      id_token,
      token_type,
      expires_in: expiresInNumber,
    });

    this.logger.info('Tokens obtained and stored successfully');
  }

  /**
   * Ensures the current grant type supports generating an authorization URL.
   * @throws {ClientError} If the grant type is unsupported.
   */
  private ensureGrantTypeSupportsAuthUrl(): void {
    const supportedGrantTypes = [
      GrantType.AuthorizationCode,
      GrantType.Implicit,
      GrantType.DeviceCode,
    ];
    if (!supportedGrantTypes.includes(this.config.grantType)) {
      throw new ClientError(
        `Grant type ${this.config.grantType} does not support authorization URLs.`,
        'INVALID_GRANT_TYPE',
      );
    }
  }

  /**
   * Initiates the device authorization request to obtain device and user codes.
   * @returns Device authorization details.
   * @throws {ClientError} If device authorization initiation fails.
   */
  public async startDeviceAuthorization(): Promise<{
    device_code: string;
    user_code: string;
    verification_uri: string;
    expires_in: number;
    interval: number;
  }> {
    if (this.config.grantType !== GrantType.DeviceCode) {
      throw new ClientError(
        `startDeviceAuthorization() is only applicable for DeviceCode flows. Current grantType: ${this.config.grantType}`,
        'INVALID_GRANT_TYPE',
      );
    }

    const client: ClientMetadata = await this.issuer.discover();
    const deviceEndpoint = client.device_authorization_endpoint;

    if (!deviceEndpoint) {
      const error = new ClientError(
        'No device_authorization_endpoint found in discovery configuration.',
        'ENDPOINT_MISSING',
      );
      this.logger.error('Failed to start device authorization', {
        error: error,
      });
      throw new ClientError(
        'Device authorization failed',
        'DEVICE_AUTH_ERROR',
        {
          originalError: error,
        },
      );
    }

    const params = {
      client_id: this.config.clientId,
      scope: this.config.scopes.join(' '),
      // Add any additional parameters needed by your provider
    };

    const headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    const body = buildUrlEncodedBody(params);

    try {
      const response = await fetch(deviceEndpoint, {
        method: 'POST',
        body,
        headers,
      });
      const json = await response.json();
      this.logger.info('Device authorization initiated');
      return {
        device_code: json.device_code,
        user_code: json.user_code,
        verification_uri: json.verification_uri,
        expires_in: json.expires_in,
        interval: json.interval || 5,
      };
    } catch (error) {
      this.logger.error('Failed to start device authorization', { error });
      throw new ClientError(
        'Device authorization failed',
        'DEVICE_AUTH_ERROR',
        {
          originalError: error,
        },
      );
    }
  }

  /**
   * Polls the token endpoint until the device is authorized or the process times out.
   * @param device_code The device code obtained from device authorization.
   * @param interval Polling interval in seconds.
   * @param timeout Maximum time to wait in milliseconds.
   * @throws {ClientError} If polling fails or times out.
   */
  public async pollDeviceToken(
    device_code: string,
    interval: number = 5,
    timeout?: number,
  ): Promise<void> {
    if (this.config.grantType !== GrantType.DeviceCode) {
      throw new ClientError(
        `pollDeviceToken() is only applicable for DeviceCode flows. Current grantType: ${this.config.grantType}`,
        'INVALID_GRANT_TYPE',
      );
    }

    const client: ClientMetadata = await this.issuer.discover();
    const tokenEndpoint = client.token_endpoint;
    const startTime = Date.now();
    let currentInterval = interval;

    const pollLoop = async (): Promise<void> => {
      if (timeout && Date.now() - startTime > timeout) {
        const timeoutError = new ClientError(
          'Device code polling timed out',
          'TIMEOUT_ERROR',
        );
        this.logger.error('Device token polling timed out', {
          error: timeoutError,
        });
        throw timeoutError;
      }

      const params = {
        grant_type: GrantType.DeviceCode,
        device_code,
        client_id: this.config.clientId,
      };
      const headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      const body = buildUrlEncodedBody(params);

      try {
        const response = await fetch(tokenEndpoint, {
          method: 'POST',
          body,
          headers,
        });
        const tokenResponse = await response.json();
        if (tokenResponse.error) {
          throw new ClientError(
            'Error response from token endpoint',
            'TOKEN_ERROR',
            {
              originalError: tokenResponse.error,
            },
          );
        }
        this.tokenClient.setTokens(tokenResponse);
        this.logger.info('Device authorized and tokens obtained');
        return;
      } catch (error: any) {
        currentInterval = await this.handlePollingError(error, currentInterval);
        await sleep(currentInterval * 1000);
        return pollLoop();
      }
    };

    await pollLoop();
  }

  /**
   * Generates the logout URL to initiate the logout flow.
   * @param idTokenHint Optional ID token to hint the logout request.
   * @param state Optional state for logout.
   * @returns The logout URL.
   * @throws {ClientError} If logout endpoint is missing.
   */
  public async getLogoutUrl(
    idTokenHint?: string,
    state?: string,
  ): Promise<string> {
    const client: ClientMetadata = await this.issuer.discover();
    const endSessionEndpoint = client.end_session_endpoint;

    if (!endSessionEndpoint) {
      const error = new ClientError(
        'No end_session_endpoint found in discovery configuration.',
        'END_SESSION_ENDPOINT_MISSING',
      );
      this.logger.error('Failed to generate logout URL', { error });
      throw error;
    }

    const logoutParams: ILogoutUrlParams = {
      endSessionEndpoint,
      clientId: this.config.clientId,
      postLogoutRedirectUri: this.config.postLogoutRedirectUri,
      idTokenHint,
      state,
    };

    const logoutUrl = buildLogoutUrl(logoutParams);

    this.logger.debug('Logout URL generated', { logoutUrl });
    return logoutUrl;
  }

  private async handlePollingError(
    error: any,
    interval: number,
  ): Promise<number> {
    let errorBody: any = {};
    if (error.context?.body) {
      try {
        errorBody = JSON.parse(error.context.body);
      } catch (parseError) {
        this.logger.warn('Failed to parse error response as JSON', {
          originalError: parseError,
        });
        this.logger.warn('Error response from token endpoint', {
          response: error.context.body,
        });
      }
    }

    switch (errorBody.error) {
      case 'authorization_pending':
        await sleep(interval * 1000);
        break;
      case 'slow_down':
        interval += 5;
        await sleep(interval * 1000);
        break;
      case 'expired_token':
        this.logger.error('Device code expired', {
          error: new ClientError('Device code expired', 'DEVICE_CODE_EXPIRED'),
        });
        throw new ClientError('Device code expired', 'DEVICE_CODE_EXPIRED');
      default:
        this.logger.error('Device token polling failed', {
          originalError: error,
        });
        throw new ClientError(
          'Device token polling failed',
          'TOKEN_POLLING_ERROR',
          {
            originalError: error,
          },
        );
    }
    return interval;
  }
}
