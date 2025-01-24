import { NullObject } from './NullObject';

// src/utils/NullObject.test.ts

describe('NullObject', () => {
  it('should create an object with no prototype', () => {
    const obj = new NullObject();
    expect(Object.getPrototypeOf(obj)).toBeNull();
  });

  it('should allow setting and getting properties', () => {
    const obj = new NullObject();
    obj.testProperty = 'testValue';
    expect(obj.testProperty).toBe('testValue');
  });

  it('should not inherit properties from Object.prototype', () => {
    const obj = new NullObject();
    expect(obj.hasOwnProperty).toBeUndefined();
    expect(obj.toString).toBeUndefined();
  });
});
