/**
 * @fileoverview
 * Defines the `IStore` interface, which standardizes the behavior of session storage implementations.
 * Provides methods to create, retrieve, update, and delete session data, as well as an optional context
 * for interacting with HTTP requests and responses.
 *
 * @module src/interfaces/IStore
 */

import { IRequest } from './IRequest';
import { IResponse } from './IResponse';
import { ISessionData } from './ISessionData';
import { IUser } from './IUser';

/**
 * Represents the context for session storage operations.
 *
 * The `IStoreContext` interface provides optional access to the HTTP request and response objects,
 * allowing implementations to interact with the HTTP layer when managing session data.
 *
 * @interface
 */
export interface IStoreContext {
  /**
   * The HTTP request object, if available.
   *
   * @type {Request | undefined}
   */
  request?: IRequest;

  /**
   * The HTTP response object, if available.
   *
   * @type {Response | undefined}
   */
  response?: IResponse;

  /**
   * Additional context data for the store implementation.
   *
   * @type {Record<string, any> | undefined}
   */
  extra?: Record<string, any>;

  /**
   * The User object, if available.
   *
   * @type {IUser | undefined}
   */
  user?: IUser;
}

/**
 * Standard interface for session storage implementations.
 *
 * The `IStore` interface defines methods for managing session data, including setting, retrieving,
 * destroying, and updating (touching) sessions. It supports optional context for integrating
 * with HTTP layers or other environment-specific contexts.
 *
 * @interface
 */
export interface IStore {
  /**
   * Stores session data with the specified session ID.
   *
   * @param {string} sid - The session ID.
   * @param {ISessionData} data - The session data to store.
   * @param {IStoreContext} [context] - Optional store context.
   * @returns {Promise<void>} A promise that resolves when the data is successfully stored.
   */
  set(sid: string, data: ISessionData, context?: IStoreContext): Promise<void>;

  /**
   * Retrieves the session data for the specified session ID.
   *
   * @param {string} sid - The session ID.
   * @param {IStoreContext} [context] - Optional store context.
   * @returns {Promise<ISessionData | null>} A promise that resolves to the session data,
   * or `null` if the session is not found.
   */
  get(sid: string, context?: IStoreContext): Promise<ISessionData | null>;

  /**
   * Deletes the session data associated with the specified session ID.
   *
   * @param {string} sid - The session ID.
   * @param {IStoreContext} [context] - Optional store context.
   * @returns {Promise<void>} A promise that resolves when the session data is successfully deleted.
   */
  destroy(sid: string, context?: IStoreContext): Promise<void>;

  /**
   * Extends the session's expiration without modifying its data.
   *
   * @param {string} sid - The session ID.
   * @param {ISessionData} session - The session data to touch.
   * @param {IStoreContext} [context] - Optional store context.
   * @returns {Promise<void>} A promise that resolves when the session expiration is updated.
   */
  touch(
    sid: string,
    session: ISessionData,
    context?: IStoreContext,
  ): Promise<void>;
}
