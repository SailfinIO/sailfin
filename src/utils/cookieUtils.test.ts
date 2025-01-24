// src/middleware/cookieUtils.test.ts

import { parseCookies } from '../utils/cookieUtils';
import { parse } from '../utils/Cookie';

jest.mock('../utils/Cookie');

describe('parseCookies', () => {
  afterEach(() => {
    jest.clearAllMocks();
    jest.restoreAllMocks();
  });

  it('should return an empty object if no Cookie header is present', () => {
    const headers = new Map<string, string>();
    expect(parseCookies(headers)).toEqual({});
  });

  it('should parse cookies correctly when Cookie header is present', () => {
    const headers = new Map<string, string>([
      ['cookie', 'sessionId=abc123; userId=xyz789'],
    ]);
    const parsed = { sessionId: 'abc123', userId: 'xyz789' };
    (parse as jest.Mock).mockReturnValue(parsed);

    expect(parseCookies(headers)).toEqual(parsed);
    expect(parse).toHaveBeenCalledWith('sessionId=abc123; userId=xyz789');
  });

  it('should parse cookies correctly regardless of header casing', () => {
    const headers = new Map<string, string>([
      ['COOKIE', 'sessionId=abc123; userId=xyz789'],
    ]);
    const parsed = { sessionId: 'abc123', userId: 'xyz789' };
    (parse as jest.Mock).mockReturnValue(parsed);

    expect(parseCookies(headers)).toEqual(parsed);
    expect(parse).toHaveBeenCalledWith('sessionId=abc123; userId=xyz789');
  });
  it('should return an empty object and log an error if parsing fails (Plain Object)', () => {
    const headers = new Map<string, string>([['cookie', 'invalid-cookie']]);
    const error = new Error('Parse error');

    // Mock the parse function to throw an error
    (parse as jest.Mock).mockImplementation(() => {
      throw error;
    });

    // Spy on console.error
    const consoleErrorSpy = jest.spyOn(console, 'error').mockImplementation();

    // Call the function under test
    const result = parseCookies(headers);

    // Assert the result is an empty object
    expect(result).toEqual({});

    // Assert the parse function was called with the correct argument
    expect(parse).toHaveBeenCalledWith('invalid-cookie');

    // Assert that console.error was called with the correct error message
    expect(consoleErrorSpy).toHaveBeenCalledWith(
      'Failed to parse cookies:',
      error,
    );

    // Restore the original console.error implementation
    consoleErrorSpy.mockRestore();
  });
});
