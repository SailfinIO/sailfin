// src/interfaces/IIssuer.ts

import { ClientMetadata } from './ClientMetadata';

/**
 * Interface for Issuer.
 * Defines the contract for fetching and managing discovery configurations.
 */
export interface IIssuer {
  /**
   * Retrieves the discovery configuration from the discovery URL.
   * Utilizes caching to minimize redundant network requests.
   *
   * @param forceRefresh - If true, bypasses the cache and fetches fresh data.
   * @returns A promise that resolves to the issuer's discovery configuration.
   * @throws ClientError if fetching or parsing the configuration fails.
   */
  discover(forceRefresh?: boolean): Promise<ClientMetadata>;
}
