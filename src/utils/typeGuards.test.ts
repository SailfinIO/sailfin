import { isDate } from './typeGuards';

// src/utils/typeGuards.test.ts

describe('isDate', () => {
  it('should return true for Date instances', () => {
    expect(isDate(new Date())).toBe(true);
  });

  it('should return false for non-Date instances', () => {
    expect(isDate('2023-01-01')).toBe(false);
    expect(isDate(1672531199000)).toBe(false);
    expect(isDate({})).toBe(false);
    expect(isDate(null)).toBe(false);
    expect(isDate(undefined)).toBe(false);
    expect(isDate([])).toBe(false);
  });
});
