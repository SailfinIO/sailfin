// src/interfaces/ILogger.ts

import { LogLevel } from '../enums';

/**
 * Interface representing a customizable logger with multiple log levels.
 */
export interface ILogger {
  /**
   * Sets the log level for the logger, controlling which messages are logged.
   * @param level - The log level to set, which determines the minimum severity of logs that will be recorded.
   */
  setLogLevel(level: LogLevel): void;

  /**
   * Logs an error message, typically used for critical issues.
   * @param message - The error message to log.
   * @param trace - (Optional) Additional trace or error information.
   */
  error(message: string, trace?: unknown): void;

  /**
   * Logs a warning message, often used for non-critical issues that may require attention.
   * @param message - The warning message to log.
   * @param context - (Optional) Additional context or metadata about the warning.
   */
  warn(message: string, context?: unknown): void;

  /**
   * Logs an informational message, usually for general operational insights.
   * @param message - The informational message to log.
   * @param context - (Optional) Additional context or metadata for the message.
   */
  info(message: string, context?: unknown): void;

  /**
   * Logs a debug message, useful for tracing execution during development or troubleshooting.
   * @param message - The debug message to log.
   * @param context - (Optional) Additional context or metadata about the debug information.
   */
  debug(message: string, context?: unknown): void;
}
