import { Response } from './Response';
import { StatusCode } from '../enums';
import { IncomingMessage } from 'http';

describe('Response', () => {
  let response: Response;
  let headers: Record<string, string | string[]>;
  let headersSent: boolean;
  let currentStatusCode: StatusCode;

  const createMockIncomingMessage = (): Partial<IncomingMessage> => ({
    headers: {},
    method: 'GET',
    url: '/test',
  });

  beforeEach(() => {
    headersSent = false;

    const incomingMessageMock = createMockIncomingMessage();
    response = new Response(incomingMessageMock as IncomingMessage);

    // Mock the `headersSent` property using Object.defineProperty
    Object.defineProperty(response, 'headersSent', {
      get: () => headersSent,
      set: (value: boolean) => {
        headersSent = value;
      },
      configurable: true,
    });

    // Initialize tracking variables
    headers = {};
    currentStatusCode = StatusCode.OK;

    // Spy on the ServerResponse methods with updated implementations
    jest.spyOn(response, 'setHeader').mockImplementation((name, value) => {
      if (headersSent)
        throw new Error(
          'Cannot set headers after they are sent to the client.',
        );
      headers[name.toLowerCase()] = value;
      (response as any)._headers.set(name.toLowerCase(), value);
      return response;
    });

    jest.spyOn(response, 'getHeader').mockImplementation(function (name) {
      return (this as any)._headers.get(name.toLowerCase()) || undefined;
    });

    jest.spyOn(response, 'removeHeader').mockImplementation((name) => {
      if (headersSent)
        throw new Error(
          'Cannot remove headers after they are sent to the client.',
        );
      delete headers[name.toLowerCase()];
      (response as any)._headers.delete(name.toLowerCase());
    });

    jest.spyOn(response, 'end').mockImplementation((body?: any) => {
      headersSent = true;
      return response;
    });

    jest
      .spyOn(response, 'writeHead')
      .mockImplementation((statusCode: StatusCode) => {
        headersSent = true;
        currentStatusCode = statusCode;
        (response as any)._status = statusCode;
        return response;
      });
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  test('should set status code', () => {
    response.status(StatusCode.CREATED);
    expect(response.getStatus()).toBe(StatusCode.CREATED);
    expect(response.statusCode).toBe(StatusCode.CREATED);
  });

  test('should append headers', () => {
    response.append('X-Custom-Header', 'value1');
    response.append('X-Custom-Header', 'value2');
    expect(response.getHeader('X-Custom-Header')).toEqual(['value1', 'value2']);

    expect(response.setHeader).toHaveBeenCalledWith(
      'X-Custom-Header',
      'value1',
    );
    expect(response.setHeader).toHaveBeenCalledWith('X-Custom-Header', [
      'value1',
      'value2',
    ]);
  });

  test('should set cookies', () => {
    response.cookie('test', 'value');
    expect((response as any).cookies.get('test')).toBe('value');

    expect(response.setHeader).toHaveBeenCalledWith(
      'Set-Cookie',
      expect.stringContaining('test=value'),
    );
  });

  test('should clear cookies', () => {
    response.cookie('test', 'value');
    response.clearCookie('test');

    expect((response as any).cookies.get('test')).toBe('');

    expect(response.setHeader).toHaveBeenCalledTimes(2);
    expect(response.setHeader).toHaveBeenNthCalledWith(
      1,
      'Set-Cookie',
      expect.stringContaining('test=value'),
    );
    expect(response.setHeader).toHaveBeenNthCalledWith(
      2,
      'Set-Cookie',
      expect.arrayContaining([expect.stringContaining('test=; Max-Age=0')]),
    );
  });

  test('should redirect with default status', () => {
    const url = 'http://example.com';
    response.redirect(url);

    expect(response.getStatus()).toBe(StatusCode.FOUND);
    expect(response.getHeader('Location')).toBe(url);

    expect(response.setHeader).toHaveBeenCalledWith('Location', url);
    expect(response.statusCode).toBe(StatusCode.FOUND);
    expect(response.end).toHaveBeenCalledWith();
  });

  test('should redirect with custom status', () => {
    const url = 'http://example.com';
    response.redirect(StatusCode.MOVED_PERMANENTLY, url);

    expect(response.getStatus()).toBe(StatusCode.MOVED_PERMANENTLY);
    expect(response.getHeader('Location')).toBe(url);

    expect(response.setHeader).toHaveBeenCalledWith('Location', url);
    expect(response.statusCode).toBe(StatusCode.MOVED_PERMANENTLY);
    expect(response.end).toHaveBeenCalledWith();
  });

  test('should not allow modifying headers after response is sent', () => {
    response.send('Hello');

    expect(() => {
      response.setHeader('Another-Header', 'value');
    }).toThrow('Cannot set headers after they are sent to the client.');

    expect(() => {
      response.removeHeader('Content-Type');
    }).toThrow('Cannot remove headers after they are sent to the client.');

    expect(() => {
      response.append('X-Test', 'value');
    }).toThrow('Cannot append headers after they are sent to the client.');
  });

  test('should handle different body types', () => {
    // Sending a string
    response.send('A simple string');
    expect(response.end).toHaveBeenCalledWith('A simple string');

    // Reset mocks
    (response.end as jest.Mock).mockClear();
    response = new Response(createMockIncomingMessage() as IncomingMessage);

    // Re-spy on the methods with mock implementations
    jest.spyOn(response, 'setHeader').mockImplementation((name, value) => {
      headers[name.toLowerCase()] = value;
      (response as any)._headers.set(name.toLowerCase(), value);
      return response;
    });

    jest.spyOn(response, 'getHeader').mockImplementation(function (name) {
      return (this as any)._headers.get(name.toLowerCase()) || undefined;
    });

    jest.spyOn(response, 'removeHeader').mockImplementation((name) => {
      if (headersSent)
        throw new Error(
          'Cannot remove headers after they are sent to the client.',
        );
      delete headers[name.toLowerCase()];
      (response as any)._headers.delete(name.toLowerCase());
    });

    jest.spyOn(response, 'end').mockImplementation((body?: any) => {
      headersSent = true;
      return response;
    });

    jest
      .spyOn(response, 'writeHead')
      .mockImplementation((statusCode: StatusCode) => {
        headersSent = true;
        currentStatusCode = statusCode;
        (response as any)._status = statusCode;
        return response;
      });

    // Sending a Buffer
    const buffer = Buffer.from('Buffer data');
    response.send(buffer);
    expect(response.end).toHaveBeenCalledWith(buffer);

    // Reset mocks
    (response.end as jest.Mock).mockClear();
    response = new Response(createMockIncomingMessage() as IncomingMessage);

    // Re-spy on the methods with mock implementations
    jest.spyOn(response, 'setHeader').mockImplementation((name, value) => {
      headers[name.toLowerCase()] = value;
      (response as any)._headers.set(name.toLowerCase(), value);
      return response;
    });

    jest.spyOn(response, 'getHeader').mockImplementation(function (name) {
      return (this as any)._headers.get(name.toLowerCase()) || undefined;
    });

    jest.spyOn(response, 'removeHeader').mockImplementation((name) => {
      if (headersSent)
        throw new Error(
          'Cannot remove headers after they are sent to the client.',
        );
      delete headers[name.toLowerCase()];
      (response as any)._headers.delete(name.toLowerCase());
    });

    jest.spyOn(response, 'end').mockImplementation((body?: any) => {
      headersSent = true;
      return response;
    });

    jest
      .spyOn(response, 'writeHead')
      .mockImplementation((statusCode: StatusCode) => {
        headersSent = true;
        currentStatusCode = statusCode;
        (response as any)._status = statusCode;
        return response;
      });

    // Sending an object
    const obj = { key: 'value' };
    response.send(obj);
    expect((response as any).body).toBe(JSON.stringify(obj));
    expect(response.end).toHaveBeenCalledWith(JSON.stringify(obj));
  });
});
