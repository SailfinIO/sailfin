// src/middleware/middleware.test.ts

import { csrfMiddleware, middleware } from './middleware';
import { Client } from '../classes/Client';
import { MetadataManager } from '../decorators/MetadataManager';
import {
  IRouteMetadata,
  IResponse,
  ISessionData,
  IRequest,
  ISessionStore,
  CookieOptions,
  IClientConfig,
  IStoreContext,
} from '../interfaces';
import {
  Claims,
  RequestMethod,
  RouteAction,
  SameSite,
  SessionMode,
  StatusCode,
} from '../enums';
import { ClientError } from '../errors';
import { Request } from '../classes';

jest.mock('../classes/Client');
jest.mock('../decorators/MetadataManager');

const createMockRequest = (
  url: string,
  options: {
    headers?: Record<string, string>;
    method?: RequestMethod;
    body?: any;
    query?: Record<string, any>;
  } = {},
): IRequest => {
  const {
    headers = {},
    method = RequestMethod.GET,
    body = null,
    query = {},
  } = options;
  //@ts-ignore
  const req = new Request()
    .setUrl(url)
    .setHeaders(headers)
    .setMethod(method)
    .setQuery(query)
    .setBody(body);

  // If cookies are provided in headers, parse and set them
  if (headers.cookie) {
    const cookiePairs = headers.cookie
      .split(';')
      .map((c) => c.trim().split('='));
    const cookies = cookiePairs.reduce(
      (acc: Record<string, string>, [key, value]) => {
        acc[key] = value;
        return acc;
      },
      {},
    );
    req.setCookies(cookies);
  }

  return req;
};

const createMockResponse = (): IResponse => {
  return {
    redirect: jest.fn(),
    status: jest.fn().mockReturnThis(),
    send: jest.fn(),
    cookie: jest.fn(),
  } as unknown as IResponse;
};

const mockSessionStore: ISessionStore = {
  set: jest.fn().mockResolvedValue(undefined),
  get: jest.fn().mockResolvedValue(null),
  destroy: jest.fn().mockResolvedValue(undefined),
  touch: jest.fn().mockResolvedValue(undefined),
};

const mockCookieOptions: CookieOptions = {
  httpOnly: true,
  secure: true,
  sameSite: SameSite.LAX,
};

const mockConfig: IClientConfig = {
  clientId: 'your-client-id',
  redirectUri: 'http://localhost/callback',
  scopes: ['openid', 'profile', 'email'],
  discoveryUrl: 'http://localhost/.well-known/openid-configuration',
  session: {
    mode: SessionMode.SERVER,
    store: mockSessionStore,
    cookie: {
      name: 'session_cookie',
      secret: 'supersecretkey',
      options: mockCookieOptions,
    },
    useSilentRenew: false,
    ttl: 3600,
  },
};

describe('OIDC Middleware', () => {
  let mockClient: jest.Mocked<Client>;
  let mockRequest: IRequest;
  let mockResponse: IResponse;
  let mockNext: jest.Mock;
  let capturedContext: IStoreContext | null = null;

  beforeEach(() => {
    mockClient = {
      getConfig: jest.fn(),
      handleRedirect: jest.fn(),
      getUserInfo: jest.fn(),
      getAuthorizationUrl: jest.fn(),
      getAccessToken: jest.fn(),
      getClaims: jest.fn(),
      getLogger: jest.fn().mockReturnValue({
        debug: jest.fn(),
        warn: jest.fn(),
        error: jest.fn(),
      }),
      getSessionStore: jest.fn().mockReturnValue(mockSessionStore),
    } as unknown as jest.Mocked<Client>;

    mockClient.getConfig.mockReturnValue(mockConfig);
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

    mockResponse = createMockResponse();

    mockNext = jest.fn().mockResolvedValue(undefined);
    MetadataManager.getRouteMetadata = jest.fn();

    // Capture context in handleRedirect
    mockClient.handleRedirect.mockImplementation(
      async (code, state, context) => {
        console.log('Before handleRedirect:', context.user); // Should log undefined
        capturedContext = {
          request: context.request,
          response: context.response,
          extra: { ...context.extra },
          user: context.user,
        };
        if (context.request.session && context.request.session.state) {
          delete context.request.session.state[state];
        }
        console.log('After handleRedirect:', context.user); // Should still log undefined
      },
    );
  });

  afterEach(() => {
    capturedContext = null;
    jest.resetAllMocks();
  });

  it('should call next if no request or response', async () => {
    const mw = middleware(mockClient);
    await mw(
      undefined as unknown as IRequest,
      undefined as unknown as IResponse,
      mockNext,
    );
    expect(mockNext).toHaveBeenCalled();
  });

  it('should call next if no route metadata', async () => {
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(null);
    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);
    expect(mockNext).toHaveBeenCalled();
  });

  it('should handle login action', async () => {
    const routeMetadata: IRouteMetadata = { action: RouteAction.Login };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );
    mockClient.getAuthorizationUrl.mockResolvedValue({
      url: 'http://auth.url',
      state: 'abc',
      codeVerifier: '123',
    });

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.getAuthorizationUrl).toHaveBeenCalled();
    expect(mockResponse.redirect).toHaveBeenCalledWith('http://auth.url');
    expect(mockNext).not.toHaveBeenCalled();
  });

  it('should handle callback action', async () => {
    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Callback,
      postLoginRedirectUri: '/dashboard',
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );

    const initialSession: ISessionData = {
      state: {
        abc: {
          codeVerifier: 'code_verifier_123',
          createdAt: Date.now(),
        },
      },
      user: undefined,
      cookie: undefined,
    };

    //@ts-ignore
    const mockRequest = new Request()
      .setUrl('http://localhost/callback?code=123&state=abc')
      .setHeaders({
        cookie: '',
      })
      .setMethod('GET')
      .setQuery({ key: 'value' })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock_sid' })
      .setSession(initialSession);

    mockClient.getConfig.mockReturnValue(mockConfig);
    mockClient.getUserInfo.mockResolvedValue({ sub: 'user1' });

    // Modify the handleRedirect mock to include assertions
    mockClient.handleRedirect.mockImplementation(
      async (code, state, context) => {
        // Assert that context.user is undefined at the time of handleRedirect
        expect(context.user).toBeUndefined();

        // Optionally, you can capture other parts of context if needed
        expect(context.request).toBe(mockRequest);
        expect(context.response).toBe(mockResponse);
        expect(context.extra).toEqual({});

        // Simulate any necessary behavior within handleRedirect
        if (context.request.session && context.request.session.state) {
          delete context.request.session.state[state];
        }
      },
    );

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    // Verify handleRedirect was called correctly with 3 arguments
    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      '123',
      'abc',
      expect.any(Object),
    );

    // Verify getUserInfo was called
    expect(mockClient.getUserInfo).toHaveBeenCalled();

    // Verify session was updated with user info
    expect(mockRequest.session?.user).toEqual({ sub: 'user1' });

    // Verify state was removed from session
    expect(mockRequest.session?.state).toEqual({});

    // Verify redirection after successful callback handling
    expect(mockResponse.redirect).toHaveBeenCalledWith('/dashboard');

    // Ensure next was not called
    expect(mockNext).not.toHaveBeenCalled();
  });

  it('should handle errors and call onError if provided', async () => {
    const mockOnError = jest.fn();
    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Login,
      onError: mockOnError,
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );
    mockClient.getAuthorizationUrl.mockRejectedValue(new Error('Auth Error'));

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.getAuthorizationUrl).toHaveBeenCalled();
    expect(mockOnError).toHaveBeenCalledWith(
      expect.any(Error),
      mockRequest,
      mockResponse,
    );
    expect(mockResponse.status).not.toHaveBeenCalled();
    expect(mockResponse.send).not.toHaveBeenCalled();
    expect(mockNext).toHaveBeenCalledWith(expect.any(Error));
  });

  it('should handle errors and send 500 if onError not provided', async () => {
    const routeMetadata: IRouteMetadata = { action: RouteAction.Login };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );
    mockClient.getAuthorizationUrl.mockRejectedValue(new Error('Auth Error'));

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.getAuthorizationUrl).toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.send).toHaveBeenCalledWith('Authentication failed');
    expect(mockNext).toHaveBeenCalledWith(expect.any(Error));
  });

  // New Test Cases for Claims Validation

  it('should allow access if all required claims are present', async () => {
    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Protected,
      requiredClaims: [Claims.Email, Claims.Roles],
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );
    mockClient.getAccessToken.mockResolvedValue('valid_token');
    mockClient.getClaims.mockResolvedValue({
      [Claims.Email]: 'user@example.com',
      [Claims.Roles]: ['admin', 'user'],
      // Do not include sub here
    });
    mockClient.getUserInfo.mockResolvedValue({ sub: 'user1' });

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.getAccessToken).toHaveBeenCalled();
    expect(mockClient.getClaims).toHaveBeenCalled();
    expect(mockClient.getUserInfo).toHaveBeenCalled();
    expect(mockRequest.session?.user).toEqual({ sub: 'user1' });
    expect(mockNext).toHaveBeenCalled();
  });

  it('should deny access and send 500 if required claims are missing', async () => {
    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Protected,
      requiredClaims: [Claims.Email, Claims.Roles],
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );
    mockClient.getAccessToken.mockResolvedValue('valid_token');
    mockClient.getClaims.mockResolvedValue({
      email: 'user@example.com',
      // 'roles' claim is missing
    });

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.getAccessToken).toHaveBeenCalled();
    expect(mockClient.getClaims).toHaveBeenCalled();
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(mockRequest.session?.user).toBeUndefined();
    expect(mockNext).toHaveBeenCalledWith(expect.any(ClientError));
    expect(mockResponse.redirect).not.toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.send).toHaveBeenCalledWith('Authentication failed');
  });

  it('should allow access if no required claims are specified', async () => {
    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Protected,
      // No requiredClaims
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );
    mockClient.getAccessToken.mockResolvedValue('valid_token');
    mockClient.getClaims.mockResolvedValue({
      email: 'user@example.com',
      roles: ['user'],
    });
    mockClient.getUserInfo.mockResolvedValue({ sub: 'user1' });

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.getAccessToken).toHaveBeenCalled();
    expect(mockClient.getClaims).toHaveBeenCalled();
    expect(mockClient.getUserInfo).toHaveBeenCalled();
    expect(mockRequest.session?.user).toEqual({ sub: 'user1' });
    expect(mockNext).toHaveBeenCalled();
  });

  it('should handle errors during claims retrieval and send 500', async () => {
    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Protected,
      requiredClaims: [Claims.Email],
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );
    mockClient.getAccessToken.mockResolvedValue('valid_token');
    mockClient.getClaims.mockRejectedValue(
      new Error('Claims retrieval failed'),
    );

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.getAccessToken).toHaveBeenCalled();
    expect(mockClient.getClaims).toHaveBeenCalled();
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(mockRequest.session?.user).toBeUndefined();
    expect(mockNext).toHaveBeenCalledWith(expect.any(Error));
    expect(mockResponse.redirect).not.toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.send).toHaveBeenCalledWith('Authentication failed');
  });

  it('should validate session successfully when session exists and matches state', async () => {
    // Setup the request with the correct URL containing code and state
    const initialSession: ISessionData = {
      state: {
        abc: {
          codeVerifier: 'code_verifier_123',
          createdAt: Date.now(),
        },
      },
      user: undefined,
      cookie: undefined,
    };
    //@ts-ignore
    const mockRequest = new Request()
      .setUrl('http://localhost/callback?code=123&state=abc')
      .setHeaders({
        cookie: '',
      })
      .setMethod('GET')
      .setQuery({ key: 'value' })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock_sid' })
      .setSession(initialSession);

    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Callback,
      postLoginRedirectUri: '/dashboard',
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );
    mockClient.getConfig.mockReturnValue(mockConfig);
    mockClient.handleRedirect.mockImplementation(
      async (code, state, context) => {
        if (context.request && context.request.session) {
          context.request.session.state = undefined;
        }
      },
    );
    mockClient.getUserInfo.mockResolvedValue({ sub: 'user1' });

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      '123',
      'abc',
      expect.any(Object),
    );
    expect(mockClient.getUserInfo).toHaveBeenCalled();
    expect(mockRequest.session?.user).toEqual({ sub: 'user1' });
    expect(mockRequest.session?.state).toEqual({});
    expect(mockResponse.redirect).toHaveBeenCalledWith('/dashboard');
    expect(mockNext).not.toHaveBeenCalled();
  });

  it('should throw ClientError if session is missing', async () => {
    // Setup the request without a session
    //@ts-ignore
    const mockRequest = new Request()
      .setUrl('http://localhost/callback?code=123&state=abc')
      .setHeaders({
        cookie: '',
      })
      .setMethod('GET')
      .setQuery({ key: 'value' })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock_sid' })
      .setSession(undefined);

    mockClient.getConfig.mockReturnValue(mockConfig);

    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Callback,
      postLoginRedirectUri: '/dashboard',
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );

    // Make handleRedirect throw an error due to missing session data
    mockClient.handleRedirect.mockImplementation(
      async (code, state, context) => {
        throw new ClientError('Missing session data', 'MISSING_SESSION');
      },
    );

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      '123',
      'abc',
      expect.any(Object),
    );
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.send).toHaveBeenCalledWith('Authentication failed');
    expect(mockNext).toHaveBeenCalledWith(expect.any(ClientError));
  });

  it('should throw ClientError if state does not match', async () => {
    // Setup the request with mismatched state
    const initialSession: ISessionData = {
      state: {
        wrong_state: {
          codeVerifier: 'code_verifier_123',
          createdAt: Date.now(),
        },
      },
      user: undefined,
      cookie: undefined,
    };
    //@ts-ignore
    const mockRequest = new Request()
      .setUrl('http://localhost/callback?code=123&state=abc')
      .setHeaders({
        cookie: '',
      })
      .setMethod('GET')
      .setQuery({ key: 'value' })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock_sid' })
      .setSession(initialSession);

    mockClient.getConfig.mockReturnValue(mockConfig);

    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Callback,
      postLoginRedirectUri: '/dashboard',
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );

    // Make handleRedirect throw an error due to state mismatch
    mockClient.handleRedirect.mockImplementation(
      async (code, state, context) => {
        const sessionState = context.request.session.state;
        if (!sessionState || !sessionState[state]) {
          throw new ClientError('State mismatch', 'STATE_MISMATCH');
        }
      },
    );

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      '123',
      'abc',
      expect.any(Object),
    );
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.send).toHaveBeenCalledWith('Authentication failed');
    expect(mockNext).toHaveBeenCalledWith(expect.any(ClientError));
  });

  it('should throw ClientError if codeVerifier is missing', async () => {
    // Setup the request without codeVerifier
    const initialSession: ISessionData = {
      state: {
        abc: {
          // codeVerifier is missing
          createdAt: Date.now(),
        },
      },
      user: undefined,
      cookie: undefined,
    };

    //@ts-ignore
    const mockRequest = new Request()
      .setUrl('http://localhost/callback?code=123&state=abc')
      .setHeaders({
        cookie: '',
      })
      .setMethod('GET')
      .setQuery({ key: 'value' })
      .setParams({ id: '123' })
      .setBody({ example: 'body' })
      .setIp('127.0.0.1')
      .setIps(['127.0.0.1'])
      .setCookies({ sid: 'mock_sid' })
      .setSession(initialSession);

    mockClient.getConfig.mockReturnValue(mockConfig);

    const routeMetadata: IRouteMetadata = {
      action: RouteAction.Callback,
      postLoginRedirectUri: '/dashboard',
    };
    (MetadataManager.getRouteMetadata as jest.Mock).mockReturnValue(
      routeMetadata,
    );

    // Make handleRedirect throw an error due to missing codeVerifier
    mockClient.handleRedirect.mockImplementation(
      async (code, state, context) => {
        const sessionState = context.request.session.state;
        if (
          !sessionState ||
          !sessionState[state] ||
          !sessionState[state].codeVerifier
        ) {
          throw new ClientError(
            'Missing codeVerifier',
            'MISSING_CODE_VERIFIER',
          );
        }
      },
    );

    const mw = middleware(mockClient);
    await mw(mockRequest, mockResponse, mockNext);

    expect(mockClient.handleRedirect).toHaveBeenCalledWith(
      '123',
      'abc',
      expect.any(Object),
    );
    expect(mockClient.getUserInfo).not.toHaveBeenCalled();
    expect(mockResponse.status).toHaveBeenCalledWith(500);
    expect(mockResponse.send).toHaveBeenCalledWith('Authentication failed');
    expect(mockNext).toHaveBeenCalledWith(expect.any(ClientError));
  });

  describe('csrfMiddleware', () => {
    let mockClient: jest.Mocked<Client>;
    let mockRequest: IRequest;
    let mockResponse: IResponse;
    let mockNext: jest.Mock;

    // Helper to create a request with given method and headers as a Map.
    function createTestRequest(
      method: RequestMethod,
      headers: Record<string, string> = {},
    ): IRequest {
      //@ts-ignore
      const req = new Request()
        .setUrl('http://localhost')
        .setMethod(method)
        .setHeaders(headers);
      return req;
    }
    beforeEach(() => {
      mockClient = {
        getLogger: jest.fn().mockReturnValue({
          debug: jest.fn(),
          warn: jest.fn(),
          error: jest.fn(),
        }),
        getConfig: jest.fn(),
      } as unknown as jest.Mocked<Client>;

      mockResponse = createMockResponse();
      mockNext = jest.fn();
    });

    it('should call next() immediately if session mode is CLIENT', async () => {
      mockClient.getConfig.mockReturnValue({
        session: { mode: SessionMode.CLIENT },
      } as IClientConfig);

      mockRequest = createTestRequest(RequestMethod.POST);
      const mw = csrfMiddleware(mockClient);
      await mw(mockRequest, mockResponse, mockNext);

      expect(mockNext).toHaveBeenCalled();
      expect(mockResponse.status).not.toHaveBeenCalled();
      expect(mockResponse.send).not.toHaveBeenCalled();
    });

    it('should call next() if request method is GET', async () => {
      mockClient.getConfig.mockReturnValue({
        session: { mode: SessionMode.SERVER },
      } as IClientConfig);

      mockRequest = createTestRequest(RequestMethod.GET);
      const mw = csrfMiddleware(mockClient);
      await mw(mockRequest, mockResponse, mockNext);

      expect(mockNext).toHaveBeenCalled();
      expect(mockResponse.status).not.toHaveBeenCalled();
      expect(mockResponse.send).not.toHaveBeenCalled();
    });

    it('should call next() if request method is HEAD', async () => {
      mockClient.getConfig.mockReturnValue({
        session: { mode: SessionMode.SERVER },
      } as IClientConfig);

      mockRequest = createTestRequest(RequestMethod.HEAD);
      const mw = csrfMiddleware(mockClient);
      await mw(mockRequest, mockResponse, mockNext);

      expect(mockNext).toHaveBeenCalled();
      expect(mockResponse.status).not.toHaveBeenCalled();
      expect(mockResponse.send).not.toHaveBeenCalled();
    });

    it('should call next() if request method is OPTIONS', async () => {
      mockClient.getConfig.mockReturnValue({
        session: { mode: SessionMode.SERVER },
      } as IClientConfig);

      mockRequest = createTestRequest(RequestMethod.OPTIONS);
      const mw = csrfMiddleware(mockClient);
      await mw(mockRequest, mockResponse, mockNext);

      expect(mockNext).toHaveBeenCalled();
      expect(mockResponse.status).not.toHaveBeenCalled();
      expect(mockResponse.send).not.toHaveBeenCalled();
    });

    it('should return 403 if x-csrf-token header is missing on a POST', async () => {
      mockClient.getConfig.mockReturnValue({
        session: { mode: SessionMode.SERVER },
      } as IClientConfig);

      mockRequest = createTestRequest(RequestMethod.POST);
      const mw = csrfMiddleware(mockClient);
      await mw(mockRequest, mockResponse, mockNext);

      expect(mockNext).not.toHaveBeenCalled();
      expect(mockResponse.status).toHaveBeenCalledWith(StatusCode.FORBIDDEN);
      expect(mockResponse.send).toHaveBeenCalledWith('Invalid CSRF token');
    });

    it('should return 403 if token in header does not match session csrfToken', async () => {
      mockClient.getConfig.mockReturnValue({
        session: { mode: SessionMode.SERVER },
      } as IClientConfig);

      // Set up a POST request with an incorrect CSRF token in headers.
      mockRequest = createTestRequest(RequestMethod.POST, {
        'x-csrf-token': 'mismatch_token',
      });
      mockRequest.setSession({ csrfToken: 'real_token' } as any);

      const mw = csrfMiddleware(mockClient);
      await mw(mockRequest, mockResponse, mockNext);

      expect(mockNext).not.toHaveBeenCalled();
      expect(mockResponse.status).toHaveBeenCalledWith(StatusCode.FORBIDDEN);
      expect(mockResponse.send).toHaveBeenCalledWith('Invalid CSRF token');
    });

    it('should call next() if token in header matches the session csrfToken', async () => {
      mockClient.getConfig.mockReturnValue({
        session: { mode: SessionMode.SERVER },
      } as IClientConfig);

      // Set up a POST request with a correct CSRF token in headers.
      mockRequest = createTestRequest(RequestMethod.POST, {
        'x-csrf-token': 'real_token',
      });
      mockRequest.setSession({ csrfToken: 'real_token' } as any);

      const mw = csrfMiddleware(mockClient);
      await mw(mockRequest, mockResponse, mockNext);

      expect(mockNext).toHaveBeenCalled();
      expect(mockResponse.status).not.toHaveBeenCalled();
      expect(mockResponse.send).not.toHaveBeenCalled();
    });
  });
});
