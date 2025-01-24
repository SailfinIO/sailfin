/**
 * @fileoverview
 * Implements the `Issuer` class, which handles fetching and caching OpenID Connect (OIDC)
 * discovery metadata. It ensures efficient retrieval and validation of configuration data
 * from the issuer's discovery endpoint.
 *
 * @module src/classes/Issuer
 */

import { ICache, IIssuer, ILogger, ClientMetadata } from '../interfaces';
import { ClientError } from '../errors/ClientError';
import { Cache } from '../cache/Cache';

/**
 * Represents an OIDC issuer responsible for discovery metadata.
 *
 * The `Issuer` class fetches and validates discovery metadata from the OIDC issuer's
 * discovery URL and caches the results for efficient reuse.
 *
 * @class
 * @implements {IIssuer}
 */
export class Issuer implements IIssuer {
  private readonly discoveryUrl: string;
  private readonly logger: ILogger;
  private readonly cache: ICache<ClientMetadata>;
  private readonly cacheKey: string = 'discoveryConfig';
  private readonly cacheTtl: number;
  private fetchingConfig: Promise<ClientMetadata> | null = null;

  /**
   * Creates an instance of `Issuer`.
   *
   * @param {string} discoveryUrl - The URL of the issuer's discovery endpoint.
   * @param {ILogger} logger - Logger instance for logging discovery operations.
   * @param {ICache<ClientMetadata>} [cache] - Optional cache implementation for storing metadata.
   * @param {number} [cacheTtl=3600000] - Time-to-live (TTL) for cached metadata in milliseconds.
   * @throws {ClientError} Throws an error if the discovery URL is invalid.
   */
  constructor(
    discoveryUrl: string,
    logger: ILogger,
    cache?: ICache<ClientMetadata>,
    cacheTtl: number = 3600000, // 1 hour default
  ) {
    if (!discoveryUrl || typeof discoveryUrl !== 'string') {
      throw new ClientError(
        'Invalid discovery URL provided',
        'INVALID_DISCOVERY_URL',
      );
    }

    this.discoveryUrl = discoveryUrl;
    this.logger = logger;
    this.cache = cache ?? new Cache<ClientMetadata>(this.logger, cacheTtl);
    this.cacheTtl = cacheTtl;
  }

  /**
   * Retrieves the OIDC discovery configuration.
   *
   * If `forceRefresh` is true, the method bypasses the cache and fetches fresh data.
   *
   * @param {boolean} [forceRefresh=false] - Whether to bypass the cache.
   * @returns {Promise<ClientMetadata>} A promise that resolves to the discovery configuration.
   * @throws {ClientError} Throws an error if fetching or parsing the configuration fails.
   */
  public async discover(
    forceRefresh: boolean = false,
  ): Promise<ClientMetadata> {
    if (forceRefresh) {
      this.logger.debug('Force refresh enabled. Fetching discovery config.');
      return this.fetchAndCacheConfig();
    }

    const cachedConfig = this.cache.get(this.cacheKey);
    if (cachedConfig) {
      this.logger.debug('Cache hit for discovery config.');
      return cachedConfig;
    }

    this.logger.debug('Cache miss for discovery config.');
    return this.fetchAndCacheConfig();
  }

  /**
   * Fetches the discovery metadata and caches it, ensuring only one fetch occurs at a time.
   *
   * @returns {Promise<ClientMetadata>} A promise that resolves to the discovery configuration.
   */
  private async fetchAndCacheConfig(): Promise<ClientMetadata> {
    if (this.fetchingConfig !== null) {
      this.logger.debug(
        'Fetch in progress. Awaiting existing fetch operation.',
      );
      return this.fetchingConfig;
    }

    this.fetchingConfig = this.fetchDiscoveryMetadata().finally(() => {
      this.fetchingConfig = null;
    });

    return this.fetchingConfig;
  }

  /**
   * Fetches the discovery metadata from the issuer's discovery URL and validates it.
   *
   * @returns {Promise<ClientMetadata>} A promise that resolves to the discovery configuration.
   * @throws {ClientError} Throws an error if the fetch or validation fails.
   */
  private async fetchDiscoveryMetadata(): Promise<ClientMetadata> {
    this.logger.debug('Fetching discovery configuration.', {
      discoveryUrl: this.discoveryUrl,
    });

    try {
      const response = await fetch(this.discoveryUrl);
      const config: ClientMetadata = await response.json();
      this.validateDiscoveryMetadata(config);

      this.cache.set(this.cacheKey, config, this.cacheTtl);
      this.logger.info(
        'Discovery configuration fetched and cached successfully.',
      );
      return config;
    } catch (error) {
      this.logger.error('Failed to fetch discovery configuration.', { error });
      if (error instanceof ClientError) {
        throw error; // Rethrow existing ClientError without wrapping
      }
      throw new ClientError(
        'Unable to fetch discovery configuration',
        'DISCOVERY_ERROR',
        { originalError: error },
      );
    }
  }

  /**
   * Validates the discovery metadata against required fields.
   *
   * @param {ClientMetadata} client - The discovery metadata to validate.
   * @throws {ClientError} Throws an error if any required field is missing or invalid.
   */
  private validateDiscoveryMetadata(client: ClientMetadata): void {
    const { issuer, jwks_uri, authorization_endpoint, token_endpoint } = client;

    if (!issuer || typeof issuer !== 'string') {
      throw new ClientError(
        'Invalid discovery configuration: Missing or invalid issuer.',
        'INVALID_DISCOVERY_CONFIG',
      );
    }

    if (!jwks_uri || typeof jwks_uri !== 'string') {
      throw new ClientError(
        'Invalid discovery configuration: Missing or invalid jwks_uri.',
        'INVALID_DISCOVERY_CONFIG',
      );
    }

    if (!authorization_endpoint || typeof authorization_endpoint !== 'string') {
      throw new ClientError(
        'Invalid discovery configuration: Missing or invalid authorization_endpoint.',
        'INVALID_DISCOVERY_CONFIG',
      );
    }

    if (!token_endpoint || typeof token_endpoint !== 'string') {
      throw new ClientError(
        'Invalid discovery configuration: Missing or invalid token_endpoint.',
        'INVALID_DISCOVERY_CONFIG',
      );
    }
  }
}
