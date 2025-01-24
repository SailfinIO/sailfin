// src/interfaces/IJwt.ts

import { JwtHeader, JwtPayload } from './Jwt';

/**
 * Represents a JSON Web Token (JWT).
 *
 * The `IJwt` interface defines the structure of a JWT instance,
 * including its header, payload, and signature components.
 * This interface facilitates type-safe handling and manipulation
 * of JWTs within the application.
 *
 * @interface IJwt
 */
export interface IJwt {
  /**
   * The decoded header of the JWT.
   *
   * @type {JwtHeader}
   * @example { alg: 'RS256', typ: 'JWT' }
   */
  header: JwtHeader;

  /**
   * The decoded payload of the JWT.
   *
   * @type {JwtPayload}
   * @example { iss: 'https://auth.example.com/', sub: 'user123', aud: 'client-app', exp: 1618884473, iat: 1618880873 }
   */
  payload: JwtPayload;

  /**
   * The signature part of the JWT, encoded as a Base64URL string.
   *
   * @type {string}
   * @example "dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk"
   */
  signature: string;
}
