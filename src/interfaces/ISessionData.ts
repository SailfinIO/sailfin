/**
 * @fileoverview
 * Defines the `ISessionData` interface, which represents the structure of session data
 * stored in a session management system. It includes information about cookies and optionally
 * user details.
 *
 * @module src/interfaces/ISessionData
 */

import { TokenSet } from './TokenSet';
import { IUser } from './IUser';

/**
 * Represents the data associated with a session.
 *
 * The `ISessionData` interface defines the structure for storing session-related
 * information, including token response details and optional user data.
 *
 * @interface
 */
export interface ISessionData {
  /**
   * Contains the token response details, such as access and refresh tokens.
   *
   * @type {TokenSet}
   */
  cookie?: TokenSet;

  /**
   * Optionally includes user information associated with the session.
   *
   * @type {IUser | undefined}
   */
  user?: IUser | undefined;

  /**
   * Stores per-request states mapped to their PKCE codeVerifier or other metadata.
   * Useful for handling multiple simultaneous login requests (e.g. multi-tab).
   */
  state?: Record<
    string, // The `state` string from the OIDC flow
    {
      codeVerifier?: string;
      createdAt?: number;
      [key: string]: any; // If you need more fields
    }
  >;

  /**
   * Contains the Cross-Site Request Forgery (CSRF) token associated with the session.
   *
   * @type {string | undefined}
   * @remarks This field is optional and may not be present in all sessions.
   * @see {@link https://en.wikipedia.org/wiki/Cross-site_request_forgery}
   * @see {@link https://owasp.org/www-community/attacks/csrf}
   *
   */
  csrfToken?: string | undefined;
}
