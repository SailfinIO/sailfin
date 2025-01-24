import { WithMutexLockExclusive } from './withMutexLockExclusive';
import { Mutex } from '../utils';
import { MetadataManager } from './MetadataManager';

describe('WithMutexLockExclusive', () => {
  let mutex: Mutex;
  let mockMethod: jest.Mock;
  let target: any;
  let propertyKey: string;
  let descriptor: PropertyDescriptor;

  beforeEach(() => {
    mutex = new Mutex();
    mockMethod = jest.fn();
    target = {};
    propertyKey = 'testMethod';
    descriptor = {
      value: mockMethod,
    };

    jest.spyOn(MetadataManager, 'setMethodMetadata');
    jest
      .spyOn(mutex, 'runExclusive')
      .mockImplementation(async (fn) => await fn());
  });

  it('should set method metadata', () => {
    const decorator = WithMutexLockExclusive(mutex);
    decorator(target, propertyKey, descriptor);

    expect(MetadataManager.setMethodMetadata).toHaveBeenCalledWith(
      target.constructor,
      propertyKey,
      {
        isWithMutexLock: true,
        mutex,
        timeout: undefined,
      },
    );
  });

  it('should wrap the original method with runExclusive', async () => {
    const decorator = WithMutexLockExclusive(mutex);
    decorator(target, propertyKey, descriptor);

    const args = [1, 2, 3];
    await descriptor.value(...args);

    expect(mutex.runExclusive).toHaveBeenCalled();
    expect(mockMethod).toHaveBeenCalledWith(...args);
  });

  it('should pass the timeout to runExclusive', async () => {
    const timeout = 5000;
    const decorator = WithMutexLockExclusive(mutex, timeout);
    decorator(target, propertyKey, descriptor);

    const args = [1, 2, 3];
    await descriptor.value(...args);

    expect(mutex.runExclusive).toHaveBeenCalledWith(
      expect.any(Function),
      timeout,
    );
  });
});
