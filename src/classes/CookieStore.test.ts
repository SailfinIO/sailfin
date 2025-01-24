import { CookieStore } from './CookieStore';
import { MemoryStore } from './MemoryStore';
import {
  IStoreContext,
  ISessionData,
  IUser,
  IResponse,
  IRequest,
} from '../interfaces';
import { SameSite, StatusCode } from '../enums';
import { Cookie } from '../utils/Cookie';
import { Request } from './Request';
import { Response } from './Response';
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

describe('CookieStore', () => {
  let cookieStore: CookieStore;
  let context: IStoreContext;
  let mockRequest: IRequest;
  let mockResponse: IResponse;
  let response: IResponse;
  let mockRes: Partial<ServerResponse>;
  let mockSetHeader: jest.Mock;
  let mockGetHeader: jest.Mock;
  let mockRemoveHeader: jest.Mock;
  let mockEnd: jest.Mock;
  let mockWriteHead: jest.Mock;
  const mocks = createMockServerResponse();
  mockRes = mocks.mockRes;
  mockSetHeader = mocks.mockSetHeader;
  mockGetHeader = mocks.mockGetHeader;
  mockRemoveHeader = mocks.mockRemoveHeader;
  mockEnd = mocks.mockEnd;
  mockWriteHead = mocks.mockWriteHead;

  // Instantiate Response with the mocked ServerResponse
  response = new Response(mockRes as unknown as IncomingMessage);

  const mockUser: IUser = { sub: 'user123' };
  const mockCookie = {
    access_token: 'mockAccessToken',
    refresh_token: 'mockRefreshToken',
    expires_in: 3600,
    token_type: 'Bearer',
  };
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

    .setCookies({
      sid: 'mock-sid',
      access_token: 'mockAccessToken',
      refresh_token: 'mockRefreshToken',
      expires_in: '3600',
      token_type: 'Bearer',
    });

  mockResponse = response;

  beforeEach(() => {
    const memoryStore = new MemoryStore();
    cookieStore = new CookieStore(
      'test_sid',
      {
        httpOnly: true,
        secure: false,
        sameSite: SameSite.STRICT,
        path: '/',
        maxAge: 100,
      },
      memoryStore,
    );
    context = { request: mockRequest, response: mockResponse };
  });

  it('should set a new session and return a session ID', async () => {
    // Create spies on the methods you want to inspect
    const cookieSpy = jest.spyOn(mockResponse, 'cookie');

    const data: ISessionData = { cookie: mockCookie, user: mockUser };
    const sid = await cookieStore.set(data, context);

    expect(sid).toBeDefined();
    expect(cookieSpy).toHaveBeenCalledWith(
      'test_sid', // cookie name
      sid, // cookie value
      expect.objectContaining({
        httpOnly: true,
        secure: false, // This should match your cookieOptions in test setup
        sameSite: SameSite.STRICT, // Assuming SameSite.STRICT resolves to 'Strict'
        path: '/',
        maxAge: 100, // from cookieOptions in your test setup
      }),
    );

    // Restore the spy if needed
    cookieSpy.mockRestore();
  });

  it('should return null if request object is missing', async () => {
    await expect(
      cookieStore.get('invalid', { response: mockResponse }),
    ).rejects.toThrow('Request object is required to get cookies.');
  });

  it('manual test for MemoryStore', async () => {
    const memoryStore = new MemoryStore();
    const sid = 'test-sid';
    const data: ISessionData = { cookie: mockCookie, user: mockUser };

    await memoryStore.set(sid, data);
    const retrievedData = await memoryStore.get(sid);

    expect(retrievedData).toEqual(data);
  });

  it('should get stored session data if cookie matches', async () => {
    const data: ISessionData = { cookie: mockCookie, user: mockUser };
    const sid = await cookieStore.set(data, context);

    // Create a new request that includes the correct cookie name and value
    //@ts-ignore
    const newRequest = new Request()
      .setUrl('http://localhost')
      .setHeaders({
        cookie: `test_sid=${sid}`, // Use 'test_sid' to match CookieStore
        'content-type': 'application/json',
      })
      .setMethod('GET')
      .setQuery({ key: 'value' })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1']);

    // Update the context with the new request
    context.request = newRequest;

    const session = await cookieStore.get(sid, context);
    expect(session).toEqual(data);
  });

  it('should return null if session ID mismatches', async () => {
    mockRequest.headers.set('Cookie', `test_sid=unknownSid`);
    const session = await cookieStore.get('someSid', context);
    expect(session).toBeNull();
  });

  it('should destroy the session and expire the cookie', async () => {
    const appendSpy = jest.spyOn(mockResponse, 'append');

    const sid = await cookieStore.set(
      { cookie: mockCookie, user: mockUser },
      context,
    );
    await cookieStore.destroy(sid, context);

    expect(appendSpy).toHaveBeenCalledWith(
      'Set-Cookie',
      expect.stringContaining('test_sid=;'),
    );

    appendSpy.mockRestore();
  });

  it('should touch session and reset cookie maxAge', async () => {
    const appendSpy = jest.spyOn(mockResponse, 'append');

    const sid = await cookieStore.set(
      { cookie: mockCookie, user: mockUser },
      context,
    );
    await cookieStore.touch(
      sid,
      { cookie: mockCookie, user: mockUser },
      context,
    );

    expect(appendSpy).toHaveBeenCalledWith(
      'Set-Cookie',
      expect.stringContaining(`test_sid=${sid}`),
    );

    appendSpy.mockRestore();
  });

  it('should use MemoryStore by default if no dataStore is provided', () => {
    const defaultStore = new CookieStore('default_sid');
    expect((defaultStore as any).dataStore).toBeInstanceOf(MemoryStore);
  });

  it('should  return null if cookie parsing fails', async () => {
    // Arrange

    // Mock Cookie.parse to throw an error
    const parseError = new Error('Parsing failed');
    const parseSpy = jest.spyOn(Cookie, 'parse').mockImplementation(() => {
      throw parseError;
    });

    // Spy on the logger.error method
    const loggerErrorSpy = jest.spyOn(cookieStore['logger'], 'error');

    // Act
    const session = await cookieStore.get('someSid', context);

    // Assert
    expect(session).toBeNull();

    // Cleanup
    parseSpy.mockRestore();
    loggerErrorSpy.mockRestore();
  });

  it('should throw an error when setting a session without a response object', async () => {
    const data: ISessionData = { cookie: mockCookie, user: mockUser };
    const invalidContext: IStoreContext = { request: mockRequest };
    await expect(cookieStore.set(data, invalidContext)).rejects.toThrow(
      'Response object is required to set cookies.',
    );
  });

  it('should return null when getting a session if cookie header is missing', async () => {
    const data: ISessionData = { cookie: mockCookie, user: mockUser };
    const sid = await cookieStore.set(data, context);

    // Remove the cookie header
    mockRequest.headers.delete('Cookie');

    const session = await cookieStore.get(sid, context);
    expect(session).toBeNull();
  });

  it('should return null when getting a session if cookie header is not a string', async () => {
    const data: ISessionData = { cookie: mockCookie, user: mockUser };
    const sid = await cookieStore.set(data, context);

    const originalGet = Headers.prototype.get;
    Headers.prototype.get = jest.fn().mockReturnValue(123 as any);

    const session = await cookieStore.get(sid, context);
    expect(session).toBeNull();

    // Restore the original get method
    Headers.prototype.get = originalGet;
  });

  it('should return null when getting a session if session cookie is not found', async () => {
    const data: ISessionData = { cookie: mockCookie, user: mockUser };
    const sid = await cookieStore.set(data, context);

    // Set the 'test_sid' cookie to a different name
    mockRequest.headers.set('Cookie', `other_cookie=${sid}`);

    const session = await cookieStore.get(sid, context);
    expect(session).toBeNull();
  });

  it('should throw an error when destroying a session without a response object', async () => {
    const data: ISessionData = { cookie: mockCookie, user: mockUser };
    const sid = await cookieStore.set(data, context);

    const invalidContext: IStoreContext = { request: mockRequest };
    await expect(cookieStore.destroy(sid, invalidContext)).rejects.toThrow(
      'Response object is required to destroy cookies.',
    );
  });

  it('should throw an error when touching a session without a response object', async () => {
    const data: ISessionData = { cookie: mockCookie, user: mockUser };
    const sid = await cookieStore.set(data, context);

    const invalidContext: IStoreContext = { request: mockRequest };
    await expect(cookieStore.touch(sid, data, invalidContext)).rejects.toThrow(
      'Response object is required to touch cookies.',
    );
  });

  it('should use the default cookieName "sid" when none is provided', () => {
    const defaultStore = new CookieStore(); // No arguments provided
    expect(defaultStore['cookieName']).toBe('sid');
  });
});
