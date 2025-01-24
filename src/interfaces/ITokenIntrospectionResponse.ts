import { JwtPayload } from './Jwt';

export interface ITokenIntrospectionResponse extends Partial<JwtPayload> {
  /**
   * Whether or not the presented token is currently active.
   */
  active: boolean;

  /**
   * Client identifier for the token if available.
   */
  client_id?: string;

  /**
   * Human-readable identifier for the resource owner who authorized the token.
   */
  username?: string;

  /**
   * Type of the token as per the authorization server.
   */
  token_type?: string;

  /**
   * A space-separated list of scopes granted to this token.
   */
  scope?: string;
}
