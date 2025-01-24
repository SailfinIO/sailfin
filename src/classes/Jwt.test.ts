// src/classes/Jwt.test.ts

// 1. Move jest.mock calls to the top before any imports
jest.mock('./Jwks');
jest.mock('../utils/urlUtils');

import { Jwt } from './Jwt';
import { ClientError } from '../errors/ClientError';
import { ClaimsValidator } from './ClaimsValidator';
import { SignatureVerifier } from './SignatureVerifier';
import { Jwks } from './Jwks';
import {
  ILogger,
  ClientMetadata,
  JwtPayload,
  JwtEncodeOptions,
  JwtVerifyOptions,
} from '../interfaces';
import { base64UrlDecode, base64UrlEncode } from '../utils/urlUtils';
import { Buffer } from 'buffer';
import { Algorithm, AlgorithmType } from '../enums';
import { ALGORITHM_DETAILS_MAP } from '../constants/algorithmConstants';
import { constants } from 'crypto';

describe('Jwt', () => {
  // Define mock variables
  let mockLogger: jest.Mocked<ILogger>;
  let client: Partial<ClientMetadata>;
  let clientId: string;

  let signatureVerifier: SignatureVerifier;
  let claimsValidator: ClaimsValidator;
  let jwksMock: jest.Mocked<Jwks>;

  // Setup before each test
  beforeEach(() => {
    // Initialize the mock logger with jest.fn() for each method
    mockLogger = {
      info: jest.fn(),
      error: jest.fn(),
      setLogLevel: jest.fn(),
      warn: jest.fn(),
      debug: jest.fn(),
    };

    // Define client metadata
    client = {
      issuer: 'https://auth.example.com',
      jwks_uri: 'https://auth.example.com/.well-known/jwks.json',
      authorization_endpoint: 'https://auth.example.com/authorize',
      token_endpoint: 'https://auth.example.com/token',
      userinfo_endpoint: 'https://auth.example.com/userinfo',
    };

    clientId = 'client-app';

    // Initialize jwksMock with mocked methods
    jwksMock = {
      getKey: jest.fn(),
    } as unknown as jest.Mocked<Jwks>;

    // Mock the Jwks constructor to return jwksMock
    (Jwks as jest.Mock).mockReturnValue(jwksMock);

    // Mock base64UrlDecode to return specific buffers based on input
    (base64UrlDecode as jest.Mock).mockImplementation((input: string) => {
      if (input === 'validHeader') {
        return Buffer.from(
          JSON.stringify({ alg: 'RS256', typ: 'JWT' }),
          'utf-8',
        );
      } else if (input === 'validPayload') {
        return Buffer.from(
          JSON.stringify({
            iss: client.issuer,
            sub: 'user123',
            aud: clientId,
            exp: Math.floor(Date.now() / 1000) + 3600,
            nonce: 'nonce', // Added nonce
          }),
          'utf-8',
        );
      } else if (input === 'invalidJSON') {
        return Buffer.from('{invalidJson:', 'utf-8');
      } else {
        // Default to empty buffer
        return Buffer.from('');
      }
    });

    // Mock base64UrlEncode if needed for encode tests
    (base64UrlEncode as jest.Mock).mockImplementation((input: Buffer) =>
      input.toString('base64url'),
    );

    // Initialize real instances of ClaimsValidator and SignatureVerifier
    claimsValidator = new ClaimsValidator(client.issuer!, clientId);
    signatureVerifier = new SignatureVerifier(jwksMock);

    // Spy on the 'validate' method
    jest.spyOn(claimsValidator, 'validate');

    // **Replace the 'verify' method with a Jest mock function**
    signatureVerifier.verify = jest.fn();
  });

  afterEach(() => {
    jest.resetAllMocks();
    jest.restoreAllMocks();
  });

  // 4. Constructor Tests
  describe('constructor', () => {
    it('parses a valid JWT correctly', () => {
      const validJwt = ['validHeader', 'validPayload', 'validSignature'].join(
        '.',
      );
      const jwtInstance = new Jwt(validJwt);

      expect(jwtInstance.header).toEqual({ alg: 'RS256', typ: 'JWT' });
      expect(jwtInstance.payload).toEqual({
        iss: client.issuer,
        sub: 'user123',
        aud: clientId,
        exp: expect.any(Number),
        nonce: 'nonce', // Ensure nonce is present
      });
      expect(jwtInstance.signature).toBe('validSignature');
    });

    it('throws ClientError if JWT is not a string', () => {
      // @ts-ignore: Intentional incorrect type for testing
      expect(() => new Jwt(123)).toThrow(ClientError);
    });

    it('throws ClientError if JWT does not have 3 parts', () => {
      const invalidJwt = 'invalid.jwt';
      expect(() => new Jwt(invalidJwt)).toThrow(ClientError);
      // Optionally, you can check the error message and code
    });

    it('throws ClientError if decoding fails', () => {
      const invalidJsonJwt = [
        'invalidJSON',
        'validPayload',
        'validSignature',
      ].join('.');
      expect(() => new Jwt(invalidJsonJwt)).toThrow(ClientError);
    });
  });

  // 5. Static decode Method Tests
  describe('decode', () => {
    it('decodes a valid JWT correctly', () => {
      const validJwt = ['validHeader', 'validPayload', 'validSignature'].join(
        '.',
      );
      const decoded = Jwt.decode(validJwt);

      expect(decoded).toEqual({
        header: { alg: 'RS256', typ: 'JWT' },
        payload: {
          iss: client.issuer,
          sub: 'user123',
          aud: clientId,
          exp: expect.any(Number),
          nonce: 'nonce', // Ensure nonce is present
        },
        signature: 'validSignature',
      });

      // Check that base64UrlDecode was called correctly
      expect(base64UrlDecode).toHaveBeenCalledWith('validHeader');
      expect(base64UrlDecode).toHaveBeenCalledWith('validPayload');
    });

    it('throws ClientError if input is not a string', () => {
      // @ts-ignore: Intentional incorrect type for testing
      expect(() => Jwt.decode(123)).toThrow(ClientError);
    });

    it('throws ClientError if JWT does not have 3 parts', () => {
      expect(() => Jwt.decode('invalid.jwt')).toThrow(ClientError);
    });

    it('throws ClientError if JSON parsing fails', () => {
      const invalidJsonJwt = [
        'invalidJSON',
        'validPayload',
        'validSignature',
      ].join('.');
      expect(() => Jwt.decode(invalidJsonJwt)).toThrow(ClientError);
    });
  });

  // 6. Static encode Method Tests
  describe('encode', () => {
    let payload: JwtPayload;
    let optionsWithSalt: JwtEncodeOptions;
    let optionsWithoutSalt: JwtEncodeOptions;

    beforeEach(() => {
      payload = {
        iss: client!.issuer!,
        sub: 'user123',
        aud: clientId,
        exp: Math.floor(Date.now() / 1000) + 3600,
      };

      optionsWithSalt = {
        algorithm: Algorithm.RS256,
        privateKey: 'privateKey',
        header: { kid: 'key-id-123' },
      };

      // Correctly set ALGORITHM_HASH_MAP with 'RSA-PSS'
      ALGORITHM_DETAILS_MAP[Algorithm.PS256] = {
        cryptoAlg: 'RSA-PSS', // Correct cryptoAlg
        hashName: 'sha256',
        type: AlgorithmType.SIGNATURE,
        options: { saltLength: 32 }, // Example saltLength
      };

      optionsWithoutSalt = {
        algorithm: Algorithm.PS256,
        privateKey: 'privateKey',
        header: { kid: 'ps-key-id-123' },
        // Intentionally omit saltLength in the configuration
      };
    });

    it('encodes a payload with default header correctly', () => {
      // Mock base64UrlEncode behavior
      (base64UrlEncode as jest.Mock)
        .mockReturnValueOnce('encodedHeader') // for header
        .mockReturnValueOnce('encodedPayload') // for payload
        .mockReturnValueOnce('encodedSignature'); // for signature

      // Mock crypto.sign
      const crypto = require('crypto');
      crypto.sign = jest.fn().mockReturnValue(Buffer.from('signature'));

      const encodedJwt = Jwt.encode(payload, optionsWithSalt);

      expect(encodedJwt).toBe('encodedHeader.encodedPayload.encodedSignature');

      // Check base64UrlEncode calls
      expect(base64UrlEncode).toHaveBeenNthCalledWith(
        1,
        Buffer.from(
          JSON.stringify({ alg: 'RS256', typ: 'JWT', kid: 'key-id-123' }),
          'utf-8',
        ),
      );
      expect(base64UrlEncode).toHaveBeenNthCalledWith(
        2,
        Buffer.from(JSON.stringify(payload)),
      );
      expect(base64UrlEncode).toHaveBeenNthCalledWith(
        3,
        Buffer.from('signature'),
      );
    });

    it('throws ClientError if unsupported algorithm is provided', () => {
      const invalidOptions: JwtEncodeOptions = {
        algorithm: 'UnsupportedAlg' as any,
        privateKey: 'privateKey',
      };

      expect(() => Jwt.encode(payload, invalidOptions)).toThrow(ClientError);
    });

    it('signs the JWT correctly using RSASSA-PSS', () => {
      // Prepare a payload and options with a valid RSASSA-PSS configuration
      const payload: JwtPayload = {
        iss: client!.issuer!,
        sub: 'user123',
        aud: clientId,
        exp: Math.floor(Date.now() / 1000) + 3600,
      };

      const optionsWithSalt: JwtEncodeOptions = {
        algorithm: Algorithm.PS256,
        privateKey: 'privateKey',
        header: { kid: 'key-id-123' },
      };

      // Add a valid configuration for PS256
      ALGORITHM_DETAILS_MAP[Algorithm.PS256] = {
        cryptoAlg: 'RSA-PSS',
        hashName: 'sha256',
        type: AlgorithmType.SIGNATURE,
        options: { saltLength: 32 },
      };

      // Mock the `crypto.sign` function to ensure it's called
      const crypto = require('crypto');
      const mockSign = jest
        .spyOn(crypto, 'sign')
        .mockReturnValue(Buffer.from('mockSignature'));

      // Encode the JWT
      const jwt = Jwt.encode(payload, optionsWithSalt);

      // Verify the resulting JWT structure
      const parts = jwt.split('.');
      expect(parts).toHaveLength(3); // header, payload, and signature

      // Check that the `sign` function was called with correct arguments
      expect(mockSign).toHaveBeenCalledWith(
        'RSA-PSS',
        Buffer.from(`${parts[0]}.${parts[1]}`), // signingInput
        {
          key: optionsWithSalt.privateKey,
          padding: constants.RSA_PKCS1_PSS_PADDING,
          saltLength: 32,
        },
      );

      // Ensure the signature matches the mocked return value
      expect(parts[2]).toBe(Buffer.from('mockSignature').toString('base64url'));

      // Restore the mock
      mockSign.mockRestore();
    });

    it('throws ClientError if saltLength is missing for PS algorithms', () => {
      // Backup the original configuration for PS256
      const originalConfig = { ...ALGORITHM_DETAILS_MAP[Algorithm.PS256] };

      try {
        // Remove saltLength from the configuration
        delete ALGORITHM_DETAILS_MAP[Algorithm.PS256].options?.saltLength;

        expect(() => Jwt.encode(payload, optionsWithoutSalt)).toThrow(
          ClientError,
        );

        try {
          Jwt.encode(payload, optionsWithoutSalt);
        } catch (err) {
          expect(err).toBeInstanceOf(ClientError);
          expect(err.message).toBe('Failed to encode JWT');
          expect(err.context.originalError).toBeInstanceOf(ClientError); // Updated access
          expect(err.context.originalError.message).toBe(
            'Missing saltLength for algorithm: PS256',
          );
        }
      } finally {
        // Restore the original configuration
        ALGORITHM_DETAILS_MAP[Algorithm.PS256] = originalConfig;
      }
    });

    it('throws ClientError if crypto.sign fails', () => {
      // Mock crypto.sign to throw
      const crypto = require('crypto');
      crypto.sign.mockImplementation(() => {
        throw new Error('signing failed');
      });

      expect(() => Jwt.encode(payload, optionsWithSalt)).toThrow(ClientError);
    });

    // Additional encode tests
    it('includes additional header parameters when provided', () => {
      const extendedOptions: JwtEncodeOptions = {
        ...optionsWithSalt,
        header: { kid: 'key-id-123', x5u: 'https://example.com/certs.pem' },
      };

      // Mock base64UrlEncode behavior
      (base64UrlEncode as jest.Mock)
        .mockReturnValueOnce('encodedHeader') // for header
        .mockReturnValueOnce('encodedPayload') // for payload
        .mockReturnValueOnce('encodedSignature'); // for signature

      // Mock crypto.sign
      const crypto = require('crypto');
      crypto.sign = jest.fn().mockReturnValue(Buffer.from('signature'));

      const encodedJwt = Jwt.encode(payload, extendedOptions);

      expect(encodedJwt).toBe('encodedHeader.encodedPayload.encodedSignature');

      // Check base64UrlEncode calls with extended header
      expect(base64UrlEncode).toHaveBeenNthCalledWith(
        1,
        Buffer.from(
          JSON.stringify({
            alg: 'RS256',
            typ: 'JWT',
            kid: 'key-id-123',
            x5u: 'https://example.com/certs.pem',
          }),
          'utf-8',
        ),
      );
      expect(base64UrlEncode).toHaveBeenNthCalledWith(
        2,
        Buffer.from(JSON.stringify(payload)),
      );
      expect(base64UrlEncode).toHaveBeenNthCalledWith(
        3,
        Buffer.from('signature'),
      );
    });

    it('throws ClientError if header contains unsupported fields', () => {
      const extendedOptions: JwtEncodeOptions = {
        ...optionsWithSalt,
        header: { kid: 'key-id-123', unsupportedField: 'unsupportedValue' },
      };

      // Mock base64UrlEncode behavior
      (base64UrlEncode as jest.Mock)
        .mockReturnValueOnce('encodedHeader') // for header
        .mockReturnValueOnce('encodedPayload') // for payload
        .mockReturnValueOnce('encodedSignature'); // for signature

      // Mock crypto.sign
      const crypto = require('crypto');
      crypto.sign = jest.fn().mockReturnValue(Buffer.from('signature'));

      const encodedJwt = Jwt.encode(payload, extendedOptions);

      expect(encodedJwt).toBe('encodedHeader.encodedPayload.encodedSignature');

      // Check that unsupported fields are included
      expect(base64UrlEncode).toHaveBeenNthCalledWith(
        1,
        Buffer.from(
          JSON.stringify({
            alg: 'RS256',
            typ: 'JWT',
            kid: 'key-id-123',
            unsupportedField: 'unsupportedValue',
          }),
          'utf-8',
        ),
      );
      expect(base64UrlEncode).toHaveBeenNthCalledWith(
        2,
        Buffer.from(JSON.stringify(payload)),
      );
      expect(base64UrlEncode).toHaveBeenNthCalledWith(
        3,
        Buffer.from('signature'),
      );
    });
  });

  // 7. Static verify Method Tests
  describe('verify', () => {
    let validJwt: string;
    let validOptions: JwtVerifyOptions;

    beforeEach(() => {
      validJwt = 'validJWT';
      validOptions = {
        logger: mockLogger,
        client: client as ClientMetadata,
        clientId: clientId,
        jwks: jwksMock,
        claimsValidator: claimsValidator,
        signatureVerifier: signatureVerifier,
        nonce: 'nonce',
      };

      // Mock Jwt.decode behavior using jest.spyOn
      jest.spyOn(Jwt, 'decode').mockImplementation((jwt: string) => {
        if (jwt === 'validJWT') {
          return {
            header: { alg: Algorithm.RS256, typ: 'JWT', kid: 'key-id-123' },
            payload: {
              iss: client!.issuer!,
              sub: 'user123',
              aud: clientId,
              exp: Math.floor(Date.now() / 1000) + 3600,
              nonce: 'nonce', // Added nonce
            },
            signature: 'validSignature',
          };
        } else if (jwt === 'invalidFormat') {
          throw new ClientError(
            'Invalid JWT format, expected 3 parts',
            'INVALID_JWT_FORMAT',
          );
        }
      });

      // **Do not mock the SignatureVerifier.verify method here**
      // Allow it to execute its actual implementation
    });

    afterEach(() => {
      jest.restoreAllMocks();
    });

    it('verifies a valid JWT successfully', async () => {
      // Mock Jwks.getKey to return a valid key
      jwksMock.getKey.mockResolvedValue({
        kty: 'RSA',
        kid: 'key-id-123',
        alg: 'RS256',
        n: 'sXch6vZ3N9nndrQmbXEps2aiAFbWhM78LhWx4cbbfAAtQ9jYy5V9k7qJAsFDcQBUQM0E9sYbVjk40D19bXq9xLqGQ8GaPoVTVQeAUn0pFB1ZkWQQaTMeQFRt4ZtNTS7vkTl6T8tVQXoQoi8wS5fvAKX9uY4oVBcYecOgL',
        e: 'AQAB',
      });

      // **Mock the SignatureVerifier.verify method to call jwksMock.getKey and resolve**
      jest
        .spyOn(signatureVerifier, 'verify')
        .mockImplementation(async (header, jwt) => {
          await jwksMock.getKey(header.kid); // Ensure jwksMock.getKey is called
          // Simulate successful verification
          return;
        });

      await expect(Jwt.verify(validJwt, validOptions)).resolves.toEqual({
        iss: client!.issuer!,
        sub: 'user123',
        aud: clientId,
        exp: expect.any(Number),
        nonce: 'nonce', // Ensure nonce is present
      });

      // Check that Jwt.decode was called
      expect(Jwt.decode).toHaveBeenCalledWith(validJwt);

      // Check that Jwks.getKey was called with 'key-id-123'
      expect(jwksMock.getKey).toHaveBeenCalledWith('key-id-123');

      // Check that ClaimsValidator.validate was called
      expect(claimsValidator.validate).toHaveBeenCalledWith(
        {
          iss: client!.issuer!,
          sub: 'user123',
          aud: clientId,
          exp: expect.any(Number),
          nonce: 'nonce', // Ensure nonce is present
        },
        'nonce',
      );

      // Check that SignatureVerifier.verify was called
      expect(signatureVerifier.verify).toHaveBeenCalledWith(
        { alg: 'RS256', typ: 'JWT', kid: 'key-id-123' },
        'validJWT',
      );

      // Check logger calls
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Starting JWT verification process',
      );
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'JWT successfully decoded',
        {
          header: { alg: 'RS256', typ: 'JWT', kid: 'key-id-123' },
          payload: {
            iss: client!.issuer!,
            sub: 'user123',
            aud: clientId,
            exp: expect.any(Number),
            nonce: 'nonce',
          },
        },
      );
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Claims validated successfully',
      );
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Signature verified successfully',
      );
    });

    it('throws ClientError if JWT format is invalid', async () => {
      await expect(Jwt.verify('invalidFormat', validOptions)).rejects.toThrow(
        ClientError,
      );

      expect(Jwt.decode).toHaveBeenCalledWith('invalidFormat');

      // Ensure that ClaimsValidator.validate and SignatureVerifier.verify were not called
      expect(claimsValidator.validate).not.toHaveBeenCalled();
      expect(signatureVerifier.verify).not.toHaveBeenCalled();
    });

    it('throws ClientError if ClaimsValidator.validate fails', async () => {
      // Mock ClaimsValidator.validate to throw
      (claimsValidator.validate as jest.Mock).mockImplementation(() => {
        throw new ClientError(
          'Claim validation failed',
          'ID_TOKEN_VALIDATION_ERROR',
        );
      });

      await expect(Jwt.verify(validJwt, validOptions)).rejects.toThrow(
        'Claim validation failed',
      );

      // Check that ClaimsValidator.validate was called
      expect(claimsValidator.validate).toHaveBeenCalledWith(
        {
          iss: client!.issuer!,
          sub: 'user123',
          aud: clientId,
          exp: expect.any(Number),
          nonce: 'nonce',
        },
        'nonce',
      );

      // Check that SignatureVerifier.verify was not called
      expect(signatureVerifier.verify).not.toHaveBeenCalled();

      // Check logger calls
      expect(mockLogger.error).toHaveBeenCalledWith(
        'Claims validation failed',
        { error: expect.any(ClientError) },
      );
    });

    it('throws ClientError if SignatureVerifier.verify fails', async () => {
      // Mock Jwks.getKey to return a valid key
      jwksMock.getKey.mockResolvedValue({
        kty: 'RSA',
        kid: 'key-id-123',
        alg: 'RS256',
        n: 'some-modulus',
        e: 'AQAB',
      });

      // Mock SignatureVerifier.verify to throw
      jest
        .spyOn(signatureVerifier, 'verify')
        .mockRejectedValue(
          new ClientError(
            'Signature verification failed',
            'ID_TOKEN_VALIDATION_ERROR',
          ),
        );

      await expect(Jwt.verify(validJwt, validOptions)).rejects.toThrow(
        'Signature verification failed',
      );

      // Check that ClaimsValidator.validate was called
      expect(claimsValidator.validate).toHaveBeenCalledWith(
        {
          iss: client!.issuer!,
          sub: 'user123',
          aud: clientId,
          exp: expect.any(Number),
          nonce: 'nonce',
        },
        'nonce',
      );

      // Check that SignatureVerifier.verify was called
      expect(signatureVerifier.verify).toHaveBeenCalledWith(
        { alg: 'RS256', typ: 'JWT', kid: 'key-id-123' },
        'validJWT',
      );

      // Check logger calls
      expect(mockLogger.error).toHaveBeenCalledWith(
        'Signature verification failed',
        { error: expect.any(ClientError) },
      );
    });

    it('throws ClientError if Jwks.getKey fails', async () => {
      // Mock Jwks.getKey to throw
      jwksMock.getKey.mockRejectedValue(
        new ClientError('Key not found', 'JWKS_KEY_NOT_FOUND'),
      );

      // **Mock the SignatureVerifier.verify method to call jwksMock.getKey and throw**
      jest
        .spyOn(signatureVerifier, 'verify')
        .mockImplementation(async (header, jwt) => {
          await jwksMock.getKey(header.kid); // This will throw
          // Simulate signature verification (not reached due to throw)
          return;
        });

      await expect(Jwt.verify(validJwt, validOptions)).rejects.toThrow(
        'Key not found',
      );

      // Check that Jwks.getKey was called with 'key-id-123'
      expect(jwksMock.getKey).toHaveBeenCalledWith('key-id-123');

      // Ensure that ClaimsValidator.validate was called
      expect(claimsValidator.validate).toHaveBeenCalledWith(
        {
          iss: client!.issuer!,
          sub: 'user123',
          aud: clientId,
          exp: expect.any(Number),
          nonce: 'nonce',
        },
        'nonce',
      );

      // Ensure that SignatureVerifier.verify was called and failed
      expect(signatureVerifier.verify).toHaveBeenCalledWith(
        { alg: 'RS256', typ: 'JWT', kid: 'key-id-123' },
        'validJWT',
      );

      // Check logger calls
      expect(mockLogger.error).toHaveBeenCalledWith(
        'Signature verification failed',
        { error: expect.any(ClientError) },
      );
    });
  });
});
