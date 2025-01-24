// src/utils/Logger.test.ts

import { Logger } from './Logger';
import { LogLevel } from '../enums';
import { COLOR_CODES } from '../constants/loggerConstants';

describe('Logger', () => {
  let logger: Logger;

  // Mock console methods
  const consoleErrorSpy = jest
    .spyOn(console, 'error')
    .mockImplementation(() => {});
  const consoleWarnSpy = jest
    .spyOn(console, 'warn')
    .mockImplementation(() => {});
  const consoleInfoSpy = jest
    .spyOn(console, 'info')
    .mockImplementation(() => {});
  const consoleDebugSpy = jest
    .spyOn(console, 'debug')
    .mockImplementation(() => {});
  const consoleLogSpy = jest.spyOn(console, 'log').mockImplementation(() => {});

  // Mock Date to return a fixed date that corresponds to "01/01/2022, 12:00:00 AM" in local time
  // Adjust the time based on your local timezone. For UTC-5, set to "2022-01-01T05:00:00Z"
  const fixedDate = new Date('2022-01-01T05:00:00Z'); // Adjust as needed
  const OriginalDate = Date;
  global.Date = class extends OriginalDate {
    constructor() {
      super();
      return fixedDate;
    }
  } as any;

  beforeEach(() => {
    jest.clearAllMocks();
    // Instantiate Logger with default log level (INFO) and without colors for easier testing
    logger = new Logger('TestContext', LogLevel.INFO, false);
  });

  afterAll(() => {
    // Restore original implementations
    consoleErrorSpy.mockRestore();
    consoleWarnSpy.mockRestore();
    consoleInfoSpy.mockRestore();
    consoleDebugSpy.mockRestore();
    consoleLogSpy.mockRestore();
    global.Date = OriginalDate;
  });

  // Helper function to generate expected timestamp
  const getFormattedTimestamp = () => {
    const now = fixedDate;
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    const year = now.getFullYear();
    let hours = now.getHours();
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    const ampm = hours >= 12 ? 'PM' : 'AM';

    hours = hours % 12 || 12;

    return `${month}/${day}/${year}, ${hours}:${minutes}:${seconds} ${ampm}`;
  };

  describe('Logger Constructor', () => {
    it('should initialize with default values', () => {
      const logger = new Logger('DefaultContext');

      // Assert defaults
      expect(logger).toHaveProperty('context', 'DefaultContext');
      expect(logger).toHaveProperty('currentLogLevel', LogLevel.INFO);
      expect(logger).toHaveProperty('useColors', true);
    });

    it('should initialize with custom log level and useColors', () => {
      const logger = new Logger('CustomContext', LogLevel.DEBUG, false);

      // Assert custom values
      expect(logger).toHaveProperty('context', 'CustomContext');
      expect(logger).toHaveProperty('currentLogLevel', LogLevel.DEBUG);
      expect(logger).toHaveProperty('useColors', false);
    });

    it('should handle an empty context string', () => {
      const logger = new Logger('');

      // Assert that context is an empty string
      expect(logger).toHaveProperty('context', '');
      expect(logger).toHaveProperty('currentLogLevel', LogLevel.INFO);
      expect(logger).toHaveProperty('useColors', true);
    });

    it('should handle invalid log level gracefully', () => {
      // @ts-ignore - Test bypasses TypeScript checks to simulate misuse
      const logger = new Logger('InvalidLogLevelContext', 'INVALID');

      // Assert default log level is used if invalid value is provided
      expect(logger).toHaveProperty('currentLogLevel', LogLevel.INFO);
    });
  });

  it('should log error messages when log level is ERROR', () => {
    logger.error('This is an error message');

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.error).toHaveBeenCalledTimes(1);
    const logMessage = consoleErrorSpy.mock.calls[0][0];
    expect(logMessage).toContain('[ERROR]');
    expect(logMessage).toContain('This is an error message');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
  });

  it('should log warn messages when log level is WARN', () => {
    logger.warn('This is a warning message');

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.warn).toHaveBeenCalledTimes(1);
    const logMessage = consoleWarnSpy.mock.calls[0][0];
    expect(logMessage).toContain('[WARN]');
    expect(logMessage).toContain('This is a warning message');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
  });

  it('should log info messages when log level is INFO', () => {
    logger.info('This is an info message');

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.info).toHaveBeenCalledTimes(1);
    const logMessage = consoleInfoSpy.mock.calls[0][0];
    expect(logMessage).toContain('[INFO]');
    expect(logMessage).toContain('This is an info message');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
  });

  it('should not log debug messages when log level is INFO', () => {
    logger.debug('This is a debug message');

    expect(console.debug).not.toHaveBeenCalled();
  });

  it('should log debug messages when log level is DEBUG', () => {
    logger.setLogLevel(LogLevel.DEBUG);
    logger.debug('This is a debug message');

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.debug).toHaveBeenCalledTimes(1);
    const logMessage = consoleDebugSpy.mock.calls[0][0];
    expect(logMessage).toContain('[DEBUG]');
    expect(logMessage).toContain('This is a debug message');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
  });

  it('should not log info messages when log level is ERROR', () => {
    logger.setLogLevel(LogLevel.ERROR);
    logger.info('This is an info message');

    expect(console.info).not.toHaveBeenCalled();
  });

  it('should log error messages even when log level is ERROR', () => {
    logger.setLogLevel(LogLevel.ERROR);
    logger.error('This is an error message');

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.error).toHaveBeenCalledTimes(1);
    const logMessage = consoleErrorSpy.mock.calls[0][0];
    expect(logMessage).toContain('[ERROR]');
    expect(logMessage).toContain('This is an error message');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
  });

  it('should include additional data in error logs', () => {
    const error = new Error('Test error');
    logger.error('An error occurred', error);

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.error).toHaveBeenCalledTimes(1);
    const logMessage = consoleErrorSpy.mock.calls[0][0];
    expect(logMessage).toContain('[ERROR]');
    expect(logMessage).toContain('An error occurred');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
    expect(logMessage).toContain('Test error');
    expect(logMessage).toContain(error.stack || '');
  });

  it('should handle additional context in warn logs', () => {
    const context = { user: 'John Doe', action: 'login' };
    logger.warn('User action', context);

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.warn).toHaveBeenCalledTimes(1);
    const logMessage = consoleWarnSpy.mock.calls[0][0];
    expect(logMessage).toContain('[WARN]');
    expect(logMessage).toContain('User action');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
    expect(logMessage).toContain(JSON.stringify(context));
  });

  it('should handle circular references in additional data gracefully', () => {
    const obj: any = { a: 1 };
    obj.b = obj; // Create a circular reference

    logger.info('Circular reference test', obj);

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.info).toHaveBeenCalledTimes(1);
    const logMessage = consoleInfoSpy.mock.calls[0][0];
    expect(logMessage).toContain('[INFO]');
    expect(logMessage).toContain('Circular reference test');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
    expect(logMessage).toContain('[Circular]');
  });

  it('should update the log level correctly', () => {
    logger.setLogLevel(LogLevel.WARN);
    logger.info('This should not be logged');
    logger.warn('This should be logged');

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.info).not.toHaveBeenCalled();
    expect(console.warn).toHaveBeenCalledTimes(1);
    const logMessage = consoleWarnSpy.mock.calls[0][0];
    expect(logMessage).toContain('[WARN]');
    expect(logMessage).toContain('This should be logged');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
  });

  it('should handle string as additional data correctly', () => {
    logger.info('This is a message', 'Additional string data');

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.info).toHaveBeenCalledTimes(1);
    const logMessage = consoleInfoSpy.mock.calls[0][0];
    expect(logMessage).toContain('[INFO]');
    expect(logMessage).toContain('This is a message');
    expect(logMessage).toContain('Additional string data');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
  });

  it('should handle non-stringifiable data gracefully', () => {
    const nonStringifiableData = BigInt(12345678901234567890n); // BigInt cannot be stringified

    logger.info('Non-stringifiable data test', nonStringifiableData);

    const expectedTimestamp = getFormattedTimestamp();

    expect(console.info).toHaveBeenCalledTimes(1);
    const logMessage = consoleInfoSpy.mock.calls[0][0];
    expect(logMessage).toContain('[INFO]');
    expect(logMessage).toContain('Non-stringifiable data test');
    expect(logMessage).toContain('TestContext');
    expect(logMessage).toContain(expectedTimestamp);
    expect(logMessage).toContain('Unable to stringify additional data');
  });

  it('should format message with colors when useColors is true', () => {
    const testLogger = new Logger('TestContext', LogLevel.INFO, true);

    const formattedMessage = testLogger['formatMessage'](
      LogLevel.INFO,
      'Test message',
    );

    expect(formattedMessage).toContain(COLOR_CODES['white']);
    expect(formattedMessage).toContain(COLOR_CODES['yellow']);
    expect(formattedMessage).toContain(COLOR_CODES['info']);
    expect(formattedMessage).toContain('Test message');
  });

  it('should format message without colors when useColors is false', () => {
    const testLogger = new Logger('TestContext', LogLevel.INFO, false);

    const formattedMessage = testLogger['formatMessage'](
      LogLevel.INFO,
      'Test message',
    );

    expect(formattedMessage).not.toContain(COLOR_CODES['white']);
    expect(formattedMessage).not.toContain(COLOR_CODES['yellow']);
    expect(formattedMessage).not.toContain(COLOR_CODES['info']);
    expect(formattedMessage).toContain('Test message');
  });

  it('should use empty string for color when log level is not in COLOR_CODES and useColors is true', () => {
    const testLogger = new Logger('TestContext', LogLevel.INFO, true);

    // Mock COLOR_CODES to exclude the 'INFO' log level
    const originalColorCodes = { ...COLOR_CODES };
    delete COLOR_CODES['info'];

    const formattedMessage = testLogger['formatMessage'](
      LogLevel.INFO,
      'Test message without matching color',
    );

    // Restore original COLOR_CODES
    Object.assign(COLOR_CODES, originalColorCodes);

    expect(formattedMessage).not.toContain(originalColorCodes['info']);
    expect(formattedMessage).toContain('Test message without matching color');
  });
});
