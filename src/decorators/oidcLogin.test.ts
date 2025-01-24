// src/decorators/oidcLogin.test.ts

import { OidcLogin, OidcLoginOptions } from './oidcLogin';
import { Client } from '../classes/Client';
import { IStoreContext, IClientConfig } from '../interfaces';
import { StorageMechanism } from '../enums';
import { MetadataManager } from './MetadataManager';

describe('OidcLogin Decorator', () => {
  let mockClient: jest.Mocked<Client>;
  let mockContext: IStoreContext;
  let mockRequest: any;
  let mockResponse: any;
  let originalConsoleError: typeof console.error;

  // Define a mock class to apply the decorator
  class MockController {
    client: Client;

    constructor(client: Client) {
      this.client = client;
    }

    @OidcLogin()
    async loginHandler(req: any, res: any) {
      // Original method logic (if any)
      // For testing, we can leave this empty or add mock behavior
    }
  }

  beforeEach(() => {
    // Mock console.error to prevent actual logging during tests
    originalConsoleError = console.error;
    console.error = jest.fn();

    // Mock the Client methods used in oidcLogin
    mockClient = {
      getAuthorizationUrl: jest.fn(),
      getConfig: jest.fn(),
    } as unknown as jest.Mocked<Client>;

    // Initialize mock request and response
    mockRequest = {
      // session is no longer manipulated by the decorator
    };

    mockResponse = {
      redirect: jest.fn(),
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
    };

    // Initialize the mock context with request and response
    mockContext = {
      request: mockRequest,
      response: mockResponse,
    };

    // Default implementation for getConfig
    mockClient.getConfig.mockReturnValue({
      clientId: 'dummy-client-id', // minimal required property
      redirectUri: '/', // minimal required property
      scopes: [], // minimal required property
      discoveryUrl: 'http://dummy', // minimal required property
      session: {
        mechanism: StorageMechanism.MEMORY,
        options: {},
      },
    } as IClientConfig);
  });

  afterEach(() => {
    // Restore the original console.error after each test
    console.error = originalConsoleError;
    jest.restoreAllMocks();
    MetadataManager.reset(); // Clear metadata between tests
  });

  /**
   * Helper function to create an instance of the mock controller
   * with the decorated method.
   */
  const createController = (options?: OidcLoginOptions) => {
    // Dynamically create a new class with the decorator applied with options
    class DynamicMockController {
      client: Client;

      constructor(client: Client) {
        this.client = client;
      }

      @OidcLogin(options)
      async loginHandler(req: any, res: any) {
        // Original method logic (if any)
      }
    }

    return new DynamicMockController(mockClient);
  };

  it('should redirect to the authorization URL when session is enabled', async () => {
    // Arrange
    const statusCode = 302;
    const authorizationUrl = 'https://auth.example.com/authorize';

    mockClient.getAuthorizationUrl.mockResolvedValue({
      url: authorizationUrl,
      state: 'randomState123', // Even though decorator doesn't handle it, client returns it
      codeVerifier: 'randomCodeVerifier123',
    });

    const controller = createController();

    // Act
    await controller.loginHandler(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getAuthorizationUrl).toHaveBeenCalledTimes(1);
    expect(mockResponse.redirect).toHaveBeenCalledWith(
      statusCode,
      authorizationUrl,
    );
  });

  it('should redirect to the authorization URL when codeVerifier is null', async () => {
    // Arrange
    const statusCode = 302;
    const authorizationUrl = 'https://auth.example.com/authorize';

    mockClient.getAuthorizationUrl.mockResolvedValue({
      url: authorizationUrl,
      state: 'randomState123',
      codeVerifier: null, // Explicitly set to null
    });

    const controller = createController();

    // Act
    await controller.loginHandler(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getAuthorizationUrl).toHaveBeenCalledTimes(1);
    expect(mockResponse.redirect).toHaveBeenCalledWith(
      statusCode,
      authorizationUrl,
    );
  });

  it('should handle the case when session is not present gracefully', async () => {
    // Arrange
    // Since the decorator no longer manipulates session, we don't need to initialize it
    const statusCode = 302;
    const authorizationUrl = 'https://auth.example.com/authorize';

    mockClient.getAuthorizationUrl.mockResolvedValue({
      url: authorizationUrl,
      state: 'randomState123',
      codeVerifier: 'randomCodeVerifier123',
    });

    const controller = createController();

    // Act
    await controller.loginHandler(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getAuthorizationUrl).toHaveBeenCalledTimes(1);
    expect(mockResponse.redirect).toHaveBeenCalledWith(
      statusCode,
      authorizationUrl,
    );
  });

  it('should redirect to the authorization URL without modifying session when session is disabled', async () => {
    // Arrange
    mockClient.getConfig.mockReturnValue({
      // Omit the session property to disable session
      session: undefined,
    } as IClientConfig);

    const controller = createController();

    // Initialize mockRequest without session
    mockRequest.session = undefined;

    const statusCode = 302;
    const authorizationUrl = 'https://auth.example.com/authorize';

    mockClient.getAuthorizationUrl.mockResolvedValue({
      url: authorizationUrl,
      state: 'randomState123',
      codeVerifier: 'randomCodeVerifier123',
    });

    // Act
    await controller.loginHandler(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getAuthorizationUrl).toHaveBeenCalledTimes(1);
    expect(mockRequest.session).toBeUndefined(); // No session to modify
    expect(mockResponse.redirect).toHaveBeenCalledWith(
      statusCode,
      authorizationUrl,
    );
  });

  it('should call the custom onError handler when getAuthorizationUrl throws an error', async () => {
    // Arrange
    const error = new Error('Authorization URL fetch failed');
    mockClient.getAuthorizationUrl.mockRejectedValue(error);

    const onError = jest.fn();

    const controller = createController({ onError });

    // Act
    await controller.loginHandler(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getAuthorizationUrl).toHaveBeenCalledTimes(1);
    expect(console.error).toHaveBeenCalledWith('OIDC Login Error:', error);
    expect(onError).toHaveBeenCalledWith(error, mockContext);
    expect(mockResponse.status).not.toHaveBeenCalled();
    expect(mockResponse.send).not.toHaveBeenCalled();
  });

  it('should send a 500 response when getAuthorizationUrl throws an error and no onError handler is provided', async () => {
    // Arrange
    const error = new Error('Authorization URL fetch failed');
    mockClient.getAuthorizationUrl.mockRejectedValue(error);

    const controller = createController(); // No onError provided

    // Act
    await controller.loginHandler(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getAuthorizationUrl).toHaveBeenCalledTimes(1);
    expect(console.error).toHaveBeenCalledWith('OIDC Login Error:', error);
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.send).toHaveBeenCalledWith(
      'Authentication initiation failed',
    );
  });

  it('should not set codeVerifier in session if it is not provided (set to null)', async () => {
    // Arrange
    const statusCode = 302;
    const authorizationUrl = 'https://auth.example.com/authorize';

    mockClient.getAuthorizationUrl.mockResolvedValue({
      url: authorizationUrl,
      state: 'randomState123',
      codeVerifier: null, // Explicitly set to null
    });

    const controller = createController();

    // Act
    await controller.loginHandler(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getAuthorizationUrl).toHaveBeenCalledTimes(1);
    // Since decorator doesn't set session, we don't assert on session.state
    expect(mockResponse.redirect).toHaveBeenCalledWith(
      statusCode,
      authorizationUrl,
    );
  });

  it('should attach metadata indicating this method is an OIDC login handler', () => {
    // Arrange
    const controller = createController();
    const metadata = MetadataManager.getMethodMetadata(
      controller.constructor,
      'loginHandler',
    );

    // Assert
    expect(metadata).toBeDefined();
    expect(metadata.isOidcLogin).toBe(true);
  });
});
