// src/interfaces/ClientMetadata.ts

/**
 * Interface for the client metadata.
 */
export interface ClientMetadata {
  /**
   * The client's issuer.
   * @example 'https://issuer.example.com'
   */
  issuer: string;
  /**
   * The issuer's authorization endpoint.
   */
  authorization_endpoint: string;

  /**
   * The issuer's device authorization endpoint.
   */
  device_authorization_endpoint: string;

  /**
   * The issuer's token endpoint.
   */
  token_endpoint: string;

  /**
   * The issuer's userinfo endpoint.
   */
  userinfo_endpoint: string;

  /**
   * The issuer's jwks_uri endpoint.
   */
  jwks_uri: string;

  /**
   * The issuer's revocation endpoint.
   */
  revocation_endpoint: string;

  /**
   * The issuer's introspection endpoint.
   */
  introspection_endpoint: string;

  /**
   * The issuer's end session endpoint.
   */
  end_session_endpoint: string;

  /**
   * The issuer's registration endpoint.
   */
  registration_endpoint: string;

  /**
   * The issuer's scopes supported.
   */
  scopes_supported: string[];

  /**
   * The issuer's response types supported.
   */
  response_types_supported: string[];

  /**
   * The issuer's response modes supported.
   */
  response_modes_supported: string[];

  /**
   * The issuer's grant types supported.
   */
  grant_types_supported: string[];

  /**
   * The issuer's acr values supported.
   */
  acr_values_supported: string[];

  /**
   * The issuer's subject types supported.
   */
  subject_types_supported: string[];

  /**
   * The issuer's id token signing algorithm values supported.
   */
  id_token_signing_alg_values_supported: string[];

  /**
   * The issuer's token endpoint auth methods supported.
   */
  token_endpoint_auth_methods_supported: string[];

  /**
   * The issuer's claims supported.
   */
  claims_supported: string[];

  /**
   * The issuer's code challenge methods supported.
   */
  code_challenge_methods_supported: string[];

  /**
   * The issuer's request parameter supported.
   */
  request_parameter_supported: boolean;

  /**
   * The issuer's request URI parameter supported.
   */
  request_uri_parameter_supported: boolean;

  /**
   * The issuer's require request URI registration.
   */
  require_request_uri_registration: boolean;

  /**
   * The issuer's request object signing algorithm values supported.
   */
  request_object_signing_alg_values_supported: string[];

  /**
   * The issuer's request object encryption algorithm values supported.
   */
  request_object_encryption_alg_values_supported: string[];

  /**
   * The issuer's request object encryption encoding values supported.
   */
  request_object_encryption_enc_values_supported: string[];

  /**
   * The issuer's token endpoint auth signing algorithm values supported.
   */
  token_endpoint_auth_signing_alg_values_supported: string[];

  /**
   * The issuer's display values supported.
   */
  display_values_supported: string[];

  /**
   * The issuer's claim types supported.
   */
  claim_types_supported: string[];

  /**
   * The issuer's claims locales supported.
   */
  claims_locales_supported: string[];

  /**
   * The issuer's ui locales supported.
   */
  ui_locales_supported: string[];

  /**
   * The issuer's claims parameter supported.
   */
  claims_parameter_supported: boolean;

  /**
   * The issuer's op policy uri.
   */
  op_policy_uri: string;

  /**
   * The issuer's op tos uri.
   */
  op_tos_uri: string;

  /**
   * The issuer's service documentation.
   */
  service_documentation: string;
}
