/**
 * @fileoverview Defines the `StatusCode` enum, which provides a list of HTTP status codes.
 *
 * @enum {string}
 */
export enum StatusCode {
  /**
   * Continue to the next step in the request.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/100}
   * @member {number} StatusCode.CONTINUE
   */
  CONTINUE = 100,

  /**
   * The server will switch protocols to the one specified in the upgrade header.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/101}
   * @member {number} StatusCode.SWITCHING_PROTOCOLS
   */
  SWITCHING_PROTOCOLS = 101,

  /**
   * The server is sending an early response.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/103}
   * @member {number} StatusCode.EARLY_HINTS
   */
  EARLY_HINTS = 103,

  /**
   * The request was successful.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/200}
   * @member {number} StatusCode.OK
   */
  OK = 200,

  /**
   * The request was successful and a new resource was created.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/201}
   * @member {number} StatusCode.CREATED
   */
  CREATED = 201,

  /**
   * The request was accepted for processing.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/202}
   * @member {number} StatusCode.ACCEPTED
   */
  ACCEPTED = 202,

  /**
   * The request was successful but no content was returned.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/203}
   * @member {number} StatusCode.NON_AUTHORITATIVE_INFORMATION
   */
  NON_AUTHORITATIVE_INFORMATION = 203,

  /**
   * The request was successful but no content was returned.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/204}
   * @member {number} StatusCode.NO_CONTENT
   */
  NO_CONTENT = 204,

  /**
   * The server is resetting the content.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/205}
   * @member {number} StatusCode.RESET_CONTENT
   */
  RESET_CONTENT = 205,

  /**
   * The server is sending content in parts.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/206}
   * @member {number} StatusCode.PARTIAL_CONTENT
   */
  PARTIAL_CONTENT = 206,

  /**
   * The server is sending multiple status codes.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/207}
   * @member {number} StatusCode.MULTI_STATUS
   */
  MULTI_STATUS = 207,

  /**
   * The request has already been reported.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/208}
   * @member {number} StatusCode.ALREADY_REPORTED
   */
  ALREADY_REPORTED = 208,

  /**
   * The server is sending content in parts.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/300}
   * @member {number} StatusCode.MULTIPLE_CHOICES
   */
  MULTIPLE_CHOICES = 300,

  /**
   * The resource was moved permanently.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/301}
   * @member {number} StatusCode.MOVED_PERMANENTLY
   */
  MOVED_PERMANENTLY = 301,

  /**
   * The resource was found.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/302}
   * @member {number} StatusCode.FOUND
   */
  FOUND = 302,

  /**
   * The resource was found, but the client should use a different URL.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/303}
   * @member {number} StatusCode.SEE_OTHER
   */
  SEE_OTHER = 303,

  /**
   * The resource has not been modified since the last request.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/304}
   * @member {number} StatusCode.NOT_MODIFIED
   */
  NOT_MODIFIED = 304,

  /**
   * The resource was moved temporarily.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/307}
   * @member {number} StatusCode.TEMPORARY_REDIRECT
   */
  TEMPORARY_REDIRECT = 307,

  /**
   * The resource was moved permanently.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/308}
   * @member {number} StatusCode.PERMANENT_REDIRECT
   */
  PERMANENT_REDIRECT = 308,

  /**
   * The client should continue with its request.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/400}
   * @member {number} StatusCode.BAD_REQUEST
   */
  BAD_REQUEST = 400,

  /**
   * The client must authenticate to get the requested response.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/401}
   * @member {number} StatusCode.UNAUTHORIZED
   */
  UNAUTHORIZED = 401,

  /**
   * The client must pay to access the requested response.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/402}
   * @member {number} StatusCode.PAYMENT_REQUIRED
   */
  PAYMENT_REQUIRED = 402,

  /**
   * The client does not have permission to access the requested resource.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/403}
   * @member {number} StatusCode.FORBIDDEN
   */
  FORBIDDEN = 403,

  /**
   * The server could not find the requested resource.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/404}
   * @member {number} StatusCode.NOT_FOUND
   */
  NOT_FOUND = 404,

  /**
   * The client used an HTTP method that the server does not allow.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/405}
   * @member {number} StatusCode.METHOD_NOT_ALLOWED
   */
  METHOD_NOT_ALLOWED = 405,

  /**
   * The server could not produce a response matching the list of acceptable values defined in the request's proactive content negotiation headers
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/406}
   * @member {number} StatusCode.NOT_ACCEPTABLE
   */
  NOT_ACCEPTABLE = 406,

  /**
   * The client must authenticate with a proxy server.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/407}
   * @member {number} StatusCode.PROXY_AUTHENTICATION_REQUIRED
   */
  PROXY_AUTHENTICATION_REQUIRED = 407,

  /**
   * The server timed out.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/408}
   * @member {number} StatusCode.REQUEST_TIMEOUT
   */
  REQUEST_TIMEOUT = 408,

  /**
   * There is a conflict with the current state of the target resource
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/409}
   * @member {number} StatusCode.CONFLICT
   */
  CONFLICT = 409,

  /**
   * The requested resource is no longer available.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/410}
   * @member {number} StatusCode.GONE
   */
  GONE = 410,

  /**
   * The client must specify the `Content-Length` header.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/411}
   * @member {number} StatusCode.LENGTH_REQUIRED
   */
  LENGTH_REQUIRED = 411,

  /**
   * The client sent a request with a pre-condition that failed.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/412}
   * @member {number} StatusCode.PRECONDITION_FAILED
   */
  PRECONDITION_FAILED = 412,

  /**
   * The request payload is too large.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/413}
   * @member {number} StatusCode.PAYLOAD_TOO_LARGE
   */
  PAYLOAD_TOO_LARGE = 413,

  /**
   * The request URI is too long.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/414}
   * @member {number} StatusCode.URI_TOO_LONG
   */
  URI_TOO_LONG = 414,

  /**
   * The request payload has an unsupported media type.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/415}
   * @member {number} StatusCode.UNSUPPORTED_MEDIA_TYPE
   */
  UNSUPPORTED_MEDIA_TYPE = 415,

  /**
   * The server cannot fulfill the request range.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/416}
   * @member {number} StatusCode.RANGE_NOT_SATISFIABLE
   */
  RANGE_NOT_SATISFIABLE = 416,

  /**
   * The server cannot meet the client's expectations.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/417}
   * @member {number} StatusCode.EXPECTATION_FAILED
   */
  EXPECTATION_FAILED = 417,

  /**
   * I'm a teapot.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/418}
   * @member {number} StatusCode.I_AM_A_TEAPOT
   */
  IM_A_TEAPOT = 418,

  /**
   * The server is misconfigured.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/421}
   * @member {number} StatusCode.MISDIRECTED_REQUEST
   */
  MISDIRECTED_REQUEST = 421,

  /**
   * The server cannot process the request due to a client error.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/422}
   * @member {number} StatusCode.UNPROCESSABLE_ENTITY
   */
  UNPROCESSABLE_ENTITY = 422,

  /**
   * The resource is locked.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/423}
   * @member {number} StatusCode.LOCKED
   */
  LOCKED = 423,

  /**
   * The server is sending content in parts.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/424}
   * @member {number} StatusCode.FAILED_DEPENDENCY
   */
  FAILED_DEPENDENCY = 424,

  /**
   * The server is sending content in parts.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/425}
   * @member {number} StatusCode.TOO_EARLY
   */
  TOO_EARLY = 425,

  /**
   * The client must upgrade to a different protocol.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/426}
   * @member {number} StatusCode.UPGRADE_REQUIRED
   */
  UPGRADE_REQUIRED = 426,

  /**
   * The client must include the `Precondition` header.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/428}
   * @member {number} StatusCode.PRECONDITION_REQUIRED
   */
  PRECONDITION_REQUIRED = 428,

  /**
   * The client sent too many requests in a given amount of time.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/429}
   * @member {number} StatusCode.TOO_MANY_REQUESTS
   */
  TOO_MANY_REQUESTS = 429,

  /**
   * The client must include the `Request Header Fields` header.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/431}
   * @member {number} StatusCode.REQUEST_HEADER_FIELDS_TOO_LARGE
   */
  REQUEST_HEADER_FIELDS_TOO_LARGE = 431,

  /**
   * The server cannot fulfill the request due to a legal reason.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/451}
   * @member {number} StatusCode.UNAVAILABLE_FOR_LEGAL_REASONS
   */
  UNAVAILABLE_FOR_LEGAL_REASONS = 451,

  /**
   * The server encountered an internal error.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/500}
   * @member {number} StatusCode.INTERNAL_SERVER_ERROR
   */
  INTERNAL_SERVER_ERROR = 500,

  /**
   * The server does not recognize the request method.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/501}
   * @member {number} StatusCode.NOT_IMPLEMENTED
   */
  NOT_IMPLEMENTED = 501,

  /**
   * The server cannot fulfill the request due to a bad gateway.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/502}
   * @member {number} StatusCode.BAD_GATEWAY
   */
  BAD_GATEWAY = 502,

  /**
   * The server is unavailable.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/503}
   * @member {number} StatusCode.SERVICE_UNAVAILABLE
   */
  SERVICE_UNAVAILABLE = 503,

  /**
   * The server timed out.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/504}
   * @member {number} StatusCode.GATEWAY_TIMEOUT
   */
  GATEWAY_TIMEOUT = 504,

  /**
   * The server does not support the HTTP version.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/505}
   * @member {number} StatusCode.HTTP_VERSION_NOT_SUPPORTED
   */
  HTTP_VERSION_NOT_SUPPORTED = 505,

  /**
   * The server cannot fulfill the request due to a policy.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/506}
   * @member {number} StatusCode.VARIANT_ALSO_NEGOTIATES
   */
  VARIANT_ALSO_NEGOTIATES = 506,

  /**
   * The server is out of storage.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/507}
   * @member {number} StatusCode.INSUFFICIENT_STORAGE
   */
  INSUFFICIENT_STORAGE = 507,

  /**
   * The server cannot fulfill the request due to a loop.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/508}
   * @member {number} StatusCode.LOOP_DETECTED
   */
  LOOP_DETECTED = 508,

  /**
   * The server is sending content in parts.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/510}
   * @member {number} StatusCode.NOT_EXTENDED
   */
  NOT_EXTENDED = 510,

  /**
   * The server requires network authentication.
   * @see {@link https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/511}
   * @member {number} StatusCode.NETWORK_AUTHENTICATION_REQUIRED
   */
  NETWORK_AUTHENTICATION_REQUIRED = 511,
}
