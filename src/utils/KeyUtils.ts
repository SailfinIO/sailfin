// Assuming these imports based on your project structure
import * as rsaKeyUtils from './rsaKeyUtils';
import * as ecKeyUtils from './ecKeyUtils';
import { IAlgorithmIdentifier, Jwk, KeyData } from '../interfaces';
import { pemToDer } from './pem';
import {
  createHash,
  createPrivateKey,
  createPublicKey,
  createSign,
  createVerify,
  generateKeyPairSync,
} from 'crypto';
import {
  Algorithm,
  BinaryToTextEncoding,
  EcCurve,
  KeyExportOptions,
  KeyFormat,
  KeyOps,
  KeyType,
} from '../enums';
import { ALGORITHM_DETAILS_MAP } from '../constants/algorithmConstants';
import { generateX5c, generateX5t } from './certUtils';
import { decodeObjectIdentifier, decodeSequence } from './derUtils';

interface GenerateKeyPairOptions {
  modulusLength?: number; // for RSA
  namedCurve?: EcCurve; // for EC
}

export class KeyUtils {
  /**
   * Converts a JWK object to PEM format.
   * Delegates to RSA or EC specific utility based on the key type.
   */
  static jwkToPem(jwk: Jwk): string {
    if (jwk.kty === 'RSA') {
      // Expecting RSA properties: n and e
      if (!jwk.n || !jwk.e) {
        throw new Error('Invalid RSA JWK: missing modulus (n) or exponent (e)');
      }
      return rsaKeyUtils.rsaJwkToPem(jwk.n, jwk.e);
    } else if (jwk.kty === 'EC') {
      // Expecting EC properties: crv, x, y
      if (!jwk.crv || !jwk.x || !jwk.y) {
        throw new Error(
          'Invalid EC JWK: missing curve (crv) or coordinates (x, y)',
        );
      }
      return ecKeyUtils.ecJwkToPem(jwk.crv, jwk.x, jwk.y);
    } else {
      throw new Error(`Unsupported key type: ${jwk.kty}`);
    }
  }

  /**
   * Heuristic method to determine the type of Key
   * @param pem - The PEM-encoded key
   * @returns {KeyType} The type of key (e.g., 'RSA', 'EC')
   * @throws {Error} If the key type cannot be determined
   * @example
   * ```typescript
   * const keyType = KeyUtils.getKeyType(pem);
   * ```
   */
  public static getKeyType(pem: string): KeyType {
    const derBuffer = pemToDer(pem);
    const { elements: spkiElements } = decodeSequence(derBuffer, 0);
    const algIdElement = spkiElements[0];
    const { elements: algIdElements } = decodeSequence(algIdElement.content, 0);
    const { oid: algorithmOid } = decodeObjectIdentifier(
      algIdElements[0].content,
      0,
    );
    if (algorithmOid === ALGORITHM_DETAILS_MAP.RSA_PUBLIC_KEY.publicKeyOid) {
      return KeyType.RSA;
    } else if (
      algorithmOid === ALGORITHM_DETAILS_MAP.EC_PUBLIC_KEY.publicKeyOid
    ) {
      return KeyType.EC;
    } else {
      throw new Error('Unsupported key type based on algorithm OID');
    }
  }

  /**
   * Converts a PEM-encoded public key to JWK format.
   * Automatically detects if the key is RSA or EC.
   */
  public static pemToJwk(pem: string): Jwk {
    // Determine the key type using the getKeyType method.
    const keyType = KeyUtils.getKeyType(pem);

    // Choose the appropriate conversion based on the detected key type.
    switch (keyType) {
      case KeyType.RSA: {
        const { n, e } = rsaKeyUtils.rsaPemToJwk(pem);
        return { kty: keyType.toUpperCase(), n, e }; // 'RSA'
      }
      case KeyType.EC: {
        const { crv, x, y } = ecKeyUtils.ecPemToJwk(pem);
        return { kty: keyType.toUpperCase(), crv, x, y }; // 'EC'
      }
      default:
        throw new Error('Unsupported key type');
    }
  }
  /**
   * Generates a key pair (public and private keys) in PEM format.
   * Delegates to RSA or EC specific utility based on provided type.
   */
  public static generateKeyPair(
    type: KeyType,
    options: GenerateKeyPairOptions,
  ): { publicKey: string; privateKey: string } {
    if (type === KeyType.RSA) {
      const modulusLength = options.modulusLength || 2048;
      const { publicKey, privateKey } = generateKeyPairSync(KeyType.RSA, {
        modulusLength,
        publicKeyEncoding: {
          type: KeyExportOptions.SPKI,
          format: KeyFormat.PEM,
        },
        privateKeyEncoding: {
          type: KeyExportOptions.PKCS8,
          format: KeyFormat.PEM,
        },
      });
      return { publicKey, privateKey };
    } else if (type === KeyType.EC) {
      const namedCurve = options.namedCurve || EcCurve.P256;
      const { publicKey, privateKey } = generateKeyPairSync(KeyType.EC, {
        namedCurve,
        publicKeyEncoding: {
          type: KeyExportOptions.SPKI,
          format: KeyFormat.PEM,
        },
        privateKeyEncoding: {
          type: KeyExportOptions.PKCS8,
          format: KeyFormat.PEM,
        },
      });
      return { publicKey, privateKey };
    } else {
      throw new Error(`Unsupported key type: ${type}`);
    }
  }

  /**
   * Generates a key pair and returns JWK representations.
   * Delegates to RSA or EC specific utility based on provided type.
   */
  public static generateJwkKeyPair(
    type: KeyType,
    options: GenerateKeyPairOptions,
  ): { publicJwk: JsonWebKey; privateJwk: JsonWebKey } {
    // First, generate the PEM key pair using the above helper
    const { publicKey, privateKey } = this.generateKeyPair(type, options);

    // Convert PEM keys to JWK using Node.js crypto export functionality
    const publicKeyObj = createPublicKey(publicKey);
    const privateKeyObj = createPrivateKey(privateKey);
    const publicJwk: JsonWebKey = publicKeyObj.export({
      format: KeyFormat.JWK,
    });
    const privateJwk: JsonWebKey = privateKeyObj.export({
      format: KeyFormat.JWK,
    });

    return { publicJwk, privateJwk };
  }

  /**
   * Extracts the public key from a PEM-encoded X.509 certificate in JWK format.
   *
   * @param pemCertificate - PEM-encoded X.509 certificate.
   * @returns {Jwk} The public key as a JWK.
   */
  static extractPublicKeyFromCertificate(pemCertificate: string): Jwk {
    // Parse the certificate and then extract the subjectPublicKeyInfo.
    const jwk = this.pemToJwk(pemCertificate);
    return jwk;
  }

  /**
   * Verifies a signature given data, signature, and a certificate.
   *
   * @param data - The original data buffer.
   * @param signature - The signature to verify.
   * @param pemCertificate - The PEM-encoded X.509 certificate containing the public key.
   * @param Algorithm  - The hash algorithm used (e.g., 'sha256').
   * @returns {boolean} True if signature is valid, false otherwise.
   */
  static verifySignature(
    data: Buffer,
    signature: Buffer,
    pemCertificate: string,
    algorithm: Algorithm = Algorithm.SHA256,
  ): boolean {
    const { hashName } = ALGORITHM_DETAILS_MAP[algorithm];
    const verify = createVerify(hashName);
    verify.update(data);
    verify.end();
    return verify.verify(pemCertificate, signature);
  }

  /**
   * Creates a JWKS-compliant key representation, including x5t and x5c values.
   * @param pemCertificate - The PEM-encoded certificate.
   * @returns A JSON Web Key with x5t and x5c attributes.
   */
  static createJwksKey(pemCertificate: string): Record<string, any> {
    const x5t = generateX5t(pemCertificate);
    const x5c = generateX5c([pemCertificate]);
    return {
      x5t,
      x5c,
    };
  }

  /**
   * Generates key data, including x5c, x5t, and a key pair object, for storage or usage.
   *
   * @param privateKey - PEM-encoded private key.
   * @param publicKey - PEM-encoded public key.
   * @param certificate - PEM-encoded X.509 certificate.
   * @param alg - Algorithm used for the key (e.g., RS256).
   * @param kty - Key type (e.g., 'RSA', 'EC').
   * @param kid - Optional key identifier. If not provided, a hash of the public key will be used.
   * @param keyOps - Optional array of key operations. Defaults to ['sign', 'verify'].
   * @returns {KeyData} The generated key data including x5c, x5t, and metadata.
   */
  static generateKeyData(
    privateKey: string,
    publicKey: string,
    certificate: string,
    kty: KeyType,
    alg?: Algorithm,
    kid?: string,
    keyOps: KeyOps[] = [KeyOps.SIGN, KeyOps.VERIFY], // Default key operations
  ): KeyData {
    // Compute x5c and x5t using existing helper methods
    const jwksKey = KeyUtils.createJwksKey(certificate);
    const x5c = jwksKey.x5c;
    const x5t = jwksKey.x5t;

    // Generate a unique key ID if not provided
    if (!kid) {
      const hash = createHash(Algorithm.SHA256);
      hash.update(publicKey);
      kid = hash.digest(BinaryToTextEncoding.HEX);
    }

    // Generate a default algorithm if not provided
    if (!alg) {
      alg = Algorithm.RS256;
    }

    // Get the current timestamp for metadata
    const createdAt = new Date();

    // Build and return the KeyData object
    return {
      privateKey,
      publicKey,
      kid,
      kty,
      alg,
      createdAt,
      activatedAt: createdAt,
      deactivatedAt: null,
      x5c,
      x5t,
      keyOps,
    };
  }

  /**
   * Sign a certificate using the provided private key.
   * @param {certificateDer} [Buffer<ArrayBufferLike>]- The certificate to sign.
   * @param {privateKeyPem} [string]- The private key to sign the certificate with.
   * @param {signAlgorithm} [IAlgorithmIdentifier]- The algorithm to use for signing.
   * @returns {Buffer} The signed certificate.
   * @throws {Error} If the signing operation fails.
   *
   * @memberof KeyUtils
   * @static
   * @example
   * ```typescript
   * const signedCert = KeyUtils.sign(certificateDer, privateKeyPem, signAlgorithm);
   * ```
   */
  static sign(
    certificateDer: Buffer,
    privateKeyPem: string,
    signAlgorithm: IAlgorithmIdentifier,
  ): Buffer {
    // use OID_ALGORITHM_MAP to get the algorithm name
    const algorithm = ALGORITHM_DETAILS_MAP[signAlgorithm.algorithm];
    const sign = createSign(algorithm);
    sign.update(certificateDer);
    sign.end();
    return sign.sign(privateKeyPem);
  }
}
