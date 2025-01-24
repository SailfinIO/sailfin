// src/interfaces/TokenSet.ts

export interface TokenSet {
  /**
   * The access token issued by the authorization server. This value is REQUIRED.
   * The access token MUST be a Bearer Token as defined in RFC 6750.
   *
   * @see https://tools.ietf.org/html/rfc6750
   */
  access_token: string;

  /**
   * The type of the token issued as described in Section 7.1.
   *
   * @see https://tools.ietf.org/html/rfc6749#section-7.1
   */
  token_type: string;

  /**
   * The lifetime in seconds of the access token. For example, the value "3600" denotes that the access token will expire in one hour from the time the response was generated.
   * If omitted, the authorization server SHOULD provide the expiration time via other means or document the default value.
   *
   * @see https://tools.ietf.org/html/rfc6749#section-5.1
   */
  expires_in?: number;

  /**
   * The refresh token, which can be used to obtain new access tokens using the same authorization grant.
   *
   * @see https://tools.ietf.org/html/rfc6749#section-6
   */
  refresh_token?: string;

  /**
   * The scope of the access token as described by Section 3.3. The value of the scope parameter is expressed as a list of space-delimited, case-sensitive strings.
   *
   * @see https://tools.ietf.org/html/rfc6749#section-3.3
   */
  scope?: string;

  /**
   * The ID Token, which is a JSON Web Token (JWT) that contains information about the user. The ID Token is described in Section 2. ID Token
   *
   * @see https://openid.net/specs/openid-connect-core-1_0.html#IDToken
   */
  id_token?: string;
}
