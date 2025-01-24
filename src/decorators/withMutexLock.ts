import { Mutex } from '../utils';
import { MetadataManager } from './MetadataManager';

export const WithMutexLock = (
  mutex: Mutex,
  timeout?: number,
): MethodDecorator => {
  return (target, propertyKey, descriptor: PropertyDescriptor) => {
    const originalMethod = descriptor.value;

    MetadataManager.setMethodMetadata(
      target.constructor,
      propertyKey as string,
      {
        isWithMutexLock: true,
        mutex,
        timeout,
      },
    );

    descriptor.value = async function (...args: any[]) {
      // Acquire the lock (with optional timeout)
      const release = await mutex.acquire(timeout);
      try {
        // Run the original method while lock is held
        return await originalMethod.apply(this, args);
      } finally {
        // Release the lock
        release();
      }
    };

    return descriptor;
  };
};
