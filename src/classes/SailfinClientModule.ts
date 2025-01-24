import { IClientConfig, DynamicModule } from '../interfaces';
import { Client } from './Client';
import { SAILFIN_CLIENT } from '../constants/sailfinClientToken';
import { createSailfinClient } from '../utils';
import { Provider } from '../types';

export class SailfinClientModule {
  private static instances = new Map<symbol, Promise<Client>>();

  /**
   * Creates and registers an OIDC client instance.
   */
  static forRoot(config: Partial<IClientConfig>): DynamicModule {
    const clientProvider: Provider = {
      provide: SAILFIN_CLIENT,
      useFactory: async () => {
        const instance = createSailfinClient(config).useFactory();
        this.instances.set(SAILFIN_CLIENT, instance);
        return instance;
      },
      inject: [],
      scope: 0,
    };

    return {
      module: SailfinClientModule,
      providers: [clientProvider],
      exports: [SAILFIN_CLIENT],
    };
  }

  /**
   * Creates and registers an OIDC client instance asynchronously.
   *
   * @param {() => Promise<Partial<IClientConfig>>} configFactory - Factory function to provide config.
   * @returns {DynamicModule} - The dynamic module with the client provider.
   */
  static forRootAsync(
    configFactory: () => Promise<Partial<IClientConfig>>,
  ): DynamicModule {
    const clientProvider: Provider = {
      provide: SAILFIN_CLIENT,
      useFactory: async () => {
        const userConfig = await configFactory();
        const provider = createSailfinClient(userConfig);
        const client = await provider.useFactory();
        return client;
      },
      inject: [],
    };

    return {
      module: SailfinClientModule,
      providers: [clientProvider],
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
