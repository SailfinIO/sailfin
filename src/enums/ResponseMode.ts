// src/enums/ResponseMode.ts

// Enum representing the OpenID Connect response mode parameter values.

/**
 * Enum representing the OpenID Connect response mode parameter values.
 */
export enum ResponseMode {
  /**
   * The Authorization Server returns the authorization code in the query string.
   */
  Query = 'query',

  /**
   * The Authorization Server returns the authorization code in the fragment.
   */
  Fragment = 'fragment',

  /**
   * The Authorization Server returns the authorization code as a form post.
   */
  FormPost = 'form_post',
}
