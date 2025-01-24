import { RefreshToken } from './refreshToken';
import { MetadataManager } from './MetadataManager';
import { Client } from '../classes/Client';
import { StatusCode } from '../enums';
import { HttpException } from '../errors/HttpExeption';

// Mock MetadataManager
jest.mock('./MetadataManager', () => ({
  MetadataManager: {
    setMethodMetadata: jest.fn(),
  },
}));

describe('RefreshToken Decorator', () => {
  let mockClient: Client;
  let mockLogger: any;
  let mockReq: any;
  let mockRes: any;
  let mockContext: any;

  beforeEach(() => {
    mockLogger = {
      debug: jest.fn(),
      error: jest.fn(),
      info: jest.fn(),
    };

    mockClient = {
      getLogger: jest.fn().mockReturnValue(mockLogger),
      silentRenew: jest.fn(),
    } as unknown as Client;

    mockReq = {};
    mockRes = {
      status: jest.fn().mockReturnThis(),
      send: jest.fn(),
    };

    mockContext = { request: mockReq, response: mockRes };
    jest.clearAllMocks();
  });

  it('should set method metadata', () => {
    const target = {};
    const propertyKey = 'testMethod';
    const descriptor = { value: jest.fn() };

    RefreshToken()(target, propertyKey, descriptor);

    expect(MetadataManager.setMethodMetadata).toHaveBeenCalledWith(
      target.constructor,
      propertyKey,
      { requiresRefresh: true },
    );
  });

  it('should call original method if token is refreshed successfully', async () => {
    const target = { client: mockClient };
    const propertyKey = 'testMethod';
    const originalMethod = jest.fn();
    const descriptor = { value: originalMethod };

    RefreshToken()(target, propertyKey, descriptor);

    await descriptor.value.call(target, mockReq, mockRes);

    expect(mockClient.silentRenew).toHaveBeenCalledWith(mockContext);
    expect(originalMethod).toHaveBeenCalledWith(mockReq, mockRes);
  });

  it('should return 400 if request or response is missing', async () => {
    const target = { client: mockClient };
    const propertyKey = 'testMethod';
    const originalMethod = jest.fn();
    const descriptor = { value: originalMethod };

    RefreshToken()(target, propertyKey, descriptor);

    await descriptor.value.call(target, null, mockRes);

    expect(mockLogger.error).toHaveBeenCalledWith(
      'Invalid parameters: Missing request or response.',
      { req: null, res: mockRes },
    );
    expect(mockRes.status).toHaveBeenCalledWith(StatusCode.BAD_REQUEST);
    expect(mockRes.send).toHaveBeenCalledWith(
      'Invalid parameters: Missing request or response.',
    );
    expect(originalMethod).not.toHaveBeenCalled();
  });

  it('should return 500 if client is not available', async () => {
    const target = { client: null };
    const propertyKey = 'testMethod';
    const originalMethod = jest.fn();
    const descriptor = { value: originalMethod };

    RefreshToken()(target, propertyKey, descriptor);

    // Spy on console.error
    const consoleErrorSpy = jest
      .spyOn(console, 'error')
      .mockImplementation(() => {});

    await descriptor.value.call(target, mockReq, mockRes);

    expect(consoleErrorSpy).toHaveBeenCalledWith(
      'Server configuration error: Client not available',
    );
    expect(mockRes.status).toHaveBeenCalledWith(
      StatusCode.INTERNAL_SERVER_ERROR,
    );
    expect(mockRes.send).toHaveBeenCalledWith(
      'Server configuration error: Client not available',
    );
    expect(originalMethod).not.toHaveBeenCalled();

    consoleErrorSpy.mockRestore();
  });

  it('should return 500 if token refresh fails', async () => {
    const target = { client: mockClient };
    const propertyKey = 'testMethod';
    const originalMethod = jest.fn();
    const descriptor = { value: originalMethod };

    // Cast silentRenew to jest.Mock before using mockRejectedValue
    (mockClient.silentRenew as jest.Mock).mockRejectedValue(
      new Error('Token refresh error'),
    );

    RefreshToken()(target, propertyKey, descriptor);

    await descriptor.value.call(target, mockReq, mockRes);

    expect(mockLogger.error).toHaveBeenCalledWith(
      'Silent token renewal failed',
      {
        error: new Error('Token refresh error'),
        context: mockContext,
      },
    );
    expect(mockRes.status).toHaveBeenCalledWith(
      StatusCode.INTERNAL_SERVER_ERROR,
    );
    expect(mockRes.send).toHaveBeenCalledWith('Token refresh failed');
    expect(originalMethod).not.toHaveBeenCalled();
  });
});
