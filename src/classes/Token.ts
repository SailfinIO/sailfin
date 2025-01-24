// src/classes/Token.ts

import {
  IClientConfig,
  TokenSet,
  ITokenIntrospectionResponse,
  IIssuer,
  ILogger,
  IToken,
} from '../interfaces';
import { ClientError } from '../errors/ClientError';
import { buildUrlEncodedBody } from '../utils';
import {
  TokenTypeHint,
  AuthMethod,
  GrantType,
  Algorithm,
  RequestMethod,
} from '../enums';
import { Jwt } from './Jwt';
import { randomBytes } from 'crypto';
import { ClaimsRecord } from '../types';

export class Token implements IToken {
  private readonly logger: ILogger;
  private readonly config: IClientConfig;
  private readonly issuer: IIssuer;

  private accessToken: string | null = null;
  private refreshToken: string | null = null;
  private idToken: string | null = null;
  private expiresAt: number | null = null;

  constructor(logger: ILogger, config: IClientConfig, issuer: IIssuer) {
    this.logger = logger;
    this.config = config;
    this.issuer = issuer;

    this.validateConfig();
  }

  private validateConfig(): void {
    // 1) If no tokenEndpointAuthMethod is set, pick a default (already done)
    if (!this.config.tokenEndpointAuthMethod) {
      if (this.config.clientSecret) {
        this.logger.debug(
          'No tokenEndpointAuthMethod specified; using client_secret_post',
        );
        this.config.tokenEndpointAuthMethod = AuthMethod.CLIENT_SECRET_POST;
      } else {
        this.logger.debug(
          'No tokenEndpointAuthMethod specified, no clientSecret; using none',
        );
        this.config.tokenEndpointAuthMethod = AuthMethod.NONE;
      }
    }

    // 2) Additional checks:
    switch (this.config.tokenEndpointAuthMethod) {
      case AuthMethod.CLIENT_SECRET_BASIC:
      case AuthMethod.CLIENT_SECRET_POST:
      case AuthMethod.CLIENT_SECRET_JWT:
        if (!this.config.clientSecret) {
          throw new ClientError(
            `tokenEndpointAuthMethod ${this.config.tokenEndpointAuthMethod} requires a clientSecret`,
            'MISSING_CLIENT_SECRET',
          );
        }
        break;

      case AuthMethod.PRIVATE_KEY_JWT:
        if (!this.config.requestObjectSigningAlg) {
          throw new ClientError(
            'requestObjectSigningAlg is required for private_key_jwt (e.g. RS256)',
            'MISSING_ALGORITHM',
          );
        }
        if (!this.config.privateKeyPem) {
          throw new ClientError(
            'privateKeyPem is required for private_key_jwt',
            'MISSING_PRIVATE_KEY',
          );
        }
        break;

      case AuthMethod.TLS_CLIENT_AUTH:
      case AuthMethod.SELF_SIGNED_TLS_CLIENT_AUTH:
        if (!this.config.tlsClientBoundAccessToken) {
          throw new ClientError(
            `tokenEndpointAuthMethod ${this.config.tokenEndpointAuthMethod} requires tlsClientBoundAccessToken`,
            'MISSING_TLS_CLIENT_BOUND_ACCESS_TOKEN',
          );
        }
        break;

      case AuthMethod.NONE:
      default:
        // No additional checks needed for `none`.
        break;
    }
  }

  public setTokens(tokenResponse: TokenSet): void {
    this.accessToken = tokenResponse.access_token;
    this.refreshToken = tokenResponse.refresh_token || null;
    this.expiresAt = tokenResponse.expires_in
      ? Date.now() + tokenResponse.expires_in * 1000
      : null;
    if (tokenResponse.id_token) {
      this.idToken = tokenResponse.id_token;
    }
    this.logger.debug('Tokens set successfully', { tokenResponse });
  }

  public async getAccessToken(): Promise<string | null> {
    if (this.accessToken && this.isTokenValid()) {
      return this.accessToken;
    }
    if (this.refreshToken) {
      await this.refreshAccessToken();
      return this.accessToken;
    }
    return null;
  }

  private isTokenValid(): boolean {
    if (!this.expiresAt) return true;
    const now = Date.now();
    const threshold = (this.config.tokenRefreshThreshold || 60) * 1000; // default 60 seconds
    return now < this.expiresAt - threshold;
  }

  public async refreshAccessToken(): Promise<void> {
    if (!this.refreshToken) {
      const error = new ClientError(
        'No refresh token available',
        'NO_REFRESH_TOKEN',
      );
      this.logger.error('Failed to refresh access token', error);
      throw error;
    }

    const { token_endpoint } = await this.issuer.discover();
    const params: Record<string, string> = {
      grant_type: GrantType.RefreshToken,
      refresh_token: this.refreshToken,
      client_id: this.config.clientId,
    };

    const { headers, finalBody } = this.prepareTokenRequestAuth(
      token_endpoint,
      params,
    );

    try {
      const response = await fetch(token_endpoint, {
        method: RequestMethod.POST,
        headers,
        body: finalBody,
      });

      // Parse JSON
      const tokenResponse = await response.json();
      if (!response.ok) {
        throw new ClientError(
          `Refresh token request failed: ${response.status} ${JSON.stringify(tokenResponse)}`,
        );
      }

      // Now pass the parsed tokenResponse to setTokens:
      this.setTokens(tokenResponse);
      this.logger.info('Access token refreshed successfully');
    } catch (error) {
      this.logger.error('Failed to refresh access token', error);
      throw new ClientError('Token refresh failed', 'TOKEN_REFRESH_ERROR', {
        originalError: error,
      });
    }
  }

  public getTokens(): TokenSet | null {
    if (!this.accessToken) {
      return null;
    }
    return {
      access_token: this.accessToken,
      refresh_token: this.refreshToken || undefined,
      expires_in: this.expiresAt
        ? Math.floor((this.expiresAt - Date.now()) / 1000)
        : undefined,
      token_type: 'Bearer',
      id_token: this.idToken || undefined,
    };
  }

  public clearTokens(): void {
    this.accessToken = null;
    this.refreshToken = null;
    this.idToken = null;
    this.expiresAt = null;
    this.logger.debug('All stored tokens have been cleared');
  }

  /**
   * Introspect a token using the introspection endpoint.
   * @param token The access or refresh token to introspect.
   * @returns Introspection response with active = true/false and other claims if active.
   */
  public async introspectToken(
    token: string,
  ): Promise<ITokenIntrospectionResponse> {
    const issuer = await this.issuer.discover();
    if (!issuer.introspection_endpoint) {
      throw new ClientError(
        'No introspection endpoint available',
        'INTROSPECTION_UNSUPPORTED',
      );
    }

    const params: Record<string, string> = {
      token,
      client_id: this.config.clientId,
    };

    if (this.config.clientSecret) {
      params.client_secret = this.config.clientSecret;
    }

    try {
      const introspectionResult = await this.performTokenRequest(
        issuer.introspection_endpoint,
        params,
      );
      this.logger.debug('Token introspected successfully', {
        introspectionResult,
      });
      return introspectionResult;
    } catch (error) {
      this.logger.error('Token introspection failed', { error });
      throw new ClientError(
        'Token introspection failed',
        'INTROSPECTION_ERROR',
        { originalError: error },
      );
    }
  }

  /**
   * Revoke a token using the revocation endpoint.
   * @param token The access or refresh token to revoke.
   * @param tokenTypeHint Optional hint about the type of token: 'refresh_token' or 'access_token'.
   */
  public async revokeToken(
    token: string,
    tokenTypeHint?: TokenTypeHint,
  ): Promise<void> {
    const issuer = await this.issuer.discover();
    if (!issuer.revocation_endpoint) {
      throw new ClientError(
        'No revocation endpoint available',
        'REVOCATION_UNSUPPORTED',
      );
    }

    const params: Record<string, string> = {
      token,
      client_id: this.config.clientId,
    };

    if (this.config.clientSecret) {
      params.client_secret = this.config.clientSecret;
    }

    if (tokenTypeHint) {
      params.token_type_hint = tokenTypeHint;
    }

    try {
      await this.performTokenRequest(issuer.revocation_endpoint, params);
      this.logger.info('Token revoked successfully');
      // If this is the currently stored token, consider clearing them
      if (token === this.accessToken || token === this.refreshToken) {
        this.clearTokens();
      }
    } catch (error) {
      this.logger.error('Token revocation failed', { error });
      throw new ClientError('Token revocation failed', 'REVOCATION_ERROR', {
        originalError: error,
      });
    }
  }

  /**
   * Performs a token-related HTTP POST request.
   * @param endpoint The endpoint URL.
   * @param params The parameters to include in the request body.
   * @returns The parsed JSON response.
   */
  private async performTokenRequest(
    endpoint: string,
    baseParams: Record<string, string>,
  ): Promise<any> {
    // Decide how to handle client authentication
    const { headers, finalBody } = this.prepareTokenRequestAuth(
      endpoint,
      baseParams,
    );

    try {
      const response = await fetch(endpoint, {
        method: RequestMethod.POST,
        body: finalBody,
        headers,
        // If you need mutual TLS, you would pass an `agent` here:
        // agent: new https.Agent({ cert: ..., key: ... })
      });
      const json = await response.json();

      if (!response.ok) {
        throw new Error(
          `Token request failed: ${response.status} ${JSON.stringify(json)}`,
        );
      }
      return json;
    } catch (error) {
      this.logger.error('Token request failed', {
        endpoint,
        baseParams,
        error,
      });
      throw new ClientError('Token request failed', 'TOKEN_REQUEST_ERROR', {
        originalError: error,
      });
    }
  }

  /**
   * Prepare the appropriate headers and final request body
   * based on `tokenEndpointAuthMethod`.
   */
  private prepareTokenRequestAuth(
    endpoint: string,
    params: Record<string, string>,
  ): { headers: Record<string, string>; finalBody: string } {
    // Start with base headers
    const headers: Record<string, string> = {
      'Content-Type': 'application/x-www-form-urlencoded',
    };

    const authMethod = this.config.tokenEndpointAuthMethod;

    // Default: If no method set, try client_secret_post or fallback logic
    const method = authMethod || AuthMethod.CLIENT_SECRET_POST;

    // Make a shallow copy so we can safely modify
    const requestParams: Record<string, string> = { ...params };

    // Decide how to handle each method:
    switch (method) {
      case AuthMethod.CLIENT_SECRET_POST: {
        // Put client_secret in the body (the current default approach).
        if (this.config.clientSecret) {
          requestParams.client_secret = this.config.clientSecret;
        }
        break;
      }

      case AuthMethod.CLIENT_SECRET_BASIC: {
        // Basic Auth header with base64(client_id:client_secret)
        if (!this.config.clientSecret) {
          throw new ClientError(
            'client_secret is required for client_secret_basic',
            'MISSING_CLIENT_SECRET',
          );
        }

        // Remove from the body if you don’t want it there
        delete requestParams.client_secret;

        const basicAuth = Buffer.from(
          `${this.config.clientId}:${this.config.clientSecret}`,
        ).toString('base64');
        headers['Authorization'] = `Basic ${basicAuth}`;
        break;
      }

      case AuthMethod.CLIENT_SECRET_JWT: {
        if (!this.config.clientSecret) {
          throw new ClientError(
            'client_secret is required for client_secret_jwt',
            'MISSING_CLIENT_SECRET',
          );
        }
        const clientAssertion = this.signJwtWithClientSecret(endpoint); // "endpoint" is your token endpoint

        requestParams.client_assertion_type =
          'urn:ietf:params:oauth:client-assertion-type:jwt-bearer';
        requestParams.client_assertion = clientAssertion;
        delete requestParams.client_secret; // remove raw secret from body
        break;
      }
      case AuthMethod.PRIVATE_KEY_JWT: {
        // signJwtWithPrivateKey(...) returns the JWT
        const clientAssertion = this.signJwtWithPrivateKey(endpoint);

        requestParams.client_assertion_type =
          'urn:ietf:params:oauth:client-assertion-type:jwt-bearer';
        requestParams.client_assertion = clientAssertion;
        delete requestParams.client_secret;
        break;
      }

      case AuthMethod.TLS_CLIENT_AUTH:
      case AuthMethod.SELF_SIGNED_TLS_CLIENT_AUTH: {
        // For (self-signed) TLS client auth, you typically do not send client_secret.
        // Instead, you present a client TLS certificate via HTTPS agent.
        // Just ensure client_id is in the body if required.
        delete requestParams.client_secret;
        // (In Node, you’d pass { agent: new https.Agent({ cert, key }) } in fetch)
        break;
      }

      case AuthMethod.NONE: {
        // Public client; no secret. Just ensure client_id is in body.
        delete requestParams.client_secret;
        break;
      }

      default: {
        this.logger.warn(
          `Unrecognized tokenEndpointAuthMethod: ${method}. Defaulting to client_secret_post.`,
        );
        if (this.config.clientSecret) {
          requestParams.client_secret = this.config.clientSecret;
        }
        break;
      }
    }

    const finalBody = buildUrlEncodedBody(requestParams);
    return { headers, finalBody };
  }

  /**
   * Exchanges an authorization code for tokens.
   * @param code The authorization code received from the authorization server.
   * @param codeVerifier Optional code verifier if PKCE is used.
   * @throws {ClientError} If the exchange fails.
   */
  async exchangeCodeForToken(
    code: string,
    codeVerifier?: string | null,
  ): Promise<void> {
    const { token_endpoint } = await this.issuer.discover();
    const baseParams = this.buildTokenRequestParams(code, codeVerifier);

    // Let prepareTokenRequestAuth decide whether to put client_secret in body or Basic auth, etc.
    const { headers, finalBody } = this.prepareTokenRequestAuth(
      token_endpoint,
      baseParams,
    );

    try {
      const response = await fetch(token_endpoint, {
        method: RequestMethod.POST,
        body: finalBody,
        headers,
      });
      const tokenResponse: TokenSet = await response.json();

      if (!response.ok) {
        throw new Error(
          `Token exchange failed: ${response.status} ${JSON.stringify(tokenResponse)}`,
        );
      }

      this.setTokens(tokenResponse);
      this.logger.info('Exchanged grant for tokens', {
        grantType: this.config.grantType,
      });
    } catch (error) {
      this.logger.error('Failed to exchange grant for tokens', {
        error,
        grantType: this.config.grantType,
      });
      throw new ClientError('Token exchange failed', 'TOKEN_EXCHANGE_ERROR', {
        originalError: error,
      });
    }
  }

  /**
   * Builds the parameters for the token request based on the grant type.
   * @param code The code being exchanged.
   * @param codeVerifier Optional code verifier.
   * @returns The parameters as a record of strings.
   */
  private buildTokenRequestParams(
    code: string,
    codeVerifier?: string,
  ): Record<string, string> {
    const baseParams: Record<string, string> = {
      grant_type: this.config.grantType,
      client_id: this.config.clientId,
      redirect_uri: this.config.redirectUri,
    };

    switch (this.config.grantType) {
      case GrantType.AuthorizationCode:
        baseParams.code = code;
        if (codeVerifier) baseParams.code_verifier = codeVerifier;
        break;
      case GrantType.RefreshToken:
        baseParams.refresh_token = code;
        break;
      case GrantType.DeviceCode:
        baseParams.device_code = code;
        break;
      case GrantType.JWTBearer:
      case GrantType.SAML2Bearer:
        baseParams.assertion = code;
        baseParams.scope = this.config.scopes.join(' ');
        break;
      case GrantType.ClientCredentials:
      case GrantType.Custom:
        // Handle as needed
        break;
      default:
        throw new ClientError(
          `Unsupported grant type: ${this.config.grantType}`,
          'UNSUPPORTED_GRANT_TYPE',
        );
    }

    return baseParams;
  }

  /**
   * Extracts claims from the access token.
   * If the access token is a JWT, decode and return its payload.
   * If opaque, optionally use the UserInfo endpoint to fetch claims.
   *
   * @returns A promise that resolves to an array of claim keys.
   */
  public async getClaims(): Promise<ClaimsRecord> {
    try {
      await this.ensureToken();
    } catch (error) {
      this.logger.error('No access token available', {
        error: new ClientError('No access token available', 'NO_ACCESS_TOKEN'),
      });
      throw new ClientError('No access token available', 'NO_ACCESS_TOKEN');
    }

    if (this.isJwt(this.accessToken)) {
      try {
        const jwtPayload = await Jwt.verify(this.accessToken, {
          logger: this.logger,
          client: await this.issuer.discover(),
          clientId: this.config.clientId,
        });
        this.logger.debug('Claims extracted from JWT access token', {
          payload: jwtPayload,
        });
        // Cast or validate that jwtPayload matches ClaimsRecord structure, if desired
        return jwtPayload as ClaimsRecord;
      } catch (error) {
        this.logger.error('Failed to verify JWT access token', { error });
        throw new ClientError('Failed to verify access token', 'DECODE_ERROR', {
          originalError: error,
        });
      }
    } else {
      // Access token is opaque; use UserInfo endpoint if available
      this.logger.debug(
        'Access token is opaque; fetching claims from UserInfo endpoint',
      );
      try {
        const userInfo = await this.fetchUserInfo();
        this.logger.debug('Claims fetched from UserInfo endpoint', {
          userInfo,
        });
        return userInfo as ClaimsRecord;
      } catch (error) {
        this.logger.error('Failed to fetch user info', { error });
        throw new ClientError('Failed to fetch user info', 'USERINFO_ERROR', {
          originalError: error,
        });
      }
    }
  }

  /**
   * Ensures that the client is initialized and has a valid access token.
   */
  private async ensureToken(): Promise<void> {
    if (this.accessToken && this.isTokenValid()) {
      return;
    }
    if (this.refreshToken) {
      await this.refreshAccessToken();
      return;
    }
    throw new ClientError('No valid access token available', 'NO_VALID_TOKEN');
  }

  /**
   * Determines if a token is a JWT based on its structure.
   *
   * @param token The access token to check.
   * @returns True if the token is a JWT, false otherwise.
   */
  private isJwt(token: string): boolean {
    const parts = token.split('.');
    return parts.length === 3;
  }

  /**
   * Fetches user information from the UserInfo endpoint using the access token.
   *
   * @returns A promise that resolves to the user info object.
   */
  private async fetchUserInfo(): Promise<Record<string, any>> {
    const userInfoEndpoint = (await this.issuer.discover()).userinfo_endpoint;
    if (!userInfoEndpoint) {
      throw new ClientError(
        'UserInfo endpoint not available',
        'USERINFO_UNAVAILABLE',
      );
    }

    const headers = {
      Authorization: `Bearer ${this.accessToken}`,
      'Content-Type': 'application/json',
    };

    try {
      const response = await fetch(userInfoEndpoint, {
        method: RequestMethod.GET,
        headers,
      });

      const userInfo = await response.json();
      return userInfo;
    } catch (error) {
      this.logger.error('Error fetching UserInfo', { error });
      throw error;
    }
  }

  private signJwtWithClientSecret(tokenEndpoint: string): string {
    if (!this.config.clientId || !this.config.clientSecret) {
      throw new ClientError(
        'client_id and client_secret must be set for client_secret_jwt',
        'MISSING_CLIENT_CREDENTIALS',
      );
    }

    // The usual claims needed for client_assertion:
    const now = Math.floor(Date.now() / 1000);
    const payload = {
      iss: this.config.clientId, // issuer = client_id
      sub: this.config.clientId, // subject = client_id
      aud: tokenEndpoint, // audience = the token endpoint
      iat: now,
      exp: now + 60, // short-lived, typically 60 seconds
      jti: this.generateRandomJti(),
    };

    // Decide the HMAC-based algorithm (HS256 is most common)
    const algorithm: Algorithm = Algorithm.HS256;

    // Use the static Jwt.encode() method
    const jwt = Jwt.encode(payload, {
      algorithm,
      privateKey: this.config.clientSecret, // for HS256, "privateKey" is actually the secret key
    });

    return jwt;
  }

  private signJwtWithPrivateKey(tokenEndpoint: string): string {
    if (!this.config.clientId) {
      throw new ClientError(
        'client_id is required for private_key_jwt',
        'MISSING_CLIENT_ID',
      );
    }
    if (!this.config.requestObjectSigningAlg) {
      // Or however you store the signing alg
      throw new ClientError(
        'requestObjectSigningAlg is required for private_key_jwt (e.g., RS256)',
        'MISSING_ALGORITHM',
      );
    }
    if (!this.config.privateKeyPem) {
      // You need some way of storing the actual private key, e.g. config.privateKeyPem
      throw new ClientError(
        'No private key provided for private_key_jwt',
        'MISSING_PRIVATE_KEY',
      );
    }

    const now = Math.floor(Date.now() / 1000);
    const payload = {
      iss: this.config.clientId,
      sub: this.config.clientId,
      aud: tokenEndpoint,
      iat: now,
      exp: now + 60, // 60s expiration, typical
      jti: this.generateRandomJti(),
    };

    // For RSA-based, typically "RS256" is the default
    const algorithm = this.config.requestObjectSigningAlg; // e.g., "RS256"

    const jwt = Jwt.encode(payload, {
      algorithm,
      privateKey: this.config.privateKeyPem,
    });

    return jwt;
  }

  private generateRandomJti(): string {
    return randomBytes(16).toString('hex');
  }
}
