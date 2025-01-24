/**
 * Enum representing the various log levels available in the logger.
 * Used to control the verbosity of logging output.
 *
 * @enum {string}
 * @readonly
 */
export enum LogLevel {
  /**
   * Error level - logs only error messages, typically for critical issues.
   */
  ERROR = 'error',

  /**
   * Warn level - logs warnings and error messages, useful for potential issues that need attention.
   */
  WARN = 'warn',

  /**
   * Info level - logs informational messages along with warnings and errors, useful for general operational insights.
   */
  INFO = 'info',

  /**
   * Debug level - logs detailed debugging information, including info, warnings, and errors, useful for troubleshooting.
   */
  DEBUG = 'debug',
}
