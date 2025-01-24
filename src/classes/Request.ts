// src/classes/Request.ts

import { parseCookies } from '../utils';
import { ContentType, RequestHeader, RequestMethod } from '../enums';
import {
  IRequest,
  IResponse,
  ISessionData,
  Method,
  RequestBody,
  RequestCookies,
  RequestHeaders,
  RequestIp,
  RequestIps,
  RequestParams,
  RequestPath,
  RequestProtocol,
  RequestQuery,
  RequestUrl,
} from '../interfaces';
import { isIP } from 'net';
import { IncomingMessage } from 'http';
import { URL } from 'url';
import { Middleware, MiddlewareManager } from '../middleware/MiddlewareManager';
import { Response } from './Response'; // Ensure correct import
import { TLSSocket } from 'tls';

export class Request implements IRequest {
  // Encapsulated IncomingMessage
  private _incomingMessage: IncomingMessage;

  // Properties
  private _method: Method = RequestMethod.GET;
  private _url: RequestUrl = 'http://localhost';
  private _originalUrl: RequestUrl = '';
  private _path: RequestPath = '';
  private _query: RequestQuery = {};
  private _params: RequestParams = {};
  private _body: RequestBody = null;
  private _headers: RequestHeaders = new Map<string, string | string[]>();
  private _cookies: RequestCookies = {};
  private _session: ISessionData | null = null;
  private _ip: RequestIp = undefined;
  private _ips: RequestIps = [];
  private _protocol: RequestProtocol = 'http';
  private _secure: boolean = false;
  private middlewareManager: MiddlewareManager = new MiddlewareManager();

  // Public Getters
  public get method(): Method {
    return this._method;
  }

  public get url(): RequestUrl {
    return this._url;
  }

  public get originalUrl(): RequestUrl {
    return this._originalUrl;
  }

  public get path(): RequestPath {
    return this._path;
  }

  public get query(): RequestQuery {
    return this._query;
  }

  public get params(): RequestParams {
    return this._params;
  }

  public get body(): RequestBody {
    return this._body;
  }

  public get headers(): RequestHeaders {
    return Object.freeze(new Map(this._headers));
  }

  public get cookies(): RequestCookies {
    return { ...this._cookies };
  }

  public get session(): ISessionData | null {
    return this._session ? { ...this._session } : null;
  }

  public get ip(): RequestIp {
    return this._ip;
  }

  public get ips(): RequestIps {
    return [...this._ips];
  }

  public get protocol(): RequestProtocol {
    return this._protocol;
  }

  public get secure(): boolean {
    return this._secure;
  }

  // Private constructor to enforce use of factory method
  private constructor(req: IncomingMessage) {
    this._incomingMessage = req;
  }

  // Factory method for asynchronous initialization
  public static async fromIncomingMessage(
    req: IncomingMessage,
    res: Response,
  ): Promise<Request> {
    const request = new Request(req);
    const protocol = req.socket instanceof TLSSocket ? 'https' : 'http';
    const host = req.headers.host || 'localhost';
    const url = new URL(req.url || '', `${protocol}://${host}`);

    request
      .setMethod(req.method as Method)
      .setUrl(url.href)
      .setOriginalUrl(url.href)
      .setPath(url.pathname)
      .setQuery(Object.fromEntries(url.searchParams.entries()))
      .setHeaders(req.headers as Record<string, string | string[]>)
      .setIp(req.socket.remoteAddress)
      .setProtocol(protocol);

    // Parse IP addresses
    const forwardedFor = request.get(RequestHeader.X_FORWARDED_FOR);
    if (forwardedFor) {
      request._ips =
        typeof forwardedFor === 'string'
          ? forwardedFor.split(',').map((ip) => ip.trim())
          : forwardedFor.map((ip) => ip.trim());
      request._ip = request._ips[0];
    }

    // Await body parsing
    await request.parseBody();

    // Execute middleware
    await request.processMiddleware(res);

    return request;
  }

  /**
   * Registers a middleware function.
   * @param middleware - The middleware function to register.
   */
  public use(middleware: Middleware): void {
    this.middlewareManager.use(middleware);
  }

  /**
   * Processes the request through all registered middleware.
   */
  public async processMiddleware(res?: Response): Promise<void> {
    await this.middlewareManager.execute(this, res);
  }

  // Setters with validation
  public setMethod(method: Method): this {
    if (!Object.values(RequestMethod).includes(method as RequestMethod)) {
      throw new Error(`Unsupported HTTP method: ${method}`);
    }
    this._method = method;
    return this;
  }

  public setUrl(url: RequestUrl): this {
    try {
      new URL(url); // Validate URL format
      this._url = url;
    } catch (error) {
      throw new Error('Invalid URL format');
    }
    return this;
  }

  public setOriginalUrl(originalUrl: RequestUrl): this {
    this._originalUrl = originalUrl;
    return this;
  }

  public setPath(path: RequestPath): this {
    this._path = path;
    return this;
  }

  public setQuery(query: RequestQuery): this {
    this._query = { ...query };
    return this;
  }

  public setParams(params: RequestParams): this {
    this._params = { ...params };
    return this;
  }

  public setBody(body: RequestBody): this {
    const contentType = this.get(RequestHeader.CONTENT_TYPE) || '';

    if (typeof body === 'string' && contentType.includes(ContentType.JSON)) {
      try {
        this._body = JSON.parse(body);
      } catch (error) {
        throw new Error('Invalid JSON body');
      }
    } else {
      this._body = body;
    }
    return this;
  }

  public setHeaders(headers: Record<string, string | string[]>): this {
    this._headers = new Map<string, string | string[]>(
      Object.entries(headers).map(([key, value]) => [key.toLowerCase(), value]),
    );

    // Re-parse cookies whenever headers are updated
    this._cookies = parseCookies(this._headers);
    return this;
  }

  public setCookies(cookies: RequestCookies): this {
    this._cookies = { ...cookies };
    return this;
  }

  public setSession(session: ISessionData): this {
    this._session = { ...session };
    return this;
  }

  public setIp(ip: RequestIp): this {
    if (ip && !isIP(ip)) {
      throw new Error('Invalid IP address format');
    }
    this._ip = ip;
    return this;
  }

  public setIps(ips: RequestIps): this {
    if (ips && ips.some((ip) => !isIP(ip))) {
      throw new Error('One or more IP addresses have an invalid format');
    }
    this._ips = [...ips];
    return this;
  }

  public setProtocol(protocol?: RequestProtocol): this {
    if (!protocol) {
      const forwardedProto = this.get(RequestHeader.X_FORWARDED_PROTO);
      this._protocol = (forwardedProto || 'http') as RequestProtocol;
    } else {
      if (!['http', 'https'].includes(protocol)) {
        throw new Error(`Unsupported protocol: ${protocol}`);
      }
      this._protocol = protocol;
    }
    this._secure = this._protocol === 'https';
    return this;
  }

  // Utility Methods
  public get(header: string): string | string[] | undefined {
    return this._headers.get(header.toLowerCase());
  }

  public is(type: string): boolean {
    const contentType = this.get(RequestHeader.CONTENT_TYPE) || '';
    let mimeType = '';

    if (typeof contentType === 'string') {
      mimeType = contentType.split(';')[0].trim().toLowerCase();
    } else if (Array.isArray(contentType)) {
      mimeType = contentType[0].split(';')[0].trim().toLowerCase(); // Take the first Content-Type if multiple
    }

    return mimeType === type.toLowerCase();
  }

  public hasHeader(header: string): boolean {
    return this._headers.has(header.toLowerCase());
  }

  public accepts(types: string | string[]): string | false {
    const acceptHeader = this.get(RequestHeader.ACCEPT) || '';
    const typesArray = Array.isArray(types) ? types : [types];

    for (const type of typesArray) {
      if (
        typeof acceptHeader === 'string' &&
        acceptHeader.toLowerCase().includes(type.toLowerCase())
      ) {
        return type;
      }
    }
    return false;
  }

  // Asynchronous Body Parsing
  public async parseBody(): Promise<this> {
    return new Promise((resolve, reject) => {
      let data: Buffer[] = [];

      this._incomingMessage.on('data', (chunk: Buffer) => {
        data.push(chunk);
      });

      this._incomingMessage.on('end', () => {
        try {
          const bodyStr = Buffer.concat(data).toString();
          this.setBody(bodyStr);
          resolve(this);
        } catch (error) {
          reject(error);
        }
      });

      this._incomingMessage.on('error', (error) => {
        reject(error);
      });
    });
  }

  // Cloning Method
  public clone(): this {
    const clonedRequest = new Request(this._incomingMessage);

    clonedRequest
      .setMethod(this._method)
      .setUrl(this._url)
      .setOriginalUrl(this._originalUrl)
      .setPath(this._path)
      .setQuery({ ...this._query })
      .setParams({ ...this._params })
      .setBody(
        Buffer.isBuffer(this._body)
          ? Buffer.from(this._body)
          : typeof this._body === 'object' && this._body !== null
            ? { ...this._body }
            : this._body,
      )
      .setHeaders(Object.fromEntries(this._headers))
      .setCookies({ ...this._cookies })
      .setIp(this._ip)
      .setIps([...this._ips])
      .setProtocol(this._protocol);

    if (this._session) {
      clonedRequest.setSession({ ...this._session });
    }

    return clonedRequest as this;
  }
}
