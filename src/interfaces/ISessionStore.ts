// src/interfaces/ISessionStore.ts

import { ISessionData } from './ISessionData';
import { IStoreContext } from './IStore';

export interface ISessionStore {
  /**
   * Sets session data and returns the generated session ID.
   * The implementation handles the generation of `sid`.
   */
  set(data: ISessionData, context?: IStoreContext): Promise<string>;

  /**
   * Retrieves session data based on `sid`.
   */
  get(sid: string, context?: IStoreContext): Promise<ISessionData | null>;

  /**
   * Destroys the session associated with `sid`.
   */
  destroy(sid: string, context?: IStoreContext): Promise<void>;

  /**
   * Updates the session's expiration without altering the data.
   */
  touch(
    sid: string,
    session: ISessionData,
    context?: IStoreContext,
  ): Promise<void>;
}
