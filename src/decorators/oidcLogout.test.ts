import { OidcLogout, OidcLogoutOptions } from './oidcLogout';
import { MetadataManager } from './MetadataManager';
import { Client } from '../classes/Client';
import { StatusCode } from '../enums';

describe('OidcLogout', () => {
  let mockClient: Client;
  let mockReq: any;
  let mockRes: any;
  let mockContext: any;

  beforeEach(() => {
    // Spy on setMethodMetadata so we can track its calls
    jest
      .spyOn(MetadataManager, 'setMethodMetadata')
      .mockImplementation(() => {});

    mockClient = {
      getLogger: jest.fn().mockReturnValue(console),
      getSessionStore: jest.fn().mockReturnValue({
        destroy: jest.fn().mockResolvedValue(undefined),
      }),
      getConfig: jest.fn().mockReturnValue({
        session: {
          cookie: {
            name: 'sid',
          },
        },
      }),
      logout: jest.fn().mockResolvedValue('http://logout.url'),
    } as unknown as Client;

    mockReq = {
      id: 'request-id',
      session: { user: 'test-user' },
      cookies: { sid: 'session-id' },
      setSession: jest.fn(),
    };

    mockRes = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
      redirect: jest.fn(),
    };

    mockContext = { request: mockReq, response: mockRes, extra: {} };
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  it('should set method metadata', () => {
    const target = {};
    const propertyKey = 'testMethod';
    const descriptor = { value: jest.fn() };

    OidcLogout()(target, propertyKey, descriptor);

    expect(MetadataManager.setMethodMetadata).toHaveBeenCalledWith(
      target.constructor,
      propertyKey,
      expect.any(Object),
    );
  });

  it('should handle missing request or response', async () => {
    const target = { client: mockClient };
    const propertyKey = 'testMethod';
    const descriptor = { value: jest.fn() };

    OidcLogout()(target, propertyKey, descriptor);

    await descriptor.value.call(target, null, mockRes);

    expect(mockRes.status).toHaveBeenCalledWith(StatusCode.BAD_REQUEST);
    expect(mockRes.send).toHaveBeenCalledWith(
      'Invalid callback parameters: Missing request or response.',
    );
  });

  it('should clear session and redirect to logout URL', async () => {
    const target = { client: mockClient };
    const propertyKey = 'testMethod';
    const descriptor = { value: jest.fn() };

    OidcLogout()(target, propertyKey, descriptor);

    await descriptor.value.call(target, mockReq, mockRes);

    expect(mockClient.getSessionStore().destroy).toHaveBeenCalledWith(
      'session-id',
      mockContext,
    );
    expect(mockReq.setSession).toHaveBeenCalledWith({});
    expect(mockRes.redirect).toHaveBeenCalledWith('http://logout.url');
  });

  it('should handle error during logout process', async () => {
    const target = { client: mockClient };
    const propertyKey = 'testMethod';
    const descriptor = { value: jest.fn() };

    const error = new Error('Logout error');
    mockClient.logout = jest.fn().mockRejectedValue(error);

    OidcLogout()(target, propertyKey, descriptor);

    await descriptor.value.call(target, mockReq, mockRes);

    expect(mockRes.status).toHaveBeenCalledWith(
      StatusCode.INTERNAL_SERVER_ERROR,
    );
    expect(mockRes.send).toHaveBeenCalledWith('Logout failed');
  });

  it('should call onError callback if provided', async () => {
    const target = { client: mockClient };
    const propertyKey = 'testMethod';
    const descriptor = { value: jest.fn() };

    const error = new Error('Logout error');
    const onError = jest.fn();
    const options: OidcLogoutOptions = { onError };

    mockClient.logout = jest.fn().mockRejectedValue(error);

    OidcLogout(options)(target, propertyKey, descriptor);

    await descriptor.value.call(target, mockReq, mockRes);

    expect(onError).toHaveBeenCalledWith(error, mockContext);
  });
});
