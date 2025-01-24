// src/classes/UserInfo.test.ts

import { UserInfo } from './UserInfo';
import {
  IUserInfo,
  IUser,
  ILogger,
  IToken,
  ClientMetadata,
} from '../interfaces';
import { ClientError } from '../errors/ClientError';

// Mock the global fetch function
global.fetch = jest.fn();

describe('UserInfoClient', () => {
  let userInfoClient: IUserInfo;
  let mockTokenClient: jest.Mocked<IToken>;
  let mockDiscoveryConfig: Partial<ClientMetadata>;
  let mockLogger: jest.Mocked<ILogger>;

  const userInfoEndpoint = 'https://example.com/userinfo';
  const sampleUserInfo: IUser = {
    sub: 'user123',
    name: 'John Doe',
    email: 'john.doe@example.com',
    // Add other user info fields as necessary
  };

  beforeEach(() => {
    // Reset all mocks before each test
    jest.resetAllMocks();
    (global.fetch as jest.Mock).mockReset();

    // Mock ILogger
    mockLogger = {
      debug: jest.fn(),
      info: jest.fn(),
      warn: jest.fn(),
      error: jest.fn(),
      setLogLevel: jest.fn(),
    };

    // Mock IToken
    mockTokenClient = {
      getAccessToken: jest.fn(),
      refreshAccessToken: jest.fn(),
      setTokens: jest.fn(),
      getTokens: jest.fn(),
      clearTokens: jest.fn(),
      introspectToken: jest.fn(),
      revokeToken: jest.fn(),
      exchangeCodeForToken: jest.fn(),
      getClaims: jest.fn(),
    };

    // Mock ClientMetadata
    mockDiscoveryConfig = {
      issuer: 'https://example.com/',
      authorization_endpoint: 'https://example.com/oauth2/authorize',
      token_endpoint: 'https://example.com/oauth2/token',
      userinfo_endpoint: userInfoEndpoint,
      jwks_uri: 'https://example.com/.well-known/jwks.json',
      // Add other fields as necessary
    };

    // Instantiate UserInfo without IHttp client
    userInfoClient = new UserInfo(
      mockTokenClient,
      mockDiscoveryConfig as ClientMetadata,
      mockLogger,
    );
  });

  describe('getUserInfo', () => {
    it('should fetch user info successfully when access token is available', async () => {
      // Arrange
      mockTokenClient.getAccessToken.mockResolvedValue('valid-access-token');

      // Mock the fetch response
      (global.fetch as jest.Mock).mockResolvedValueOnce({
        json: jest.fn().mockResolvedValue(sampleUserInfo),
      });

      // Act
      const userInfo = await userInfoClient.getUserInfo();

      // Assert
      expect(mockTokenClient.getAccessToken).toHaveBeenCalledTimes(1);
      expect(global.fetch).toHaveBeenCalledWith(userInfoEndpoint, {
        method: 'GET',
        headers: {
          Authorization: 'Bearer valid-access-token',
        },
      });
      expect(userInfo).toEqual(sampleUserInfo);
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Fetching user info from endpoint',
        {
          userInfoEndpoint,
        },
      );
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Fetched user info successfully',
        {
          userInfo,
        },
      );
    });

    it('should throw ClientError with code "NO_ACCESS_TOKEN" if no access token is available', async () => {
      // Arrange
      mockTokenClient.getAccessToken.mockResolvedValue(null);

      // Act & Assert
      await expect(userInfoClient.getUserInfo()).rejects.toMatchObject({
        message: 'No valid access token available',
        code: 'NO_ACCESS_TOKEN',
      });

      expect(mockTokenClient.getAccessToken).toHaveBeenCalledTimes(1);
      expect(global.fetch).not.toHaveBeenCalled();
      expect(mockLogger.warn).toHaveBeenCalledWith(
        'No valid access token available when fetching user info',
      );
    });

    it('should throw ClientError with code "HTTP_GET_ERROR" if HTTP GET request fails', async () => {
      // Arrange
      mockTokenClient.getAccessToken.mockResolvedValue('valid-access-token');
      const mockError = new Error('Network Error');
      (global.fetch as jest.Mock).mockRejectedValueOnce(mockError);

      // Act & Assert
      await expect(userInfoClient.getUserInfo()).rejects.toMatchObject({
        message: 'Failed to fetch user info',
        code: 'HTTP_GET_ERROR',
      });

      expect(mockTokenClient.getAccessToken).toHaveBeenCalledTimes(1);
      expect(global.fetch).toHaveBeenCalledWith(userInfoEndpoint, {
        method: 'GET',
        headers: {
          Authorization: 'Bearer valid-access-token',
        },
      });
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Fetching user info from endpoint',
        {
          userInfoEndpoint,
        },
      );
      expect(mockLogger.error).toHaveBeenCalledWith(
        'Failed to fetch user info',
        {
          error: mockError,
        },
      );
    });

    it('should throw ClientError with code "INVALID_JSON" if user info response is invalid JSON', async () => {
      // Arrange
      mockTokenClient.getAccessToken.mockResolvedValue('valid-access-token');

      // Mock the fetch response to throw a SyntaxError when json() is called
      (global.fetch as jest.Mock).mockResolvedValueOnce({
        json: jest
          .fn()
          .mockRejectedValue(new SyntaxError('Unexpected token i in JSON')),
      });

      // Act & Assert
      await expect(userInfoClient.getUserInfo()).rejects.toMatchObject({
        message: 'Invalid JSON response from user info endpoint',
        code: 'INVALID_JSON',
      });

      expect(mockTokenClient.getAccessToken).toHaveBeenCalledTimes(1);
      expect(global.fetch).toHaveBeenCalledWith(userInfoEndpoint, {
        method: 'GET',
        headers: {
          Authorization: 'Bearer valid-access-token',
        },
      });
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Fetching user info from endpoint',
        {
          userInfoEndpoint,
        },
      );
      expect(mockLogger.error).toHaveBeenCalledWith(
        'Invalid JSON response from user info endpoint',
        {
          error: expect.any(SyntaxError),
        },
      );
    });
  });
});
