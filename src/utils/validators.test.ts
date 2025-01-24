// src/utils/validators.test.ts
import {
  validateCookieName,
  validateCookieValue,
  validateDomain,
  validatePath,
} from './validators';
import { CookieError } from '../errors/CookieError';

describe('validators', () => {
  describe('validateCookieName', () => {
    it('should validate a correct cookie name', () => {
      expect(() => validateCookieName('valid_cookie_name')).not.toThrow();
    });

    it('should throw an error for an invalid cookie name', () => {
      expect(() => validateCookieName('invalid cookie name')).toThrow(
        CookieError,
      );
    });
  });

  describe('validateCookieValue', () => {
    it('should validate a correct cookie value', () => {
      expect(() => validateCookieValue('valid_cookie_value')).not.toThrow();
    });

    it('should throw an error for an invalid cookie value', () => {
      expect(() => validateCookieValue('invalid cookie value')).toThrow(
        CookieError,
      );
    });
  });

  describe('validateDomain', () => {
    it('should validate a correct domain', () => {
      expect(() => validateDomain('example.com')).not.toThrow();
    });

    it('should throw an error for an invalid domain', () => {
      expect(() => validateDomain('invalid domain')).toThrow(CookieError);
    });
  });

  describe('validatePath', () => {
    it('should validate a correct path', () => {
      expect(() => validatePath('/valid/path')).not.toThrow();
    });

    it('should throw an error for an invalid path', () => {
      expect(() => validatePath('invalid path')).toThrow(CookieError);
    });
  });
});
