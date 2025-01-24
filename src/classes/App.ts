// src/classes/App.ts

import { createServer, IncomingMessage, Server } from 'http';
import { Request } from './Request';
import { Response } from './Response';
import { Middleware, MiddlewareManager } from '../middleware/MiddlewareManager';
import { pathToRegexp } from '../utils/pathToReg';
import { HttpException } from '../errors/HttpExeption';
import { RequestMethod, StatusCode } from '../enums';
import { IMethodMetadata, IRequest, IResponse } from '../interfaces';
import { Cache } from '../cache/Cache';
import { ILogger } from '../interfaces';
import { Logger } from '../utils/Logger';
import { MetadataManager } from 'src/decorators';
import { Container } from 'src/utils/Container';

// define RouteHandler type
type RouteHandler = (req: Request, res: Response) => Promise<void>;

// define RouteTable type
type RouteTable = Map<
  string,
  { regexp: RegExp; handler: RouteHandler; keys: string[] }
>;

export interface IApiResponse {
  data: any; // Replace `any` with more specific types as needed
  timestamp: number;
  // Add other relevant fields
}

export class App {
  private _server: Server;
  private _routes: RouteTable = new Map();
  private _middlewareManager: MiddlewareManager;
  private readonly logger: ILogger;
  private readonly cache: Cache<IApiResponse>;

  constructor() {
    this.logger = new Logger(App.name);
    this.cache = new Cache<IApiResponse>(this.logger, 60000); // Default TTL: 60 seconds
    this._routes = new Map();
    this._middlewareManager = new MiddlewareManager();
    this._server = createServer(this.handleRequest.bind(this));
  }

  /**
   * Registers middleware for the application.
   * @param middleware - Middleware function to execute.
   */
  public use(middleware: Middleware): void {
    this._middlewareManager.use(middleware);
  }

  public async processMiddleware(context: {
    req: IRequest;
    res: IResponse;
  }): Promise<void> {
    await this._middlewareManager.execute(context.req, context.res);
  }
  /**
   * Registers a route handler for a specific method and path.
   * @param method - HTTP method (e.g., 'GET', 'POST').
   * @param path - Route path (e.g., '/api').
   * @param handler - Route handler function.
   */
  public route(method: string, path: string, handler: RouteHandler): void {
    // Extract `regexp` and `keys` from pathToRegexp
    const { regexp, keys } = pathToRegexp(path, {
      end: true,
      sensitive: false,
    });

    // Save the route with the handler and parameter keys
    this._routes.set(`${method.toUpperCase()} ${regexp.source}`, {
      regexp,
      handler,
      keys: keys.map((key) => key.name), // Extract parameter names
    });
  }

  /**
   * Starts the server on the specified port.
   * @param port - Port number to listen on.
   * @param callback - Optional callback to execute when the server starts.
   */
  public listen(port: number, callback?: () => void): void {
    this._server.listen(port, callback);
  }

  public stop(): void {
    this._server.close((err) => {
      if (err) {
        console.error('Error while shutting down:', err);
      } else {
        console.log('Server stopped gracefully');
      }
    });
  }

  /**
   * Handles incoming HTTP requests.
   * @param req - Incoming HTTP request.
   * @param res - Server response object.
   */
  private async handleRequest(
    req: IncomingMessage,
    res: Response,
  ): Promise<void> {
    const response = new Response(req);
    try {
      const request = await Request.fromIncomingMessage(req, res);
      await this._middlewareManager.execute(request, response);

      const handler = this.matchRoute(request);

      if (handler) {
        await Promise.resolve(handler(request, response)).catch((err) => {
          throw err;
        });
      } else {
        throw new HttpException('Route not found', StatusCode.NOT_FOUND);
      }
    } catch (error) {
      const status =
        error instanceof HttpException
          ? error.status
          : StatusCode.INTERNAL_SERVER_ERROR;
      response.status(status).json({ error: error.message });
    }
  }

  /**
   * Matches a route based on the request method and path.
   * @param request - Request object.
   * @returns Route handler function or undefined if no match is found.
   */
  private matchRoute(request: Request): RouteHandler | undefined {
    for (const [pattern, { handler, keys }] of this._routes.entries()) {
      const regexp = new RegExp(pattern); // Create the RegExp from the stored pattern
      const match = regexp.exec(request.path || '');

      if (match) {
        // Populate request.params with matched values
        const params: Record<string, string> = {};
        keys.forEach((key, index) => {
          params[key] = match[index + 1]; // Match groups start at index 1
        });
        request.setParams(params);

        return handler;
      }
    }
    return undefined; // No match found
  }

  public registerHandlers(...handlers: Function[]): void {
    handlers.forEach((controller) => {
      const classMetadata = MetadataManager.getClassMetadata(controller);
      if (!classMetadata) {
        this.logger.warn(
          `No metadata found for controller: ${controller.name}`,
        );
        return;
      }

      const basePath = classMetadata.path || '';
      const instance = this.resolveHandlerInstance(controller);

      // Retrieve all method names excluding constructor
      const methodNames = Object.getOwnPropertyNames(
        controller.prototype,
      ).filter(
        (prop) =>
          prop !== 'constructor' &&
          typeof controller.prototype[prop] === 'function',
      );

      methodNames.forEach((methodName) => {
        const methodMetadata = MetadataManager.getMethodMetadata(
          controller,
          methodName,
        ) as IMethodMetadata;
        if (!methodMetadata || !methodMetadata.route) return;

        const { method, path } = methodMetadata.route;
        const fullPath = this.normalizePath(`${basePath}${path}`);
        const httpMethod = method || RequestMethod.GET;

        // Bind the method to the instance to preserve 'this'
        const handler = instance[methodName].bind(instance);

        this.route(httpMethod, fullPath, handler);
        this.logger.info(`Registered route: [${httpMethod}] ${fullPath}`);
      });
    });
  }
  /**
   * Resolves an instance of the handler, handling dependency injection.
   * @param handler The handler class constructor.
   */
  private resolveHandlerInstance(handler: Function): any {
    const paramTypes: any[] =
      Reflect.getMetadata('design:paramtypes', handler) || [];
    const dependencies = paramTypes.map((param: any, index: number) => {
      const injectMetadata = MetadataManager.getMethodMetadata(
        handler,
        'constructor',
      )?.inject;
      const token =
        injectMetadata && injectMetadata[index] ? injectMetadata[index] : param;
      return Container.resolve(token);
    });

    return new (handler as any)(...dependencies);
  }

  /**
   * Normalizes the path to ensure it starts with a '/' and doesn't have trailing slashes.
   * @param path The route path.
   */
  private normalizePath(path: string): string {
    if (!path.startsWith('/')) {
      path = `/${path}`;
    }
    if (path !== '/' && path.endsWith('/')) {
      path = path.slice(0, -1);
    }
    return path;
  }
}
