import { ISessionData } from './ISessionData';
import { RequestMethod } from '../enums';

export interface IRequest {
  // Properties
  readonly method: Method;
  readonly url: RequestUrl;
  readonly originalUrl?: RequestUrl;
  readonly path?: RequestPath;
  readonly query: RequestQuery;
  readonly params: RequestParams;
  readonly body: RequestBody;
  readonly headers: RequestHeaders;
  readonly cookies?: RequestCookies;
  readonly session?: ISessionData;
  readonly ip?: RequestIp;
  readonly ips?: RequestIps;
  readonly protocol: RequestProtocol;
  readonly secure: boolean;

  // Methods
  setMethod(method: Method): this;
  setUrl(url: RequestUrl): this;
  setOriginalUrl(originalUrl: RequestUrl): this;
  setPath(path: RequestPath): this;
  setQuery(query: RequestQuery): this;
  setParams(params: RequestParams): this;
  setBody(body: RequestBody): this;
  setHeaders(headers: Record<string, string>): this;
  setCookies(cookies: RequestCookies): this;
  setSession(session: ISessionData): this;
  setIp(ip: RequestIp): this;
  setIps(ips: RequestIps): this;
  setProtocol(protocol: RequestProtocol): this;

  // Utilities
  get(header: string): string | string[] | undefined;
  is(type: string): boolean;
  hasHeader(header: string): boolean;
  accepts(types: string | string[]): string | false;
  clone(): this;
}

// Supporting Types
export type RequestBody = string | object | Buffer | null;
export type RequestHeaders = Readonly<Map<string, string | string[]>>;
export type RequestParams = Readonly<Record<string, any>>;
export type RequestQuery = Readonly<Record<string, any>>;
export type RequestCookies = Readonly<Record<string, string>>;
export type RequestIp = string | undefined;
export type RequestIps = ReadonlyArray<string> | undefined;
export type Method = keyof typeof RequestMethod | string;
export type RequestPath = string | undefined;
export type RequestUrl = string | undefined;
export type RequestProtocol = 'http' | 'https';
