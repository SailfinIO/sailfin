import { SailfinClientModule } from './SailfinClientModule';
import { SAILFIN_CLIENT } from '../constants/sailfinClientToken';
import { createSailfinClient } from '../utils';
import { Client } from './Client';
import { IClientConfig } from '../interfaces';

jest.mock('../utils', () => ({
  createSailfinClient: jest.fn(),
}));

describe('SailfinClientModule', () => {
  const mockClient = {} as Client;
  const mockConfig: Partial<IClientConfig> = { clientId: 'test-client-id' };

  beforeEach(() => {
    (createSailfinClient as jest.Mock).mockReturnValue({
      useFactory: jest.fn().mockResolvedValue(mockClient),
    });
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('forRoot', () => {
    it('should create and register an OIDC client instance', async () => {
      const dynamicModule = SailfinClientModule.forRoot(mockConfig);
      const clientProvider = dynamicModule.providers[0];

      expect(dynamicModule.module).toBe(SailfinClientModule);
      expect(dynamicModule.providers).toHaveLength(1);
      expect(dynamicModule.exports).toHaveLength(1);

      const clientInstance = await clientProvider.useFactory();
      expect(clientInstance).toBe(mockClient);
      expect(createSailfinClient).toHaveBeenCalledWith(mockConfig);
    });
  });

  describe('forRootAsync', () => {
    it('should create and register an OIDC client instance asynchronously', async () => {
      const configFactory = jest.fn().mockResolvedValue(mockConfig);
      const dynamicModule = SailfinClientModule.forRootAsync(configFactory);
      const clientProvider = dynamicModule.providers[0];

      expect(dynamicModule.module).toBe(SailfinClientModule);
      expect(dynamicModule.providers).toHaveLength(1);
      expect(dynamicModule.exports).toHaveLength(1);

      const clientInstance = await clientProvider.useFactory();
      expect(clientInstance).toBe(mockClient);
      expect(createSailfinClient).toHaveBeenCalledWith(mockConfig);
      expect(configFactory).toHaveBeenCalled();
    });
  });

  describe('getClient', () => {
    it('should retrieve an OIDC client instance by its token', async () => {
      SailfinClientModule.forRoot(mockConfig);
      const clientInstance =
        await SailfinClientModule.getClient(SAILFIN_CLIENT);

      expect(clientInstance).toBe(mockClient);
    });

    it('should throw an error if client instance is not found', async () => {
      await expect(
        SailfinClientModule.getClient(Symbol('INVALID_TOKEN')),
      ).rejects.toThrow('Client for token Symbol(INVALID_TOKEN) not found.');
    });
  });
});
