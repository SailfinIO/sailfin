// src/classes/Session.test.ts

import { Session } from './Session';
import {
  IClientConfig,
  ILogger,
  IToken,
  ISession,
  IUserInfo,
  ISessionData,
  ISessionStore,
  IResponse,
  IRequest,
  IStoreContext,
} from '../interfaces';
import { SessionMode, StatusCode } from '../enums';
import { Request } from './Request';
import { Response } from './Response';
import { IncomingMessage, ServerResponse } from 'http';

jest.useFakeTimers();
jest.spyOn(global, 'setTimeout');
jest.spyOn(global, 'clearTimeout');

const createMockServerResponse = () => {
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

describe('Session', () => {
  let config: Partial<IClientConfig>;
  let logger: ILogger;
  let tokenClient: IToken;
  let userInfoClient: IUserInfo;
  let sessionStore: ISessionStore;
  let session: ISession;
  let mockRequest: IRequest;
  let mockResponse: IResponse;
  let response: IResponse;
  let mockRes: Partial<ServerResponse>;
  let mockSetHeader: jest.Mock;
  let mockGetHeader: jest.Mock;
  let mockRemoveHeader: jest.Mock;
  let mockEnd: jest.Mock;
  let mockWriteHead: jest.Mock;

  beforeEach(() => {
    const mocks = createMockServerResponse();
    mockRes = mocks.mockRes;
    mockSetHeader = mocks.mockSetHeader;
    mockGetHeader = mocks.mockGetHeader;
    mockRemoveHeader = mocks.mockRemoveHeader;
    mockEnd = mocks.mockEnd;
    mockWriteHead = mocks.mockWriteHead;

    // Instantiate Response with the mocked ServerResponse
    response = new Response(mockRes as unknown as IncomingMessage);
    config = {
      session: {
        useSilentRenew: true,
      },
      tokenRefreshThreshold: 60, // in seconds
    };
    logger = {
      debug: jest.fn(),
      error: jest.fn(),
      info: jest.fn(),
      warn: jest.fn(),
      setLogLevel: jest.fn(),
    };
    tokenClient = {
      getAccessToken: jest.fn(),
      getTokens: jest.fn(),
      refreshAccessToken: jest.fn(),
      setTokens: jest.fn(),
      clearTokens: jest.fn(),
      introspectToken: jest.fn(),
      revokeToken: jest.fn(),
      exchangeCodeForToken: jest.fn(),
      getClaims: jest.fn(),
    };
    // Mock IUserInfo
    userInfoClient = {
      getUserInfo: jest.fn(),
    };
    // Mock IStore
    sessionStore = {
      get: jest.fn(),
      set: jest.fn(),
      touch: jest.fn(),
      destroy: jest.fn(),
    };
    // Instantiate Session with mocks
    session = new Session(
      config as IClientConfig,
      logger,
      tokenClient,
      userInfoClient,
      sessionStore,
    );
    //@ts-ignore
    mockRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: 'sid=mock-sid',
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ key: 'value' })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock-sid' });

    mockResponse = response;
  });

  afterEach(() => {
    jest.clearAllTimers();
    jest.clearAllMocks();
  });

  describe('start', () => {
    it('should schedule token refresh if useSilentRenew is true and existing session exists', async () => {
      // Arrange
      const mockSessionData: ISessionData = {
        cookie: {
          access_token: 'access-token',
          token_type: 'Bearer',
          expires_in: 120, // in seconds
        },
        user: { sub: 'user123' },
      };
      // Mock store.get to return existing session data
      (sessionStore.get as jest.Mock).mockResolvedValue(mockSessionData);

      // Mock tokenClient.getTokens to return tokens
      (tokenClient.getTokens as jest.Mock).mockReturnValue(
        mockSessionData.cookie,
      );

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);

      // Assert
      expect(sessionStore.get).toHaveBeenCalledWith('mock-sid', context);
      expect(logger.debug).toHaveBeenCalledWith('Server-side session resumed', {
        // Updated line
        sid: 'mock-sid',
      });
      expect(setTimeout).toHaveBeenCalledWith(expect.any(Function), 60000); // (120 - 60) * 1000
      expect(logger.debug).toHaveBeenCalledWith('Scheduled token refresh in', {
        refreshTime: 60000,
      });
    });

    it('should create a new session if no existing session exists', async () => {
      // Arrange
      const mockTokens = {
        access_token: 'new-access-token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };
      const mockUser: any = { sub: 'user456', name: 'Jane Doe' };

      // Mock sessionStore.get to return null, indicating no existing session
      (sessionStore.get as jest.Mock).mockResolvedValue(null);

      // Mock tokenClient.getTokens to return tokens
      (tokenClient.getTokens as jest.Mock).mockReturnValue(mockTokens);

      // Mock userInfoClient.getUserInfo to return user info
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue(mockUser);

      // Mock sessionStore.set to return a new sid
      (sessionStore.set as jest.Mock).mockResolvedValue('new-mock-sid');

      // Mock request and response objects with empty cookie
      //@ts-ignore
      const mockRequest = new Request()
        .setUrl('http://localhost')
        .setHeaders({
          cookie: '',
        })
        .setMethod('GET')
        .setQuery({ key: 'value' })
        .setParams({ id: '123' })
        .setBody({ example: 'body' })
        .setIp('127.0.0.1')
        .setIps(['127.0.0.1'])
        .setCookies({ sid: 'mock-sid' });

      // Optionally, mock the append method if needed
      mockResponse.setHeader = jest.fn();

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);

      // Assert
      expect(sessionStore.get).not.toHaveBeenCalled(); // No existing session
      expect(sessionStore.set).toHaveBeenCalledWith(
        {
          cookie: mockTokens,
          user: mockUser,
          csrfToken: expect.any(String),
        },
        context,
      );
      expect(logger.debug).toHaveBeenCalledWith(
        'New server-side session created',
        {
          sid: 'new-mock-sid',
        },
      );
      expect(setTimeout).toHaveBeenCalledWith(expect.any(Function), 60000); // (120 - 60) * 1000
      expect(logger.debug).toHaveBeenCalledWith('Scheduled token refresh in', {
        refreshTime: 60000,
      });
    });

    it('should throw an error if no tokens are available to create a session', async () => {
      // Arrange
      // Mock sessionStore.get to return null, indicating no existing session
      (sessionStore.get as jest.Mock).mockResolvedValue(null);

      // Mock tokenClient.getTokens to return null
      (tokenClient.getTokens as jest.Mock).mockReturnValue(null);

      // Mock request and response objects
      //@ts-ignore
      const mockRequest = new Request()
        .setUrl('http://localhost')
        .setHeaders({
          cookie: '',
        })
        .setMethod('GET')
        .setQuery({ key: 'value' })
        .setParams({ id: '123' })
        .setBody({ example: 'body' })
        .setIp('127.0.0.1')
        .setIps(['127.0.0.1'])
        .setCookies({ sid: 'mock-sid' });

      const context = { request: mockRequest, response: mockResponse };

      // Act & Assert
      await expect(session.start(context)).rejects.toThrow(
        'No tokens available to create a session.',
      );
      expect(logger.error).not.toHaveBeenCalled();
    });

    it('should handle failure to fetch user info gracefully', async () => {
      // Arrange
      const mockTokens = {
        access_token: 'new-access-token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };

      // Mock sessionStore.get to return null, indicating no existing session
      (sessionStore.get as jest.Mock).mockResolvedValue(null);

      // Mock tokenClient.getTokens to return tokens
      (tokenClient.getTokens as jest.Mock).mockReturnValue(mockTokens);

      // Mock userInfoClient.getUserInfo to throw an error
      const userInfoError = new Error('Failed to fetch user info');
      (userInfoClient.getUserInfo as jest.Mock).mockRejectedValue(
        userInfoError,
      );

      // Mock sessionStore.set to return a new sid
      (sessionStore.set as jest.Mock).mockResolvedValue('new-mock-sid');

      // Mock request and response objects
      //@ts-ignore
      const mockRequest = new Request()
        .setUrl('http://localhost')
        .setHeaders({
          cookie: '',
        })
        .setMethod('GET')
        .setQuery({ key: 'value' })
        .setParams({ id: '123' })
        .setBody({ example: 'body' })
        .setIp('127.0.0.1')
        .setIps(['127.0.0.1'])
        .setCookies({ sid: 'mock-sid' });

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);

      // Assert
      expect(sessionStore.set).toHaveBeenCalledWith(
        {
          cookie: mockTokens,
          user: undefined,
          csrfToken: expect.any(String),
        },
        context,
      );
      expect(logger.warn).toHaveBeenCalledWith(
        'Failed to fetch user info during session creation',
        { error: userInfoError },
      );
      expect(logger.debug).toHaveBeenCalledWith(
        'New server-side session created',
        {
          sid: 'new-mock-sid',
        },
      );
      expect(setTimeout).toHaveBeenCalledWith(expect.any(Function), 60000); // (120 - 60) * 1000
    });

    it('should throw an error if request is missing in context', async () => {
      // Arrange

      const context = { request: undefined, response: mockResponse };

      // Act & Assert
      await expect(session.start(context)).rejects.toThrow(
        'Both Request and Response objects are required to start a session.',
      );
    });

    it('should throw an error if response is missing in context', async () => {
      // Arrange

      const context = { request: mockRequest, response: undefined };

      // Act & Assert
      await expect(session.start(context)).rejects.toThrow(
        'Both Request and Response objects are required to start a session.',
      );
    });
  });

  describe('stop', () => {
    it('should clear the session timer if it exists and reset sid', async () => {
      // Arrange
      const mockTokens = {
        access_token: 'token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };
      const mockUser: any = { sub: 'user123' };

      const mockSessionData: ISessionData = {
        cookie: mockTokens,
        user: mockUser,
      };

      // Mock sessionStore.get to return existing session data
      (sessionStore.get as jest.Mock).mockResolvedValue(mockSessionData);

      // Mock tokenClient.getTokens to return the tokens
      (tokenClient.getTokens as jest.Mock).mockReturnValue(
        mockSessionData.cookie,
      );

      // Mock userInfoClient.getUserInfo to return user info
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue(mockUser);

      // Mock sessionStore.set to return a valid session ID
      (sessionStore.set as jest.Mock).mockResolvedValue('mock-sid');

      // Mock sessionStore.destroy to handle destroying the session
      (sessionStore.destroy as jest.Mock).mockResolvedValue(undefined);

      const context = { request: mockRequest, response: mockResponse };

      // Act: Start the session first
      await session.start(context);

      // Act: Stop the session
      await session.stop(context);

      // Assert: Check that the session timer was cleared and the session was destroyed
      expect(clearTimeout).toHaveBeenCalled();
      expect(logger.debug).toHaveBeenCalledWith('Session timer cleared');
      expect(logger.debug).toHaveBeenCalledWith('Session destroyed', {
        sid: 'mock-sid',
      });
      expect(sessionStore.destroy).toHaveBeenCalledWith('mock-sid', context);
      expect(session.sid).toBeNull();
    });

    it('should do nothing if there is no session timer', () => {
      // Arrange
      const context = { request: mockRequest, response: mockResponse };
      // Act
      session.stop(context);

      // Assert
      expect(clearTimeout).not.toHaveBeenCalled();
      expect(logger.debug).not.toHaveBeenCalledWith('Session timer cleared');
      expect(logger.debug).not.toHaveBeenCalledWith('Session stopped');
    });
  });

  describe('refreshToken', () => {
    it('should successfully refresh the access token and reschedule refresh', async () => {
      // Arrange
      const initialTokens = {
        access_token: 'initial-token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };
      const refreshedTokens = {
        access_token: 'refreshed-token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };
      const mockUser: any = { sub: 'user123', name: 'John Doe' };

      // Mock sessionStore.get to return existing session data
      const mockSessionData: ISessionData = {
        cookie: initialTokens,
        user: mockUser,
      };
      (sessionStore.get as jest.Mock).mockResolvedValue(mockSessionData);

      // Mock tokenClient.getTokens to return initialTokens first, then refreshedTokens
      (tokenClient.getTokens as jest.Mock)
        .mockReturnValueOnce(initialTokens) // First call during start
        .mockReturnValueOnce(refreshedTokens) // Second call during updateSession
        .mockReturnValueOnce(refreshedTokens); // Third call during scheduleTokenRefresh

      // Mock userInfoClient.getUserInfo to return user info
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue(mockUser);

      // Mock sessionStore.set to return a new sid
      (sessionStore.set as jest.Mock).mockResolvedValue('mock-sid');

      // Mock tokenClient.refreshAccessToken to resolve successfully
      (tokenClient.refreshAccessToken as jest.Mock).mockResolvedValue(
        undefined,
      );

      // Mock sessionStore.touch to simulate updating session
      (sessionStore.touch as jest.Mock).mockResolvedValue(undefined);

      // Optionally, mock the append method if needed
      mockResponse.setHeader = jest.fn();

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);
      await (session as any).refreshToken(context);

      // Assert
      expect(tokenClient.refreshAccessToken).toHaveBeenCalled();
      expect(tokenClient.getTokens).toHaveBeenCalledTimes(3); // Updated from 2 to 3
      expect(sessionStore.touch).toHaveBeenCalledWith(
        'mock-sid',
        {
          cookie: refreshedTokens,
          user: mockUser,
        },
        context,
      );
      expect(logger.info).toHaveBeenCalledWith(
        'Access token refreshed successfully',
      );
      expect(setTimeout).toHaveBeenCalledWith(expect.any(Function), 60000); // (120 - 60) * 1000
    });

    it('should handle errors during token refresh and stop the session', async () => {
      // Arrange
      const mockTokens = {
        access_token: 'token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };
      const mockUser: any = { sub: 'user123' };
      const refreshError = new Error('Refresh failed');

      // Mock sessionStore.get to return existing session data
      const mockSessionData: ISessionData = {
        cookie: mockTokens,
        user: mockUser,
      };
      (sessionStore.get as jest.Mock).mockResolvedValue(mockSessionData);

      // Mock tokenClient.getTokens to return tokens
      (tokenClient.getTokens as jest.Mock).mockReturnValue(
        mockSessionData.cookie,
      );

      // Mock userInfoClient.getUserInfo to return user info
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue(mockUser);

      // Mock sessionStore.set to return a new sid
      (sessionStore.set as jest.Mock).mockResolvedValue('mock-sid');

      // Mock tokenClient.refreshAccessToken to reject
      (tokenClient.refreshAccessToken as jest.Mock).mockRejectedValue(
        refreshError,
      );

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);
      await (session as any).refreshToken(context);

      // Assert
      expect(tokenClient.refreshAccessToken).toHaveBeenCalled();
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to refresh access token',
        { error: refreshError },
      );
      expect(clearTimeout).toHaveBeenCalled();
      expect(logger.debug).toHaveBeenCalledWith('Session timer cleared');
      expect(session.sid).toBeNull();
    });
  });

  describe('scheduleTokenRefresh', () => {
    it('should handle successful token retrieval and schedule refresh', async () => {
      // Arrange
      const mockTokens = {
        access_token: 'token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };
      const mockUser: any = { sub: 'user123', name: 'John Doe' };

      // Mock tokenClient.getTokens to return tokens
      (tokenClient.getTokens as jest.Mock).mockReturnValue(mockTokens);

      // Mock userInfoClient.getUserInfo to return user info
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue(mockUser);

      // Mock sessionStore.set to return a new sid
      (sessionStore.set as jest.Mock).mockResolvedValue('mock-sid');

      // Optionally, mock the append method if needed
      mockResponse.append = jest.fn();

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);
      await (session as any).scheduleTokenRefresh(context);

      // Assert
      expect(tokenClient.getTokens).toHaveBeenCalled();
      expect(setTimeout).toHaveBeenCalledWith(expect.any(Function), 60000); // (120 - 60) * 1000
      expect(logger.debug).toHaveBeenCalledWith('Scheduled token refresh in', {
        refreshTime: 60000,
      });
    });

    it('should set a timer to refresh the token at the correct time', async () => {
      // Arrange
      const mockTokens = {
        access_token: 'token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };
      const mockUser = { sub: 'user123', name: 'John Doe' };

      // Mock tokenClient.getTokens to return tokens
      (tokenClient.getTokens as jest.Mock).mockReturnValue(mockTokens);

      // Mock userInfoClient.getUserInfo to return user info
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue(mockUser);

      // Mock sessionStore.set to return a new sid
      (sessionStore.set as jest.Mock).mockResolvedValue('mock-sid');

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);
      await (session as any).scheduleTokenRefresh(context);

      // Assert
      expect(setTimeout).toHaveBeenCalledWith(expect.any(Function), 60000); // (120 - 60) * 1000
      expect(logger.debug).toHaveBeenCalledWith('Scheduled token refresh in', {
        refreshTime: 60000,
      });
    });

    it('should handle token retrieval failure', async () => {
      // Arrange
      const getTokenError = new Error('Get token failed');

      // Mock sessionStore.get to return existing session data
      const mockSessionData: ISessionData = {
        cookie: {
          access_token: 'valid-token',
          token_type: 'Bearer',
          expires_in: 120, // in seconds
        },
        user: { sub: 'user123' },
      };
      (sessionStore.get as jest.Mock).mockResolvedValue(mockSessionData);

      // Mock tokenClient.getTokens
      (tokenClient.getTokens as jest.Mock)
        .mockResolvedValueOnce(mockSessionData.cookie) // Called during scheduleTokenRefresh in start
        .mockRejectedValueOnce(getTokenError); // Called during manual scheduleTokenRefresh

      // Mock userInfoClient.getUserInfo
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue({
        sub: 'user123',
      });

      // Mock sessionStore.set to return a new sid (not used in this path)
      (sessionStore.set as jest.Mock).mockResolvedValue('mock-sid');

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);

      // Reset mock calls after start to isolate manual invocation
      (tokenClient.getTokens as jest.Mock).mockClear();
      jest.spyOn(global, 'setTimeout').mockClear();

      // Now, set getTokens to reject on the next call (during scheduleTokenRefresh)
      (tokenClient.getTokens as jest.Mock).mockRejectedValueOnce(getTokenError);

      // Act again: manually invoke scheduleTokenRefresh
      await (session as any).scheduleTokenRefresh(context);

      // Assert
      expect(tokenClient.getTokens).toHaveBeenCalledTimes(1); // Only the manual call
      expect(tokenClient.getTokens).toHaveBeenCalledWith(); // Optionally, verify parameters
      expect(logger.error).toHaveBeenCalledWith(
        'Failed to schedule token refresh',
        { error: getTokenError },
      );
      expect(setTimeout).not.toHaveBeenCalled(); // Should not schedule refresh due to failure
    });

    it('should not schedule refresh if token is missing', async () => {
      // Arrange
      // Mock tokenClient.getTokens to return valid tokens during start
      // and null during scheduleTokenRefresh
      (tokenClient.getTokens as jest.Mock)
        .mockImplementationOnce(() =>
          Promise.resolve({
            access_token: 'valid-token',
            token_type: 'Bearer',
            expires_in: 120, // in seconds
          }),
        )
        .mockImplementationOnce(() => Promise.resolve(null)); // During scheduleTokenRefresh

      // Mock userInfoClient.getUserInfo to return user info
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue({
        sub: 'user123',
      });

      // Mock sessionStore.set to return a new sid
      (sessionStore.set as jest.Mock).mockResolvedValue('mock-sid');

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);

      // Reset mocks to ignore calls made during start
      jest.clearAllMocks();

      // Act again: manually invoke scheduleTokenRefresh
      await (session as any).scheduleTokenRefresh(context);

      // Assert
      expect(tokenClient.getTokens).toHaveBeenCalledTimes(1); // Only the manual call
      expect(setTimeout).not.toHaveBeenCalled(); // Should not schedule refresh
      expect(logger.debug).not.toHaveBeenCalledWith(
        'Scheduled token refresh in',
        {
          refreshTime: expect.any(Number),
        },
      );
    });

    it('should not schedule refresh if expires_in is missing', async () => {
      // Arrange
      const mockTokens = {
        access_token: 'token',
        token_type: 'Bearer',
        // expires_in is missing
      };
      const mockUser: any = { sub: 'user123', name: 'John Doe' };

      // Mock tokenClient.getTokens to return tokens without expires_in
      (tokenClient.getTokens as jest.Mock).mockReturnValue(mockTokens);

      // Mock userInfoClient.getUserInfo to return user info
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue(mockUser);

      // Mock sessionStore.set to return a new sid
      (sessionStore.set as jest.Mock).mockResolvedValue('mock-sid');

      const context = { request: mockRequest, response: mockResponse };

      // Act
      await session.start(context);
      await (session as any).scheduleTokenRefresh(context);

      // Assert
      expect(tokenClient.getTokens).toHaveBeenCalled();
      expect(setTimeout).not.toHaveBeenCalled();
      expect(logger.debug).not.toHaveBeenCalledWith(
        'Scheduled token refresh in',
        {
          refreshTime: expect.any(Number),
        },
      );
    });
    it('should call refreshToken when the token refresh timer fires', async () => {
      // Arrange
      const mockTokens = {
        access_token: 'access-token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };
      const mockUser: any = { sub: 'user123' };
      const newSid = 'mock-sid';

      // Mock sessionStore.get to return existing session data
      (sessionStore.get as jest.Mock).mockResolvedValue({
        cookie: mockTokens,
        user: mockUser,
      });

      // Mock tokenClient.getTokens to return tokens
      (tokenClient.getTokens as jest.Mock).mockReturnValue(mockTokens);

      // Mock userInfoClient.getUserInfo to return user info
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue(mockUser);

      // Mock sessionStore.set to return a new sid
      (sessionStore.set as jest.Mock).mockResolvedValue(newSid);

      // Spy on the refreshToken method
      const refreshTokenSpy = jest
        .spyOn(session as any, 'refreshToken')
        .mockResolvedValue(undefined);

      const context = { request: mockRequest, response: mockResponse };

      // Act: Start the session
      await session.start(context);

      // Assert that setTimeout was called with the correct refresh time
      expect(setTimeout).toHaveBeenCalledWith(expect.any(Function), 60000); // (120 - 60) * 1000

      // Act: Fast-forward time to trigger the refreshToken
      jest.advanceTimersByTime(60000); // Advance by 60 seconds

      // Wait for any pending promises
      await Promise.resolve();

      // Assert that refreshToken was called
      expect(refreshTokenSpy).toHaveBeenCalledWith(context);

      // Clean up the spy
      refreshTokenSpy.mockRestore();
    });
  });

  describe('updateSession', () => {
    it('should log a warning and return if no tokens are available', async () => {
      // Arrange
      // Set a valid session ID
      (sessionStore.get as jest.Mock).mockResolvedValue({
        cookie: {
          access_token: 'existing-token',
          token_type: 'Bearer',
          expires_in: 120,
        },
        user: { sub: 'user123' },
      });

      // Mock tokenClient.getTokens to return null
      (tokenClient.getTokens as jest.Mock).mockResolvedValue(null);

      // Mock request and response objects
      //@ts-ignore
      const mockRequest = new Request()
        .setUrl('http://localhost')
        .setHeaders({
          cookie: 'sid=mock-sid',
          'content-type': 'application/json',
        })
        .setMethod('GET')
        .setQuery({ key: 'value' })
        .setParams({ id: '123' })
        .setBody({ example: 'body' })
        .setIp('127.0.0.1')
        .setIps(['127.0.0.1'])
        .setCookies({ sid: 'mock-sid' });

      const context = { request: mockRequest, response: mockResponse };

      // Set the session ID manually
      (session as any)._sid = 'mock-sid';

      // Act
      await (session as any).updateSession(context);

      // Assert
      expect(tokenClient.getTokens).toHaveBeenCalled();
      expect(logger.warn).toHaveBeenCalledWith(
        'No tokens available to update the session.',
      );
      expect(sessionStore.touch).not.toHaveBeenCalled();
    });

    it('should log a warning and proceed if fetching user info fails', async () => {
      // Arrange
      const mockTokens = {
        access_token: 'existing-token',
        token_type: 'Bearer',
        expires_in: 120, // in seconds
      };
      const userInfoError = new Error('Failed to fetch user info');

      // Mock sessionStore.get to return existing session data
      (sessionStore.get as jest.Mock).mockResolvedValue({
        cookie: mockTokens,
        user: { sub: 'user123' },
      });

      // Mock tokenClient.getTokens to return tokens
      (tokenClient.getTokens as jest.Mock).mockResolvedValue(mockTokens);

      // Mock userInfoClient.getUserInfo to throw an error
      (userInfoClient.getUserInfo as jest.Mock).mockRejectedValue(
        userInfoError,
      );

      // Mock sessionStore.touch to simulate updating session
      (sessionStore.touch as jest.Mock).mockResolvedValue(undefined);
      // Mock request and response objects
      //@ts-ignore
      const mockRequest = new Request()
        .setUrl('http://localhost')
        .setHeaders({
          cookie: 'sid=mock-sid',
          'content-type': 'application/json',
        })
        .setMethod('GET')
        .setQuery({ key: 'value' })
        .setParams({ id: '123' })
        .setBody({ example: 'body' })
        .setIp('127.0.0.1')
        .setIps(['127.0.0.1'])
        .setCookies({ sid: 'mock-sid' });

      const context = { request: mockRequest, response: mockResponse };

      // Set the session ID manually
      (session as any)._sid = 'mock-sid';

      // Act
      await (session as any).updateSession(context);

      // Assert
      expect(tokenClient.getTokens).toHaveBeenCalled();
      expect(userInfoClient.getUserInfo).toHaveBeenCalled();
      expect(logger.warn).toHaveBeenCalledWith(
        'Failed to fetch user info during session update',
        { error: userInfoError },
      );
      expect(sessionStore.touch).toHaveBeenCalledWith(
        'mock-sid',
        {
          cookie: mockTokens,
          user: undefined, // User info should be undefined due to failure
        },
        context,
      );
    });
  });
  describe('sid setter', () => {
    it('should set sid to a valid string', () => {
      // Arrange
      const newSid = 'valid-sid';

      // Act
      session.sid = newSid;

      // Assert
      expect(logger.debug).toHaveBeenCalledWith('Setting session ID', {
        sid: newSid,
      });
      expect(session.sid).toBe(newSid);
    });

    it('should set sid to null', () => {
      // Arrange
      const newSid = null;

      // Act
      session.sid = newSid;

      // Assert
      expect(logger.debug).toHaveBeenCalledWith('Setting session ID', {
        sid: newSid,
      });
      expect(session.sid).toBe(newSid);
    });

    it('should throw an error when setting sid to a non-string value', () => {
      // Arrange
      const invalidSid = 12345; // Number instead of string

      // Act & Assert
      expect(() => {
        // Type assertion to bypass TypeScript type checking for test purposes
        (session as any).sid = invalidSid;
      }).toThrow('Session ID must be a string or null.');
    });

    it('should throw an error when setting sid to an object', () => {
      // Arrange
      const invalidSid = { id: 'invalid-sid' };

      // Act & Assert
      expect(() => {
        (session as any).sid = invalidSid;
      }).toThrow('Session ID must be a string or null.');
    });
  });

  describe('update', () => {
    let context: IStoreContext;
    let mockRequest: IRequest;
    let mockResponse: IResponse;

    beforeEach(() => {
      // Spy on exposeTokensToClient to verify client-side logic
      jest
        .spyOn(session as any, 'exposeTokensToClient')
        .mockImplementation(() => {});
      context = { request: mockRequest, response: mockResponse };
    });

    it('should log a warning if no tokens are available after refresh', async () => {
      // Arrange: tokenClient.getTokens returns null
      (tokenClient.getTokens as jest.Mock).mockReturnValue(null);

      // Act
      await session.update(context);

      // Assert: warn logged and no further actions taken
      expect(logger.warn).toHaveBeenCalledWith(
        'No tokens available after refresh',
      );
    });

    it('should expose tokens to client when in CLIENT mode', async () => {
      // Arrange
      config.session!.mode = SessionMode.CLIENT;
      const tokens = {
        access_token: 'client-token',
        token_type: 'Bearer',
        expires_in: 3600,
      };
      (tokenClient.getTokens as jest.Mock).mockReturnValue(tokens);
      // Spy on save to ensure it's not called in client mode
      const saveSpy = jest
        .spyOn(session, 'save' as any)
        .mockResolvedValue(undefined);

      // Act
      await session.update(context);

      // Assert
      expect((session as any).exposeTokensToClient).toHaveBeenCalledWith(
        context,
        tokens,
      );
      expect(saveSpy).not.toHaveBeenCalled();
    });

    it('should update session server side in SERVER mode', async () => {
      // Arrange
      config.session!.mode = SessionMode.SERVER;
      const tokens = {
        access_token: 'server-token',
        token_type: 'Bearer',
        expires_in: 3600,
      };
      (tokenClient.getTokens as jest.Mock).mockReturnValue(tokens);
      const saveSpy = jest
        .spyOn(session, 'save' as any)
        .mockResolvedValue(undefined);

      // Act
      await session.update(context);

      // Assert
      expect(saveSpy).toHaveBeenCalledWith(context, tokens);
      // client side exposure should not be called
      expect((session as any).exposeTokensToClient).not.toHaveBeenCalled();
    });

    it('should handle HYBRID mode by both exposing tokens and updating server side', async () => {
      // Arrange
      config.session!.mode = SessionMode.HYBRID;
      const tokens = {
        access_token: 'hybrid-token',
        token_type: 'Bearer',
        expires_in: 3600,
      };
      (tokenClient.getTokens as jest.Mock).mockReturnValue(tokens);
      const saveSpy = jest
        .spyOn(session, 'save' as any)
        .mockResolvedValue(undefined);

      // Act
      await session.update(context);

      // Assert
      expect((session as any).exposeTokensToClient).toHaveBeenCalledWith(
        context,
        tokens,
      );
      expect(saveSpy).toHaveBeenCalledWith(context, tokens);
    });
  });

  describe('save', () => {
    let context: IStoreContext;
    let mockRequest: IRequest;
    let mockResponse: IResponse;

    beforeEach(() => {
      //@ts-ignore
      const mockRequest = new Request()
        .setUrl('http://localhost')
        .setHeaders({
          cookie: 'sid=mock-sid',
          'content-type': 'application/json',
        })
        .setMethod('GET')
        .setQuery({ key: 'value' })
        .setParams({ id: '123' })
        .setBody({ example: 'body' })
        .setIp('127.0.0.1')
        .setIps(['127.0.0.1'])
        .setCookies({ sid: 'mock-sid' });

      context = { request: mockRequest, response: mockResponse };
    });

    it('should create a new session if no sid cookie is present', async () => {
      // Arrange
      //@ts-ignore
      mockRequest = new Request()
        .setUrl('http://localhost')
        .setHeaders({
          cookie: '',
          'content-type': 'application/json',
        })
        .setMethod('GET')
        .setQuery({ key: 'value' })
        .setParams({ id: '123' })
        .setBody({ example: 'body' })
        .setIp('127.0.0.1')
        .setIps(['127.0.0.1'])
        .setCookies({});
      const tokens = {
        access_token: 'new-session-token',
        token_type: 'Bearer',
        expires_in: 3600,
      };
      (tokenClient.getTokens as jest.Mock).mockReturnValue(tokens);
      const createNewServerSessionSpy = jest
        .spyOn(session as any, 'createNewServerSession')
        .mockResolvedValue(undefined);

      // Act
      await session.save(context, tokens);

      // Assert
      expect(createNewServerSessionSpy).toHaveBeenCalledWith(context, tokens);
    });

    it('should create a new session if sessionData is not found for existing sid', async () => {
      // Arrange
      const tokens = {
        access_token: 'token',
        token_type: 'Bearer',
        expires_in: 3600,
      };
      (tokenClient.getTokens as jest.Mock).mockReturnValue(tokens);
      (sessionStore.get as jest.Mock).mockResolvedValue(null);
      const createNewServerSessionSpy = jest
        .spyOn(session as any, 'createNewServerSession')
        .mockResolvedValue(undefined);

      // Act
      await session.save(context, tokens);

      // Assert
      expect(createNewServerSessionSpy).toHaveBeenCalledWith(context, tokens);
    });

    it('should update an existing session with new tokens', async () => {
      // Arrange
      const tokens = {
        access_token: 'updated-token',
        token_type: 'Bearer',
        expires_in: 3600,
      };
      const existingSessionData: ISessionData = {
        cookie: {
          access_token: 'old-token',
          token_type: 'Bearer',
          expires_in: 3600,
        },
        user: { sub: 'user789' },
      };
      (tokenClient.getTokens as jest.Mock).mockReturnValue(tokens);
      (sessionStore.get as jest.Mock).mockResolvedValue(existingSessionData);
      (sessionStore.touch as jest.Mock).mockResolvedValue(undefined);
      const userInfo = { sub: 'user789', name: 'Alice' };
      (userInfoClient.getUserInfo as jest.Mock).mockResolvedValue(userInfo);

      // Act
      await session.save(context, tokens);

      // Assert
      expect(sessionStore.touch).toHaveBeenCalledWith(
        'mock-sid',
        {
          cookie: tokens,
          user: userInfo,
        },
        context,
      );
      expect(logger.debug).toHaveBeenCalledWith(
        'Server-side session updated with new tokens',
        {
          sid: 'mock-sid',
        },
      );
    });
  });
});
