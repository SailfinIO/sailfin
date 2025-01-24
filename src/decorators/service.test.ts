import { Service, ResolveDependency } from './service';
import { MetadataManager } from './MetadataManager';

describe('Injection Decorators', () => {
  afterEach(() => {
    MetadataManager.reset();
  });
  it('should define metadata on the target class', () => {
    @Service()
    class TestClass {}

    const metadata = MetadataManager.getClassMetadata(TestClass)?.injectable;
  });

  it('should define metadata with default options if none are provided', () => {
    @Service()
    class TestClass {}

    const metadata = MetadataManager.getClassMetadata(TestClass)?.injectable;
    expect(metadata).toBeUndefined();
  });

  it('should define metadata on the target property', () => {
    class TestClass {
      @ResolveDependency(String)
      public testProperty!: string;
    }

    const metadata = MetadataManager.getMethodMetadata(
      TestClass,
      'testProperty',
    )?.inject;
    expect(metadata).toBe(String);
  });

  it('should define metadata on the target parameter', () => {
    class TestClass {
      constructor(@ResolveDependency('testToken') testParam: any) {}
    }

    const metadata = MetadataManager.getMethodMetadata(
      TestClass,
      'constructor',
    )?.inject;
    expect(metadata).toEqual(['testToken']);
  });

  it('should define metadata with a custom token', () => {
    class TestClass {
      @ResolveDependency('customToken')
      public testProperty!: string;
    }

    const metadata = MetadataManager.getMethodMetadata(
      TestClass,
      'testProperty',
    )?.inject;
    expect(metadata).toBe('customToken');
  });

  it('should define metadata on multiple parameters', () => {
    class TestClass {
      constructor(
        @ResolveDependency('token1') param1: any,
        @ResolveDependency('token2') param2: any,
      ) {}
    }

    const metadata = MetadataManager.getMethodMetadata(
      TestClass,
      'constructor',
    )?.inject;
    expect(metadata).toEqual(['token1', 'token2']);
  });
});
