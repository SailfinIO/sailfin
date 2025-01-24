import { DependencyScope } from './DependencyScope';

export interface DependencyScopeOptions {
  /**
   * Specifies the lifetime of an injected Provider or Controller.
   */
  dependency?: DependencyScope;
  /**
   * Flags provider as durable. This flag can be used in combination with custom context id
   * factory strategy to construct lazy DI subtrees.
   *
   * This flag can be used only in conjunction with scope = Scope.REQUEST.
   */
  durable?: boolean;
}
