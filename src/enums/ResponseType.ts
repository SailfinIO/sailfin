// src/enum/ResponseType.ts

// Enum representing the OpenID Connect response type parameter values.
export enum ResponseType {
  /**
   * The Authorization Server must return an authorization code.
   */
  Code = 'code',

  /**
   * The Authorization Server must return an ID Token.
   */
  IdToken = 'id_token',

  /**
   * The Authorization Server must return an ID Token and an authorization code.
   */
  IdTokenCode = 'id_token code',
}
