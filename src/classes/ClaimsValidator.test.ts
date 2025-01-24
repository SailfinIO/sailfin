import { ClaimsValidator } from './ClaimsValidator';
import { ClientError } from '../errors';
import { JwtPayload } from '../interfaces';

describe('ClaimsValidator', () => {
  const expectedIssuer = 'https://auth.example.com/';
  const expectedAudience = 'client-app';
  const maxFutureSec = 300;

  let validator: ClaimsValidator;
  let now: number;

  beforeAll(() => {
    // Freeze time to ensure consistent testing
    now = Math.floor(Date.now() / 1000);
    jest.useFakeTimers();
    jest.setSystemTime(now * 1000);
  });

  afterAll(() => {
    jest.useRealTimers();
  });

  beforeEach(() => {
    validator = new ClaimsValidator(
      expectedIssuer,
      expectedAudience,
      maxFutureSec,
    );
  });

  describe('validate', () => {
    const basePayload: JwtPayload = {
      iss: expectedIssuer,
      sub: 'user123',
      aud: expectedAudience,
      exp: now + 1000, // Expires in the future
    };

    it('should not throw an error for a valid payload', () => {
      expect(() => validator.validate(basePayload)).not.toThrow();
    });

    it('should validate issuer and throw error if invalid', () => {
      const payload = { ...basePayload, iss: 'wrong-issuer' };
      expect(() => validator.validate(payload)).toThrowError(ClientError);
      try {
        validator.validate(payload);
      } catch (err: any) {
        expect(err.code).toBe('ID_TOKEN_VALIDATION_ERROR');
        expect(err.message).toMatch(/Invalid issuer/);
      }
    });

    it('should validate audience (single) and throw error if not found', () => {
      const payload = { ...basePayload, aud: 'some-other-audience' };
      expect(() => validator.validate(payload)).toThrowError(ClientError);
      try {
        validator.validate(payload);
      } catch (err: any) {
        expect(err.code).toBe('ID_TOKEN_VALIDATION_ERROR');
        expect(err.message).toMatch(/Audience not found/);
      }
    });

    it('should validate audience (array) and succeed if it includes the expected audience', () => {
      const payload = {
        ...basePayload,
        aud: ['another-app', expectedAudience],
      };
      expect(() => validator.validate(payload)).not.toThrow();
    });

    it('should validate audience (array) and throw if expected is not included', () => {
      const payload = {
        ...basePayload,
        aud: ['another-app', 'some-other-audience'],
      };
      expect(() => validator.validate(payload)).toThrowError(ClientError);
    });

    describe('validateAzp', () => {
      it('should not throw if there is a single audience', () => {
        const payload = {
          ...basePayload,
          aud: expectedAudience,
          azp: 'some-azp',
        };
        // single audience should be fine even if azp doesn't match expectedAudience
        // because the condition checks only if multiple aud are present
        expect(() => validator.validate(payload)).not.toThrow();
      });

      it('should not throw if multiple audiences and azp is missing', () => {
        const payload = {
          ...basePayload,
          aud: [expectedAudience, 'another-app'],
        };
        expect(() => validator.validate(payload)).not.toThrow();
      });

      it('should throw if multiple audiences present and azp is defined but not equal to expectedAudience', () => {
        const payload = {
          ...basePayload,
          aud: [expectedAudience, 'another-app'],
          azp: 'wrong-azp',
        };
        expect(() => validator.validate(payload)).toThrowError(ClientError);
        try {
          validator.validate(payload);
        } catch (err: any) {
          expect(err.code).toBe('ID_TOKEN_VALIDATION_ERROR');
          expect(err.message).toMatch(/Invalid authorized party \(azp\)/);
        }
      });

      it('should not throw if multiple audiences present and azp equals expectedAudience', () => {
        const payload = {
          ...basePayload,
          aud: [expectedAudience, 'another-app'],
          azp: expectedAudience,
        };
        expect(() => validator.validate(payload)).not.toThrow();
      });
    });

    describe('validateTimestamps', () => {
      it('should throw if token is expired', () => {
        const payload = { ...basePayload, exp: now - 10 };
        expect(() => validator.validate(payload)).toThrowError(ClientError);
        try {
          validator.validate(payload);
        } catch (err: any) {
          expect(err.message).toMatch(/ID token is expired/);
        }
      });

      it('should throw if iat is too far in the future', () => {
        const futureIat = now + maxFutureSec + 10;
        const payload = { ...basePayload, iat: futureIat };
        expect(() => validator.validate(payload)).toThrowError(ClientError);
        try {
          validator.validate(payload);
        } catch (err: any) {
          expect(err.message).toMatch(/iat is too far in the future/);
        }
      });

      it('should throw if nbf is in the future', () => {
        const payload = { ...basePayload, nbf: now + 10 };
        expect(() => validator.validate(payload)).toThrowError(ClientError);
        try {
          validator.validate(payload);
        } catch (err: any) {
          expect(err.message).toMatch(/not valid yet \(nbf\)/);
        }
      });

      it('should not throw for valid timestamps', () => {
        const payload = {
          ...basePayload,
          exp: now + 1000,
          iat: now,
          nbf: now - 10,
        };
        expect(() => validator.validate(payload)).not.toThrow();
      });
    });

    describe('validateNonce', () => {
      it('should not throw if nonce matches', () => {
        const payload = { ...basePayload, nonce: 'test-nonce' };
        expect(() => validator.validate(payload, 'test-nonce')).not.toThrow();
      });

      it('should throw if nonce does not match', () => {
        const payload = { ...basePayload, nonce: 'test-nonce' };
        expect(() => validator.validate(payload, 'wrong-nonce')).toThrowError(
          ClientError,
        );
        try {
          validator.validate(payload, 'wrong-nonce');
        } catch (err: any) {
          expect(err.message).toMatch(/Invalid nonce/);
        }
      });

      it('should not throw if nonce is not provided at all', () => {
        const payload = { ...basePayload };
        expect(() => validator.validate(payload)).not.toThrow();
      });
    });
  });
});
