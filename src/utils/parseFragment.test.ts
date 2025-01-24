/**
 * @fileoverview
 * Test suite for the `parseFragment` utility function.
 * This suite ensures that the `parseFragment` function correctly parses
 * URL fragments under various scenarios, including valid fragments,
 * handling of empty or malformed fragments, and decoding of URI components.
 *
 * @module src/utils/parseFragment.test
 */

import { parseFragment } from './parseFragment';
import { ClientError } from '../errors/ClientError';

describe('parseFragment', () => {
  it('should parse a simple fragment correctly', () => {
    const fragment = '#access_token=abc123&expires_in=3600';
    const expected = {
      access_token: 'abc123',
      expires_in: '3600',
    };
    expect(parseFragment(fragment)).toEqual(expected);
  });

  it('should handle fragments without a leading hash', () => {
    const fragment = 'token=xyz&status=active';
    const expected = {
      token: 'xyz',
      status: 'active',
    };
    expect(parseFragment(fragment)).toEqual(expected);
  });

  it('should return an empty object for a fragment with only a hash', () => {
    const fragment = '#';
    const expected = {};
    expect(parseFragment(fragment)).toEqual(expected);
  });

  it('should return an empty object for an empty string', () => {
    const fragment = '';
    expect(() => parseFragment(fragment)).toThrow(ClientError);
  });

  it('should throw ClientError if fragment is not a string', () => {
    expect(() => parseFragment(null)).toThrow(ClientError);

    expect(() => parseFragment(undefined)).toThrow(ClientError);

    // @ts-expect-error Testing runtime behavior with invalid input
    expect(() => parseFragment(123)).toThrow(ClientError);

    // @ts-expect-error Testing runtime behavior with invalid input
    expect(() => parseFragment({})).toThrow(ClientError);
  });

  it('should handle fragments with empty values', () => {
    const fragment = '#key1=&key2=value2';
    const expected = {
      key1: '',
      key2: 'value2',
    };
    expect(parseFragment(fragment)).toEqual(expected);
  });

  it('should skip empty pairs and not throw', () => {
    const fragment = '#key1=value1&&key2=value2&';
    const expected = {
      key1: 'value1',
      key2: 'value2',
    };
    expect(parseFragment(fragment)).toEqual(expected);
  });

  it('should throw ClientError for malformed fragment segments', () => {
    const fragment = '#key1=value1&=value2&key3=value3';
    expect(() => parseFragment(fragment)).toThrow(ClientError);
  });

  it('should handle URI encoded characters correctly', () => {
    const fragment = '#name=John%20Doe&city=New%20York';
    const expected = {
      name: 'John Doe',
      city: 'New York',
    };
    expect(parseFragment(fragment)).toEqual(expected);
  });

  it('should throw ClientError if decoding fails', () => {
    // Invalid URI sequence
    const fragment = '#key=%E0%A4%A';
    expect(() => parseFragment(fragment)).toThrow(ClientError);
  });

  it('should handle multiple identical keys by overwriting', () => {
    const fragment = '#key=first&key=second';
    const expected = {
      key: 'second',
    };
    expect(parseFragment(fragment)).toEqual(expected);
  });

  it('should handle fragments with no key but with value', () => {
    const fragment = '#=value';
    expect(() => parseFragment(fragment)).toThrow(ClientError);
  });

  it('should handle fragments with keys but no values', () => {
    const fragment = '#key1&key2=';
    const expected = {
      key1: '',
      key2: '',
    };
    expect(parseFragment(fragment)).toEqual(expected);
  });

  it('should throw ClientError if key is empty after decoding', () => {
    // The fragment contains an encoded empty key
    const fragment = '#%20=value'; // "%20" decodes to a space, which becomes an empty key after trimming
    expect(() => parseFragment(fragment)).toThrow(ClientError);
    expect(() => parseFragment(fragment)).toThrow(
      'Failed to decode fragment segment: "%20=value"',
    );
  });
});
