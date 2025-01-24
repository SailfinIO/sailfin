// src/utils/NullObject.ts

/**
 * @fileoverview
 * Defines the `NullObject` class, which creates objects with no prototype.
 * This is useful for creating truly empty objects that do not inherit properties
 * from `Object.prototype`, thereby preventing potential prototype pollution.
 *
 * @module src/utils/NullObject
 */

/**
 * Represents an object with no prototype.
 *
 * The `NullObject` class implements the `NullPrototypeObject` type, ensuring
 * that the created object does not inherit from `Object.prototype`. This can help
 * prevent unintended property access and enhance security by avoiding prototype pollution.
 *
 * @class
 */
export class NullObject {
  [key: string]: string | undefined;

  /**
   * Creates an instance of `NullObject`.
   */
  constructor() {
    Object.setPrototypeOf(this, null);
  }
}
