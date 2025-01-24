// src/decorators/oidcCallback.test.ts

import { OidcCallback } from './oidcCallback';
import { Client } from '../classes/Client';
import { IClientConfig, IRequest, IResponse } from '../interfaces';
import { StatusCode, StorageMechanism } from '../enums';
import { Request, Response } from '../classes';
import { IncomingMessage, ServerResponse } from 'http';

/**
 * Creates a mocked ServerResponse with jest.fn() for methods.
 */
export const createMockServerResponse = () => {
  const mockSetHeader = jest.fn();
  const mockGetHeader = jest.fn();
  const mockRemoveHeader = jest.fn();
  const mockEnd = jest.fn();
  const mockWriteHead = jest.fn();

  const mockRes: Partial<ServerResponse> = {
    setHeader: mockSetHeader,
    getHeader: mockGetHeader,
    removeHeader: mockRemoveHeader,
    end: mockEnd,
    writeHead: mockWriteHead,
    headersSent: false,
    statusCode: StatusCode.OK,
  };

  return {
    mockRes,
    mockSetHeader,
    mockGetHeader,
    mockRemoveHeader,
    mockEnd,
    mockWriteHead,
  };
};

// Dummy class to apply the decorator
class DummyController {
  client: Client;

  constructor(client: Client) {
    this.client = client;
  }

  @OidcCallback({ postLoginRedirectUri: 'http://example.com/redirect' })
  async handleCallback(req: IRequest, res: IResponse) {
    // Original method logic can be empty or perform additional actions if needed
  }
}

describe('OidcCallback Decorator', () => {
  let mockClient: jest.Mocked<Client>;
  let mockRequest: IRequest;
  let mockResponse: IResponse;
  let dummyController: DummyController;
  let originalConsoleError: typeof console.error;
  let response: IResponse;
  let mockRes: Partial<ServerResponse>;
  let mockSetHeader: jest.Mock;
  let mockGetHeader: jest.Mock;
  let mockRemoveHeader: jest.Mock;
  let mockEnd: jest.Mock;
  let mockWriteHead: jest.Mock;

  beforeEach(() => {
    // Mock console.error to prevent actual logging during tests
    originalConsoleError = console.error;
    console.error = jest.fn();

    // Create a mocked ServerResponse
    const mocks = createMockServerResponse();
    mockRes = mocks.mockRes;
    mockSetHeader = mocks.mockSetHeader;
    mockGetHeader = mocks.mockGetHeader;
    mockRemoveHeader = mocks.mockRemoveHeader;
    mockEnd = mocks.mockEnd;
    mockWriteHead = mocks.mockWriteHead;

    // Instantiate Response with the mocked ServerResponse
    response = new Response(mockRes as unknown as IncomingMessage);

    mockResponse = response;

    // Mock the Client methods used in oidcCallback
    mockClient = {
      getConfig: jest.fn(),
      handleRedirect: jest.fn(),
      getUserInfo: jest.fn(),
    } as unknown as jest.Mocked<Client>;

    // Initialize the dummy controller with the mocked client
    dummyController = new DummyController(mockClient);

    // Default implementation for getConfig (session enabled)
    mockClient.getConfig.mockReturnValue({
      clientId: 'dummy-client-id',
      redirectUri: '/',
      scopes: [],
      discoveryUrl: 'http://dummy',
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
  });

  it('should redirect to the postLoginRedirectUri after successful authentication with session enabled', async () => {
    // Arrange
    const authorizationCode = 'authCode123';
    const state = 'state123';
    const userInfo = { sub: 'user123', name: 'John Doe' };

    // Initialize mockRequest with query parameters and other properties
    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state }) // Set query parameters
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });

    // Initialize mockResponse and spy on its redirect method

    const redirectSpy = jest.spyOn(mockResponse, 'redirect');

    // Initialize session on the request
    const currentSession = {
      state: { [state]: { codeVerifier: 'codeVerifier123' } },
      user: undefined,
    };
    mockRequest.setSession(currentSession);

    // Spy on setSession to track updates to the session
    const setSessionSpy = jest
      .spyOn(mockRequest, 'setSession')
      .mockImplementation((newSession) => {
        // Merge new session data into currentSession
        Object.assign(currentSession, newSession);
        return mockRequest;
      });

    // Mock client.handleRedirect and getUserInfo responses
    mockClient.handleRedirect.mockResolvedValue();
    mockClient.getUserInfo.mockResolvedValue(userInfo);

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).toHaveBeenCalled();
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      state,
      { request: mockRequest, response: mockResponse },
    );
    expect(mockClient.getUserInfo).toHaveBeenCalled();

    // Verify the session was updated with the user info
    expect(currentSession.user).toEqual(userInfo);
    expect(setSessionSpy).toHaveBeenCalled(); // Confirm that setSession was invoked

    // Verify redirection
    expect(redirectSpy).toHaveBeenCalledWith('http://example.com/redirect');

    // Cleanup spies
    setSessionSpy.mockRestore();
    redirectSpy.mockRestore();
  });

  it('should redirect to the specified postLoginRedirectUri after successful authentication with session enabled', async () => {
    // Arrange
    const authorizationCode = 'authCode456';
    const state = 'state456';
    const postLoginRedirectUri = '/dashboard';
    const userInfo = { sub: 'user456', name: 'Jane Smith' };

    // Initialize mockRequest with query parameters and other properties
    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });

    // Initialize mockResponse and spy on its redirect method

    const redirectSpy = jest.spyOn(mockResponse, 'redirect');

    // Initialize session on the request
    const currentSession = {
      state: { [state]: { codeVerifier: 'codeVerifier456' } },
      user: undefined,
    };
    mockRequest.setSession(currentSession);

    // Spy on setSession to track session updates
    const setSessionSpy = jest
      .spyOn(mockRequest, 'setSession')
      .mockImplementation((newSession) => {
        Object.assign(currentSession, newSession);
        return mockRequest;
      });

    // Mock client.handleRedirect and getUserInfo responses
    mockClient.handleRedirect.mockResolvedValue();
    mockClient.getUserInfo.mockResolvedValue(userInfo);

    // Create a controller with the specified postLoginRedirectUri
    class CustomRedirectController extends DummyController {
      @OidcCallback({ postLoginRedirectUri })
      async handleCallback(req: any, res: any) {}
    }
    dummyController = new CustomRedirectController(mockClient);

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).toHaveBeenCalled();
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      state,
      { request: mockRequest, response: mockResponse },
    );
    expect(mockClient.getUserInfo).toHaveBeenCalled();

    // Verify the session was updated with the user info
    expect(currentSession.user).toEqual(userInfo);
    expect(setSessionSpy).toHaveBeenCalled();

    // Verify redirection to the specified URI
    expect(redirectSpy).toHaveBeenCalledWith(postLoginRedirectUri);

    // Cleanup spies
    setSessionSpy.mockRestore();
    redirectSpy.mockRestore();
  });

  it('should respond with 400 if code and state is missing', async () => {
    // Arrange: Create a new Request without setting query
    //@ts-ignore
    mockRequest = new Request();

    const statusSpy = jest.spyOn(mockResponse, 'status');
    const sendSpy = jest.spyOn(mockResponse, 'send');

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).not.toHaveBeenCalled();
    expect(mockClient.handleRedirect).not.toHaveBeenCalled();
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(statusSpy).toHaveBeenCalledWith(StatusCode.BAD_REQUEST);
    expect(sendSpy).toHaveBeenCalledWith(
      'Invalid callback parameters: Missing code or state.',
    );

    // Cleanup spies
    statusSpy.mockRestore();
    sendSpy.mockRestore();
  });

  it('should redirect to the postLoginRedirectUri after successful authentication with session disabled', async () => {
    // Arrange
    const authorizationCode = 'authCode789';
    const state = 'state789';
    const postLoginRedirectUri = '/home';
    const userInfo = { sub: 'user789', name: 'Alice Johnson' };

    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });

    // Disable session by returning an empty config (session undefined)
    mockClient.getConfig.mockReturnValue({} as IClientConfig);

    class StatelessController extends DummyController {
      @OidcCallback({ postLoginRedirectUri })
      async handleCallback(req: any, res: any) {}
    }
    dummyController = new StatelessController(mockClient);

    const redirectSpy = jest.spyOn(mockResponse, 'redirect');

    mockClient.handleRedirect.mockResolvedValue();
    mockClient.getUserInfo.mockResolvedValue(userInfo);

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).toHaveBeenCalledTimes(1);
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      state,
      { request: mockRequest, response: mockResponse },
    );
    expect(mockClient.getUserInfo).toHaveBeenCalledTimes(1);
    // Use optional chaining to safely check user
    expect(mockRequest.session?.user).toBeUndefined();
    expect(redirectSpy).toHaveBeenCalledWith(postLoginRedirectUri);

    // Cleanup
    redirectSpy.mockRestore();
  });

  it('should respond with 400 if code is missing', async () => {
    // Arrange
    const state = 'stateMissingCode';
    //@ts-ignore
    mockRequest = new Request(); // create a new Request

    // Create spies on status and send
    const statusSpy = jest
      .spyOn(mockResponse, 'status')
      .mockReturnValue(mockResponse);
    const sendSpy = jest
      .spyOn(mockResponse, 'send')
      .mockReturnValue(mockResponse);

    mockRequest.setQuery({ state });

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).not.toHaveBeenCalled();
    expect(mockClient.handleRedirect).not.toHaveBeenCalled();
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(statusSpy).toHaveBeenCalledWith(StatusCode.BAD_REQUEST);
    expect(sendSpy).toHaveBeenCalledWith(
      'Invalid callback parameters: Missing code or state.',
    );

    // Cleanup spies
    statusSpy.mockRestore();
    sendSpy.mockRestore();
  });

  it('should respond with 400 if state is missing', async () => {
    // Arrange
    const authorizationCode = 'authCodeMissingState';
    //@ts-ignore
    mockRequest = new Request(); // create a new Request

    // Create spies on status and send
    const statusSpy = jest
      .spyOn(mockResponse, 'status')
      .mockReturnValue(mockResponse);
    const sendSpy = jest
      .spyOn(mockResponse, 'send')
      .mockReturnValue(mockResponse);

    mockRequest.setQuery({ code: authorizationCode });

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).not.toHaveBeenCalled();
    expect(mockClient.handleRedirect).not.toHaveBeenCalled();
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(statusSpy).toHaveBeenCalledWith(StatusCode.BAD_REQUEST);
    expect(sendSpy).toHaveBeenCalledWith(
      'Invalid callback parameters: Missing code or state.',
    );

    // Cleanup spies
    statusSpy.mockRestore();
    sendSpy.mockRestore();
  });

  it('should respond with 500 if state does not match the stored state in session', async () => {
    // Arrange
    const authorizationCode = 'authCodeStateMismatch';
    const receivedState = 'receivedState';
    const storedState = 'storedState';
    const error = new Error('State mismatch');

    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state: receivedState })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });

    // Initialize response and spies if needed

    const statusSpy = jest
      .spyOn(mockResponse, 'status')
      .mockReturnValue(mockResponse);
    const sendSpy = jest
      .spyOn(mockResponse, 'send')
      .mockReturnValue(mockResponse);

    // Initialize session and its state
    if (!mockRequest.session) {
      mockRequest.setSession({ state: {}, user: undefined });
    }
    mockRequest.session.state[storedState] = {
      codeVerifier: 'codeVerifierMismatch',
    };

    // Simulate handleRedirect throwing an error
    mockClient.handleRedirect.mockImplementation(() => {
      throw error;
    });

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      receivedState,
      { request: mockRequest, response: mockResponse },
    );
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(statusSpy).toHaveBeenCalledWith(StatusCode.INTERNAL_SERVER_ERROR);
    expect(sendSpy).toHaveBeenCalledWith('Authentication failed');

    // Cleanup spies
    statusSpy.mockRestore();
    sendSpy.mockRestore();
  });

  it('should respond with 500 if codeVerifier is missing from session when session is enabled', async () => {
    // Arrange
    const authorizationCode = 'authCodeMissingVerifier';
    const state = 'stateMissingVerifier';
    const error = new Error('Code verifier missing');

    // Set up request query parameters
    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state }) // Merge query parameters
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });
    // Before setting up session data without codeVerifier
    if (!mockRequest.session) {
      mockRequest.setSession({ state: {}, user: undefined });
    }
    mockRequest.session.state[state] = {}; // Missing codeVerifier

    // Mock handleRedirect to throw an error due to missing codeVerifier
    mockClient.handleRedirect.mockImplementation((code, state, context) => {
      if (!context.request.session.state[state]?.codeVerifier) {
        throw error;
      }
      return Promise.resolve();
    });

    const statusSpy = jest
      .spyOn(mockResponse, 'status')
      .mockReturnValue(mockResponse);
    const sendSpy = jest
      .spyOn(mockResponse, 'send')
      .mockReturnValue(mockResponse);

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).toHaveBeenCalledTimes(1);
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      state,
      { request: mockRequest, response: mockResponse },
    );
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(statusSpy).toHaveBeenCalledWith(StatusCode.INTERNAL_SERVER_ERROR);
    expect(sendSpy).toHaveBeenCalledWith('Authentication failed');

    // Cleanup spies
    statusSpy.mockRestore();
    sendSpy.mockRestore();
  });

  it('should call the custom onError handler when handleRedirect throws an error with session enabled', async () => {
    // Arrange
    const authorizationCode = 'authCodeHandleRedirectError';
    const state = 'stateHandleRedirectError';
    const error = new Error('handleRedirect failed');

    // Set up request query parameters
    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state }) // Merge query parameters
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });

    if (!mockRequest.session) {
      mockRequest.setSession({ state: {}, user: undefined });
    }
    mockRequest.session.state[state] = {
      codeVerifier: 'codeVerifierHandleRedirectError',
    };

    // Mock handleRedirect to throw an error
    mockClient.handleRedirect.mockRejectedValue(error);

    // Define the onError mock
    const onErrorMock = jest.fn();

    // Re-define the dummy controller with onError option
    class CustomErrorController extends DummyController {
      @OidcCallback({ onError: onErrorMock })
      async handleCallback(req: any, res: any) {}
    }

    dummyController = new CustomErrorController(mockClient);

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).toHaveBeenCalledTimes(1); // Only decorator's getConfig
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      state,
      { request: mockRequest, response: mockResponse },
    );
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(console.error).toHaveBeenCalledWith('OIDC Callback Error:', error);
    expect(onErrorMock).toHaveBeenCalledTimes(1);
    expect(onErrorMock).toHaveBeenCalledWith(error, {
      request: mockRequest,
      response: mockResponse,
    });
  });

  it('should send a 500 response when handleRedirect throws an error and no onError handler is provided', async () => {
    // Arrange
    const authorizationCode = 'authCodeHandleRedirect500';
    const state = 'stateHandleRedirect500';
    const error = new Error('handleRedirect failed');

    // Set up request query parameters
    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state }) // Merge query parameters
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });
    // Set up session data
    if (!mockRequest.session) {
      mockRequest.setSession({ state: {}, user: undefined });
    }
    mockRequest.session.state[state] = {
      codeVerifier: 'codeVerifierHandleRedirect500',
    };

    // Mock handleRedirect to throw an error
    mockClient.handleRedirect.mockRejectedValue(error);
    const statusSpy = jest
      .spyOn(mockResponse, 'status')
      .mockReturnValue(mockResponse);
    const sendSpy = jest
      .spyOn(mockResponse, 'send')
      .mockReturnValue(mockResponse);

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).toHaveBeenCalledTimes(1); // Only decorator's getConfig
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      state,
      { request: mockRequest, response: mockResponse },
    );
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(console.error).toHaveBeenCalledWith('OIDC Callback Error:', error);
    expect(mockResponse.status).toHaveBeenCalledWith(
      StatusCode.INTERNAL_SERVER_ERROR,
    );
    expect(mockResponse.send).toHaveBeenCalledWith('Authentication failed');
  });

  it('should call the custom onError handler when getUserInfo throws an error with session enabled', async () => {
    // Arrange
    const authorizationCode = 'authCodeUserInfoError';
    const state = 'stateUserInfoError';
    const error = new Error('getUserInfo failed');

    // Set up request query parameters
    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state }) // Merge query parameters
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });

    if (!mockRequest.session) {
      mockRequest.setSession({ state: {}, user: undefined });
    }
    mockRequest.session.state[state] = {
      codeVerifier: 'codeVerifierUserInfoError',
    };

    // Mock handleRedirect to resolve successfully
    mockClient.handleRedirect.mockResolvedValue();

    // Mock getUserInfo to throw an error
    mockClient.getUserInfo.mockRejectedValue(error);

    // Ensure getConfig is called twice
    mockClient.getConfig
      .mockReturnValueOnce({
        clientId: 'dummy',
        redirectUri: '/',
        scopes: [],
        discoveryUrl: 'http://dummy',
        session: {
          mechanism: StorageMechanism.MEMORY,
          options: {},
        },
      } as IClientConfig)
      .mockReturnValueOnce({
        clientId: 'dummy',
        redirectUri: '/',
        scopes: [],
        discoveryUrl: 'http://dummy',
        session: {
          mechanism: StorageMechanism.MEMORY,
          options: {},
        },
      } as IClientConfig);

    // Define the onError mock
    const onErrorMock = jest.fn();

    // Re-define the dummy controller with onError option
    class CustomErrorController2 extends DummyController {
      @OidcCallback({ onError: onErrorMock })
      async handleCallback(req: any, res: any) {}
    }

    dummyController = new CustomErrorController2(mockClient);

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).toHaveBeenCalledTimes(1); // Decorator and processSessionFlow
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      state,
      { request: mockRequest, response: mockResponse },
    );
    expect(mockClient.getUserInfo).toHaveBeenCalledTimes(1);
    expect(mockRequest.session.user).toBeUndefined(); // user not set due to error
    expect(console.error).toHaveBeenCalledWith('OIDC Callback Error:', error);
    expect(onErrorMock).toHaveBeenCalledTimes(1);
    expect(onErrorMock).toHaveBeenCalledWith(error, {
      request: mockRequest,
      response: mockResponse,
    });
  });

  it('should send a 500 response when getUserInfo throws an error and no onError handler is provided', async () => {
    // Arrange
    const authorizationCode = 'authCodeUserInfo500';
    const state = 'stateUserInfo500';
    const error = new Error('getUserInfo failed');

    // Set up request query parameters
    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state }) // Merge query parameters
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });

    if (!mockRequest.session) {
      mockRequest.setSession({ state: {}, user: undefined });
    }
    mockRequest.session.state[state] = {
      codeVerifier: 'codeVerifierUserInfo500',
    };

    // Mock handleRedirect to resolve successfully
    mockClient.handleRedirect.mockResolvedValue();

    // Mock getUserInfo to throw an error
    mockClient.getUserInfo.mockRejectedValue(error);

    // Ensure getConfig is called twice
    mockClient.getConfig
      .mockReturnValueOnce({
        clientId: 'dummy',
        redirectUri: '/',
        scopes: [],
        discoveryUrl: 'http://dummy',
        session: {
          mechanism: StorageMechanism.MEMORY,
          options: {},
        },
      } as IClientConfig)
      .mockReturnValueOnce({
        clientId: 'dummy',
        redirectUri: '/',
        scopes: [],
        discoveryUrl: 'http://dummy',
        session: {
          mechanism: StorageMechanism.MEMORY,
          options: {},
        },
      } as IClientConfig);

    // Add spies for status and send before invoking the handler
    const statusSpy = jest
      .spyOn(mockResponse, 'status')
      .mockReturnValue(mockResponse);
    const sendSpy = jest
      .spyOn(mockResponse, 'send')
      .mockReturnValue(mockResponse);

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).toHaveBeenCalledTimes(1);
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      state,
      { request: mockRequest, response: mockResponse },
    );
    expect(mockClient.getUserInfo).toHaveBeenCalledTimes(1);
    expect(mockRequest.session.user).toBeUndefined(); // user not set due to error
    expect(console.error).toHaveBeenCalledWith('OIDC Callback Error:', error);
    expect(statusSpy).toHaveBeenCalledWith(StatusCode.INTERNAL_SERVER_ERROR);
    expect(sendSpy).toHaveBeenCalledWith('Authentication failed');

    statusSpy.mockRestore();
    sendSpy.mockRestore();
  });

  it('should respond with 400 if request is missing', async () => {
    // Arrange

    const statusSpy = jest
      .spyOn(mockResponse, 'status')
      .mockReturnValue(mockResponse);
    const sendSpy = jest
      .spyOn(mockResponse, 'send')
      .mockReturnValue(mockResponse);

    // Act
    await dummyController.handleCallback(undefined, mockResponse);

    // Assert
    expect(mockClient.getConfig).not.toHaveBeenCalled();
    expect(mockClient.handleRedirect).not.toHaveBeenCalled();
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(statusSpy).toHaveBeenCalledWith(StatusCode.BAD_REQUEST);
    expect(sendSpy).toHaveBeenCalledWith(
      'Invalid callback parameters: Missing request or response.',
    );

    // Cleanup spies
    statusSpy.mockRestore();
    sendSpy.mockRestore();
  });

  it('should handle callback without session correctly', async () => {
    // Arrange
    const authorizationCode = 'authCodeNoSession';
    const state = 'stateNoSession';
    const postLoginRedirectUri = '/no-session';
    const userInfo = { sub: 'userNoSession', name: 'No Session User' };

    // Set up request query parameters
    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ code: authorizationCode, state }) // Merge query parameters
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });

    // Disable session by omitting the session property
    mockClient.getConfig.mockReturnValue({
      // session is undefined
    } as IClientConfig);

    // Re-define the dummy controller with postLoginRedirectUri option
    class NoSessionController extends DummyController {
      @OidcCallback({ postLoginRedirectUri })
      async handleCallback(req: any, res: any) {}
    }

    dummyController = new NoSessionController(mockClient);

    // Initialize mockResponse and create a spy for the redirect method

    const redirectSpy = jest.spyOn(mockResponse, 'redirect');

    // Mock client.handleRedirect and getUserInfo
    mockClient.handleRedirect.mockResolvedValue();
    mockClient.getUserInfo.mockResolvedValue(userInfo);

    // Act
    await dummyController.handleCallback(mockRequest, mockResponse);

    // Assert
    expect(mockClient.getConfig).toHaveBeenCalledTimes(1); // Only decorator's getConfig
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      authorizationCode,
      state,
      { request: mockRequest, response: mockResponse }, // Updated parameters
    );
    expect(mockClient.getUserInfo).toHaveBeenCalledTimes(1);
    expect(mockRequest.session?.user).toBeUndefined(); // user not set since session is disabled
    expect(mockResponse.redirect).toHaveBeenCalledWith(postLoginRedirectUri);
    expect(redirectSpy).toHaveBeenCalledWith(postLoginRedirectUri);
  });
});
