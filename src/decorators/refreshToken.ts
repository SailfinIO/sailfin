import { MetadataManager } from './MetadataManager';
import { IStoreContext } from '../interfaces';
import { Client } from '../classes/Client';
import { StatusCode } from '../enums';
import { HttpException } from '../errors/HttpExeption';

/**
 * Decorator to refresh the token before executing the method.
 */
export const RefreshToken = (): MethodDecorator => {
  return (
    target: any,
    propertyKey: string | symbol,
    descriptor: PropertyDescriptor,
  ) => {
    MetadataManager.setMethodMetadata(
      target.constructor,
      propertyKey as string,
      { requiresRefresh: true },
    );

    const originalMethod = descriptor.value;

    descriptor.value = async function (
      this: { client: Client },
      ...args: any[]
    ) {
      const req: any = args[0];
      const res: any = args[1];
      const client: Client = this.client;
      const logger = client ? client.getLogger() : console;

      logger.debug('RefreshToken decorator invoked', {
        method: propertyKey.toString(),
      });

      // Check for missing request or response objects
      if (!req || !res) {
        const message = 'Invalid parameters: Missing request or response.';
        logger.error(message, { req, res });
        if (res && typeof res.status === 'function') {
          return res.status(StatusCode.BAD_REQUEST).send(message);
        }
        throw new HttpException(message, StatusCode.BAD_REQUEST);
      }

      // Check if client is available
      if (!client) {
        const message = 'Server configuration error: Client not available';
        logger.error(message);
        if (res && typeof res.status === 'function') {
          return res.status(StatusCode.INTERNAL_SERVER_ERROR).send(message);
        }
        throw new HttpException(message, StatusCode.INTERNAL_SERVER_ERROR);
      }

      const context: IStoreContext = { request: req, response: res };

      try {
        logger.debug('Attempting silent token renewal', { context });
        await client.silentRenew(context);
        logger.info('Token successfully refreshed');
      } catch (error) {
        const message = 'Token refresh failed';
        logger.error('Silent token renewal failed', { error, context });
        if (res && typeof res.status === 'function') {
          return res.status(StatusCode.INTERNAL_SERVER_ERROR).send(message);
        }
        throw new HttpException(message, StatusCode.INTERNAL_SERVER_ERROR);
      }

      logger.debug('Proceeding with original method after token refresh', {
        method: propertyKey.toString(),
      });
      return originalMethod.apply(this, args);
    };

    return descriptor;
  };
};
