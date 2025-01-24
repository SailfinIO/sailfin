import { WithMutexLock } from './withMutexLock';
import { Mutex } from '../utils';
import { MetadataManager } from './MetadataManager';

describe('WithMutexLock', () => {
  let mutex: Mutex;
  let mockMethod: jest.Mock;
  let mockRelease: jest.Mock;

  beforeEach(() => {
    mutex = {
      acquire: jest.fn(),
    } as unknown as Mutex;
    mockMethod = jest.fn();
    mockRelease = jest.fn();
    (mutex.acquire as jest.Mock).mockResolvedValue(mockRelease);
    jest.spyOn(MetadataManager, 'setMethodMetadata');
  });

  it('should set method metadata correctly', () => {
    class TestClass {
      @WithMutexLock(mutex, 1000)
      async testMethod() {
        return 'test';
      }
    }

    const instance = new TestClass();
    expect(MetadataManager.setMethodMetadata).toHaveBeenCalledWith(
      TestClass,
      'testMethod',
      {
        isWithMutexLock: true,
        mutex,
        timeout: 1000,
      },
    );
  });

  it('should acquire and release the lock', async () => {
    class TestClass {
      @WithMutexLock(mutex)
      async testMethod() {
        mockMethod();
      }
    }

    const instance = new TestClass();
    await instance.testMethod();

    expect(mutex.acquire).toHaveBeenCalled();
    expect(mockMethod).toHaveBeenCalled();
    expect(mockRelease).toHaveBeenCalled();
  });

  it('should pass arguments to the original method', async () => {
    class TestClass {
      @WithMutexLock(mutex)
      async testMethod(arg1: string, arg2: number) {
        mockMethod(arg1, arg2);
      }
    }

    const instance = new TestClass();
    await instance.testMethod('arg1', 2);

    expect(mockMethod).toHaveBeenCalledWith('arg1', 2);
  });

  it('should release the lock even if the method throws an error', async () => {
    class TestClass {
      @WithMutexLock(mutex)
      async testMethod() {
        throw new Error('test error');
      }
    }

    const instance = new TestClass();
    await expect(instance.testMethod()).rejects.toThrow('test error');

    expect(mockRelease).toHaveBeenCalled();
  });
});
