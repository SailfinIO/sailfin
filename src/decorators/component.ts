import { DependencyScope } from '../enums';
import { MetadataManager } from './MetadataManager';

export interface AbstractType<T> extends Function {
  prototype: T;
}

export interface DeferredReference<T = any> {
  resolveRef: T;
}

export type DependencyToken<T = any> =
  | string
  | symbol
  | Constructable<T>
  | AbstractType<T>
  | Function;

export interface DynamicComponent {
  component: any;
  dependencies?: Dependency[];
  exports?: any[];
  imports?: any[];
  handlers?: any[];
  universal?: boolean;
}

/**
 * Interface defining a class-based dependency configuration.
 */
export interface ClassDependency<T = any> {
  /**
   * Dependency token.
   */
  token: DependencyToken;
  /**
   * Class to instantiate as the dependency.
   */
  implementation: Constructable<T>;
  /**
   * Optional scope of the dependency.
   */
  dependencyScope?: DependencyScope;
  /**
   * This option is not applicable to class dependencies.
   */
  resolveDependency?: never;
  /**
   * Marks the dependency as durable for scoped contexts.
   */
  persistent?: boolean;
}

/**
 * Interface defining a value-based dependency configuration.
 */
export interface ValueDependency<T = any> {
  /**
   * Dependency token.
   */
  token: DependencyToken;
  /**
   * The value to be used as the dependency.
   */
  value: T;
  /**
   * This option is not applicable to value dependency.
   */
  inject?: never;
}

/**
 * Interface defining a factory-based dependency configuration.
 */
export interface FactoryDependency<T = any> {
  /**
   * Dependency token.
   */
  token: DependencyToken;
  /**
   * Factory function to create the dependency instance.
   */
  factory: (...args: any[]) => T | Promise<T>;
  /**
   * List of dependencies to inject into the factory function.
   */
  dependencies?: Array<DependencyToken | OptionalFactoryDependency>;
  /**
   * Optional scope of the dependency.
   */
  dependencyScope?: DependencyScope;
  /**
   * Marks the dependency as durable for scoped contexts.
   */
  persistent?: boolean;
}

/**
 * Interface defining an alias-based dependency configuration.
 */
export interface AliasDependency<T = any> {
  /**
   * Dependency token.
   */
  token: DependencyToken;
  /**
   * The dependency to alias by the token.
   */
  alias: any;
}

export interface Constructable<T = any> extends Function {
  new (...args: any[]): T;
}

export type Dependency<T = any> =
  | Constructable<any>
  | ClassDependency<T>
  | ValueDependency<T>
  | FactoryDependency<T>
  | AliasDependency<T>;

export interface ComponentConfig {
  /**
   * List of imported components that export required dependencies.
   */
  dependencies?: Array<
    | Constructable<any>
    | DynamicComponent
    | Promise<DynamicComponent>
    | DeferredReference
  >;
  /**
   * List of handlers defined in this module.
   */
  handlers?: Constructable<any>[];
  /**
   * List of providers instantiated by the dependency injector.
   */
  services?: Dependency[];
  /**
   * List of exported providers to make available to other modules.
   */
  exports?: Array<
    | DynamicComponent
    | Promise<DynamicComponent>
    | string
    | symbol
    | Dependency
    | DeferredReference
    | AbstractType<any>
    | Function
  >;
}

export type OptionalFactoryDependency = {
  token: DependencyToken;
  optional: boolean;
};

export const Component = (metadata: ComponentConfig): ClassDecorator => {
  return (target: Function) => {
    MetadataManager.setClassMetadata(target, { component: metadata });
  };
};
