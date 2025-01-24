import { ClientError } from '../errors';
import {
  BinaryToTextEncoding,
  DERTag,
  Algorithm,
  KeyType,
  EcCurve,
} from '../enums';
import { pemToDer } from './pem';
import {
  bitString,
  decodeBitString,
  decodeInteger,
  decodeSequence,
  derNull,
  encodeDER,
  integer,
  objectIdentifier,
  sequence,
} from './derUtils';
import {
  ALGORITHM_DETAILS_MAP,
  ATTRIBUTE_DETAILS,
} from '../constants/algorithmConstants';
import {
  IAlgorithmIdentifier,
  AttributeTypeAndValue,
  IExtension,
  IName,
  IRelativeDistinguishedName,
  ISubjectPublicKeyInfo,
  ITbsCertificate,
  IValidity,
  IX509Certificate,
  CreateSelfSignedCertificateOptions,
} from '../interfaces';
import { ExtensionHandler } from './ExtensionHandler';
import { createHash, BinaryToTextEncoding as B2E } from 'crypto';
import { KeyUtils } from './KeyUtils';
import { RSACertificate } from './RSACertificate';
import { EllipticCurveCertificate } from './EllipticCurveCertificate';

export class X509Certificate {
  // Instance properties to hold parsed certificate data
  private _tbsCertificate: ITbsCertificate;
  private _signatureAlgorithm: IAlgorithmIdentifier;
  private _signatureValue: Buffer;
  private static strictSortingEnabled: boolean = true;

  // Private constructor to enforce use of static parse method for instantiation
  private constructor(cert: IX509Certificate) {
    this._tbsCertificate = cert.tbsCertificate;
    this._signatureAlgorithm = cert.signatureAlgorithm;
    this._signatureValue = cert.signatureValue;
  }

  // Getters/Setter to expose certificate data
  public get tbsCertificate(): ITbsCertificate {
    return this._tbsCertificate;
  }

  public set tbsCertificate(value: ITbsCertificate) {
    this._tbsCertificate = value;
  }

  public get signatureAlgorithm(): IAlgorithmIdentifier {
    return this._signatureAlgorithm;
  }

  public set signatureAlgorithm(value: IAlgorithmIdentifier) {
    this._signatureAlgorithm = value;
  }

  public get signatureValue(): Buffer {
    return this._signatureValue;
  }

  public set signatureValue(value: Buffer) {
    this._signatureValue = value;
  }

  public get strictSortingEnabled(): boolean {
    return X509Certificate.strictSortingEnabled;
  }

  public set strictSortingEnabled(value: boolean) {
    X509Certificate.strictSortingEnabled = value;
  }

  // Static factory method to parse PEM and return an X509Certificate instance
  public static parse(pem: string): X509Certificate {
    const certData = X509Certificate.parseX509Certificate(pem);
    return new X509Certificate(certData);
  }
  /**
   * Creates a new X509Certificate instance from the provided certificate data.
   * @param tbsCertificate - The TBSCertificate part of the certificate.
   * @param signatureAlgorithm - The signature algorithm identifier.
   * @param signatureValue - The signature value as a Buffer.
   * @returns A new X509Certificate instance.
   */
  public static create(
    tbsCertificate: ITbsCertificate,
    signatureAlgorithm: IAlgorithmIdentifier,
    signatureValue: Buffer,
  ): X509Certificate {
    const certData: IX509Certificate = {
      tbsCertificate,
      signatureAlgorithm,
      signatureValue,
    };
    return new X509Certificate(certData);
  }

  /**
   * Encodes an X.509 certificate into a DER-encoded Buffer.
   * @param cert The in-memory certificate representation.
   * @returns DER-encoded certificate as a Buffer.
   */
  public static buildX509Certificate(cert: IX509Certificate): Buffer {
    // Build TBS Certificate DER
    const tbsDER = this.buildTbsCertificate(cert.tbsCertificate);

    // Encode signature algorithm
    const sigAlgDER = this.buildAlgorithmIdentifier(cert.signatureAlgorithm);

    // Encode signature value as BIT STRING
    const sigValueDER = bitString(cert.signatureValue);

    // Combine into top-level sequence: Certificate ::= SEQUENCE { tbsCertificate, signatureAlgorithm, signatureValue }
    const certificateDER = sequence(
      Buffer.concat([tbsDER, sigAlgDER, sigValueDER]),
    );
    return certificateDER;
  }

  // Instance method to generate human-readable certificate text
  public toText(): string {
    return X509Certificate.certificateToText({
      tbsCertificate: this.tbsCertificate,
      signatureAlgorithm: this.signatureAlgorithm,
      signatureValue: this.signatureValue,
    });
  }

  // Instance method to build a DER-encoded certificate buffer from the current object
  public build(): Buffer {
    return X509Certificate.buildX509Certificate({
      tbsCertificate: this.tbsCertificate,
      signatureAlgorithm: this.signatureAlgorithm,
      signatureValue: this.signatureValue,
    });
  }

  /**
   * Parses a PEM-encoded X.509 certificate and returns a structured representation.
   *
   * @param {string} pem - A PEM-formatted X.509 certificate.
   * @returns {IX509Certificate} The parsed certificate structure.
   * @throws {ClientError} If the certificate cannot be parsed.
   */
  private static parseX509Certificate(pem: string): IX509Certificate {
    // Remove PEM header/footer and decode Base64 to DER buffer
    const derData = pemToDer(pem);

    try {
      // Verify that the certificate starts with a SEQUENCE
      if (derData[0] !== DERTag.SEQUENCE) {
        throw new ClientError('Invalid certificate format', 'PARSE_ERROR');
      }

      // Decode the top-level SEQUENCE which should contain three elements.
      const { elements: topElements } = decodeSequence(derData, 0);
      if (topElements.length !== 3) {
        throw new ClientError('Unexpected top-level structure', 'PARSE_ERROR');
      }

      // Extract buffers for tbsCertificate, signatureAlgorithm, signatureValue
      const tbsBuffer = topElements[0].content;
      const sigAlgBuffer = topElements[1].content;
      const sigValueBuffer = topElements[2].content;

      // Parse TBS Certificate using DER utilities as needed
      const tbsCertificate = this.parseTbsCertificate(tbsBuffer);

      // Parse signature algorithm identifier, for instance using decodeObjectIdentifier if structure known
      const signatureAlgorithm =
        ExtensionHandler.parseAlgorithmIdentifier(sigAlgBuffer);

      // Use DER utilities to extract BIT STRING content for signatureValue
      const { bits: signatureValue } = decodeBitString(sigValueBuffer, 0);

      return {
        tbsCertificate,
        signatureAlgorithm,
        signatureValue,
      };
    } catch (error) {
      throw new ClientError(
        'Failed to parse X.509 certificate',
        'PARSE_ERROR',
        {
          originalError: error,
        },
      );
    }
  }

  private static parseTbsCertificate(data: Buffer): ITbsCertificate {
    const { elements: tbsElements } = decodeSequence(data, 0);
    const tbsCert: Partial<ITbsCertificate> = {};
    let cursor = 0;

    // Version (optional, context-specific [0])
    if (tbsElements[cursor].tag === 0xa0) {
      const versionElement = tbsElements[cursor];
      const { value: versionBuf } = decodeInteger(versionElement.content, 0);
      tbsCert.version = versionBuf.readUInt8(0);
      cursor++;
    } else {
      tbsCert.version = 0;
    }

    // serialNumber (INTEGER)
    {
      const serialElement = tbsElements[cursor++];
      const { value: serialNumber } = decodeInteger(serialElement.content, 0);
      tbsCert.serialNumber = serialNumber;
    }

    // signature (AlgorithmIdentifier)
    {
      const signatureElement = tbsElements[cursor++];
      tbsCert.signature = ExtensionHandler.parseAlgorithmIdentifier(
        signatureElement.content,
      );
    }

    // issuer (Name)
    {
      const issuerElement = tbsElements[cursor++];
      tbsCert.issuer = ExtensionHandler.parseName(issuerElement.content);
    }

    // validity (Validity)
    {
      const validityElement = tbsElements[cursor++];
      tbsCert.validity = ExtensionHandler.parseValidity(
        validityElement.content,
      );
    }

    // subject (Name)
    {
      const subjectElement = tbsElements[cursor++];
      tbsCert.subject = ExtensionHandler.parseName(subjectElement.content);
    }

    // subjectPublicKeyInfo (SubjectPublicKeyInfo)
    {
      const spkiElement = tbsElements[cursor++];
      tbsCert.subjectPublicKeyInfo = ExtensionHandler.parseSubjectPublicKeyInfo(
        spkiElement.content,
      );
    }

    // Optional Fields (issuerUniqueID, subjectUniqueID, extensions)
    while (cursor < tbsElements.length) {
      const elem = tbsElements[cursor];

      switch (elem.tag) {
        case 0xa1: {
          // issuerUniqueID [1] IMPLICIT BIT STRING
          const { bits: issuerUniqueID } = decodeBitString(elem.content, 0);
          tbsCert.issuerUniqueID = issuerUniqueID;
          cursor++;
          break;
        }
        case 0xa2: {
          // subjectUniqueID [2] IMPLICIT BIT STRING
          const { bits: subjectUniqueID } = decodeBitString(elem.content, 0);
          tbsCert.subjectUniqueID = subjectUniqueID;
          cursor++;
          break;
        }
        case 0xa3: {
          // extensions [3] EXPLICIT
          // The content of an explicit tag is another encoded element (a sequence)
          const { elements: extElements } = decodeSequence(elem.content, 0);
          tbsCert.extensions = ExtensionHandler.parseExtensions(extElements);
          cursor++;
          break;
        }
        default:
          // Unknown or unsupported field: you can choose to skip, log a warning, or throw an error
          throw new ClientError(
            `Unexpected tag ${elem.tag} in TBS Certificate`,
            'PARSE_ERROR',
          );
      }
    }

    return tbsCert as ITbsCertificate;
  }

  /**
   * Converts an IName object to a human-readable string.
   * Example output: "CN=example.com, O=Example Org, C=US"
   */
  private static humanReadableName(name: IName): string {
    return name.rdnSequence
      .map(
        (rdn) =>
          rdn.attributes
            .map(({ type, value }) => {
              // Find the attribute name by matching the OID in ATTRIBUTE_DETAILS
              const attrName =
                Object.keys(ATTRIBUTE_DETAILS).find(
                  (key) => ATTRIBUTE_DETAILS[key].oid === type,
                ) || type; // Default to type (OID) if not found

              return `${attrName}=${value}`;
            })
            .join('+'), // multiple attributes in an RDN joined by '+'
      )
      .join(', '); // separate RDNs with commas
  }

  /**
   * Formats a Date object into a human-readable string.
   * @param date - The Date object to format.
   * @param toUTC - If true, returns the date in UTC; otherwise, local time.
   * @returns A formatted date string.
   */
  private static formatDate(date: Date, toUTC: boolean = true): string {
    return toUTC ? date.toUTCString() : date.toLocaleString();
  }

  /**
   * Generates a human-readable summary of the certificate.
   * @param cert - The parsed X.509 certificate.
   * @returns A formatted string representation of the certificate.
   */
  private static certificateToText(cert: IX509Certificate): string {
    const { tbsCertificate, signatureAlgorithm, signatureValue } = cert;
    let output = '';

    output += 'Certificate:\n';
    output += '    Data:\n';
    output += `        Version: ${tbsCertificate.version}\n`;
    output += `        Serial Number: ${tbsCertificate.serialNumber.toString('hex')}\n`;
    output += `    Signature Algorithm: ${signatureAlgorithm.algorithm}\n`;
    output += `        Issuer: ${this.humanReadableName(tbsCertificate.issuer)}\n`;
    output += `        Validity:\n`;
    output += `            Not Before: ${this.formatDate(tbsCertificate.validity.notBefore)}\n`;
    output += `            Not After : ${this.formatDate(tbsCertificate.validity.notAfter)}\n`;
    output += `        Subject: ${this.humanReadableName(tbsCertificate.subject)}\n`;
    output += `        Subject Public Key Info:\n`;
    output += `            Algorithm: ${tbsCertificate.subjectPublicKeyInfo.algorithm.algorithm}\n`;
    output += `            Public Key: ${tbsCertificate.subjectPublicKeyInfo.subjectPublicKey.toString('hex')}\n`;

    if (tbsCertificate.extensions) {
      output += '        Extensions:\n';
      for (const ext of tbsCertificate.extensions) {
        const extName =
          Object.keys(ATTRIBUTE_DETAILS).find(
            (key) => ATTRIBUTE_DETAILS[key].oid === ext.extnID,
          ) || ext.extnID; // Default to ext.extnID (OID) if no
        output += `            ${extName}: ${JSON.stringify(ext.parsedData, null, 2)}\n`;
      }
    }

    // Signature at end of certificate
    output += `    Signature Value: ${signatureValue.toString('hex')}\n`;

    return output;
  }

  /**
   * Builds the DER encoding for TBSCertificate.
   */
  public static buildTbsCertificate(tbs: ITbsCertificate): Buffer {
    const elements: Buffer[] = [];

    // Version (OPTIONAL, default v1). Use explicit [0] tag if version != v1
    if (tbs.version && tbs.version !== 0) {
      const versionInt = integer(Buffer.from([tbs.version]));
      // Wrap with context-specific tag [0] (constructed)
      const versionTagged = encodeDER(0xa0, versionInt);
      elements.push(versionTagged);
    }

    // serialNumber
    elements.push(integer(tbs.serialNumber));

    // signature (AlgorithmIdentifier)
    elements.push(this.buildAlgorithmIdentifier(tbs.signature));

    // issuer (Name)
    elements.push(this.buildName(tbs.issuer));

    // validity (Validity)
    elements.push(this.buildValidity(tbs.validity));

    // subject (Name)
    elements.push(this.buildName(tbs.subject));

    // subjectPublicKeyInfo
    elements.push(this.buildSubjectPublicKeyInfo(tbs.subjectPublicKeyInfo));

    // Optional issuerUniqueID [1]
    if (tbs.issuerUniqueID) {
      const issuerUID = bitString(tbs.issuerUniqueID);
      const issuerUIDTagged = encodeDER(0xa1, issuerUID);
      elements.push(issuerUIDTagged);
    }

    // Optional subjectUniqueID [2]
    if (tbs.subjectUniqueID) {
      const subjectUID = bitString(tbs.subjectUniqueID);
      const subjectUIDTagged = encodeDER(0xa2, subjectUID);
      elements.push(subjectUIDTagged);
    }

    // Optional extensions [3]
    if (tbs.extensions && tbs.extensions.length > 0) {
      // Build sequence of extensions
      tbs.extensions = tbs.extensions.map((ext) =>
        ExtensionHandler.createExtension(
          ext.extnID,
          ext.critical,
          ext.parsedData || ext.value,
        ),
      );
      const extBuffers = tbs.extensions.map(this.buildExtension);
      const extsSeq = sequence(Buffer.concat(extBuffers));
      const extensionsTagged = encodeDER(0xa3, extsSeq);
      elements.push(extensionsTagged);
    }

    // Combine all TBS elements into a SEQUENCE
    return sequence(Buffer.concat(elements));
  }

  /**
   * Builds an AlgorithmIdentifier structure.
   */
  private static buildAlgorithmIdentifier(alg: IAlgorithmIdentifier): Buffer {
    const oidDER = objectIdentifier(alg.algorithm);
    let paramsDER: Buffer;
    // If parameters are provided, encode them; otherwise, use NULL.
    if (alg.parameters) {
      // For simplicity, assume parameters are already DER-encoded.
      paramsDER = alg.parameters;
    } else {
      paramsDER = derNull();
    }
    return sequence(Buffer.concat([oidDER, paramsDER]));
  }

  /**
   * Builds a Name structure from IName.
   */
  private static buildName(name: IName): Buffer {
    // Name ::= SEQUENCE OF RDNSequence
    const rdnBuffers = name.rdnSequence.map(
      this.buildRelativeDistinguishedName,
    );
    return sequence(Buffer.concat(rdnBuffers));
  }

  /**
   * Builds a RelativeDistinguishedName structure.
   */
  private static buildRelativeDistinguishedName(
    rdn: IRelativeDistinguishedName,
  ): Buffer {
    const attrBuffers = rdn.attributes.map(this.buildAttributeTypeAndValue);
    if (X509Certificate.strictSortingEnabled) {
      attrBuffers.sort((a, b) => a.compare(b));
    }
    return encodeDER(DERTag.SET, Buffer.concat(attrBuffers));
  }

  /**
   * Encodes a string as a PrintableString.
   * @param str The string to encode.
   * @returns DER-encoded PrintableString.
   */
  private static encodePrintableString(str: string): Buffer {
    return encodeDER(
      DERTag.PRINTABLE_STRING,
      Buffer.from(str, BinaryToTextEncoding.ASCII),
    );
  }

  /**
   * Encodes a string as an IA5String.
   * @param str The string to encode.
   * @returns DER-encoded IA5String.
   */
  private static encodeIA5String(str: string): Buffer {
    return encodeDER(
      DERTag.IA5_STRING,
      Buffer.from(str, BinaryToTextEncoding.ASCII),
    );
  }

  /**
   * Encodes a string as a UTF8String.
   * @param str The string to encode.
   * @returns DER-encoded UTF8String.
   */
  private static encodeUTF8String(str: string): Buffer {
    return encodeDER(
      DERTag.UTF8_STRING,
      Buffer.from(str, BinaryToTextEncoding.UTF_8),
    );
  }

  /**
   * Encodes an AttributeTypeAndValue structure based on the attribute type.
   * @param attr The attribute to encode.
   * @returns DER-encoded AttributeTypeAndValue as a Buffer.
   */
  private static buildAttributeTypeAndValue(
    attr: AttributeTypeAndValue,
  ): Buffer {
    // AttributeTypeAndValue ::= SEQUENCE { type, value }

    // Encode the type (OID)
    const typeDER = objectIdentifier(attr.type);

    // Determine the ASN.1 type for the value based on the OID
    const attributeName = Object.keys(ATTRIBUTE_DETAILS).find(
      (key) => ATTRIBUTE_DETAILS[key].oid === attr.type,
    );
    const attributeDetails = attributeName
      ? ATTRIBUTE_DETAILS[attributeName]
      : { oid: attr.type, asn1Type: DERTag.UTF8_STRING };

    let valueDER: Buffer;

    // Encode the value based on its type
    if ('value' in attr) {
      if (typeof attr.value === 'string') {
        if (typeof attributeDetails === 'object') {
          switch (attributeDetails.asn1Type) {
            case DERTag.PRINTABLE_STRING:
              valueDER = this.encodePrintableString(attr.value);
              break;
            case DERTag.IA5_STRING:
              valueDER = this.encodeIA5String(attr.value);
              break;
            case DERTag.UTF8_STRING:
            default:
              valueDER = this.encodeUTF8String(attr.value);
              break;
          }
        } else {
          // Default to OCTET_STRING for unknown OIDs
          valueDER = encodeDER(
            DERTag.OCTET_STRING,
            Buffer.from(attr.value, 'utf8'),
          );
        }
      } else if (typeof attr.value === 'number') {
        // Handle integer encoding
        const intBuffer = Buffer.allocUnsafe(4);
        intBuffer.writeUInt32BE(attr.value, 0);
        valueDER = integer(intBuffer);
      } else if (Buffer.isBuffer(attr.value)) {
        // Handle buffer encoding
        valueDER = encodeDER(DERTag.OCTET_STRING, attr.value);
      } else {
        // Unsupported value type
        throw new Error(
          `Unsupported attribute value type for OID ${attr.type}`,
        );
      }
    } else {
      // If no value is present, throw an error or handle accordingly
      throw new Error(`Attribute value missing for OID ${attr.type}`);
    }

    // Combine type and value into a SEQUENCE
    return sequence(Buffer.concat([typeDER, valueDER]));
  }

  /**
   * Builds the Validity structure.
   */
  private static buildValidity(validity: IValidity): Buffer {
    // Validity ::= SEQUENCE { notBefore, notAfter }
    const notBeforeDER = this.buildTime(validity.notBefore);
    const notAfterDER = this.buildTime(validity.notAfter);
    return sequence(Buffer.concat([notBeforeDER, notAfterDER]));
  }

  /**
   * Encodes a Date into either UTCTime or GeneralizedTime based on the year.
   */
  private static buildTime(date: Date): Buffer {
    // Use UTCTime for years between 1950 and 2049, otherwise GeneralizedTime.
    const year = date.getUTCFullYear();
    const useUTC = year >= 1950 && year < 2050;
    const pad = (n: number) => n.toString().padStart(2, '0');

    const timeStr = useUTC
      ? `${pad(year % 100)}${pad(date.getUTCMonth() + 1)}${pad(
          date.getUTCDate(),
        )}${pad(date.getUTCHours())}${pad(date.getUTCMinutes())}${pad(
          date.getUTCSeconds(),
        )}Z`
      : `${year}${pad(date.getUTCMonth() + 1)}${pad(date.getUTCDate())}${pad(
          date.getUTCHours(),
        )}${pad(date.getUTCMinutes())}${pad(date.getUTCSeconds())}Z`;

    const tag = useUTC ? DERTag.UTCTime : DERTag.GENERALIZED_TIME;
    return encodeDER(tag, Buffer.from(timeStr, BinaryToTextEncoding.ASCII));
  }

  /**
   * Builds a SubjectPublicKeyInfo structure.
   */
  private static buildSubjectPublicKeyInfo(
    spki: ISubjectPublicKeyInfo,
  ): Buffer {
    const algDER = this.buildAlgorithmIdentifier(spki.algorithm);
    const pubKeyDER = bitString(spki.subjectPublicKey);
    return sequence(Buffer.concat([algDER, pubKeyDER]));
  }

  /**
   * Builds an Extension structure.
   */
  private static buildExtension(ext: IExtension): Buffer {
    // Extension ::= SEQUENCE { extnID, critical DEFAULT FALSE, extnValue }
    const oidDER = objectIdentifier(ext.extnID);
    const criticalDER =
      ext.critical === true
        ? encodeDER(DERTag.BOOLEAN, Buffer.from([0xff]))
        : undefined;
    // extnValue is an OCTET STRING wrapping the encoded extension value.
    const extnValueDER = encodeDER(DERTag.OCTET_STRING, ext.value);

    const parts = [oidDER];
    if (criticalDER) parts.push(criticalDER);
    parts.push(extnValueDER);
    return sequence(Buffer.concat(parts));
  }

  /**
   * Computes the fingerprint (hash) of the certificate using the specified algorithm.
   * @param {Algorithm} [alg=Algorithm.SHA256]  - The hash algorithm (e.g., 'sha1', 'sha256').
   * @returns {string} The hexadecimal fingerprint of the certificate.
   */
  public getFingerprint(alg: Algorithm = Algorithm.SHA256): string {
    // Build the DER-encoded certificate from the current instance.
    const der = this.build();
    // Create a hash using the specified algorithm.
    const hash = createHash(alg);
    hash.update(der);
    // Return the hex digest as the fingerprint.
    return hash.digest(BinaryToTextEncoding.HEX);
  }

  /**
   * Computes a thumbprint of the certificate and returns it in the specified encoding.
   * @param {Algorithm} [alg=Algorithm.SHA256] - The hash algorithm to use for the thumbprint.
   * @param {B2E} [encoding=BinaryToTextEncoding.HEX] - The encoding to use for the thumbprint.
   * @returns {string} The thumbprint of the certificate in the desired format.
   */
  public getThumbprint(
    alg: Algorithm = Algorithm.SHA256,
    encoding: B2E = BinaryToTextEncoding.HEX,
  ): string {
    const der = this.build();
    const hash = createHash(alg);
    hash.update(der);
    // Return the digest in the specified encoding.
    return hash.digest(encoding);
  }

  /**
   * Creates or generates keys, then builds a self-signed certificate.
   * If `options.keyPair` is provided, we use that pair; otherwise a new pair is generated.
   * Automatically detects RSA vs EC if keys are provided, or uses `options.type` to generate.
   */
  public static createSelfSignedCertificate(
    options: CreateSelfSignedCertificateOptions = {},
  ): { certificate: string; publicKey: string; privateKey: string } {
    // 1) Setup defaults (subjectCN, validity, etc.)
    const now = new Date();
    const oneYearLater = new Date(now);
    oneYearLater.setFullYear(now.getFullYear() + 1);

    const validity: IValidity = options.validity || {
      notBefore: now,
      notAfter: oneYearLater,
    };
    const subjectCN = options.subjectCN || 'Example';

    let publicKey: string;
    let privateKey: string;
    let keyType: KeyType;

    // 2) Determine key type & generate or use provided keys
    if (options.keyPair) {
      publicKey = options.keyPair.publicKey;
      privateKey = options.keyPair.privateKey;
      keyType = KeyUtils.getKeyType(publicKey);
    } else {
      keyType = options.type || KeyType.RSA;
      const generated = KeyUtils.generateKeyPair(keyType, {
        modulusLength: 2048,
        namedCurve: EcCurve.P256,
      });
      publicKey = generated.publicKey;
      privateKey = generated.privateKey;
    }

    // 3) Decide which algorithm to use
    const chosenAlg =
      options.algorithm ||
      (keyType === KeyType.RSA ? Algorithm.RS256 : Algorithm.ES256);
    const algInfo = ALGORITHM_DETAILS_MAP[chosenAlg];
    if (!algInfo) {
      throw new Error(
        `Unsupported algorithm for self-signed cert: ${chosenAlg}`,
      );
    }

    // 4) Build the certificate using your builder classes
    let certificate: string;
    if (keyType === KeyType.RSA) {
      const jwk = KeyUtils.pemToJwk(publicKey);
      const rsaCertBuilder = new RSACertificate(
        subjectCN,
        validity,
        privateKey,
        jwk.n,
        jwk.e,
      );
      rsaCertBuilder.setIsCA(options.isCA);
      rsaCertBuilder.algorithm = chosenAlg;
      rsaCertBuilder.extensions = options.extensions;

      // **If** user wants to override TBS fields (like `serialNumber`, `issuer`, etc.),
      // you can do so by hooking them into your `RSACertificate` or `buildTbsCertificate`.
      // For example:
      if (options.tbs?.serialNumber) {
        rsaCertBuilder.serialNumber = options.tbs.serialNumber;
      }
      if (options.tbs?.issuer) {
        rsaCertBuilder.issuer = options.tbs.issuer;
      }
      // etc.

      certificate = rsaCertBuilder.buildCertificate();
    } else {
      // EC
      const jwk = KeyUtils.pemToJwk(publicKey) as any;
      const ecCertBuilder = new EllipticCurveCertificate(
        subjectCN,
        validity,
        privateKey,
        jwk.crv,
        jwk.x,
        jwk.y,
      );
      ecCertBuilder.setIsCA(options.isCA);
      ecCertBuilder.extensions = options.extensions;
      ecCertBuilder.algorithm = chosenAlg;

      // same approach if we want to override TBS fields
      if (options.tbs?.serialNumber) {
        ecCertBuilder.serialNumber = options.tbs.serialNumber;
      }
      if (options.tbs?.issuer) {
        ecCertBuilder.issuer = options.tbs.issuer;
      }
      // etc.

      certificate = ecCertBuilder.buildCertificate();
    }

    // 5) Return final
    return { certificate, publicKey, privateKey };
  }
}
