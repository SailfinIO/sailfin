import { Request } from './Request';
import { RequestMethod } from '../enums';
import {
  RequestBody,
  RequestCookies,
  RequestIp,
  RequestIps,
  RequestParams,
  RequestPath,
  RequestQuery,
  RequestUrl,
  ISessionData,
  IRequest,
} from '../interfaces';

describe('Request', () => {
  let request: IRequest;

  beforeEach(() => {
    //@ts-ignore
    request = new Request();
  });

  it('should initialize with default values', () => {
    expect(request.method).toBe(RequestMethod.GET);
    expect(request.url).toBe('http://localhost');
    expect(request.originalUrl).toBe('');
    expect(request.path).toBe('');
    expect(request.query).toEqual({});
    expect(request.params).toEqual({});
    expect(request.body).toBeNull();
    expect(request.headers).toBeInstanceOf(Map);
    expect(request.cookies).toEqual({});
    expect(request.session).toBeNull();
    expect(request.ip).toBeUndefined();
    expect(request.ips).toEqual([]);
    expect(request.protocol).toBe('http');
    expect(request.secure).toBe(false);
  });

  it('should set and get method', () => {
    request.setMethod(RequestMethod.POST);
    expect(request.method).toBe(RequestMethod.POST);
  });

  it('should set and get url', () => {
    const url: RequestUrl = 'http://example.com';
    request.setUrl(url);
    expect(request.url).toBe(url);
  });

  it('should set and get originalUrl', () => {
    const originalUrl: RequestUrl = 'http://example.com/original';
    request.setOriginalUrl(originalUrl);
    expect(request.originalUrl).toBe(originalUrl);
  });

  it('should set and get path', () => {
    const path: RequestPath = '/path';
    request.setPath(path);
    expect(request.path).toBe(path);
  });

  it('should set and get query', () => {
    const query: RequestQuery = { key: 'value' };
    request.setQuery(query);
    expect(request.query).toEqual(query);
  });

  it('should set and get params', () => {
    const params: RequestParams = { id: '123' };
    request.setParams(params);
    expect(request.params).toEqual(params);
  });

  it('should set and get body', () => {
    const body: RequestBody = { data: 'test' };
    request.setBody(body);
    expect(request.body).toBe(body);
  });

  it('should set and get headers', () => {
    const headers: Record<string, string> = {
      'Content-Type': 'application/json',
    };
    request.setHeaders(headers);
    expect(request.headers.get('content-type')).toBe('application/json');
  });

  it('should set and get cookies', () => {
    const cookies: RequestCookies = { session: 'abcd' };
    request.setCookies(cookies);
    expect(request.cookies).toEqual(cookies);
  });

  it('should set and get session', () => {
    const session: ISessionData = { user: { sub: '123' } };
    request.setSession(session);
    expect(request.session).toEqual(session);
  });

  it('should set and get ip', () => {
    const ip: RequestIp = '127.0.0.1';
    request.setIp(ip);
    expect(request.ip).toBe(ip);
  });

  it('should set and get ips', () => {
    const ips: RequestIps = ['127.0.0.1', '192.168.0.1'];
    request.setIps(ips);
    expect(request.ips).toEqual(ips);
  });

  it('should set and get protocol and secure', () => {
    request.setProtocol('https');
    expect(request.protocol).toBe('https');
    expect(request.secure).toBe(true);
  });

  it('should get header', () => {
    const headers: Record<string, string> = {
      'Content-Type': 'application/json',
    };
    request.setHeaders(headers);
    expect(request.get('Content-Type')).toBe('application/json');
  });

  it('should check if content type matches', () => {
    const headers: Record<string, string> = {
      'Content-Type': 'application/json',
    };
    request.setHeaders(headers);
    expect(request.is('application/json')).toBe(true);
    expect(request.is('text/html')).toBe(false);
  });

  it('should check if header exists', () => {
    const headers: Record<string, string> = {
      'Content-Type': 'application/json',
    };
    request.setHeaders(headers);
    expect(request.hasHeader('Content-Type')).toBe(true);
    expect(request.hasHeader('Accept')).toBe(false);
  });

  it('should check if accepts type', () => {
    const headers: Record<string, string> = { Accept: 'application/json' };
    request.setHeaders(headers);
    expect(request.accepts('application/json')).toBe('application/json');
    expect(request.accepts('text/html')).toBe(false);
  });

  it('should clone request', () => {
    const url: RequestUrl = 'http://example.com';
    request.setUrl(url);
    const clonedRequest = request.clone();
    expect(clonedRequest).not.toBe(request);
    expect(clonedRequest.method).toBe(request.method);
    expect(clonedRequest.url).toBe(request.url);
    expect(clonedRequest.originalUrl).toBe(request.originalUrl);
    expect(clonedRequest.path).toBe(request.path);
    expect(clonedRequest.query).toEqual(request.query);
    expect(clonedRequest.params).toEqual(request.params);
    expect(clonedRequest.body).toBe(request.body);
    expect(clonedRequest.headers).toEqual(request.headers);
    expect(clonedRequest.cookies).toEqual(request.cookies);
    expect(clonedRequest.session).toEqual(request.session);
    expect(clonedRequest.ip).toBe(request.ip);
    expect(clonedRequest.ips).toEqual(request.ips);
    expect(clonedRequest.protocol).toBe(request.protocol);
    expect(clonedRequest.secure).toBe(request.secure);
  });
});
