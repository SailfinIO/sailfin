// src/utils/Logger.ts

import { ILogger } from '../interfaces';
import { LogLevel } from '../enums';
import { COLOR_CODES, RESET_CODE } from '../constants/loggerConstants';

/**
 * A simple, customizable logger class for logging messages at various log levels.
 * Provides options for colored output and context-based logging.
 *
 * @remarks This class is intended for use in Node.js applications.
 * @implements {ILogger}
 *
 * @module Logger
 * @example
 * const logger = new Logger('MyClass', LogLevel.INFO, true);
 * logger.info('This is an info message');
 * logger.error('This is an error message');
 * logger.warn('This is a warning message');
 * logger.debug('This is a debug message');
 */
export class Logger implements ILogger {
  private context: string;
  private currentLogLevel: LogLevel;
  private useColors: boolean;

  /**
   * Creates a new instance of the Logger.
   * @param context - Identifies the origin or purpose of log messages.
   * @param logLevel - Sets the initial log level; defaults to LogLevel.INFO.
   * @param useColors - Enables color-coded output if true; defaults to true.
   */
  constructor(
    context: string,
    logLevel: LogLevel = LogLevel.INFO,
    useColors: boolean = true,
  ) {
    this.context = context;
    this.currentLogLevel = Object.values(LogLevel).includes(logLevel)
      ? logLevel
      : LogLevel.INFO;
    this.useColors = useColors;
  }

  /**
   * Sets the log level for the logger, defining the minimum severity of messages to log.
   * @param level - The log level to apply (e.g., LogLevel.ERROR, LogLevel.DEBUG).
   * @remarks Log levels are hierarchical, with DEBUG being the most verbose and ERROR the least. Messages at or above the specified level will be logged. The default log level is INFO.
   * @returns {void}
   * @example
   * logger.setLogLevel(LogLevel.DEBUG);
   */
  public setLogLevel(level: LogLevel): void {
    this.currentLogLevel = level;
  }

  /**
   * Determines whether a given log level should be logged based on the current log level setting.
   * @param level - The log level to evaluate.
   * @remarks This method is used internally to determine whether to log a message.
   * @returns {boolean} True if the specified level meets or exceeds the current log level; otherwise, false.
   */
  private shouldLog(level: LogLevel): boolean {
    const levels: LogLevel[] = [
      LogLevel.ERROR,
      LogLevel.WARN,
      LogLevel.INFO,
      LogLevel.DEBUG,
    ];
    return levels.indexOf(level) <= levels.indexOf(this.currentLogLevel);
  }

  /**
   * Converts unknown data types into a log-friendly string format.
   * @param data - The data to process.
   * @remarks This method is used internally to format additional data for log messages.
   * @returns {string} A stringified version of the data, or a message indicating a failure to stringify.
   */
  private processUnknown(data?: unknown): string {
    if (data === undefined) {
      return '';
    }
    if (typeof data === 'string') {
      return data;
    }
    if (data instanceof Error) {
      return `${data.message}\n${data.stack}`;
    }
    try {
      return JSON.stringify(data, this.circularReplacer());
    } catch {
      return 'Unable to stringify additional data';
    }
  }

  /**
   * Provides a replacer function to handle circular references in objects.
   * @remarks This method is used internally to prevent JSON.stringify from throwing an error.
   * @returns A function that replaces circular references with "[Circular]".
   */
  private circularReplacer() {
    const seen = new WeakSet();
    return (_key: string, value: any) => {
      if (typeof value === 'object' && value !== null) {
        if (seen.has(value)) {
          return '[Circular]';
        }
        seen.add(value);
      }
      return value;
    };
  }

  /**
   * Generates a human-readable timestamp for log messages.
   * @remarks This method is used internally to provide a consistent timestamp format.
   * @returns {string} The current date and time in a readable string format.
   * @example
   * const timestamp = this.formatTimestamp();
   * console.log(timestamp);
   * // Output: "01/01/2022, 12:00:00 AM"
   */
  private formatTimestamp(): string {
    const now = new Date();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    const year = now.getFullYear();
    let hours = now.getHours();
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');
    const ampm = hours >= 12 ? 'PM' : 'AM';

    hours = hours % 12 || 12;

    return `${month}/${day}/${year}, ${hours}:${minutes}:${seconds} ${ampm}`;
  }

  /**
   * Constructs and formats a log message with optional colors and additional data.
   * @remarks This method is used internally to create a formatted log message.
   * @param level - The log level of the message (e.g., LogLevel.ERROR).
   * @param message - The main message to log.
   * @param additionalData - Optional additional data to include with the message.
   * @returns {string} A formatted string ready for logging.
   */
  private formatMessage(
    level: LogLevel,
    message: string,
    additionalData?: string,
  ): string {
    const timestamp = this.formatTimestamp();
    const pid = process.pid;

    const white = this.useColors ? COLOR_CODES['white'] : '';
    const yellow = this.useColors ? COLOR_CODES['yellow'] : '';
    const reset = this.useColors ? RESET_CODE : '';
    const color = this.useColors ? COLOR_CODES[level] || '' : '';

    let formattedMessage = `${white}${pid} - ${timestamp}${reset} `;
    formattedMessage += `${color}[${level.toUpperCase()}]${reset} `;
    formattedMessage += `${yellow}[${this.context}]${reset} `;
    formattedMessage += `${color}${message}${reset}`;

    if (additionalData) {
      formattedMessage += ` | ${color}${additionalData}${reset}`;
    }

    return formattedMessage;
  }

  /**
   * Logs an error message to the console, with optional trace information.
   * @remarks This method is used to log error messages and stack traces.
   * @param message - The error message.
   * @param trace - Optional trace data to include.
   * @returns {void} Logs the message to the console.
   * @example
   * logger.error('An error occurred', new Error('Error details'));
   */
  public error(message: string, trace?: unknown): void {
    if (this.shouldLog(LogLevel.ERROR)) {
      const formattedTrace = this.processUnknown(trace);
      console.error(
        this.formatMessage(LogLevel.ERROR, message, formattedTrace),
      );
    }
  }

  /**
   * Logs a warning message to the console, with optional context.
   * @remarks This method is used to log potential issues or non-critical warnings.
   * @param message - The warning message.
   * @param context - Optional additional context.
   * @returns {void} Logs the message to the console.
   * @example
   * logger.warn('Potential issue detected');
   */
  public warn(message: string, context?: unknown): void {
    if (this.shouldLog(LogLevel.WARN)) {
      const formattedContext = this.processUnknown(context);
      console.warn(
        this.formatMessage(LogLevel.WARN, message, formattedContext),
      );
    }
  }

  /**
   * Logs an informational message to the console, with optional context.
   * @remarks This method is used to log general information or status updates.
   * @param message - The informational message.
   * @param context - Optional additional context.
   * @returns {void} Logs the message to the console.
   * @example
   * logger.info('System operational');
   */
  public info(message: string, context?: unknown): void {
    if (this.shouldLog(LogLevel.INFO)) {
      const formattedContext = this.processUnknown(context);
      console.info(
        this.formatMessage(LogLevel.INFO, message, formattedContext),
      );
    }
  }

  /**
   * Logs a debug message to the console, with optional context for troubleshooting.
   * @remarks This method is used to log detailed debugging information.
   * @param message - The debug message.
   * @param context - Optional additional context.
   * @returns {void} Logs the message to the console.
   * @example
   * logger.debug('Debugging application flow');
   */
  public debug(message: string, context?: unknown): void {
    if (this.shouldLog(LogLevel.DEBUG)) {
      const formattedContext = this.processUnknown(context);
      console.debug(
        this.formatMessage(LogLevel.DEBUG, message, formattedContext),
      );
    }
  }
}
