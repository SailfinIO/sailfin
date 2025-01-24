// src/enums/Scopes.ts

/**
 * Enum representing the OpenID Connect and OAuth 2.0 scopes.
 */
export enum Scopes {
  /**
   * Read access to the user's email address.
   */
  Email = 'email',

  /**
   * Read access to the user's profile info.
   */
  Profile = 'profile',

  /**
   * Read access to the user's address.
   */
  Address = 'address',

  /**
   * Access to the user's phone number.
   */
  Phone = 'phone',

  /**
   * Access to the user's offline access.
   */
  OfflineAccess = 'offline_access',

  /**
   * Access to the user's OpenID Connect claims.
   */
  OpenId = 'openid',

  /**
   * Access to the user's roles.
   */
  Roles = 'roles',

  /**
   * Access to the user's permissions.
   */
  Permissions = 'permissions',

  /**
   * Access to the user's groups.
   */
  Groups = 'groups',

  /**
   * Access to the user's organization.
   */
  Organization = 'organization',

  /**
   * Access to the user's organization ID.
   */
  OrganizationId = 'organization_id',

  /**
   * Access to the user's organization name.
   */
  OrganizationName = 'organization_name',

  /**
   * Access to administrative functionalities.
   */
  Admin = 'admin',

  /**
   * Access to user settings.
   */
  UserSettings = 'user_settings',

  /**
   * Access to user notifications.
   */
  Notifications = 'notifications',

  /**
   * Access to user roles with elevated privileges.
   */
  SuperUser = 'superuser',

  /**
   * Access to user activity logs.
   */
  ActivityLogs = 'activity_logs',

  /**
   * Read access to the user's birthdate.
   */
  Birthdate = 'birthdate',

  /**
   * Read access to the user's gender.
   */
  Gender = 'gender',

  /**
   * Read access to the user's locale.
   */
  Locale = 'locale',

  /**
   * Read access to the user's time zone information.
   */
  Zoneinfo = 'zoneinfo',

  /**
   * Read access to the user's given name.
   */
  GivenName = 'given_name',

  /**
   * Read access to the user's family name.
   */
  FamilyName = 'family_name',

  /**
   * Read access to the user's website.
   */
  Website = 'website',

  /**
   * Read access to the user's profile picture.
   */
  Picture = 'picture',
}
