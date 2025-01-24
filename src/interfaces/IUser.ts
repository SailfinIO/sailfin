/**
 * @fileoverview
 * Defines the `IUser` interface, representing a user's profile information based on OpenID Connect UserInfo.
 * This interface includes standard claims such as `sub`, `name`, `email`, and others, along with an optional `address` field.
 *
 * @module src/interfaces/IUser
 */

import { Address, ExtendedAddress } from '../types';

/**
 * Represents a user's profile information.
 *
 * The `IUser` interface is modeled after the OpenID Connect UserInfo claims,
 * providing a standardized structure for user data in authentication and identity systems.
 *
 * @interface IUser
 */
export interface IUser {
  /**
   * The unique identifier for the user.
   *
   * @type {string}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '1234567890' };
   * ```
   */
  sub: string;

  /**
   * The user's full name.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', name: 'John Doe' };
   * ```
   */
  name?: string;

  /**
   * The user's given name (first name).
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', given_name: 'John' };
   * ```
   */
  given_name?: string;

  /**
   * The user's family name (last name).
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', family_name: 'Doe' };
   * ```
   */
  family_name?: string;

  /**
   * The user's middle name.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', middle_name: 'Anthony' };
   * ```
   */
  middle_name?: string;

  /**
   * The user's nickname.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', nickname: 'Johnny' };
   * ```
   */
  nickname?: string;

  /**
   * The user's preferred username.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', preferred_username: 'johndoe' };
   * ```
   */
  preferred_username?: string;

  /**
   * The URL of the user's profile.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', profile: 'https://example.com/johndoe' };
   * ```
   */
  profile?: string;

  /**
   * The URL of the user's profile picture.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', picture: 'https://example.com/johndoe.jpg' };
   * ```
   */
  picture?: string;

  /**
   * The URL of the user's personal website.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', website: 'https://johndoe.dev' };
   * ```
   */
  website?: string;

  /**
   * The user's email address.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', email: 'johndoe@example.com' };
   * ```
   */
  email?: string;

  /**
   * Indicates whether the user's email address has been verified.
   *
   * @type {boolean | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', email: 'johndoe@example.com', email_verified: true };
   * ```
   */
  email_verified?: boolean;

  /**
   * The user's gender.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', gender: 'male' };
   * ```
   */
  gender?: string;

  /**
   * The user's birthdate in ISO 8601 format (e.g., "YYYY-MM-DD").
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', birthdate: '1990-01-01' };
   * ```
   */
  birthdate?: string;

  /**
   * The user's time zone in IANA Time Zone Database format.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', zoneinfo: 'America/New_York' };
   * ```
   */
  zoneinfo?: string;

  /**
   * The user's locale (e.g., "en-US").
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', locale: 'en-US' };
   * ```
   */
  locale?: string;

  /**
   * The user's phone number.
   *
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', phone_number: '+1234567890' };
   * ```
   */
  phone_number?: string;

  /**
   * The timestamp of the last update to the user's profile, represented as seconds since the epoch.
   *
   * @type {number | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', updated_at: 1625097600 };
   * ```
   */
  updated_at?: number;

  /**
   * The user's address, which can include standard fields and custom extensions.
   *
   * @type {Address<ExtendedAddress> | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = {
   *   sub: '123',
   *   address: {
   *     street_address: '123 Main St',
   *     locality: 'Anytown',
   *     region: 'CA',
   *     postal_code: '90210',
   *     country: 'USA',
   *   },
   * };
   * ```
   */
  address?: Address<ExtendedAddress>;

  /**
   * The Authentication Context Class Reference (ACR) value.
   * This field indicates the method used to authenticate the user.
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', acr: 'urn:mace:incommon:iap:silver' };
   * ```
   */
  acr?: string;

  /**
   * The user's preferred language.
   * This field can be used to customize the user interface or content for the user.
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', lang: 'en-US' };
   * ```
   */
  lang?: string;

  /**
   * The user's preferred time zone.
   * This field can be used to customize the user experience based on the user's local time.
   * @type {string | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', zone: 'America/New_York' };
   * ```
   */
  zone?: string;

  /**
   * Additional user claims not covered by the standard claims.
   * This field can include custom or proprietary claims.
   * @type {Record<string, any> | undefined}
   * @example
   * ```typescript
   * const userInfo: IUser = { sub: '123', ext: { customClaim: 'value' } };
   * ```
   * */
  ext?: Record<string, any>;
}
