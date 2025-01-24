// src/middleware/middleware.ts

import { Client } from '../classes/Client';
import { MetadataManager } from '../decorators/MetadataManager';
import {
  IRequest,
  IResponse,
  IRouteMetadata,
  ISessionData,
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
import { ClientError } from '../errors/ClientError';
import { NextFunction } from '../types';
import { parseCookies } from '../utils';

/**
 * Middleware function compatible with Express.
 *
 * @param {Client} client - The OIDC client instance.
 * @returns {Function} Express-compatible middleware function.
 */
export const middleware = (client: Client) => {
  const csrfMw = csrfMiddleware(client);

  return async (
    req: IRequest,
    res: IResponse,
    next: NextFunction,
  ): Promise<void> => {
    if (!req || !res) {
      return next();
    }

    await csrfMw(req, res, async (csrfErr) => {
      if (csrfErr) {
        return next(csrfErr);
      }
      let routeMetadata: IRouteMetadata | null = null;

      try {
        // Parse cookies and update the request
        const parsedCookies = parseCookies(req.headers);
        if (typeof req.setCookies === 'function') {
          req.setCookies(parsedCookies);
        } else {
          // Fallback: assign parsed cookies to req.cookies if setCookies doesn't exist
          (req as any).cookies = parsedCookies;
        }
        client.getLogger().debug('Parsed cookies', { cookies: parsedCookies });

        const sessionStore = client.getSessionStore();
        const sessionCookieName =
          client.getConfig().session?.cookie?.name || 'sailfin.sid';
        let sid = req.cookies[sessionCookieName] || null;
        let sessionData: ISessionData | null = null;

        if (sid && sessionStore) {
          sessionData = await sessionStore.get(sid, {
            request: req,
            response: res,
          });
          if (sessionData) {
            if (typeof req.setSession === 'function') {
              req.setSession(sessionData);
            } else {
              // Fallback assignment if setSession isn't available
              // @ts-ignore - Allow direct assignment since it's a fallback
              req.session = sessionData;
            }
            client.getLogger().debug('Session loaded', { sid, sessionData });
          } else {
            client.getLogger().warn('Invalid sid, clearing session', { sid });
            sid = null;
          }
        }

        const { method, url } = req;
        let pathname: string;

        try {
          const host =
            typeof req.headers.get === 'function'
              ? req.headers.get('host') || 'localhost'
              : Array.isArray(req.headers['host'])
                ? req.headers['host'][0] || 'localhost'
                : req.headers['host'] || 'localhost';

          const baseUrl = `http://${host}`;
          pathname = new URL(url || '', baseUrl).pathname;
          pathname = new URL(url || '', baseUrl).pathname;
        } catch (error) {
          client.getLogger().error('Invalid URL', { url, error });
          await next(error);
          return;
        }

        routeMetadata = MetadataManager.getRouteMetadata(
          method as RequestMethod,
          pathname,
        );

        if (!routeMetadata) {
          return next();
        }

        const context: IStoreContext = {
          request: req,
          response: res,
          extra: {},
          user: undefined,
        };

        client.getLogger().debug('Handling route', { pathname, routeMetadata });

        await handleRoute(client, req, res, routeMetadata, next, context);

        // After handling the route, persist the session
        if (sessionStore) {
          if (sid) {
            // Update existing session
            await sessionStore.touch(sid, req.session!, {
              request: req,
              response: res,
            });
            client.getLogger().debug('Session touched', { sid });
          } else if (req.session) {
            // Create new session; the store will generate the SID
            sid = await sessionStore.set(req.session, {
              request: req,
              response: res,
            });

            client
              .getLogger()
              .debug('New session created', { sid, sessionData: req.session });

            // Set session cookie on the response
            const options = client.getConfig().session?.cookie?.options || {
              httpOnly: true,
              secure: true,
              sameSite: SameSite.STRICT,
              path: '/',
              maxAge: 3600, // 1 hour
            };

            res.cookie(sessionCookieName, sid, options);
          }
        }

        // Only proceed to the next middleware if the action is not terminal
        if (
          routeMetadata.action !== RouteAction.Login &&
          routeMetadata.action !== RouteAction.Callback
        ) {
          await next();
        }
      } catch (error) {
        await handleError(error, routeMetadata!, req, res, next);
      }
    });
  };
};

/**
 * Handles routing based on route metadata.
 *
 * @param {Client} client
 * @param {IRequest} req
 * @param {IResponse} res
 * @param {IRouteMetadata} metadata
 * @param {NextFunction} next
 * @param {IStoreContext} context
 */
const handleRoute = async (
  client: Client,
  req: IRequest,
  res: IResponse,
  metadata: IRouteMetadata,
  next: NextFunction,
  context: IStoreContext,
) => {
  switch (metadata.action) {
    case RouteAction.Login:
      await handleLogin(client, req, res);
      return;
    case RouteAction.Callback:
      await handleCallback(client, req, res, metadata, context);
      break;
    case RouteAction.Protected:
      await handleProtected(client, req, res, metadata, next, context);
      break;
    default:
      await next();
  }
};

/**
 * Handles login action.
 *
 * @param {Client} client
 * @param {IResponse} res
 */
const handleLogin = async (client: Client, req: IRequest, res: IResponse) => {
  const {
    url: authUrl,
    state,
    codeVerifier,
  } = await client.getAuthorizationUrl();

  // Initialize session if it doesn't exist
  if (!req.session) {
    if (typeof req.setSession === 'function') {
      req.setSession({ state: {}, user: undefined });
    } else {
      // @ts-ignore - Allow direct assignment since it's a fallback
      req.session = { state: {}, user: undefined };
    }
  }

  // Ensure the session has a `state` object
  if (!req.session.state) {
    if (typeof req.setSession === 'function') {
      req.setSession({ ...req.session, state: {} });
    } else {
      req.session.state = {};
    }
  }

  // Update session with state and codeVerifier
  if (typeof req.setSession === 'function') {
    req.setSession({
      ...req.session,
      state: {
        ...req.session.state,
        [state]: { codeVerifier, createdAt: Date.now() },
      },
    });
  } else {
    req.session.state[state] = { codeVerifier, createdAt: Date.now() };
  }

  // Redirect to the authorization URL
  if (typeof res.redirect === 'function') {
    res.redirect(authUrl);
  } else if (res && typeof res === 'object') {
    // @ts-ignore - Allow direct assignment since it's a fallback
    res.statusCode = 302;

    // @ts-ignore - Allow direct assignment since it's a fallback
    res.headers = {
      ...res.headers,
      Location: authUrl,
    };
    res.end();
  } else {
    throw new Error('Unable to redirect due to unsupported response object');
  }
};

/**
 * Handles callback action.
 *
 * @param {Client} client
 * @param {IRequest} req
 * @param {IResponse} res
 * @param {IRouteMetadata} metadata
 * @param {NextFunction} next
 * @param {IStoreContext} context
 */
const handleCallback = async (
  client: Client,
  req: IRequest,
  res: IResponse,
  metadata: IRouteMetadata,
  context: IStoreContext,
) => {
  const host = Array.isArray(req.headers['host'])
    ? req.headers['host'][0]
    : req.headers['host'] || 'localhost';
  const baseUrl = `http://${host}`;
  const urlObj = new URL(req.url, baseUrl);
  const urlParams = urlObj.searchParams;

  const code = urlParams.get('code');
  const state = urlParams.get('state');
  validateCallbackParams(code, state);

  await client.handleRedirect(code, state, context);

  // Remove the state from the session after handling it
  if (req.session && req.session.state) {
    delete req.session.state[state]; // Delete the specific state entry

    // If `state` is now empty, clear it completely or set it to an empty object
    if (Object.keys(req.session.state).length === 0) {
      req.session.state = {}; // You could also set this to `undefined` if preferred
    }
  }

  const user = await client.getUserInfo();
  if (client.getConfig().session) {
    context.user = user;
    if (typeof req.setSession === 'function') {
      // Clone session data
      const updatedSession = {
        ...req.session,
        user,
      };

      // Ensure `state` is set to `{}` if it's empty
      if (
        updatedSession.state &&
        Object.keys(updatedSession.state).length === 0
      ) {
        updatedSession.state = {};
      }

      req.setSession(updatedSession);
    } else if (typeof req.session === 'object' && req.session !== null) {
      // @ts-ignore - Allow direct assignment since it's a fallback
      req.session = {
        ...req.session,
        user,
      };

      if (req.session.state && Object.keys(req.session.state).length === 0) {
        req.session.state = {};
      }
    } else {
      console.warn('Session management not supported in current environment');
      throw new Error(
        'Unable to set session data due to unsupported request object',
      );
    }
  }

  res.redirect(metadata.postLoginRedirectUri || '/');
};

/**
 * Handles protected routes.
 *
 * @param {Client} client
 * @param {IRequest} req
 * @param {IResponse} res
 * @param {IRouteMetadata} metadata
 * @param {NextFunction} next
 * @param {IStoreContext} context
 */
const handleProtected = async (
  client: Client,
  req: IRequest,
  res: IResponse,
  metadata: IRouteMetadata,
  next: NextFunction,
  context: IStoreContext,
) => {
  const accessToken = await client.getAccessToken();

  if (!accessToken) {
    const authUrl = (await client.getAuthorizationUrl()).url;

    // Check if res.redirect exists (e.g., in an Express environment)
    if (typeof res.redirect === 'function') {
      res.redirect(authUrl);
    } else if (typeof res === 'object' && res !== null) {
      // For non-Express environments, handle redirection
      // @ts-ignore - Allow direct assignment since it's a fallback
      res.statusCode = 302;
      // @ts-ignore - Allow direct assignment since it's a fallback
      res.headers = {
        ...res.headers,
        Location: authUrl,
      };
      res.end();
    } else {
      throw new Error(
        'Unable to handle redirect due to unsupported response object',
      );
    }
    return;
  }

  // Retrieve all claims
  const claims = await client.getClaims();

  // Optionally validate specific claims
  validateSpecificClaims(claims, metadata.requiredClaims);

  // Retrieve user info and update the session
  const user = await client.getUserInfo();
  context.user = user;

  // Update the session
  if (typeof req.setSession === 'function') {
    req.setSession({
      ...req.session,
      user,
    });
  } else if (typeof req.session === 'object' && req.session !== null) {
    // @ts-ignore - Allow direct assignment since it's a fallback
    req.session = {
      ...req.session,
      user,
    };
  } else {
    console.warn('Session management not supported in current environment');
    throw new Error(
      'Unable to set session data due to unsupported request object',
    );
  }

  // Call next middleware if available
  if (typeof next === 'function') {
    await next();
  } else {
    console.warn('Next function not available in current environment');
    throw new Error(
      'Unable to proceed to next middleware due to unsupported context',
    );
  }
};

/**
 * Handles errors in middleware.
 *
 * @param {unknown} error
 * @param {IRouteMetadata} metadata
 * @param {IRequest} req
 * @param {IResponse} res
 * @param {NextFunction} next
 */
const handleError = async (
  error: unknown,
  metadata: IRouteMetadata,
  req: IRequest,
  res: IResponse,
  next: NextFunction,
) => {
  console.error('OIDC Middleware Error:', error);

  if (metadata?.onError && !res.headersSent) {
    metadata.onError(error, req, res);
  } else if (!res.headersSent) {
    res.status(StatusCode.INTERNAL_SERVER_ERROR).send('Authentication failed');
  }

  // Only call next if headers haven't been sent
  if (!res.headersSent) {
    await next(error);
  }
};

/**
 * Validates callback parameters.
 *
 * @param {string | null} code
 * @param {string | null} state
 */
const validateCallbackParams = (code: string | null, state: string | null) => {
  if (!code || !state) {
    throw new ClientError(
      'Missing code or state in callback',
      'INVALID_CALLBACK',
    );
  }
};

/**
 * Validates specific claims.
 *
 * @param {Record<string, any>} claims
 * @param {string[] | undefined} requiredClaims
 */
const validateSpecificClaims = (
  claims: Record<string, any>,
  requiredClaims?: Claims[],
) => {
  if (!requiredClaims?.length) return;

  // Filter out required claims that are not present in the claims record
  const missingClaims = requiredClaims.filter((claim) => !(claim in claims));

  if (missingClaims.length > 0) {
    throw new ClientError(
      `Missing required claims: ${missingClaims.join(', ')}`,
      'MISSING_CLAIMS',
    );
  }
};

export const csrfMiddleware = (client: Client) => {
  return async (req: IRequest, res: IResponse, next: NextFunction) => {
    const mode = client.getConfig().session?.mode || SessionMode.SERVER;

    // Only enforce CSRF in server-side or hybrid modes
    if (mode === SessionMode.CLIENT) {
      return next();
    }

    // Skip enforcement for safe HTTP methods
    if (
      req.method === RequestMethod.GET ||
      req.method === RequestMethod.HEAD ||
      req.method === RequestMethod.OPTIONS
    ) {
      return next();
    }

    // --------------------------------------------
    // 1. Extract CSRF token from request headers
    // --------------------------------------------
    const csrfToken =
      typeof req.headers.get === 'function'
        ? req.headers.get('x-csrf-token') || undefined
        : Array.isArray(req.headers['x-csrf-token'])
          ? req.headers['x-csrf-token'][0]
          : req.headers['x-csrf-token'] || undefined;

    // --------------------------------------------
    // 2. Compare extracted token to stored token
    // --------------------------------------------
    const storedCsrfToken = req.session?.csrfToken;
    if (!csrfToken || csrfToken !== storedCsrfToken) {
      client
        .getLogger()
        .warn('Invalid CSRF token', { csrfToken, storedCsrfToken });
      if (!res.headersSent) {
        res.status(StatusCode.FORBIDDEN).send('Invalid CSRF token');
      }
      return;
    }

    // If token is valid, proceed to next middleware/handler
    return next();
  };
};
