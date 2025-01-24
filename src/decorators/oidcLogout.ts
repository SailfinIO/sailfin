import { MetadataManager } from './MetadataManager';
import { IMethodMetadata, IStoreContext } from '../interfaces';
import { Client } from '../classes/Client';
import { HttpException, HttpStatus } from '@nestjs/common';
import { StatusCode } from '../enums';

export interface OidcLogoutOptions {
  postLogoutRedirectUri?: string;
  onError?: (error: any, context: IStoreContext) => void;
  idTokenHint?: string;
}

const handleLogoutError = (
  error: any,
  context: IStoreContext,
  options?: OidcLogoutOptions,
) => {
  console.error('OIDC Logout Error:', error);
  const { response } = context;
  if (options?.onError) {
    options.onError(error, context);
  } else if (response) {
    response.status(StatusCode.INTERNAL_SERVER_ERROR).send('Logout failed');
  } else {
    throw new HttpException('Logout failed', HttpStatus.INTERNAL_SERVER_ERROR);
  }
};

export const OidcLogout = (options?: OidcLogoutOptions): MethodDecorator => {
  return (
    target: any,
    propertyKey: string | symbol,
    descriptor: PropertyDescriptor,
  ) => {
    MetadataManager.setMethodMetadata(
      target.constructor,
      propertyKey as string,
      {} as IMethodMetadata,
    );

    const originalMethod = descriptor.value;

    descriptor.value = async function (
      this: { client: Client },
      ...args: any[]
    ) {
      const req: any = args[0];
      const res: any = args[1];

      if (!req || !res) {
        if (res) {
          res
            .status(StatusCode.BAD_REQUEST)
            .send('Invalid callback parameters: Missing request or response.');
        }
        return;
      }

      const client: Client = this.client;
      const logger = client ? client.getLogger() : console;
      const context: IStoreContext = { request: req, response: res, extra: {} };

      try {
        // Log beginning of logout process
        logger.debug('Starting OIDC logout process', { requestId: req.id });

        // Clear local session if it exists
        if (req.session) {
          logger.debug('Session found. Attempting to clear session...', {
            session: req.session,
          });

          const sessionStore = client.getSessionStore();
          const sessionCookieName =
            client.getConfig().session?.cookie?.name || 'sid';
          const sessionId = req.cookies
            ? req.cookies[sessionCookieName]
            : undefined;

          if (sessionId && sessionStore) {
            logger.debug('Destroying session in store', { sessionId });
            await sessionStore.destroy(sessionId, context);
          }

          // Clear session using setSession or direct assignment
          if (typeof req.setSession === 'function') {
            logger.debug('Clearing session using setSession');
            req.setSession({});
          } else {
            logger.debug('Clearing session by direct assignment');
            req.session = {};
          }
        } else {
          logger.debug('No session found to clear');
        }

        // Obtain logout URL from client, optionally passing idTokenHint
        logger.debug('Obtaining logout URL', {
          idTokenHint: options?.idTokenHint,
        });
        const logoutUrl = await client.logout(options?.idTokenHint);
        logger.debug('Logout URL obtained', { logoutUrl });

        // Redirect user to logout URL if response object is available
        if (res) {
          logger.debug('Redirecting user to logout URL');
          return res.redirect(logoutUrl);
        } else {
          logger.error('Response object not available for redirection');
          throw new HttpException(
            'Response object not available',
            HttpStatus.INTERNAL_SERVER_ERROR,
          );
        }
      } catch (error) {
        logger.error('Error during logout process', { error });
        handleLogoutError(error, context, options);
        return;
      }
    };
    return descriptor;
  };
};
