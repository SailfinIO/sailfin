/**
 * @fileoverview
 * Utility function for parsing URL fragments into key-value pairs.
 * This module provides a `parseFragment` function that takes a URL fragment string
 * and converts it into a `Record<string, string>`. It includes input validation
 * to ensure the fragment is well-formed and handles decoding of URI components.
 *
 * @module src/utils/parseFragment
 */

import { ClientError } from '../errors/ClientError';

/**
 * Parses a URL fragment string into a key-value pair object.
 *
 * This function removes the leading `#` if present, splits the fragment by `&`,
 * and then by `=` to extract keys and values. It decodes URI components to handle
 * encoded characters. The function includes input validation to ensure the fragment
 * is a non-empty string and is well-formed.
 *
 * @param {string} fragment - The URL fragment string to parse.
 * @returns {Record<string, string>} An object containing the parsed key-value pairs.
 * @throws {ClientError} If `fragment` is not a string, is empty, or contains malformed key-value pairs.
 *
 * @example
 * ```typescript
 * const fragment = '#access_token=abc123&expires_in=3600';
 * const parsed = parseFragment(fragment);
 * console.log(parsed); // { access_token: 'abc123', expires_in: '3600' }
 * ```
 */
export const parseFragment = (fragment: string): Record<string, string> => {
  // Validate that fragment is a non-empty string
  if (typeof fragment !== 'string') {
    throw new ClientError('Fragment must be a string', 'INVALID_FRAGMENT_TYPE');
  }

  if (fragment.trim() === '') {
    throw new ClientError(
      'Fragment cannot be an empty string',
      'EMPTY_FRAGMENT',
    );
  }

  // Remove the leading '#' if present
  const hash = fragment.startsWith('#') ? fragment.slice(1) : fragment;

  // If the fragment is now empty after removing '#', return an empty object
  if (hash === '') {
    return {};
  }

  const pairs = hash.split('&');
  const result: Record<string, string> = {};

  for (const pair of pairs) {
    if (pair.trim() === '') {
      continue; // Skip empty pairs resulting from consecutive '&' or trailing '&'
    }

    const [key, value] = pair.split('=');

    // Check if key is present and not empty after trimming
    if (typeof key === 'undefined' || key.trim() === '') {
      throw new ClientError(
        `Malformed fragment segment: "${pair}"`,
        'MALFORMED_FRAGMENT',
      );
    }

    // Decode URI components and handle missing values
    try {
      const decodedKey = decodeURIComponent(key);
      if (decodedKey.trim() === '') {
        throw new ClientError(
          `Malformed fragment segment with empty key after decoding: "${pair}"`,
          'MALFORMED_FRAGMENT',
        );
      }
      const decodedValue =
        typeof value === 'undefined' ? '' : decodeURIComponent(value);
      result[decodedKey] = decodedValue;
    } catch (error) {
      throw new ClientError(
        `Failed to decode fragment segment: "${pair}"`,
        'DECODING_ERROR',
        error,
      );
    }
  }

  return result;
};
