/**
 * @fileoverview
 * Defines the `IAuthorizationUrlParams` interface, representing parameters required
 * to construct an authorization URL in an OpenID Connect or OAuth 2.0 flow.
 *
 * @module src/interfaces/IAuthorizationUrlParams
 */

import { ResponseMode } from '../enums';

/**
 * Represents the parameters required to construct an authorization URL.
 *
 * The `IAuthorizationUrlParams` interface provides a structured way to specify
 * parameters for initiating an OpenID Connect or OAuth 2.0 authorization flow.
 *
 * @interface IAuthorizationUrlParams
 */
export interface IAuthorizationUrlParams {
  /**
   * The authorization server's endpoint for user authentication.
   *
   * @type {string}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = {
   *   authorizationEndpoint: 'https://auth.example.com/authorize',
   *   clientId: 'my-client-id',
   *   redirectUri: 'https://example.com/callback',
   *   responseType: 'code',
   *   scope: 'openid profile email',
   *   state: 'random-string',
   * };
   * ```
   */
  authorizationEndpoint: string;

  /**
   * The client identifier registered with the authorization server.
   *
   * @type {string}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { clientId: 'my-client-id' };
   * ```
   */
  clientId: string;

  /**
   * The URI to which the user will be redirected after authorization.
   *
   * @type {string}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { redirectUri: 'https://example.com/callback' };
   * ```
   */
  redirectUri: string;

  /**
   * The response type indicating the desired authorization grant type.
   *
   * @type {string}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { responseType: 'code' }; // Authorization code flow
   * ```
   */
  responseType: string;

  /**
   * The scope of the requested permissions, as a space-separated string.
   *
   * @type {string}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { scope: 'openid profile email' };
   * ```
   */
  scope: string;

  /**
   * A random string to maintain state between the request and callback.
   *
   * @type {string}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { state: 'random-state-string' };
   * ```
   */
  state: string;

  /**
   * An optional code challenge for PKCE (Proof Key for Code Exchange).
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { codeChallenge: 'random-code-challenge' };
   * ```
   */
  codeChallenge?: string;

  /**
   * The method used to generate the `codeChallenge` for PKCE.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { codeChallengeMethod: 'S256' };
   * ```
   */
  codeChallengeMethod?: string;

  /**
   * An optional nonce value to associate with the ID token to prevent replay attacks.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { nonce: 'random-nonce-value' };
   * ```
   */
  nonce?: string;

  /**
   * An optional prompt value to control the behavior of the authentication request.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { prompt: 'login' }; // Forces re-login
   * ```
   */
  prompt?: string;

  /**
   * An optional display value to control the UI display of the authentication page.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { display: 'popup' }; // Uses a popup for login
   * ```
   */
  display?: string;

  /**
   * The mode to use for returning the authorization response.
   *
   * @type {'query' | 'fragment' | 'form_post' | undefined}
   * @example
   * ```typescript
   * const params: IAuthorizationUrlParams = { responseMode: 'fragment' };
   * ```
   */
  responseMode?: ResponseMode;

  acrValues?: string | string[];
}
