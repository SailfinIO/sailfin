import { capitalize, camelToKebab } from './helpers';

// src/utils/helpers.test.ts

describe('capitalize', () => {
  it('should capitalize the first letter of a string', () => {
    expect(capitalize('hello')).toBe('Hello');
  });

  it('should return an empty string if input is empty', () => {
    expect(capitalize('')).toBe('');
  });

  it('should not change the case of other letters', () => {
    expect(capitalize('hELLO')).toBe('HELLO');
  });
});

describe('camelToKebab', () => {
  it('should convert camelCase to kebab-case', () => {
    expect(camelToKebab('maxAge')).toBe('max-age');
  });

  it('should handle strings with multiple uppercase letters', () => {
    expect(camelToKebab('backgroundColor')).toBe('background-color');
  });

  it('should return the same string if there are no uppercase letters', () => {
    expect(camelToKebab('background')).toBe('background');
  });

  it('should handle empty strings', () => {
    expect(camelToKebab('')).toBe('');
  });
});
