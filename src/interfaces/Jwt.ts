/**
 * @fileoverview
 * Defines TypeScript interfaces for modeling JSON Web Tokens (JWT).
 * This module provides interfaces for the JWT header and payload, encompassing
 * both standard claims and custom claims. These interfaces facilitate
 * type-safe handling and validation of JWTs within the application.
 *
 * @module src/interfaces/Jwt
 */

import { Algorithm } from '../enums/Algorithm';

/**
 * Represents the header of a JSON Web Token (JWT).
 *
 * The `JwtHeader` interface defines the structure of the JWT header,
 * which contains metadata about the token, including the signing algorithm
 * and key identifier. Additional properties may be present depending on
 * specific use cases and extensions.
 *
 * @interface JwtHeader
 */
export interface JwtHeader {
  /**
   * The type of the token. For JWTs, this is typically "JWT".
   *
   * @type {string}
   * @required
   * @example "JWT"
   */
  typ?: string;

  /**
   * The signing algorithm used to secure the JWT. This should match one of the
   * supported algorithms defined in the `Algorithm` enum.
   *
   * @type {Algorithm}
   * @required
   * @example "RS256"
   */
  alg: Algorithm;

  /**
   * The Key ID (`kid`) parameter is a hint indicating which key was used to secure the JWT.
   * This parameter allows the recipient to select the correct key from a set of keys.
   *
   * @type {string}
   * @optional
   * @example "key-id-123"
   */
  kid?: string;

  /**
   * The X.509 URL (`x5u`) parameter is a URI that refers to a resource for an X.509 public key certificate
   * or certificate chain. This parameter allows the recipient to retrieve the certificate used to sign the JWT.
   *
   * @type {string}
   * @optional
   * @example "https://example.com/certs.pem"
   */
  x5u?: string;

  /**
   * The X.509 certificate chain (`x5c`) parameter is a chain of one or more PKIX certificates.
   * The certificate containing the public key MUST be first.
   *
   * @type {string[]}
   * @optional
   * @example ["MIIC...AB", "MIID...CD"]
   */
  x5c?: string[];

  /**
   * The X.509 certificate SHA-1 thumbprint (`x5t`) parameter is a base64url-encoded SHA-1 thumbprint
   * of the DER encoding of an X.509 certificate.
   *
   * @type {string}
   * @optional
   * @example "abc123def456..."
   */
  x5t?: string;

  /**
   * The X.509 certificate SHA-256 thumbprint (`x5t#S256`) parameter is a base64url-encoded SHA-256 thumbprint
   * of the DER encoding of an X.509 certificate.
   *
   * @type {string}
   * @optional
   * @example "xyz789ghi012..."
   */
  x5t_S256?: string;

  /**
   * Additional custom header parameters can be included as needed.
   * This allows for extensibility and the inclusion of application-specific metadata.
   *
   * @type {Record<string, any>}
   * @optional
   */
  [key: string]: any;
}

/**
 * Represents the payload of a JSON Web Token (JWT).
 *
 * The `JwtPayload` interface defines the structure of the JWT payload,
 * which contains the claims or assertions about an entity (typically, the user)
 * and additional data. This includes both standard claims defined by RFC 7519
 * and custom claims specific to the application's requirements.
 *
 * @interface JwtPayload
 */
export interface JwtPayload {
  /**
   * The issuer (`iss`) claim identifies the principal that issued the JWT.
   *
   * @type {string}
   * @example "https://auth.example.com/"
   */
  iss: string;

  /**
   * The subject (`sub`) claim identifies the principal that is the subject of the JWT.
   *
   * @type {string}
   * @example "user123"
   */
  sub: string;

  /**
   * The audience (`aud`) claim identifies the recipients that the JWT is intended for.
   * It can be a single string or an array of strings.
   *
   * @type {string | string[]}
   * @example "client-app"
   */
  aud: string | string[];

  /**
   * The expiration time (`exp`) claim identifies the expiration time on or after which the JWT
   * must not be accepted for processing.
   *
   * @type {number}
   * @example 1618884473
   */
  exp: number;

  /**
   * The not before (`nbf`) claim identifies the time before which the JWT must not be accepted
   * for processing.
   *
   * @type {number}
   * @example 1618880873
   */
  nbf?: number;

  /**
   * The issued at (`iat`) claim identifies the time at which the JWT was issued.
   *
   * @type {number}
   * @example 1618880873
   */
  iat?: number;

  /**
   * The JWT ID (`jti`) claim provides a unique identifier for the JWT.
   * This can be used to prevent the JWT from being replayed.
   *
   * @type {string}
   * @example "unique-jwt-id-456"
   */
  jti?: string;

  /**
   * The authorized party (`azp`) claim identifies the party to which the JWT was issued.
   * This is typically used when there are multiple audiences.
   *
   * @type {string}
   * @example "client-app"
   */
  azp?: string;

  /**
   * The nonce (`nonce`) claim is used to associate a client session with an ID token,
   * and to mitigate replay attacks.
   *
   * @type {string}
   * @example "randomNonceValue123"
   */
  nonce?: string;

  /**
   * Additional custom claims can be included as needed.
   * This allows for extensibility and the inclusion of application-specific data.
   *
   * @type {Record<string, any>}
   * @example { role: 'admin', permissions: ['read', 'write'] }
   */
  [key: string]: any;
}

/**
 * Represents the structure of a decoded JSON Web Token (JWT).
 *
 * The `DecodedJwt` interface encapsulates the decoded header and payload
 * of a JWT, providing type-safe access to the token's components.
 *
 * @interface DecodedJwt
 */
export interface DecodedJwt {
  /**
   * The header part of the JWT, containing metadata about the token.
   *
   * @type {JwtHeader}
   * @example { alg: 'RS256', typ: 'JWT' }
   */
  header: JwtHeader;

  /**
   * The payload part of the JWT, containing the claims or assertions.
   *
   * @type {JwtPayload}
   * @example { iss: 'https://auth.example.com/', sub: 'user123', aud
   */
  payload: JwtPayload;
}
