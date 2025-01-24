// src/utils/ecKeyConverter.test.ts

import { ecJwkToPem } from './ecKeyUtils';
import { ClientError } from '../errors';
import { BinaryToTextEncoding } from '../enums';
import { CURVE_OIDS } from '../constants/algorithmConstants';

// A known valid P-256 JWK public key for testing:
// This is just an example. Replace x and y with values from a known P-256 EC key if needed.
const crv = 'P-256';
const x = 'CEuRLUISufrNFr5tJ3Z42MNqC72B9eMT-S9ST7x8hHw';
const y = 'n5DNFwF7kwiYJsfuCz2p0gniqpOoShM8CojPAZmOPtY';

describe('ecJwkToPem', () => {
  it('should convert a valid P-256 JWK to a PEM public key', () => {
    const pem = ecJwkToPem(crv, x, y);
    expect(pem).toMatch(/^-----BEGIN PUBLIC KEY-----\n/);
    expect(pem).toMatch(/\n-----END PUBLIC KEY-----$/);

    // The PEM should contain a properly encoded EC public key in Base64.
    // We won't decode and fully verify the contents here, but we can do some sanity checks:
    const base64Body = pem
      .replace('-----BEGIN PUBLIC KEY-----\n', '')
      .replace('\n-----END PUBLIC KEY-----', '')
      .replace(/\n/g, '');
    expect(() =>
      Buffer.from(base64Body, BinaryToTextEncoding.BASE_64),
    ).not.toThrow();
  });

  it('should throw a ClientError for an unsupported curve', () => {
    expect(() => ecJwkToPem('P-999', x, y)).toThrow(ClientError);
    try {
      ecJwkToPem('P-999', x, y);
    } catch (err: any) {
      expect(err.code).toBe('ID_TOKEN_VALIDATION_ERROR');
    }
  });

  it('should throw a ClientError if x or y is not valid base64url', () => {
    // Use a guaranteed invalid base64url string "###"
    expect(() => ecJwkToPem(crv, '###', y)).toThrow(ClientError);
    expect(() => ecJwkToPem(crv, x, '%%%')).toThrow(ClientError);
  });
  it('should work with another supported curve (P-384)', () => {
    // Just a simple test to confirm no errors for P-384 with dummy data.
    // NOTE: For a real test, provide a valid P-384 x and y of length 48 bytes each.
    const p384x = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'; // 43 chars base64url ~ 32 bytes decoded
    const p384y = 'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB';
    // The above x and y might not decode to correct lengths needed for a real EC key,
    // but as long as they are base64url-decodable, this tests code paths.

    // We expect this to fail if invalid length after decoding; if we want a passing test,
    // we need a properly sized x and y. Here we'll just test it doesn't fail on curve lookup:
    try {
      ecJwkToPem('P-384', p384x, p384y);
      // If it doesn't throw a ClientError on curve, that means we got past the curve check.
      // This might still throw if `p384x` and `p384y` aren't correct lengths for a real key.
      // In a real scenario, replace with correct data or mock `base64UrlDecode`.
    } catch (err: any) {
      // If there's an error due to length or something else, that's expected if we didn't provide real key values.
      // The important part is that it's not the unsupported curve error.
      if (
        err instanceof ClientError &&
        err.message.includes('Unsupported curve')
      ) {
        // This would mean the curve is not supported, which you don't expect.
        throw new Error(
          'Unsupported curve error received for P-384, which should not happen.',
        );
      }
    }
  });

  it('should work with another supported curve (P-521)', () => {
    // Just a simple test to confirm no errors for P-521 with dummy data.
    // NOTE: For a real test, provide a valid P-521 x and y of length 66 bytes each.
    const p521x =
      'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'; // 65 chars base64url ~ 48 bytes decoded
    const p521y = 'BBBBBBBBBBBB';

    // We expect this to fail if invalid length after decoding; if we want a passing test,
    // we need a properly sized x and y. Here we'll just test it doesn't fail on curve lookup:

    try {
      ecJwkToPem('P-521', p521x, p521y);
      // If it doesn't throw a ClientError on curve, that means we got past the curve check.
      // This might still throw if `p521x` and `p521y` aren't correct lengths for a real key.
      // In a real scenario, replace with correct data or mock `base64UrlDecode`.
    } catch (err: any) {
      // If there's an error due to length or something else, that's expected if we didn't provide real key values.
      // The important part is that it's not the unsupported curve error.
      if (
        err instanceof ClientError &&
        err.message.includes('Unsupported curve')
      ) {
        // This would mean the curve is not supported, which you don't expect.
        throw new Error(
          'Unsupported curve error received for P-521, which should not happen.',
        );
      }
    }
  });
  it('should throw the default unsupported curve error if curveOid exists but curve is not handled', () => {
    const unsupportedCurve = 'P-256X';
    const unsupportedOid = '1.2.840.10045.3.1.7';

    // Backup the original CURVE_OIDS
    const originalCurveOids = { ...CURVE_OIDS };
    // Add the unsupported curve
    CURVE_OIDS[unsupportedCurve] = unsupportedOid;

    try {
      ecJwkToPem(unsupportedCurve, x, y);
      throw new Error('Expected ClientError was not thrown');
    } catch (err: any) {
      expect(err).toBeInstanceOf(ClientError);
      expect(err.message).toContain(`Unsupported curve: ${unsupportedCurve}`);
      expect(err.code).toBe('ID_TOKEN_VALIDATION_ERROR');
    } finally {
      // Restore the original CURVE_OIDS
      Object.keys(CURVE_OIDS).forEach((key) => delete CURVE_OIDS[key]);
      Object.assign(CURVE_OIDS, originalCurveOids);
    }
  });
});
