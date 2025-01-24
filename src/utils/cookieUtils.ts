// src/utils/cookieUtils.ts

import { RequestHeaders, RequestCookies } from '../interfaces';
import { parse } from './Cookie';

/**
 * Parses the 'Cookie' header from the request and returns a parsed cookies object.
 *
 * @param {RequestHeaders} headers - The headers object from the request.
 * @returns {RequestCookies} The parsed cookies as a key-value object.
 */
export const parseCookies = (headers: RequestHeaders): RequestCookies => {
  let cookieHeader: string | string[] | undefined;

  // Iterate through the headers to find 'cookie' key case-insensitively
  if (headers instanceof Map) {
    for (const [key, value] of headers.entries()) {
      if (key.toLowerCase() === 'cookie') {
        cookieHeader = value;
        break;
      }
    }
  } else {
    for (const [key, value] of Object.entries(headers)) {
      if (key.toLowerCase() === 'cookie') {
        // @ts-ignore fallback to string if array is not present
        cookieHeader = value;
        break;
      }
    }
  }

  if (!cookieHeader) {
    return {}; // No cookies present
  }

  let cookieString = '';

  if (typeof cookieHeader === 'string') {
    cookieString = cookieHeader;
  } else if (Array.isArray(cookieHeader)) {
    // Combine multiple 'Cookie' headers into a single string as per RFC
    cookieString = cookieHeader.join('; ');
  } else {
    // Unexpected type, log error and return empty object
    console.error('Unexpected cookie header format:', cookieHeader);
    return {};
  }

  try {
    // Parse the combined cookie string into a key-value object
    return parse(cookieString) as RequestCookies;
  } catch (error) {
    console.error('Failed to parse cookies:', error);
    return {}; // Return an empty object if parsing fails
  }
};
