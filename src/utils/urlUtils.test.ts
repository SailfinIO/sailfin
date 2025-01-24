import {
  buildUrlEncodedBody,
  buildAuthorizationUrl,
  buildLogoutUrl,
  base64UrlEncode,
  base64UrlDecode,
  generateRandomString,
} from './urlUtils';
import { IAuthorizationUrlParams } from '../interfaces/IAuthorizationUrlParams';
import { Algorithm, ResponseMode } from '../enums';
import { ClientError } from '../errors/ClientError';
import { ILogoutUrlParams } from '../interfaces';
import * as crypto from 'crypto';

describe('urlUtils', () => {
  describe('buildUrlEncodedBody', () => {
    it('should build a URL-encoded string from given parameters', () => {
      const params = {
        grant_type: 'authorization_code',
        code: 'abc123',
        redirect_uri: 'https://example.com/callback',
      };

      const encoded = buildUrlEncodedBody(params);
      expect(encoded).toBe(
        'grant_type=authorization_code&code=abc123&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback',
      );
    });

    it('should handle empty parameter objects gracefully', () => {
      const params = {};
      const encoded = buildUrlEncodedBody(params);
      expect(encoded).toBe('');
    });

    it('should correctly URL-encode special characters', () => {
      const params = {
        param: 'foo bar',
        another: 'foo+bar/baz?',
      };
      const encoded = buildUrlEncodedBody(params);
      expect(encoded).toBe('param=foo%20bar&another=foo%2Bbar%2Fbaz%3F');
    });

    // New Error Handling Tests
    it('should throw ClientError if params is not an object', () => {
      expect(() => buildUrlEncodedBody(null)).toThrow(ClientError);
      // @ts-expect-error Testing runtime behavior with invalid input
      expect(() => buildUrlEncodedBody('invalid')).toThrow(ClientError);
      // @ts-expect-error Testing runtime behavior with invalid input
      expect(() => buildUrlEncodedBody(123)).toThrow(ClientError);
    });

    it('should throw ClientError if any key or value is not a string', () => {
      const paramsWithNonStringValue = { key1: 'value1', key2: 123 };
      // @ts-expect-error Testing runtime behavior with invalid input
      expect(() => buildUrlEncodedBody(paramsWithNonStringValue)).toThrow(
        ClientError,
      );

      const paramsWithNonStringKey = { [Symbol('key')]: 'value' };
      expect(() => buildUrlEncodedBody(paramsWithNonStringKey)).toThrow(
        ClientError,
      );
    });
  });

  describe('buildAuthorizationUrl', () => {
    const baseParams: IAuthorizationUrlParams = {
      authorizationEndpoint: 'https://auth.example.com/oauth2/authorize',
      clientId: 'myclientid',
      redirectUri: 'https://example.com/callback',
      responseType: 'code',
      scope: 'openid profile',
      state: 'xyz',
    };
    it('should join acrValues array into a space-separated string', () => {
      const paramsWithAcrValuesArray = {
        ...baseParams,
        acrValues: [
          'urn:mace:incommon:iap:silver',
          'urn:mace:incommon:iap:bronze',
        ],
      };

      const url = buildAuthorizationUrl(paramsWithAcrValuesArray);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz&acr_values=urn%3Amace%3Aincommon%3Aiap%3Asilver+urn%3Amace%3Aincommon%3Aiap%3Abronze`;
      expect(url).toBe(expectedUrl);
    });

    it('should append acrValues as a string if it is not an array', () => {
      const paramsWithAcrValuesString = {
        ...baseParams,
        acrValues: 'urn:mace:incommon:iap:silver',
      };

      const url = buildAuthorizationUrl(paramsWithAcrValuesString);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz&acr_values=urn%3Amace%3Aincommon%3Aiap%3Asilver`;
      expect(url).toBe(expectedUrl);
    });

    it('should not append acr_values if it is undefined', () => {
      const paramsWithoutAcrValues = {
        ...baseParams,
      };

      const url = buildAuthorizationUrl(paramsWithoutAcrValues);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz`;
      expect(url).toBe(expectedUrl);
    });

    it('should build a valid authorization URL with minimal parameters', () => {
      const url = buildAuthorizationUrl(baseParams);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz`;
      expect(url).toBe(expectedUrl);
    });

    it('should include code_challenge and code_challenge_method if provided', () => {
      const paramsWithChallenge = {
        ...baseParams,
        codeChallenge: 'challenge123',
        codeChallengeMethod: Algorithm.SHA256,
      };

      const url = buildAuthorizationUrl(paramsWithChallenge);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz&code_challenge=challenge123&code_challenge_method=SHA256`;
      expect(url).toBe(expectedUrl);
    });

    it('should default code_challenge_method to SHA256 if only code_challenge is provided', () => {
      const paramsWithOnlyChallenge = {
        ...baseParams,
        codeChallenge: 'challengeOnly',
      };
      const url = buildAuthorizationUrl(paramsWithOnlyChallenge);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz&code_challenge=challengeOnly&code_challenge_method=SHA256`;
      expect(url).toBe(expectedUrl);
    });

    it('should include additional parameters if provided', () => {
      const additionalParams = {
        prompt: 'consent',
        acr_values: 'urn:mace:incommon:iap:silver',
      };
      const url = buildAuthorizationUrl(baseParams, additionalParams);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz&prompt=consent&acr_values=urn%3Amace%3Aincommon%3Aiap%3Asilver`;
      expect(url).toBe(expectedUrl);
    });

    it('should throw a ClientError if building the URL fails', () => {
      const invalidParams = {
        ...baseParams,
        authorizationEndpoint: 'not a valid url',
      };
      expect(() => buildAuthorizationUrl(invalidParams)).toThrow(ClientError);
    });

    it('should append prompt to the URL if provided', () => {
      const paramsWithPrompt = {
        ...baseParams,
        prompt: 'consent',
      };

      const url = buildAuthorizationUrl(paramsWithPrompt);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz&prompt=consent`;
      expect(url).toBe(expectedUrl);
    });

    it('should not append prompt to the URL if it is not provided', () => {
      const paramsWithoutPrompt = {
        ...baseParams,
      };

      const url = buildAuthorizationUrl(paramsWithoutPrompt);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz`;
      expect(url).toBe(expectedUrl);
    });

    it('should append display to the URL if provided', () => {
      const paramsWithDisplay = {
        ...baseParams,
        display: 'popup',
      };

      const url = buildAuthorizationUrl(paramsWithDisplay);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz&display=popup`;
      expect(url).toBe(expectedUrl);
    });

    it('should not append display to the URL if it is not provided', () => {
      const paramsWithoutDisplay = {
        ...baseParams,
      };

      const url = buildAuthorizationUrl(paramsWithoutDisplay);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz`;
      expect(url).toBe(expectedUrl);
    });

    it('should append response_mode to the URL if provided', () => {
      const paramsWithResponseMode = {
        ...baseParams,
        responseMode: ResponseMode.FormPost,
      };

      const url = buildAuthorizationUrl(paramsWithResponseMode);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz&response_mode=form_post`;
      expect(url).toBe(expectedUrl);
    });

    it('should not append response_mode to the URL if it is not provided', () => {
      const paramsWithoutResponseMode = {
        ...baseParams,
      };

      const url = buildAuthorizationUrl(paramsWithoutResponseMode);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz`;
      expect(url).toBe(expectedUrl);
    });

    it('should append nonce to the URL if provided', () => {
      const paramsWithNonce = {
        ...baseParams,
        nonce: 'randomNonce123',
      };

      const url = buildAuthorizationUrl(paramsWithNonce);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz&nonce=randomNonce123`;
      expect(url).toBe(expectedUrl);
    });

    it('should not append nonce to the URL if it is not provided', () => {
      const paramsWithoutNonce = {
        ...baseParams,
      };

      const url = buildAuthorizationUrl(paramsWithoutNonce);
      const expectedUrl = `https://auth.example.com/oauth2/authorize?response_type=code&client_id=myclientid&redirect_uri=https%3A%2F%2Fexample.com%2Fcallback&scope=openid+profile&state=xyz`;
      expect(url).toBe(expectedUrl);
    });
  });

  describe('buildLogoutUrl', () => {
    const baseLogoutParams: ILogoutUrlParams = {
      endSessionEndpoint: 'https://auth.example.com/oauth2/logout',
      clientId: 'myclientid',
      postLogoutRedirectUri: 'https://example.com/logout-callback',
    };

    it('should build a valid logout URL with minimal parameters', () => {
      const url = buildLogoutUrl(baseLogoutParams);
      const expectedUrl =
        'https://auth.example.com/oauth2/logout?client_id=myclientid&post_logout_redirect_uri=https%3A%2F%2Fexample.com%2Flogout-callback';
      expect(url).toBe(expectedUrl);
    });

    it('should include id_token_hint if provided', () => {
      const paramsWithIdToken = {
        ...baseLogoutParams,
        idTokenHint: 'idToken123',
      };
      const url = buildLogoutUrl(paramsWithIdToken);
      const expectedUrl =
        'https://auth.example.com/oauth2/logout?client_id=myclientid&post_logout_redirect_uri=https%3A%2F%2Fexample.com%2Flogout-callback&id_token_hint=idToken123';
      expect(url).toBe(expectedUrl);
    });

    it('should include state if provided', () => {
      const paramsWithState = {
        ...baseLogoutParams,
        state: 'logoutState456',
      };
      const url = buildLogoutUrl(paramsWithState);
      const expectedUrl =
        'https://auth.example.com/oauth2/logout?client_id=myclientid&post_logout_redirect_uri=https%3A%2F%2Fexample.com%2Flogout-callback&state=logoutState456';
      expect(url).toBe(expectedUrl);
    });

    it('should include both id_token_hint and state if provided', () => {
      const params = {
        ...baseLogoutParams,
        idTokenHint: 'idToken123',
        state: 'logoutState456',
      };
      const url = buildLogoutUrl(params);
      const expectedUrl =
        'https://auth.example.com/oauth2/logout?client_id=myclientid&post_logout_redirect_uri=https%3A%2F%2Fexample.com%2Flogout-callback&id_token_hint=idToken123&state=logoutState456';
      expect(url).toBe(expectedUrl);
    });

    it('should throw a ClientError if endSessionEndpoint is invalid', () => {
      const invalidParams = {
        ...baseLogoutParams,
        endSessionEndpoint: 'not a valid url',
      };
      expect(() => buildLogoutUrl(invalidParams)).toThrow(ClientError);
    });

    it('should throw a ClientError if required parameters are missing', () => {
      // @ts-expect-error Testing runtime behavior with missing parameters
      expect(() => buildLogoutUrl({})).toThrow(ClientError);
    });

    describe('base64 utilities', () => {
      describe('base64UrlEncode', () => {
        it('should encode a buffer to a base64url string', () => {
          const input = Buffer.from('Hello World');
          const encoded = base64UrlEncode(input);
          // The standard Base64 for "Hello World" is "SGVsbG8gV29ybGQ="
          // After base64url encoding (removing '=' and making it URL safe), we get "SGVsbG8gV29ybGQ"
          expect(encoded).toBe('SGVsbG8gV29ybGQ');
        });

        it('should throw ClientError if input is not a Buffer', () => {
          // @ts-expect-error Testing runtime behavior with invalid input
          expect(() => base64UrlEncode('not a buffer')).toThrow(ClientError);
          // @ts-expect-error Testing runtime behavior with invalid input
          expect(() => base64UrlEncode(123)).toThrow(ClientError);

          expect(() => base64UrlEncode(null)).toThrow(ClientError);
        });

        it('should throw ClientError if encoding fails', () => {
          // It's challenging to force Buffer.toString to throw, but we can mock it
          const originalToString = Buffer.prototype.toString;
          Buffer.prototype.toString = jest.fn(() => {
            throw new Error('Encoding failed');
          });

          const input = Buffer.from('Test');
          expect(() => base64UrlEncode(input)).toThrow(ClientError);

          // Restore the original method
          Buffer.prototype.toString = originalToString;
        });
      });

      describe('base64UrlDecode', () => {
        it('should decode a base64url string to a buffer', () => {
          const input = 'SGVsbG8gV29ybGQ';
          const decoded = base64UrlDecode(input);
          expect(decoded.toString('utf8')).toBe('Hello World');
        });

        it('should encode and decode back to the original buffer', () => {
          const originalStr = 'Testing base64url!';
          const originalBuffer = Buffer.from(originalStr, 'utf8');

          const encoded = base64UrlEncode(originalBuffer);
          const decoded = base64UrlDecode(encoded);

          expect(decoded.equals(originalBuffer)).toBe(true);
          expect(decoded.toString('utf8')).toBe(originalStr);
        });

        it('should throw ClientError if Buffer.from throws an error', () => {
          const originalBufferFrom = Buffer.from;
          // Mock Buffer.from to throw an error
          Buffer.from = jest.fn(() => {
            throw new Error('Decoding failed');
          }) as any;

          const validInput = 'SGVsbG8gV29ybGQ'; // "Hello World"

          expect(() => base64UrlDecode(validInput)).toThrow(ClientError);
          expect(() => base64UrlDecode(validInput)).toThrow(
            'Failed to decode base64url',
          );

          // Restore the original Buffer.from method
          Buffer.from = originalBufferFrom;
        });

        it('should handle padding correctly', () => {
          // Some Base64 strings require multiple '=' characters to pad out their length.
          // Let's test a scenario that would require padding.
          const originalStr = 'foo';
          const originalBuffer = Buffer.from(originalStr, 'utf8');

          const encoded = base64UrlEncode(originalBuffer);
          // "foo" in base64 is "Zm9v"
          // Base64url encoded: "Zm9v" (no padding needed in this case)
          expect(encoded).toBe('Zm9v');

          const decoded = base64UrlDecode(encoded);
          expect(decoded.toString('utf8')).toBe(originalStr);
        });

        it('should correctly handle characters that would normally be replaced in base64url', () => {
          // Test a value that includes '+' and '/' in its standard Base64 form.
          // For example, the byte 0xFB (in hex) is '+' and '/' in standard Base64. Let's try something that produces these chars.
          const inputBuffer = Buffer.from([0xfb, 0xff, 0x00]); // arbitrary bytes
          const encoded = base64UrlEncode(inputBuffer);
          // This would normally contain '+' and '/' in its Base64 representation.
          // Check that it's been replaced properly.
          expect(encoded).not.toContain('+');
          expect(encoded).not.toContain('/');

          const decoded = base64UrlDecode(encoded);
          expect(decoded.equals(inputBuffer)).toBe(true);
        });

        // New Error Handling Tests
        it('should throw ClientError if input is not a string', () => {
          expect(() => base64UrlDecode(null)).toThrow(ClientError);
          // @ts-expect-error Testing runtime behavior with invalid input
          expect(() => base64UrlDecode(123)).toThrow(ClientError);
          // @ts-expect-error Testing runtime behavior with invalid input
          expect(() => base64UrlDecode({})).toThrow(ClientError);
        });

        it('should throw ClientError if decoding fails due to malformed input', () => {
          const malformedInput = '!!!invalid-base64url!!!';
          expect(() => base64UrlDecode(malformedInput)).toThrow(ClientError);
        });
      });
    });

    describe('generateRandomString', () => {
      afterEach(() => {
        jest.resetAllMocks();
      });

      it('should generate a random string with default length', () => {
        const str = generateRandomString();
        expect(typeof str).toBe('string');
        expect(str).toHaveLength(64); // 32 bytes * 2 for HEX encoding
      });

      it('should generate a random string with specified length', () => {
        const length = 16;
        const str = generateRandomString(length);
        expect(str).toHaveLength(32); // 16 bytes * 2 for HEX encoding
      });

      it('should generate different strings on multiple calls', () => {
        const str1 = generateRandomString();
        const str2 = generateRandomString();
        expect(str1).not.toBe(str2);
      });

      it('should throw ClientError if length is not a positive integer', () => {
        // Test with zero
        expect(() => generateRandomString(0)).toThrow(ClientError);
        // Test with negative number
        expect(() => generateRandomString(-5)).toThrow(ClientError);
        // Test with non-integer number
        expect(() => generateRandomString(3.14)).toThrow(ClientError);
        // Test with non-number types
        // @ts-expect-error Testing runtime behavior with invalid input
        expect(() => generateRandomString('32')).toThrow(ClientError);

        expect(() => generateRandomString(null)).toThrow(ClientError);

        // @ts-expect-error Testing runtime behavior with invalid input
        expect(() => generateRandomString({})).toThrow(ClientError);
      });

      it('should throw ClientError if length exceeds maximum allowed', () => {
        const MAX_LENGTH = 1024;
        expect(() => generateRandomString(MAX_LENGTH + 1)).toThrow(ClientError);
      });

      it('should return a hexadecimal string', () => {
        const str = generateRandomString(10);
        // HEX characters are 0-9 and a-f
        expect(/^[a-f0-9]+$/.test(str)).toBe(true);
      });

      it('should handle maximum allowed length', () => {
        const MAX_LENGTH = 1024;
        const str = generateRandomString(MAX_LENGTH);
        expect(str).toHaveLength(MAX_LENGTH * 2); // HEX encoding
      });
    });
  });
});
