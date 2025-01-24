// src/enums/LoginPrompt.ts

/**
 * Enum representing the OpenID Connect prompt parameter values.
 */
export enum LoginPrompt {
  /**
   * The Authorization Server must not display any authentication or consent user interface pages.
   */
  None = 'none',

  /**
   * The Authorization Server must prompt the End-User for reauthentication.
   */
  Login = 'login',

  /**
   * The Authorization Server must prompt the End-User for consent before returning information to the client.
   */
  Consent = 'consent',

  /**
   * The Authorization Server must prompt the End-User to select a user account.
   */
  SelectAccount = 'select_account',
}
