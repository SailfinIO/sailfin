/**
 * @fileoverview
 * Defines the `ILogoutUrlParams` interface, representing the parameters required
 * to construct a logout URL in OpenID Connect or OAuth 2.0 flows.
 *
 * @module src/interfaces/ILogoutUrlParams
 */

/**
 * Represents the parameters required to construct a logout URL.
 *
 * The `ILogoutUrlParams` interface provides a structured way to specify parameters
 * for initiating a logout process in OpenID Connect or OAuth 2.0 flows.
 *
 * @interface ILogoutUrlParams
 */
export interface ILogoutUrlParams {
  /**
   * The endpoint for ending the user's session at the identity provider.
   *
   * @type {string}
   * @example
   * ```typescript
   * const params: ILogoutUrlParams = {
   *   endSessionEndpoint: 'https://auth.example.com/logout',
   *   clientId: 'my-client-id',
   *   postLogoutRedirectUri: 'https://example.com/after-logout',
   * };
   * ```
   */
  endSessionEndpoint: string;

  /**
   * The client identifier registered with the identity provider.
   *
   * @type {string}
   * @example
   * ```typescript
   * const params: ILogoutUrlParams = { clientId: 'my-client-id' };
   * ```
   */
  clientId: string;

  /**
   * The URI to which the user will be redirected after logout.
   *
   * @type {string}
   * @example
   * ```typescript
   * const params: ILogoutUrlParams = { postLogoutRedirectUri: 'https://example.com/after-logout' };
   * ```
   */
  postLogoutRedirectUri: string;

  /**
   * An optional ID token hint, which helps the identity provider identify the session to end.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const params: ILogoutUrlParams = { idTokenHint: 'eyJhbGciOiJSUzI1NiIsIn...' };
   * ```
   */
  idTokenHint?: string;

  /**
   * An optional state parameter to maintain state between the request and callback.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const params: ILogoutUrlParams = { state: 'random-state-string' };
   * ```
   */
  state?: string;

  /**
   * An optional hint to the identity provider about the user's preferred logout behavior.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const params: ILogoutUrlParams = { logoutHint: 'logout' };
   * ```
   */
  logoutHint?: string;

  /**
   * An optional prompt parameter to control the user's interaction during logout.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const params: ILogoutUrlParams = { prompt: 'login' };
   * ```
   */
  uiLocales?: string;
}
