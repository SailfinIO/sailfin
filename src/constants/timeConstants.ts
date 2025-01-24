// UTCTime format: YYMMDDHHMMSSZ (seconds optional, timezone 'Z' required)
export const UTC_REGEX = /^(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})?Z$/;

// GeneralizedTime format: YYYYMMDDHHMMSSZ (seconds optional, timezone 'Z' required)
export const GENERALIZED_TIME_REGEX =
  /^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})?Z$/;
