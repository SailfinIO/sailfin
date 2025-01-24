import { MetadataManager } from './MetadataManager';
import { IMethodMetadata } from '../interfaces';
import { Claims, StatusCode } from '../enums';
import { Client } from '../classes/Client';
import { HttpException } from '../errors/HttpExeption';

/**
 * Example: Decorator that attempts to find an OIDC token from either:
 * 1) Sailfin's server session (via sailfin.sid cookie), or
 * 2) express-session + passport style (req.session.passport.user?).
 */
export const Protected = (requiredClaims?: Claims[]): MethodDecorator => {
  return (
    target: any,
    propertyKey: string | symbol,
    descriptor: PropertyDescriptor,
  ) => {
    // Save any existing Sailfin metadata
    MetadataManager.setMethodMetadata(
      target.constructor,
      propertyKey as string,
      {
        requiresAuth: true,
        requiredClaims,
      } as IMethodMetadata,
    );

    const originalMethod = descriptor.value;

    descriptor.value = async function (
      this: { client: Client },
      ...args: any[]
    ) {
      // Nest usually puts [req, res, next] in args, depending on how your controller is set up
      const req: any = args[0];
      const res: any = args[1];
      // optionally next: NextFunction = args[2];
      const client: Client = this.client;
      const logger = client ? client.getLogger() : console;

      logger.debug('Protected decorator invoked', {
        method: propertyKey.toString(),
        requiredClaims,
      });

      if (!req || !res) {
        logger.error('Missing request or response object', { req, res });
        if (res) {
          res
            .status(StatusCode.BAD_REQUEST)
            .send('Invalid callback parameters: Missing request or response.');
        }
        return;
      }

      if (!client) {
        const message = 'Server configuration error: Client not available';
        logger.error(message);
        if (res) {
          return res.status(StatusCode.INTERNAL_SERVER_ERROR).send(message);
        }
        throw new HttpException(message, StatusCode.INTERNAL_SERVER_ERROR);
      }

      let token: string | undefined;

      try {
        // 1) Try reading from Sailfin's server session (sailfin.sid)
        //    If "sailfin.sid" is in cookies, that means Sailfin's session store has an OIDC token.
        //    The library's middleware typically attaches "req.session.cookie.access_token".
        const sailfinToken = req.session?.cookie?.access_token;

        if (sailfinToken) {
          logger.debug(
            'Protected: Found Sailfin OIDC token in req.session.cookie.access_token',
          );
          token = sailfinToken;
        } else {
          logger.debug(
            'Protected: No Sailfin token in req.session.cookie; fallback to express session?',
          );

          // 2) Or if you're using express-session + Passport:
          //    Check standard passport location: req.session?.passport?.user?.accessToken
          //    (Adjust the key name depending on how you store it.)
          const passportToken =
            req.session?.passport?.user?.accessToken ||
            req.session?.passport?.user?.access_token;

          if (passportToken) {
            logger.debug(
              'Protected: Found token in req.session.passport.user.accessToken',
            );
            token = passportToken;
          }
        }

        if (!token) {
          const message = 'Unauthorized: No access token found in session.';
          logger.warn(message);
          if (res) {
            return res.status(StatusCode.UNAUTHORIZED).send(message);
          }
          throw new HttpException(message, StatusCode.UNAUTHORIZED);
        }

        // Now that we have a token, let Sailfin introspect it or do your own logic
        const isValid = await client.introspectToken(token);
        if (!isValid) {
          const message = 'Unauthorized: Invalid or expired access token';
          logger.warn(message);
          if (res) {
            return res.status(StatusCode.UNAUTHORIZED).send(message);
          }
          throw new HttpException(message, StatusCode.UNAUTHORIZED);
        }

        logger.debug('Access token is valid');
      } catch (error) {
        const message = 'Error validating access token';
        logger.error(message, { error });
        if (res) {
          return res.status(StatusCode.INTERNAL_SERVER_ERROR).send(message);
        }
        throw new HttpException(message, StatusCode.INTERNAL_SERVER_ERROR);
      }

      // Optionally check claims if required
      if (requiredClaims && requiredClaims.length > 0) {
        try {
          logger.debug('Validating required claims', { requiredClaims });
          const claimsRecord = await client.getClaims();
          const missingClaims = requiredClaims.filter(
            (claim) => !(claim in claimsRecord),
          );
          if (missingClaims.length > 0) {
            const message = 'Forbidden: Missing required claims';
            logger.warn(message, { missingClaims });
            if (res) {
              return res.status(StatusCode.FORBIDDEN).send(message);
            }
            throw new HttpException(message, StatusCode.FORBIDDEN);
          }
          logger.debug('All required claims are present', { claimsRecord });
        } catch (error) {
          const message = 'Error retrieving user claims';
          logger.error(message, { error });
          if (res) {
            return res.status(StatusCode.INTERNAL_SERVER_ERROR).send(message);
          }
          throw new HttpException(message, StatusCode.INTERNAL_SERVER_ERROR);
        }
      }

      logger.debug('Authorization checks passed. Invoking original method.');

      return originalMethod.apply(this, args);
    };

    return descriptor;
  };
};
