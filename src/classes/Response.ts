// Import necessary modules and types
import { Readable } from 'stream';
import { ContentType, StatusCode } from '../enums';
import {
  CookieOptions,
  HeaderName,
  HeaderValue,
  IResponse,
  ResponseBody,
  ResponseHeaders,
  ResponseCookies,
  ResponseStatus,
  ResponseLocation,
  ResponseRedirect,
  ResponseEnd,
} from '../interfaces';
import { serialize as serializeCookie } from '../utils/Cookie';
import { IncomingMessage, ServerResponse } from 'http';

export class Response
  extends ServerResponse<IncomingMessage>
  implements IResponse
{
  private _headers: Map<string, HeaderValue>;
  private _status: ResponseStatus = StatusCode.OK;
  private _cookies: Map<string, string>;
  private _body: ResponseBody = null;

  constructor(req: IncomingMessage) {
    super(req);
    this._headers = new Map<string, HeaderValue>();
    this._cookies = new Map<string, string>();
  }

  public get cookies(): ResponseCookies {
    return this._cookies;
  }

  public get headers(): ResponseHeaders {
    return this._headers;
  }

  public get body(): ResponseBody {
    return this._body;
  }

  public getStatus(): ResponseStatus {
    return this._status;
  }

  public status(code: ResponseStatus): this {
    if (!Object.values(StatusCode).includes(code)) {
      throw new Error(`Invalid status code: ${code}`);
    }
    this._status = code;
    this.statusCode = code;
    return this;
  }

  public send(body: ResponseBody): this {
    if (this.headersSent) {
      throw new Error('Cannot send response, headers already sent.');
    }

    if (body instanceof Readable) {
      this._body = body;
      body.pipe(this);
    } else if (typeof body === 'object' && !Buffer.isBuffer(body)) {
      this.type(ContentType.JSON);
      this._body = JSON.stringify(body);
      this.end(this._body);
    } else {
      // Set Content-Type to text/plain for string or Buffer
      this.type(ContentType.TEXT);
      this._body = body;
      this.end(this._body);
    }

    return this;
  }

  public json(data: object): this {
    this.type(ContentType.JSON);
    this.send(data);
    return this;
  }

  public redirect(url: string): void;
  public redirect(status: number, url: string): void;
  public redirect(statusOrUrl: number | string, url?: string): void {
    const redirectData: ResponseRedirect = {
      status: typeof statusOrUrl === 'number' ? statusOrUrl : StatusCode.FOUND,
      url: typeof statusOrUrl === 'string' ? statusOrUrl : url!,
    };
    this.status(redirectData.status);
    this.location(redirectData.url);
    this.end();
  }

  public setHeader(name: HeaderName, value: HeaderValue): this {
    if (this.headersSent) {
      throw new Error('Cannot set headers after they are sent to the client.');
    }
    super.setHeader(name, value);
    this._headers.set(name.toLowerCase(), value);
    return this;
  }

  public getHeader(name: HeaderName): HeaderValue | undefined {
    const header =
      this._headers.get(name.toLowerCase()) || super.getHeader(name);
    return typeof header === 'number' ? header.toString() : header;
  }

  public removeHeader(name: HeaderName): void {
    if (this.headersSent) {
      throw new Error(
        'Cannot remove headers after they are sent to the client.',
      );
    }
    this.removeHeader(name); // Changed from super.removeHeader
    this._headers.delete(name.toLowerCase());
  }

  public append(name: HeaderName, value: HeaderValue): this {
    if (this.headersSent) {
      throw new Error(
        'Cannot append headers after they are sent to the client.',
      );
    }
    const key = name.toLowerCase();
    const existing = this._headers.get(key);

    if (existing) {
      const newValue = Array.isArray(existing)
        ? [...existing, ...[].concat(value)]
        : [existing, ...[].concat(value)];
      this.setHeader(name, newValue); // Changed from super.setHeader
      this._headers.set(key, newValue);
    } else {
      this.setHeader(name, value); // Changed from super.setHeader
      this._headers.set(key, value);
    }
    return this;
  }

  public cookie(
    name: string,
    value: string,
    options: CookieOptions = {},
  ): this {
    if (this.headersSent) {
      throw new Error(
        'Cannot set cookies after headers are sent to the client.',
      );
    }

    // Update the internal cookies map
    this._cookies.set(name, value);

    // Serialize the cookie for the Set-Cookie header
    const cookieString = serializeCookie(name, value, options);
    this.append('Set-Cookie', cookieString);

    return this;
  }

  public clearCookie(name: string, options: CookieOptions = {}): this {
    if (this.headersSent) {
      throw new Error(
        'Cannot clear cookies after headers are sent to the client.',
      );
    }

    // Remove from the internal cookies map
    this._cookies.delete(name);

    // Append a cookie with an empty value and maxAge 0 to headers
    this.cookie(name, '', { ...options, maxAge: 0 });
    return this;
  }

  public type(contentType: ContentType): this {
    return this.setHeader('Content-Type', contentType);
  }

  public location(url: ResponseLocation): this {
    return this.setHeader('Location', url || '');
  }

  public end(body?: ResponseEnd): this {
    if (this.headersSent) {
      throw new Error('Cannot end response, headers already sent.');
    }

    if (body !== undefined) {
      this._body = body;
    }
    this.finalizeResponse();
    return this;
  }

  protected finalizeResponse(): void {
    if (this.headersSent) {
      return;
    }

    // Set status code (already set in status method if called)
    this.statusCode = this._status || StatusCode.OK;

    // Send the body
    if (this._body !== null) {
      if (typeof this._body === 'string' || Buffer.isBuffer(this._body)) {
        super.end(this._body);
      } else {
        // For other types (e.g., streams), additional handling is needed
        super.end(String(this._body));
      }
    } else {
      super.end();
    }
  }
}
