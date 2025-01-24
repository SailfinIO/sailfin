import { Mutex } from '../utils';
import { MetadataManager } from './MetadataManager';

export const WithMutexLockExclusive = (
  mutex: Mutex,
  timeout?: number,
): MethodDecorator => {
  return (target, propertyKey, descriptor: PropertyDescriptor) => {
    const originalMethod = descriptor.value;

    // Optionally store metadata in case you need to inspect it later
    MetadataManager.setMethodMetadata(
      target.constructor,
      propertyKey as string,
      {
        isWithMutexLock: true, // or "isWithMutexLockExclusive"
        mutex,
        timeout,
      },
    );

    // Wrap the original method with runExclusive
    descriptor.value = async function (...args: any[]) {
      // runExclusive automatically acquires and releases the lock
      return mutex.runExclusive(async () => {
        return await originalMethod.apply(this, args);
      }, timeout);
    };

    return descriptor;
  };
};
