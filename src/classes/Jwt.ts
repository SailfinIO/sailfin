// src/classes/Jwt.ts

import { constants, sign } from 'crypto';
import { ClientError } from '../errors/ClientError';
import {
  JwtHeader,
  JwtPayload,
  JwtEncodeOptions,
  IJwt,
  JwtVerifyOptions,
  AlgorithmDetails,
} from '../interfaces';
import { Jwks } from './Jwks';
import { ClaimsValidator } from './ClaimsValidator';
import { SignatureVerifier } from './SignatureVerifier';
import { base64UrlDecode, base64UrlEncode } from '../utils/urlUtils';
import { ALGORITHM_DETAILS_MAP } from '../constants/algorithmConstants';

/**
 * Represents a JSON Web Token (JWT) and provides static methods for encoding, decoding, and verifying JWTs.
 *
 * @class Jwt
 */
export class Jwt implements IJwt {
  public header: JwtHeader;
  public payload: JwtPayload;
  public signature: string;

  /**
   * Creates an instance of Jwt by parsing a JWT string.
   *
   * @param {string} jwt - The JWT string to parse.
   * @throws {ClientError} If the JWT format is invalid.
   */
  constructor(jwt: string) {
    const { header, payload, signature } = Jwt.decode(jwt);
    this.header = header;
    this.payload = payload;
    this.signature = signature;
  }

  /**
   * Decodes a JWT string into its header, payload, and signature components.
   *
   * @param {string} jwt - The JWT string to decode.
   * @returns {{ header: JwtHeader; payload: JwtPayload; signature: string }}
   * @throws {ClientError} If the JWT format is invalid or decoding fails.
   */
  public static decode(jwt: string): {
    header: JwtHeader;
    payload: JwtPayload;
    signature: string;
  } {
    if (typeof jwt !== 'string') {
      throw new ClientError('JWT must be a string', 'INVALID_JWT_TYPE');
    }

    const parts = jwt.split('.');
    if (parts.length !== 3) {
      throw new ClientError(
        'Invalid JWT format, expected 3 parts',
        'INVALID_JWT_FORMAT',
      );
    }

    try {
      const header = JSON.parse(
        base64UrlDecode(parts[0]).toString('utf-8'),
      ) as JwtHeader;
      const payload = JSON.parse(
        base64UrlDecode(parts[1]).toString('utf-8'),
      ) as JwtPayload;
      const signature = parts[2];
      return { header, payload, signature };
    } catch (err) {
      throw new ClientError('Failed to decode JWT', 'JWT_DECODE_ERROR', {
        originalError: err,
      });
    }
  }

  /**
   * Encodes a header and payload into a JWT string using the specified algorithm and private key.
   *
   * @param {JwtPayload} payload - The payload to encode into the JWT.
   * @param {JwtEncodeOptions} options - Options for encoding the JWT.
   * @returns {string} The encoded JWT string.
   * @throws {ClientError} If encoding fails.
   */
  public static encode(payload: JwtPayload, options: JwtEncodeOptions): string {
    const { algorithm, privateKey, header = {} } = options;

    const config: AlgorithmDetails = ALGORITHM_DETAILS_MAP[algorithm];
    if (!config) {
      throw new ClientError(
        `Unsupported algorithm: ${algorithm}`,
        'UNSUPPORTED_ALGORITHM',
      );
    }

    const jwtHeader: JwtHeader = {
      alg: algorithm,
      typ: 'JWT',
      ...header,
    };

    const encodedHeader = base64UrlEncode(
      Buffer.from(JSON.stringify(jwtHeader)),
    );
    const encodedPayload = base64UrlEncode(
      Buffer.from(JSON.stringify(payload)),
    );
    const signingInput = `${encodedHeader}.${encodedPayload}`;

    try {
      let signature: Buffer;

      if (algorithm.startsWith('PS')) {
        // For RSASSA-PSS algorithms
        if (!config.options?.saltLength) {
          throw new ClientError(
            `Missing saltLength for algorithm: ${algorithm}`,
            'CONFIGURATION_ERROR',
          );
        }

        signature = sign(config.cryptoAlg, Buffer.from(signingInput), {
          key: privateKey,
          padding: constants.RSA_PKCS1_PSS_PADDING,
          saltLength: config.options.saltLength,
        });
      } else {
        // For other algorithms
        signature = sign(
          config.cryptoAlg,
          Buffer.from(signingInput),
          privateKey,
        );
      }

      const encodedSignature = base64UrlEncode(signature);
      return `${signingInput}.${encodedSignature}`;
    } catch (err) {
      throw new ClientError('Failed to encode JWT', 'JWT_ENCODE_ERROR', {
        originalError: err,
      });
    }
  }

  /**
   * Verifies the signature and claims of a JWT.
   *
   * @param {string} jwt - The JWT string to verify.
   * @param {JwtVerifyOptions} options - Options and dependencies for verification.
   * @returns {Promise<JwtPayload>} The decoded and validated JWT payload.
   * @throws {ClientError} If verification fails.
   */
  public static async verify(
    jwt: string,
    options: JwtVerifyOptions,
  ): Promise<JwtPayload> {
    const {
      logger,
      client,
      clientId,
      jwks,
      claimsValidator,
      signatureVerifier,
      nonce,
    } = options;

    logger.debug('Starting JWT verification process');

    // Decode JWT
    const { header, payload } = Jwt.decode(jwt);
    logger.debug('JWT successfully decoded', { header, payload });

    // Initialize dependencies if not provided
    const jwksClient = jwks || new Jwks(client.jwks_uri, logger);
    const claimsValidatorInstance =
      claimsValidator || new ClaimsValidator(client.issuer, clientId);
    const signatureVerifierInstance =
      signatureVerifier || new SignatureVerifier(jwksClient);

    // Validate Claims
    try {
      claimsValidatorInstance.validate(payload, nonce);
      logger.debug('Claims validated successfully');
    } catch (err) {
      logger.error('Claims validation failed', { error: err });
      throw err;
    }

    // Verify Signature
    try {
      await signatureVerifierInstance.verify(header, jwt);
      logger.debug('Signature verified successfully');
    } catch (err) {
      logger.error('Signature verification failed', { error: err });
      throw err;
    }

    return payload;
  }
}
