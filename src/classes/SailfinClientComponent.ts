import { IClientConfig } from '../interfaces';
import { Client } from './Client';
import { SAILFIN_CLIENT } from '../constants/sailfinClientToken';
import { createSailfinClient } from '../utils';
import { Dependency, DynamicComponent } from '../decorators/component';
import { DependencyScope } from '../enums';

export class SailfinClientComponent {
  private static instances = new Map<symbol, Promise<Client>>();

  /**
   * Creates and registers an OIDC client instance.
   */
  static forRoot(config: Partial<IClientConfig>): DynamicComponent {
    const clientDependency: Dependency = {
      token: SAILFIN_CLIENT,
      factory: async () => {
        const instance = createSailfinClient(config).useFactory();
        this.instances.set(SAILFIN_CLIENT, instance);
        return instance;
      },
      dependencies: [],
      dependencyScope: DependencyScope.SINGLETON,
    };

    return {
      component: SailfinClientComponent,
      dependencies: [clientDependency],
      exports: [SAILFIN_CLIENT],
    };
  }

  /**
   * Creates and registers an OIDC client instance asynchronously.
   *
   * @param {() => Promise<Partial<IClientConfig>>} configFactory - Factory function to provide config.
   * @returns {DynamicComponent} - The dynamic component with the client dependency.
   */
  static forRootAsync(
    configFactory: () => Promise<Partial<IClientConfig>>,
  ): DynamicComponent {
    const clientDependency: Dependency = {
      token: SAILFIN_CLIENT,
      factory: async () => {
        const userConfig = await configFactory();
        const dependency = createSailfinClient(userConfig);
        const client = await dependency.useFactory();
        return client;
      },
      dependencies: [],
    };

    return {
      component: SailfinClientComponent,
      dependencies: [clientDependency],
      exports: [SAILFIN_CLIENT],
    };
  }
  /**
   * Retrieves an OIDC client instance by its token.
   */
  static async getClient(token: symbol): Promise<Client> {
    const instance = this.instances.get(token);
    if (!instance) {
      throw new Error(`Client for token ${String(token)} not found.`);
    }
    return instance;
  }
}
