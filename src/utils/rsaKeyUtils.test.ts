// src/utils/rsaKeyConverter.test.ts

import { rsaJwkToPem } from './rsaKeyUtils';
import { BinaryToTextEncoding } from '../enums';
import { base64UrlDecode } from './urlUtils';

// Mock the base64UrlDecode function
jest.mock('./urlUtils', () => ({
  base64UrlDecode: jest.fn(),
}));

const mockedBase64UrlDecode = base64UrlDecode as jest.MockedFunction<
  typeof base64UrlDecode
>;

/**
 * Sample RSA JWK (Public Key)
 */
const n =
  'sXch6vZ3N9nndrQmbXEps2aiAFbWhM78LhWx4cbbfAAtQ9jYy5V9k7qJAsFDcQBUQM0E9sYbVjk40D19bXq9xLqGQ8GaPoVTVQeAUn0pFB1ZkWQQaTMeQFRt4ZtNTS7vkTl6T8tVQXoQoi8wS5fvAKX9uY4oVBcYecOgL';
const e = 'AQAB';

describe('rsaJwkToPem', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('should convert a valid RSA JWK to a PEM public key', () => {
    // Mock base64UrlDecode to return valid buffers
    mockedBase64UrlDecode.mockImplementation((input) =>
      Buffer.from(input, 'base64url'),
    );

    const pem = rsaJwkToPem(n, e);
    expect(pem).toMatch(/^-----BEGIN PUBLIC KEY-----\n/);
    expect(pem).toMatch(/\n-----END PUBLIC KEY-----$/);

    const base64Body = pem
      .replace('-----BEGIN PUBLIC KEY-----\n', '')
      .replace('\n-----END PUBLIC KEY-----', '')
      .replace(/\n/g, '');

    // Check if it's valid base64
    expect(() =>
      Buffer.from(base64Body, BinaryToTextEncoding.BASE_64),
    ).not.toThrow();
  });

  it('should throw "Invalid modulus (n), could not decode base64url" if base64UrlDecode(n) throws', () => {
    // Mock base64UrlDecode to throw an error when decoding 'n'
    mockedBase64UrlDecode.mockImplementation((input) => {
      if (input === '###') {
        throw new Error('Input contains invalid Base64URL characters');
      }
      return Buffer.from(input, 'base64url');
    });

    expect(() => rsaJwkToPem('###', e)).toThrow(
      'Invalid modulus (n), could not decode base64url',
    );
  });

  it('should throw "Invalid exponent (e), could not decode base64url" if base64UrlDecode(e) throws', () => {
    // Mock base64UrlDecode to throw an error when decoding 'e'
    mockedBase64UrlDecode.mockImplementation((input) => {
      if (input === '%%%') {
        throw new Error('Input contains invalid Base64URL characters');
      }
      return Buffer.from(input, 'base64url');
    });

    expect(() => rsaJwkToPem(n, '%%%')).toThrow(
      'Invalid exponent (e), could not decode base64url',
    );
  });

  it('should throw "Invalid modulus (n), could not decode base64url" if n is empty', () => {
    // Mock base64UrlDecode to return an empty buffer when 'n' is empty
    mockedBase64UrlDecode.mockImplementation((input) => {
      if (input === '') {
        return Buffer.from([]);
      }
      return Buffer.from(input, 'base64url');
    });

    expect(() => rsaJwkToPem('', e)).toThrow(
      'Invalid modulus (n), could not decode base64url',
    );
  });

  it('should throw "Invalid exponent (e), could not decode base64url" if e is empty', () => {
    // Mock base64UrlDecode to return an empty buffer when 'e' is empty
    mockedBase64UrlDecode.mockImplementation((input) => {
      if (input === '') {
        return Buffer.from([]);
      }
      return Buffer.from(input, 'base64url');
    });

    expect(() => rsaJwkToPem(n, '')).toThrow(
      'Invalid exponent (e), could not decode base64url',
    );
  });

  it('should throw "Invalid modulus (n), could not decode base64url" if base64UrlDecode(n) returns empty buffer', () => {
    // Mock base64UrlDecode to return an empty buffer for 'n'
    mockedBase64UrlDecode.mockImplementation((input) => {
      if (input === 'emptyN') {
        return Buffer.from([]);
      }
      return Buffer.from(input, 'base64url');
    });

    expect(() => rsaJwkToPem('emptyN', e)).toThrow(
      'Invalid modulus (n), could not decode base64url',
    );
  });

  it('should throw "Invalid exponent (e), could not decode base64url" if base64UrlDecode(e) returns empty buffer', () => {
    // Mock base64UrlDecode to return an empty buffer for 'e'
    mockedBase64UrlDecode.mockImplementation((input) => {
      if (input === 'emptyE') {
        return Buffer.from([]);
      }
      return Buffer.from(input, 'base64url');
    });

    expect(() => rsaJwkToPem(n, 'emptyE')).toThrow(
      'Invalid exponent (e), could not decode base64url',
    );
  });
});
