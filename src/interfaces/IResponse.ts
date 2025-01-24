import { ContentType, StatusCode } from '../enums';
import { CookieOptions } from './CookieOptions';

/**
 * Represents an HTTP response object.
 *
 * The `IResponse` interface defines the structure of an HTTP response,
 * which includes methods for setting status codes, headers, cookies, and
 * response body content. The response object is used to send data back to
 * the client in response to an HTTP request.
 *
 * @interface IResponse
 */
export interface IResponse {
  readonly headers: ResponseHeaders;
  readonly cookies: ResponseCookies;
  readonly body: ResponseBody;
  readonly headersSent: boolean;
  status(code: ResponseStatus): this;
  send(body: ResponseBody): this;
  json(data: object): this;
  redirect(url: string): void;
  redirect(status: number, url: string): void;
  setHeader(name: HeaderName, value: HeaderValue): this;
  getHeader(name: HeaderName): HeaderValue | undefined;
  getStatus(): ResponseStatus;
  removeHeader(name: HeaderName): void;
  append(name: HeaderName, value: HeaderValue): this;
  cookie(name: string, value: string, options?: CookieOptions): this;
  clearCookie(name: string, options?: CookieOptions): this;
  type(contentType: ContentType): this;
  location(url: ResponseLocation): this;
  end(body?: ResponseEnd): void;
}

export type HeaderValue = string | string[];
export type HeaderName = keyof typeof ContentType | string;
export type ResponseBody = string | Buffer | object | null;
export type ResponseHeaders = Readonly<Map<string, HeaderValue>>;
export type ResponseCookies = Readonly<Map<string, string>>;
export type ResponseStatus = StatusCode | undefined;
export type ResponseLocation = string | undefined;
export type ResponseEnd = any | undefined;
export type ResponseRedirect = {
  status: number;
  url: string;
};
