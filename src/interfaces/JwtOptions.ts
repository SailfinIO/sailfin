import { ClientMetadata } from './ClientMetadata';
import { IClaimsValidator } from './IClaimsValidator';
import { IJwks } from './IJwks';
import { ILogger } from './ILogger';
import { ISignatureVerifier } from './ISignatureVerifier';
import { JwtHeader } from './Jwt';
import { Algorithm } from '../enums';

/**
 * Interface for verification options used in the Jwt.verify method.
 */
export interface JwtVerifyOptions {
  logger: ILogger;
  client: ClientMetadata;
  clientId: string;
  jwks?: IJwks;
  claimsValidator?: IClaimsValidator;
  signatureVerifier?: ISignatureVerifier;
  nonce?: string;
}

/**
 * Interface for encoding options used in the Jwt.encode method.
 */
export interface JwtEncodeOptions {
  algorithm: Algorithm;
  privateKey: string | Buffer;
  header?: Partial<JwtHeader>;
}
