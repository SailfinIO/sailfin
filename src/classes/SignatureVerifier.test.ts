// src/utils/SignatureVerifier.test.ts

import { constants, verify as cryptoVerify } from 'crypto';
import { SignatureVerifier } from './SignatureVerifier';
import { ClientError } from '../errors/ClientError';
import { Jwks } from '.';
import { ecDsaSignatureFromRaw } from '../utils/derUtils';
import { ecJwkToPem } from '../utils/ecKeyUtils';
import { rsaJwkToPem } from '../utils/rsaKeyUtils';
import { Algorithm } from '../enums';
import { ClientMetadata, ILogger } from '../interfaces';
import { base64UrlDecode } from '../utils/urlUtils';

// Correctly mock individual modules
jest.mock('crypto', () => ({
  ...jest.requireActual('crypto'),
  verify: jest.fn(),
}));

jest.mock('./Jwks');

jest.mock('../utils/rsaKeyUtils', () => ({
  rsaJwkToPem: jest.fn(),
}));

jest.mock('../utils/ecKeyUtils', () => ({
  ecJwkToPem: jest.fn(),
}));

jest.mock('../utils/derUtils', () => ({
  ecDsaSignatureFromRaw: jest.fn(),
}));

jest.mock('../utils/urlUtils', () => ({
  base64UrlDecode: jest.fn((input: string) => Buffer.from(input)),
}));

describe('SignatureVerifier', () => {
  let jwksMock: jest.Mocked<Jwks>;
  let client: Partial<ClientMetadata>;
  let mockLogger: jest.Mocked<ILogger>;
  let verifier: SignatureVerifier;

  beforeEach(() => {
    mockLogger = {
      info: jest.fn(),
      error: jest.fn(),
      setLogLevel: jest.fn(),
      warn: jest.fn(),
      debug: jest.fn(),
    };

    client = {
      issuer: 'https://auth.example.com',
      jwks_uri: 'https://auth.example.com/.well-known/jwks.json',
      authorization_endpoint: 'https://auth.example.com/authorize',
      token_endpoint: 'https://auth.example.com/token',
      userinfo_endpoint: 'https://auth.example.com/userinfo',
    };

    // Instantiate the mocked Jwks
    jwksMock = new Jwks(client.jwks_uri, mockLogger) as jest.Mocked<Jwks>;

    verifier = new SignatureVerifier(jwksMock);

    // Set up return values for mocked functions
    (ecJwkToPem as jest.Mock).mockReturnValue('mockEcPem');
    (rsaJwkToPem as jest.Mock).mockReturnValue('mockRsaPem');
    (ecDsaSignatureFromRaw as jest.Mock).mockReturnValue(
      Buffer.from('mockDerSignature'),
    );
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  const validHeader = { kid: 'validKid', alg: Algorithm.RS256 };
  const validRsaJwk = {
    kty: 'RSA',
    n: 'some-n',
    e: 'some-e',
    alg: 'RS256',
  };

  const validEcJwk = {
    kty: 'EC',
    crv: 'P-256',
    x: 'some-x',
    y: 'some-y',
    alg: 'ES256',
  };

  const validIdToken = 'header.payload.signature'; // mocks a correct 3-segment token
  const validSigningInput = 'header.payload';

  describe('Happy Paths', () => {
    it('should verify a valid RSA token', async () => {
      jwksMock.getKey.mockResolvedValue(validRsaJwk);
      (cryptoVerify as jest.Mock).mockReturnValue(true);

      await expect(
        verifier.verify(validHeader, validIdToken),
      ).resolves.toBeUndefined();

      expect(jwksMock.getKey).toHaveBeenCalledWith('validKid');
      expect(rsaJwkToPem).toHaveBeenCalledWith('some-n', 'some-e');
      expect(cryptoVerify).toHaveBeenCalledWith(
        'sha256',
        Buffer.from(validSigningInput),
        expect.objectContaining({ key: 'mockRsaPem' }),
        Buffer.from('signature'), // base64UrlDecode returns Buffer.from('signature')
      );
    });

    it('should verify a valid EC token', async () => {
      const ecHeader = { kid: 'validKid', alg: 'ES256' as Algorithm };
      jwksMock.getKey.mockResolvedValue(validEcJwk);
      (cryptoVerify as jest.Mock).mockReturnValue(true);

      await expect(
        verifier.verify(ecHeader, validIdToken),
      ).resolves.toBeUndefined();

      expect(jwksMock.getKey).toHaveBeenCalledWith('validKid');
      expect(ecJwkToPem).toHaveBeenCalledWith('P-256', 'some-x', 'some-y');
      expect(ecDsaSignatureFromRaw).toHaveBeenCalledWith(
        Buffer.from('signature'),
        'ES256',
      );
      expect(cryptoVerify).toHaveBeenCalledWith(
        'sha256',
        Buffer.from(validSigningInput),
        { key: 'mockEcPem', dsaEncoding: 'der' },
        Buffer.from('mockDerSignature'),
      );
    });
  });

  describe('Error Conditions', () => {
    it('should throw JWK kty mismatch for non-RSA/EC key types', async () => {
      const unsupportedKeyTypes = ['foo', 'oct', 'OKP']; // Add any other unsupported types as needed

      for (const kty of unsupportedKeyTypes) {
        jwksMock.getKey.mockResolvedValue({
          kty,
          alg: 'RS256', // Ensure the algorithm expects a specific key type
        } as any);

        await expect(
          verifier.verify(validHeader, validIdToken),
        ).rejects.toThrow(
          new ClientError(
            `JWK kty mismatch. Expected RSA for alg RS256`,
            'ID_TOKEN_VALIDATION_ERROR',
          ),
        );

        expect(jwksMock.getKey).toHaveBeenCalledWith('validKid');
      }
    });

    it('should throw Unsupported or unimplemented algorithm: none', async () => {
      const unsupportedAlg = 'none' as Algorithm;
      const unsupportedHeader = { kid: 'validKid', alg: unsupportedAlg };
      jwksMock.getKey.mockResolvedValue({
        kty: 'RSA',
        alg: unsupportedAlg,
      } as any);

      await expect(
        verifier.verify(unsupportedHeader, validIdToken),
      ).rejects.toThrow(
        new ClientError(
          `Unsupported algorithm: ${unsupportedAlg}`,
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );

      expect(jwksMock.getKey).toHaveBeenCalledWith('validKid');
    });

    it('should throw JWK kty mismatch. Expected RSA for alg RS256', async () => {
      jwksMock.getKey.mockResolvedValue({
        kty: 'foo',
        alg: 'RS256',
      } as any);

      await expect(verifier.verify(validHeader, validIdToken)).rejects.toThrow(
        new ClientError(
          'JWK kty mismatch. Expected RSA for alg RS256',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );

      expect(jwksMock.getKey).toHaveBeenCalledWith('validKid');
    });

    it('should throw if kid is missing', async () => {
      const headerWithoutKid = { alg: 'RS256' as Algorithm };
      await expect(
        verifier.verify(headerWithoutKid as any, validIdToken),
      ).rejects.toThrow(
        new ClientError(
          'Missing kid or alg in header',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );
    });

    const curveTests = [
      {
        alg: 'ES384' as Algorithm,
        crv: 'P-256',
        expectedError: 'Incorrect curve for ES384',
      },
      {
        alg: 'ES512' as Algorithm,
        crv: 'P-384',
        expectedError: 'Incorrect curve for ES512',
      },
    ];

    it('should throw on invalid base64 encoding in signature', async () => {
      // Mock base64UrlDecode to throw an error for invalid input
      (base64UrlDecode as jest.Mock).mockImplementation((input: string) => {
        if (input === '@@@') {
          throw new Error('Input contains invalid Base64URL characters');
        }
        return Buffer.from(input);
      });

      jwksMock.getKey.mockResolvedValue(validRsaJwk);
      await expect(
        verifier.verify(validHeader, 'header.payload.@@@'),
      ).rejects.toThrow(
        new ClientError(
          'Input contains invalid Base64URL characters',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );
    });

    curveTests.forEach(({ alg, crv, expectedError }) => {
      it(`should throw if EC curve is incorrect for ${alg}`, async () => {
        const incorrectCurveJwk = {
          ...validEcJwk,
          alg, // Set jwk.alg to match header.alg
          crv, // Incorrect curve
        };
        const ecHeader = { kid: 'validKid', alg };
        jwksMock.getKey.mockResolvedValue(incorrectCurveJwk);

        await expect(verifier.verify(ecHeader, validIdToken)).rejects.toThrow(
          new ClientError(expectedError, 'ID_TOKEN_VALIDATION_ERROR'),
        );

        expect(jwksMock.getKey).toHaveBeenCalledWith('validKid');
      });
    });

    it('should throw if alg is missing', async () => {
      const headerWithoutAlg = { kid: 'someKid' };
      await expect(
        verifier.verify(headerWithoutAlg as any, validIdToken),
      ).rejects.toThrow(
        new ClientError(
          'Missing kid or alg in header',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );
    });

    it('should throw if token format is invalid (not 3 parts)', async () => {
      jwksMock.getKey.mockResolvedValue(validRsaJwk);
      await expect(
        verifier.verify(validHeader, 'invalid.token'),
      ).rejects.toThrow(
        new ClientError('Invalid JWT format', 'ID_TOKEN_VALIDATION_ERROR'),
      );
    });

    it('should throw if unsupported algorithm is given', async () => {
      const unsupportedHeader = { kid: 'validKid', alg: 'XYZ256' as Algorithm };
      jwksMock.getKey.mockResolvedValue({ kty: 'RSA' } as any);
      await expect(
        verifier.verify(unsupportedHeader, validIdToken),
      ).rejects.toThrow(
        new ClientError(
          'Unsupported algorithm: XYZ256',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );
    });

    it('should throw if JWK kty does not match algorithm type', async () => {
      // alg RS256 expects RSA key but we give EC
      jwksMock.getKey.mockResolvedValue(validEcJwk);
      await expect(verifier.verify(validHeader, validIdToken)).rejects.toThrow(
        new ClientError(
          'JWK kty mismatch. Expected RSA for alg RS256',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );
    });

    it('should throw if EC curve is incorrect for ES256', async () => {
      const incorrectCurveJwk = { ...validEcJwk, crv: 'P-384' };
      const ecHeader = { kid: 'validKid', alg: 'ES256' as Algorithm };
      jwksMock.getKey.mockResolvedValue(incorrectCurveJwk);
      await expect(verifier.verify(ecHeader, validIdToken)).rejects.toThrow(
        new ClientError(
          'Incorrect curve for ES256',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );
    });

    it('should throw if signature verification fails for RSA', async () => {
      jwksMock.getKey.mockResolvedValue(validRsaJwk);
      (cryptoVerify as jest.Mock).mockReturnValue(false);

      await expect(verifier.verify(validHeader, validIdToken)).rejects.toThrow(
        new ClientError(
          'Invalid ID token signature',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );
    });

    it('should throw if signature verification fails for EC', async () => {
      const ecHeader = { kid: 'validKid', alg: 'ES256' as Algorithm };
      jwksMock.getKey.mockResolvedValue(validEcJwk);
      (cryptoVerify as jest.Mock).mockReturnValue(false); // Simulate verification failure

      await expect(verifier.verify(ecHeader, validIdToken)).rejects.toThrow(
        new ClientError(
          'Invalid ID token signature',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );

      expect(jwksMock.getKey).toHaveBeenCalledWith('validKid');
      expect(ecJwkToPem).toHaveBeenCalledWith('P-256', 'some-x', 'some-y');
      expect(ecDsaSignatureFromRaw).toHaveBeenCalledWith(
        Buffer.from('signature'),
        'ES256',
      );
      expect(cryptoVerify).toHaveBeenCalledWith(
        'sha256',
        Buffer.from(validSigningInput),
        { key: 'mockEcPem', dsaEncoding: 'der' },
        Buffer.from('mockDerSignature'),
      );
    });

    it('should throw if JWK algorithm does not match JWT header alg', async () => {
      const mismatchedAlgJwk = {
        kty: 'RSA',
        n: 'some-n',
        e: 'some-e',
        alg: 'RS384', // Different from header.alg 'RS256'
      };
      jwksMock.getKey.mockResolvedValue(mismatchedAlgJwk);

      await expect(verifier.verify(validHeader, validIdToken)).rejects.toThrow(
        new ClientError(
          'JWK algorithm does not match JWT header alg. JWK: RS384, JWT: RS256',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );

      expect(jwksMock.getKey).toHaveBeenCalledWith('validKid');
    });

    it('should throw Unsupported key type: oct when using HS256 algorithm', async () => {
      const hsHeader = { kid: 'validKid', alg: 'HS256' as Algorithm };
      const hsJwk = {
        kty: 'oct', // Supported by the algorithm prefix 'HS'
        alg: 'HS256',
        // Add other necessary properties if required
      } as any;

      jwksMock.getKey.mockResolvedValue(hsJwk);

      await expect(verifier.verify(hsHeader, validIdToken)).rejects.toThrow(
        new ClientError(
          'Unsupported key type: oct',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );

      expect(jwksMock.getKey).toHaveBeenCalledWith('validKid');
    });
  });

  describe('Branch Coverage', () => {
    it('should handle PS algorithms (RSA-PSS)', async () => {
      const psHeader = { kid: 'validKid', alg: 'PS256' as Algorithm };
      const psJwk = { ...validRsaJwk, alg: 'PS256' };
      jwksMock.getKey.mockResolvedValue(psJwk);
      (cryptoVerify as jest.Mock).mockReturnValue(true);

      await expect(
        verifier.verify(psHeader, validIdToken),
      ).resolves.toBeUndefined();
      expect(cryptoVerify).toHaveBeenCalledWith(
        'sha256',
        Buffer.from(validSigningInput),
        expect.objectContaining({ padding: constants.RSA_PKCS1_PSS_PADDING }),
        Buffer.from('signature'),
      );
    });

    it('should throw if HS algorithm is used (unsupported in current implementation)', async () => {
      const hsHeader = { kid: 'validKid', alg: 'HS256' as Algorithm };
      // For HS256, we expect 'oct' key type
      jwksMock.getKey.mockResolvedValue({
        kty: 'oct',
        alg: 'HS256',
      } as any);

      await expect(verifier.verify(hsHeader, validIdToken)).rejects.toThrow(
        new ClientError(
          'Unsupported key type: oct',
          'ID_TOKEN_VALIDATION_ERROR',
        ),
      );
    });
  });
});
