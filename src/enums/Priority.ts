/**
 * @fileoverview
 * Enumeration of task or operation priorities.
 * This module defines the `Priority` enum, which provides a standardized way
 * to assign and categorize priority levels for tasks, operations, or entities
 * within the application.
 *
 * @module src/enums/Priority
 */

/**
 * Represents priority levels for tasks or operations.
 *
 * The `Priority` enum defines a hierarchy of priority levels, which can be used
 * to classify tasks, manage execution order, or control resource allocation
 * based on importance or urgency.
 *
 * @enum {string}
 */
export enum Priority {
  /**
   * The `High` priority level indicates that a task or operation is of the utmost importance
   * and should be addressed immediately or as a top priority.
   *
   * @member {string} Priority.HIGH
   * @example
   * // Example usage:
   * {
   *   priority: Priority.HIGH,
   * }
   */
  HIGH = 'high',

  /**
   * The `Medium` priority level represents tasks or operations that are important
   * but not as urgent as high-priority items. These tasks should be addressed
   * in a reasonable timeframe.
   *
   * @member {string} Priority.MEDIUM
   * @example
   * // Example usage:
   * {
   *   priority: Priority.MEDIUM,
   * }
   */
  MEDIUM = 'medium',

  /**
   * The `Low` priority level is used for tasks or operations that are less critical.
   * These tasks can be deferred until higher-priority items have been addressed.
   *
   * @member {string} Priority.LOW
   * @example
   * // Example usage:
   * {
   *   priority: Priority.LOW,
   * }
   */
  LOW = 'low',
}
