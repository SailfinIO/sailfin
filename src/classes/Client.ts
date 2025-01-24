// src/classes/Client.ts

import { Auth } from './Auth';
import { UserInfo } from './UserInfo';
import { Logger, deepMerge } from '../utils';
import {
  GrantType,
  LogLevel,
  TokenTypeHint,
  StorageMechanism,
  SessionMode,
} from '../enums';
import { Issuer } from './Issuer';
import {
  IClientConfig,
  ILogger,
  ITokenIntrospectionResponse,
  TokenSet,
  IUserInfo,
  IUser,
  IIssuer,
  IToken,
  IAuth,
  ISession,
  IStoreContext,
  ISessionStore,
  IAuthorizationUrlResponse,
} from '../interfaces';
import { ClientError } from '../errors';
import { Token } from './Token';
import { Session } from './Session';
import { Store, StoreInstances } from './Store';
import { defaultClientConfig } from '../config/defaultClientConfig';
import { ClaimsRecord } from '../types';

export class Client {
  private readonly config: IClientConfig;
  private readonly auth: IAuth;
  private readonly tokenClient: IToken;
  private readonly logger: ILogger;
  private readonly issuer: IIssuer;
  private readonly sessionStore: ISessionStore | null;
  private userInfoClient!: IUserInfo;
  private initialized: boolean = false;
  private session: ISession | null = null;

  constructor(userConfig: Partial<IClientConfig>) {
    this.config = deepMerge(defaultClientConfig, userConfig) as IClientConfig;
    // Ensure logging is always defined
    const envLogLevel = process.env.OIDC_CLIENT_LOG_LEVEL as LogLevel;
    if (
      !this.config.logging?.logger ||
      typeof this.config.logging.logger.debug !== 'function'
    ) {
      this.logger = new Logger(
        Client.name,
        this.config.logging?.logLevel || envLogLevel || LogLevel.INFO,
        true,
      );
      this.config.logging.logger = this.logger;
    } else {
      // Initialize logger **before** validation
      this.logger =
        this.config.logging?.logger ||
        new Logger(
          Client.name,
          this.config.logging?.logLevel || envLogLevel || LogLevel.INFO,
          true,
        );
    }

    this.validateConfig(this.config);

    const sessionMode = this.config.session?.mode || SessionMode.SERVER;
    let storeInstances: StoreInstances | null = null;

    if (
      sessionMode === SessionMode.SERVER ||
      sessionMode === SessionMode.HYBRID
    ) {
      const storageMechanism =
        this.config.session?.serverStorage || StorageMechanism.MEMORY;
      storeInstances = Store.create(
        storageMechanism,
        this.config.session?.options,
        this.logger,
      );
      this.sessionStore = storeInstances.sessionStore;
    } else {
      this.sessionStore = null; // No server-side session store needed
    }

    // Initialize other dependencies
    this.issuer = new Issuer(this.config.discoveryUrl, this.logger);
    this.tokenClient = new Token(this.logger, this.config, this.issuer);
    this.auth = new Auth(
      this.config,
      this.logger,
      this.issuer,
      this.tokenClient,
    );

    // Session will be created in .discover() or handleRedirect(), etc.
    this.session = null;
  }

  private async initializeInternal(): Promise<void> {
    try {
      this.logger.debug('Initializing OIDC Client');
      const clientMetadata = await this.issuer.discover();

      this.userInfoClient = new UserInfo(
        this.tokenClient,
        clientMetadata,
        this.logger,
      );
      this.session = new Session(
        this.config,
        this.logger,
        this.tokenClient,
        this.userInfoClient,
        this.sessionStore!,
      );

      this.initialized = true;
      this.logger.info('OIDC Client initialized successfully');
    } catch (error) {
      this.logger.error('Failed to initialize OIDC Client', { error });
      throw new ClientError('Initialization failed', 'INITIALIZATION_ERROR', {
        originalError: error,
      });
    }
  }

  /**
   * Returns the current configuration.
   */
  public getConfig(): IClientConfig {
    return this.config;
  }

  /**
   * Centralized config validation.
   */
  // src/classes/Client.ts

  private validateConfig(config: IClientConfig): void {
    const missingRequiredFields: (keyof IClientConfig)[] = [];

    // Check for core required fields
    if (!config.clientId) missingRequiredFields.push('clientId');
    if (!config.redirectUri) missingRequiredFields.push('redirectUri');
    if (!config.discoveryUrl) missingRequiredFields.push('discoveryUrl');

    if (missingRequiredFields.length > 0) {
      throw new ClientError(
        `Missing required field(s): ${missingRequiredFields.join(', ')}`,
        'CONFIG_ERROR',
      );
    }

    // Check for scopes
    if (!config.scopes?.length) {
      throw new ClientError('At least one scope is required', 'CONFIG_ERROR');
    }

    // Assign defaults for optional fields if not already set
    if (!config.grantType) {
      this.logger.debug(
        'No grantType specified, defaulting to authorization_code',
      );
      config.grantType = GrantType.AuthorizationCode;
    }

    // Validate session.cookie.secret in production
    const isProd =
      process.env.NODE_ENV === 'production' || process.env.NODE_ENV === 'prod';
    if (isProd) {
      const secret = config.session?.cookie?.secret;
      if (!secret || secret === 'default-secret') {
        throw new ClientError(
          'A secure session cookie secret must be provided in production environments.',
          'CONFIG_ERROR',
        );
      }
    }
  }

  private async ensureInitialized(): Promise<void> {
    if (!this.initialized) {
      await this.initializeInternal();
    }
  }

  public setLogLevel(level: LogLevel): void {
    this.logger.setLogLevel(level);
  }

  public async getAuthorizationUrl(
    additionalParams?: Record<string, string>,
  ): Promise<IAuthorizationUrlResponse> {
    await this.ensureInitialized();
    return this.auth.getAuthorizationUrl(additionalParams);
  }

  public async handleRedirect(
    code: string,
    returnedState: string,
    context: IStoreContext,
  ): Promise<void> {
    await this.ensureInitialized();

    // Pass only code and state; Auth class handles codeVerifier internally
    await this.auth.handleRedirect(code, returnedState);

    if (this.session) {
      await this.session.start(context);
    }
  }

  public async handleRedirectForImplicitFlow(
    fragment: string,
    context: IStoreContext,
  ): Promise<void> {
    await this.ensureInitialized();
    await this.auth.handleRedirectForImplicitFlow(fragment);

    if (this.session) {
      await this.session.start(context);
    }
  }

  public async startDeviceAuthorization(): Promise<{
    device_code: string;
    user_code: string;
    verification_uri: string;
    expires_in: number;
    interval: number;
  }> {
    await this.ensureInitialized();
    return this.auth.startDeviceAuthorization();
  }

  public async pollDeviceToken(
    device_code: string,
    interval: number = 5,
    timeout?: number,
    context?: IStoreContext,
  ): Promise<void> {
    await this.ensureInitialized();
    await this.auth.pollDeviceToken(device_code, interval, timeout);

    if (context && this.session) {
      await this.session.start(context);
    }
  }

  public async getUserInfo(): Promise<IUser> {
    await this.ensureInitialized();
    return this.userInfoClient.getUserInfo();
  }

  /**
   * Exposes the session store.
   */
  public getSessionStore(): ISessionStore | null {
    return this.sessionStore;
  }

  public getLogger(): ILogger {
    return this.logger;
  }

  public async introspectToken(
    token: string,
  ): Promise<ITokenIntrospectionResponse> {
    await this.ensureInitialized();
    return this.tokenClient.introspectToken(token);
  }

  public async revokeToken(
    token: string,
    tokenTypeHint?: TokenTypeHint,
  ): Promise<void> {
    await this.ensureInitialized();
    return this.tokenClient.revokeToken(token, tokenTypeHint);
  }

  public async getAccessToken(): Promise<string | null> {
    await this.ensureInitialized();
    return this.tokenClient.getAccessToken();
  }

  public async getTokens(): Promise<TokenSet | null> {
    await this.ensureInitialized();
    return this.tokenClient.getTokens();
  }

  /**
   * Retrieves claims from the access token.
   *
   * @returns A promise that resolves to an array of claim keys.
   */
  public async getClaims(): Promise<ClaimsRecord> {
    await this.ensureInitialized();
    return this.tokenClient.getClaims();
  }

  public async clearTokens(context: IStoreContext): Promise<void> {
    await this.ensureInitialized();
    this.tokenClient.clearTokens();
    if (this.session) {
      await this.session.stop(context);
    }
  }

  public async logout(idTokenHint?: string): Promise<string> {
    await this.ensureInitialized();
    const logoutUrl = await this.auth.getLogoutUrl(idTokenHint);
    this.logger.info('Logout initiated', { logoutUrl });
    return logoutUrl;
  }

  public async silentRenew(context: IStoreContext): Promise<void> {
    // If we have a refresh token, call tokenClient.refreshAccessToken()
    await this.tokenClient.refreshAccessToken();

    if (this.session) {
      await this.session.update(context);
    }
  }
}
