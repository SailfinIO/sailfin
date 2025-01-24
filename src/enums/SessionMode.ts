// src/enums/SessionMode.ts

/**
 * Represents the session mode for the client.
 *
 * The `SessionMode` enum defines the possible session modes for the client.
 *
 * @enum
 */
export enum SessionMode {
  /**
   * Server-side session management.
   */
  SERVER = 'server',

  /**
   * Client-side session management.
   */
  CLIENT = 'client',

  /**
   * Hybrid session management.
   */
  HYBRID = 'hybrid',
}
