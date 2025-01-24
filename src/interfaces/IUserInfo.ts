// src/clients/IUserInfo.ts

import { IUser } from './IUser';

export interface IUserInfo {
  /**
   * Retrieves user information from the UserInfo endpoint.
   *
   * @returns {Promise<IUser>} The user information.
   * @throws {ClientError} If fetching user info fails or no valid access token is available.
   */
  getUserInfo(): Promise<IUser>;
}
