import { KeyFactory } from './KeyFactory';

describe('KeyFactory', () => {
  it('should return the same key for the same function', () => {
    const fn = () => {};
    const key1 = KeyFactory.getKeyForFunction(fn);
    const key2 = KeyFactory.getKeyForFunction(fn);
    expect(key1).toBe(key2);
    expect(key1).toMatch(/^ctor_\d+$/);
  });

  it('should return different keys for different functions', () => {
    const fn1 = () => {};
    const fn2 = () => {};
    const key1 = KeyFactory.getKeyForFunction(fn1);
    const key2 = KeyFactory.getKeyForFunction(fn2);
    expect(key1).not.toBe(key2);
  });

  it('should increment counter each time a new function is assigned', () => {
    class TestClass {}
    const key1 = KeyFactory.getKeyForFunction(TestClass);
    class AnotherClass {}
    const key2 = KeyFactory.getKeyForFunction(AnotherClass);
    expect(key2).not.toBe(key1);
  });
});
