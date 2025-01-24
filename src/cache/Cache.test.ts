import { Cache } from './Cache';
import { ClientError } from '../errors/ClientError';

describe('Cache', () => {
  let cache: Cache<string>;
  let mockLogger: any;

  beforeEach(() => {
    mockLogger = {
      debug: jest.fn(),
      error: jest.fn(),
    };
    cache = new Cache<string>(mockLogger, 1000); // 1 second TTL for testing
  });

  test('should set and get a value', () => {
    cache.set('key1', 'value1');
    expect(cache.get('key1')).toBe('value1');
    expect(mockLogger.debug).toHaveBeenCalledWith('Cache hit for key: key1');
  });

  test('should return undefined for non-existent key', () => {
    expect(cache.get('unknown')).toBeUndefined();
    expect(mockLogger.debug).toHaveBeenCalledWith(
      'Cache miss for key: unknown',
    );
  });

  test('should expire a key after TTL', (done) => {
    cache.set('key2', 'value2', 500); // 0.5 second TTL
    setTimeout(() => {
      expect(cache.get('key2')).toBeUndefined();
      expect(mockLogger.debug).toHaveBeenCalledWith(
        'Cache expired for key: key2',
      );
      done();
    }, 600);
  });

  test('should delete a key', () => {
    cache.set('key3', 'value3');
    cache.delete('key3');
    expect(cache.get('key3')).toBeUndefined();
    expect(mockLogger.debug).toHaveBeenCalledWith(
      'Deleted cache for key: key3',
    );
  });

  test('should return false for non-existent key', () => {
    cache.delete('unknown');
    expect(mockLogger.debug).toHaveBeenCalledWith(
      'Attempted to delete non-existent key: unknown',
    );
  });

  test('should throw ClientError for invalid key', () => {
    expect(() => cache.set('', 'value')).toThrow(ClientError);
    expect(mockLogger.error).toHaveBeenCalledWith('Invalid key provided: ""');
  });

  test('should throw ClientError for invalid value', () => {
    expect(() => cache.set('key4', null)).toThrow(ClientError);
    expect(mockLogger.error).toHaveBeenCalledWith(
      'Invalid value provided: null',
    );
  });

  test('should throw ClientError for invalid TTL', () => {
    expect(() => cache.set('key5', 'value5', -100)).toThrow(ClientError);
    expect(mockLogger.error).toHaveBeenCalledWith('Invalid TTL provided: -100');
  });

  test('should clear all entries', () => {
    cache.set('key6', 'value6');
    cache.set('key7', 'value7');
    cache.clear();
    expect(cache.size()).toBe(0);
    expect(mockLogger.debug).toHaveBeenCalledWith('Cleared all cache entries.');
  });

  test('should throw ClientError for clear error', () => {
    const error = new Error('Test error');
    (cache as any).store.clear = jest.fn(() => {
      throw error;
    });
    expect(() => cache.clear()).toThrow(ClientError);
    expect(mockLogger.error).toHaveBeenCalledWith('Failed to clear cache.', {
      error,
    });
  });
});
