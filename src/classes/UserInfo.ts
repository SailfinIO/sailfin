/**
 * @fileoverview
 * Implements the `UserInfo` class, which fetches user information from an OIDC
 * UserInfo endpoint using an access token. This class handles error scenarios,
 * logging, and parsing responses from the UserInfo endpoint.
 *
 * @module src/classes/UserInfo
 */

import {
  IUserInfo,
  IUser,
  ILogger,
  IToken,
  ClientMetadata,
} from '../interfaces';
import { ClientError } from '../errors/ClientError';

/**
 * Represents a service for fetching user information from the UserInfo endpoint.
 *
 * The `UserInfo` class interacts with the OIDC UserInfo endpoint to retrieve user
 * details using a valid access token provided by the token client.
 *
 * @class
 * @implements {IUserInfo}
 */
export class UserInfo implements IUserInfo {
  private readonly tokenClient: IToken;
  private readonly client: ClientMetadata;
  private readonly logger: ILogger;

  /**
   * Creates an instance of `UserInfo`.
   *
   * @param {IToken} tokenClient - The token client for retrieving access tokens.
   * @param {ClientMetadata} client - The discovery metadata containing the UserInfo endpoint.
   * @param {ILogger} logger - Logger instance for logging operations and errors.
   */
  constructor(tokenClient: IToken, client: ClientMetadata, logger: ILogger) {
    this.tokenClient = tokenClient;
    this.client = client;
    this.logger = logger;
  }

  /**
   * Retrieves user information from the UserInfo endpoint.
   *
   * @returns {Promise<IUser>} A promise that resolves to the user information.
   * @throws {ClientError} Throws an error if no valid access token is available
   * or if the request to the UserInfo endpoint fails.
   */
  public async getUserInfo(): Promise<IUser> {
    // Retrieve the access token from the token client
    const accessToken = await this.tokenClient.getAccessToken();
    if (!accessToken) {
      this.logger.warn(
        'No valid access token available when fetching user info',
      );
      throw new ClientError(
        'No valid access token available',
        'NO_ACCESS_TOKEN',
      );
    }

    // Retrieve the UserInfo endpoint from the discovery metadata
    const userInfoEndpoint = this.client.userinfo_endpoint;
    const headers = {
      Authorization: `Bearer ${accessToken}`,
    };

    this.logger.debug('Fetching user info from endpoint', { userInfoEndpoint });

    try {
      // Make the HTTP GET request to the UserInfo endpoint
      const response = await fetch(userInfoEndpoint, {
        method: 'GET',
        headers,
      });

      let userInfo: IUser;

      // Parse the JSON response
      try {
        userInfo = await response.json();
      } catch (parseError) {
        this.logger.error('Invalid JSON response from user info endpoint', {
          error: parseError,
        });
        throw new ClientError(
          'Invalid JSON response from user info endpoint',
          'INVALID_JSON',
          {
            originalError: parseError,
          },
        );
      }

      this.logger.debug('Fetched user info successfully', { userInfo });
      return userInfo;
    } catch (error: any) {
      // Handle any errors that occur during the fetch operation
      if (error instanceof ClientError) {
        throw error; // Re-throw existing ClientErrors
      }
      this.logger.error('Failed to fetch user info', { error });
      throw new ClientError('Failed to fetch user info', 'HTTP_GET_ERROR', {
        originalError: error,
      });
    }
  }
}
