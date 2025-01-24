import {
  ATTRIBUTE_DETAILS,
  GENERALIZED_TIME_REGEX,
  UTC_REGEX,
} from '../constants';
import {
  AttributeTypeAndValue,
  BasicConstraints,
  ExtensionParser,
  IAlgorithmIdentifier,
  IExtension,
  IName,
  IRelativeDistinguishedName,
  ISubjectPublicKeyInfo,
  IValidity,
  ParsedExtensionData,
  ParsedKeyUsage,
  KeyUsage,
  SubjectAltName,
  ExtendedKeyUsage,
  AuthorityKeyIdentifier,
  CRLDistributionPoints,
  AuthorityInfoAccess,
} from '../interfaces';
import {
  bitString,
  decodeBitString,
  decodeDER,
  decodeInteger,
  decodeObjectIdentifier,
  decodeSequence,
  encodeDER,
  integer,
  objectIdentifier,
  sequence,
} from './derUtils';
import { BinaryToTextEncoding, DERTag, ExtentionOid } from '../enums';
import { ClientError } from '../errors';

const TAG_CLASS_UNIVERSAL = 0x00;
const TAG_CLASS_APPLICATION = 0x40;
const TAG_CLASS_CONTEXT_SPECIFIC = 0x80;
const TAG_CLASS_PRIVATE = 0xc0;

/**
 * Mapping of bit positions to key usage flags.
 *
 * @see {@link https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.3}
 */
const BIT_USAGE_MAPPING = [
  'digitalSignature',
  'nonRepudiation',
  'keyEncipherment',
  'dataEncipherment',
  'keyAgreement',
  'keyCertSign',
  'cRLSign',
  'encipherOnly',
  'decipherOnly',
];

/**
 * Utility class to handle parsing and building X.509 certificate extensions.
 */
export class ExtensionHandler {
  /**
   * Parse a Name structure from a DER-encoded buffer.
   * @param {Buffer} data DER-encoded buffer containing the Name structure
   * @returns {IName} Parsed Name structure
   * @throws {ClientError} If the Name structure is invalid or empty
   *
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { BinaryToTextEncoding } from '@sailfin/oidc';
   *
   * const nameData = Buffer.from('3031310b3009...', BinaryToTextEncoding.HEX);
   * const name = ExtensionHandler.parseName(nameData);
   * console.log(name);
   * ```
   */
  public static parseName = (data: Buffer): IName => {
    const { elements: rdnElements } = decodeSequence(data, 0);

    if (!rdnElements || rdnElements.length === 0) {
      throw new ClientError('Invalid or empty RDN sequence in Name structure.');
    }
    const rdnSequence: IRelativeDistinguishedName[] = [];

    for (const rdnElement of rdnElements) {
      // Each RelativeDistinguishedName is a SET of AttributeTypeAndValue
      const { elements: attrElements } = decodeSequence(rdnElement.content, 0);
      const attributes: AttributeTypeAndValue[] = [];

      for (const attrElement of attrElements) {
        // Each AttributeTypeAndValue is a SEQUENCE { type, value }
        const { elements } = decodeSequence(attrElement.content, 0);
        const oid = decodeObjectIdentifier(elements[0].content, 0).oid;

        // Reverse lookup in ATTRIBUTE_DETAILS
        const attributeName = Object.keys(ATTRIBUTE_DETAILS).find(
          (key) => ATTRIBUTE_DETAILS[key].oid === oid,
        );

        const attributeDetails = attributeName
          ? ATTRIBUTE_DETAILS[attributeName]
          : {
              oid, // Default to OID as the attribute identifier if not found
              asn1Type: DERTag.UTF8_STRING, // Default to UTF8_STRING if ASN.1 type is unknown
            };

        let value: string | number | Buffer;

        switch (attributeDetails.asn1Type) {
          case DERTag.PRINTABLE_STRING:
          case DERTag.IA5_STRING:
          case DERTag.UTF8_STRING:
            value = elements[1].content.toString(BinaryToTextEncoding.UTF_8);
            break;
          case DERTag.INTEGER:
            value = elements[1].content.readUInt32BE(0);
            break;
          default:
            // For unknown types, return raw buffer
            value = elements[1].content;
            break;
        }

        attributes.push({ type: oid, value });
      }

      rdnSequence.push({ attributes });
    }

    return { rdnSequence };
  };

  /**
   * Parse a Validity structure from a DER-encoded buffer.
   *
   * @param {Buffer} data DER-encoded buffer containing the Validity structure
   * @returns {IValidity} Parsed Validity structure with notBefore and notAfter dates
   * @throws {ClientError} If the Validity structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { BinaryToTextEncoding } from '@sailfin/oidc';
   *
   * const validityData = Buffer.from('301f170d313...', BinaryToTextEncoding.HEX);
   * const validity = ExtensionHandler.parseValidity(validityData);
   *
   * console.log(validity);
   * ```
   */
  public static parseValidity = (data: Buffer): IValidity => {
    // Validity is a SEQUENCE of two Time fields
    const elements = ExtensionHandler.ensureSequenceLength(
      data,
      2,
      ExtensionHandler.parseValidity.name,
    );

    if (elements.length !== 2) {
      throw new Error('Invalid Validity structure');
    }
    const notBeforeElement = elements[0];
    const notAfterElement = elements[1];

    // Assuming first element is notBefore and second is notAfter
    const notBefore = this.parseTime(
      notBeforeElement.content,
      notBeforeElement.tag,
    );
    const notAfter = this.parseTime(
      notAfterElement.content,
      notAfterElement.tag,
    );

    return { notBefore, notAfter };
  };

  /**
   * Parse a Time structure from a DER-encoded buffer.
   *
   * @param {string} timeStr Time string in UTCTime or GeneralizedTime format
   * @returns {Date} Parsed Date object
   * @throws {ClientError} If the time string is invalid or in an unsupported format
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { BinaryToTextEncoding } from '@sailfin/oidc';
   *
   * const timeStr = '20010101000000Z';
   * const time = ExtensionHandler.parseTime(timeStr);
   *
   * console.log(time);
   * ```
   */
  private static parseUTCTime(timeStr: string): Date {
    const match = UTC_REGEX.exec(timeStr);
    if (!match) {
      throw new ClientError(`Invalid UTCTime format: ${timeStr}`);
    }
    const twoDigitYear = parseInt(match[1], 10);
    const year = twoDigitYear >= 50 ? 1900 + twoDigitYear : 2000 + twoDigitYear;
    const month = parseInt(match[2], 10);
    const day = parseInt(match[3], 10);
    const hour = parseInt(match[4], 10);
    const minute = parseInt(match[5], 10);
    const second = match[6] ? parseInt(match[6], 10) : 0;
    return new Date(Date.UTC(year, month - 1, day, hour, minute, second));
  }

  /**
   * Parse a GeneralizedTime structure from a DER-encoded buffer.
   *
   * @param {string} timeStr Time string in UTCTime or GeneralizedTime format
   * @returns {Date} Parsed Date object
   * @throws {ClientError} If the time string is invalid or in an unsupported format
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { BinaryToTextEncoding } from '@sailfin/oidc';
   *
   * const timeStr = '2001-01-01T00:00:00Z';
   * const time = ExtensionHandler.parseGeneralizedTime(timeStr);
   *
   * console.log(time);
   * ```
   */
  private static parseGeneralizedTime(timeStr: string): Date {
    const match = GENERALIZED_TIME_REGEX.exec(timeStr);
    if (!match) {
      throw new ClientError(`Invalid GeneralizedTime format: ${timeStr}`);
    }
    const year = parseInt(match[1], 10);
    const month = parseInt(match[2], 10);
    const day = parseInt(match[3], 10);
    const hour = parseInt(match[4], 10);
    const minute = parseInt(match[5], 10);
    const second = match[6] ? parseInt(match[6], 10) : 0;
    return new Date(Date.UTC(year, month - 1, day, hour, minute, second));
  }

  /**
   * Parse a Time structure from a DER-encoded buffer.
   *
   * @param {Buffer} data DER-encoded buffer containing the Time structure
   * @param {number} tag Tag number indicating the Time format (UTCTime or GeneralizedTime)
   * @returns {Date} Parsed Date object
   * @throws {ClientError} If the time tag is unsupported or the time string is invalid
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { BinaryToTextEncoding } from '@sailfin/oidc';
   *
   * const timeData = Buffer.from('170d313...', BinaryToTextEncoding.HEX);
   * const time = ExtensionHandler.parseTime(timeData, 0x17);
   *
   * console.log(time);
   * ```
   */
  public static parseTime = (data: Buffer, tag: number): Date => {
    const timeStr = data.toString(BinaryToTextEncoding.ASCII).trim();
    if (tag === DERTag.UTCTime) {
      return this.parseUTCTime(timeStr);
    } else if (tag === DERTag.GENERALIZED_TIME) {
      return this.parseGeneralizedTime(timeStr);
    } else {
      throw new ClientError(`Unsupported time tag: ${tag}`);
    }
  };

  /**
   * Parse a SubjectPublicKeyInfo structure from a DER-encoded buffer.
   *
   * @param {Buffer} data DER-encoded buffer containing the SubjectPublicKeyInfo structure
   * @returns {ISubjectPublicKeyInfo} Parsed SubjectPublicKeyInfo structure
   * @throws {ClientError} If the SubjectPublicKeyInfo structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { BinaryToTextEncoding } from '@sailfin/oidc';
   *
   * const spkiData = Buffer.from('301d0609...', BinaryToTextEncoding.HEX);
   * const spki = ExtensionHandler.parseSubjectPublicKeyInfo(spkiData);
   *
   * console.log(spki);
   * ```
   */
  public static parseSubjectPublicKeyInfo = (
    data: Buffer,
  ): ISubjectPublicKeyInfo => {
    const elements = ExtensionHandler.ensureSequenceLength(
      data,
      2,
      ExtensionHandler.parseSubjectPublicKeyInfo.name,
    );

    // First element: algorithm identifier
    const algorithm = this.parseAlgorithmIdentifier(elements[0].content);

    // Second element: subjectPublicKey as a BIT STRING
    const { bits: subjectPublicKey } = decodeBitString(elements[1].content, 0);

    return { algorithm, subjectPublicKey };
  };

  /**
   * Parse an AlgorithmIdentifier structure from a DER-encoded buffer.
   *
   * @param {Buffer} data DER-encoded buffer containing the AlgorithmIdentifier structure
   * @returns {IAlgorithmIdentifier} Parsed AlgorithmIdentifier structure
   * @throws {ClientError} If the AlgorithmIdentifier structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { BinaryToTextEncoding } from '@sailfin/oidc';
   *
   * const algIdData = Buffer.from('300d0609...', BinaryToTextEncoding.HEX);
   * const algId = ExtensionHandler.parseAlgorithmIdentifier(algIdData);
   *
   * console.log(algId);
   * ```
   */
  public static parseAlgorithmIdentifier = (
    data: Buffer,
  ): IAlgorithmIdentifier => {
    // Decode the DER sequence representing the AlgorithmIdentifier
    const { elements } = decodeSequence(data, 0);

    // The first element should be the OBJECT IDENTIFIER for the algorithm
    const oidElement = elements[0];
    const { oid } = decodeObjectIdentifier(oidElement.content, 0);

    // If there's a second element, use it as parameters; otherwise, parameters are undefined
    const parameters = elements.length > 1 ? elements[1].content : undefined;

    return {
      algorithm: oid,
      parameters,
    };
  };

  /**
   * Parse an Extension structure from a DER-encoded buffer.
   *
   * @param {Buffer} extnValue
   * @returns {ParsedExtensionData} Parsed extension data
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const parsedData = ExtensionHandler.parseExtension(extnData);
   *
   * console.log(parsedData);
   * ```
   */
  public static parseBasicConstraints(extnValue: Buffer): ParsedExtensionData {
    const { elements: bcElements } = decodeSequence(extnValue, 0);
    let cA = false;
    let pathLenConstraint: number | undefined = undefined;
    let index = 0;

    if (bcElements.length > index && bcElements[index].tag === DERTag.BOOLEAN) {
      const { value: caValue } = decodeInteger(bcElements[index].content, 0);
      cA = caValue[0] !== 0;
      index++;
    }
    if (bcElements.length > index && bcElements[index].tag === DERTag.INTEGER) {
      const { value: plcValue } = decodeInteger(bcElements[index].content, 0);
      pathLenConstraint = plcValue.readUInt8(0);
      index++;
    }
    return { cA, pathLenConstraint };
  }

  /**
   * Parse a KeyUsage extension from a DER-encoded buffer.
   *
   * @param {Buffer} extnValue
   * @returns {ParsedExtensionData} Parsed extension data
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const parsedData = ExtensionHandler.parseKeyUsage(extnData);
   *
   * console.log(parsedData);
   * ```
   */
  public static parseKeyUsage(extnValue: Buffer): ParsedExtensionData {
    // Decode the BIT STRING from the extension value
    const { bits } = decodeBitString(extnValue, 0);

    // Initialize the ParsedKeyUsage object with false values
    const keyUsage: ParsedKeyUsage = {
      digitalSignature: false,
      nonRepudiation: false,
      keyEncipherment: false,
      dataEncipherment: false,
      keyAgreement: false,
      keyCertSign: false,
      cRLSign: false,
      encipherOnly: false,
      decipherOnly: false,
    };

    // Iterate over the bits and set corresponding flags
    for (let byteIndex = 0; byteIndex < bits.length; byteIndex++) {
      const byte = bits[byteIndex];
      for (let bitIndex = 0; bitIndex < 8; bitIndex++) {
        const bitPosition = byteIndex * 8 + bitIndex;

        // Check if the bit is set and within the defined mapping
        if (
          byte & (1 << (7 - bitIndex)) &&
          bitPosition < BIT_USAGE_MAPPING.length
        ) {
          const usage = BIT_USAGE_MAPPING[bitPosition];
          if (usage) {
            keyUsage[usage as keyof ParsedKeyUsage] = true;
          }
        }
      }
    }

    return keyUsage;
  }

  /**
   * Parse a SubjectAltName extension from a DER-encoded buffer.
   *
   * @param {Buffer} extnValue
   * @returns {ParsedExtensionData} Parsed extension data
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const parsedData = ExtensionHandler.parseSubjectAltName(extnData);
   *
   * console.log(parsedData);
   * ```
   */
  public static parseSubjectAltName(extnValue: Buffer): ParsedExtensionData {
    const { elements } = decodeSequence(extnValue, 0);

    if (!elements || !Array.isArray(elements)) {
      throw new ClientError(
        'Invalid SubjectAltName extension: Expected a sequence of GeneralNames.',
        'PARSE_ERROR',
      );
    }

    // Initialize all required fields for SubjectAltName
    const parsedNames: SubjectAltName = {
      names: [],
      dnsNames: [],
      ipAddresses: [],
      emailAddresses: [],
      uris: [],
    };

    for (const elem of elements) {
      const tagClass = elem.tag & 0xc0;
      const tagNumber = elem.tag & 0x1f;

      if (tagClass === TAG_CLASS_CONTEXT_SPECIFIC) {
        switch (tagNumber) {
          case 2: // DNSName
            parsedNames.dnsNames!.push(
              elem.content.toString(BinaryToTextEncoding.UTF_8),
            );
            // Optionally, also add to the general names array if desired
            parsedNames.names.push(
              elem.content.toString(BinaryToTextEncoding.UTF_8),
            );
            break;
          case 7: // IPAddress
            parsedNames.ipAddresses!.push(this.parseIPAddress(elem.content));
            parsedNames.names.push(this.parseIPAddress(elem.content));
            break;
          case 1: // RFC822Name (email)
            parsedNames.emailAddresses!.push(
              elem.content.toString(BinaryToTextEncoding.UTF_8),
            );
            parsedNames.names.push(
              elem.content.toString(BinaryToTextEncoding.UTF_8),
            );
            break;
          case 6: // URI
            parsedNames.uris!.push(
              elem.content.toString(BinaryToTextEncoding.UTF_8),
            );
            parsedNames.names.push(
              elem.content.toString(BinaryToTextEncoding.UTF_8),
            );
            break;
          default:
            console.warn(
              `Unsupported GeneralName type: Class=${tagClass}, Number=${tagNumber}. Skipping.`,
            );
            break;
        }
      } else {
        console.warn(
          `Unsupported GeneralName class: Class=${tagClass}. Skipping.`,
        );
      }
    }

    return parsedNames;
  }

  /**
   * Parse an IPAddress from a DER-encoded buffer.
   *
   * @param {Buffer} data DER-encoded buffer containing the IPAddress structure
   * @returns {string} Parsed IP address string
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { BinaryToTextEncoding } from '@sailfin/oidc';
   *
   * const ipData = Buffer.from('04030201', BinaryToTextEncoding.HEX);
   * const ipAddress = ExtensionHandler.parseIPAddress(ipData);
   *
   * console.log(ipAddress);
   * ```
   */
  private static parseIPAddress = (data: Buffer): string => {
    if (data.length === 4) {
      // IPv4
      return Array.from(data).join('.');
    } else if (data.length === 16) {
      // IPv6
      const hex = data.toString(BinaryToTextEncoding.HEX);
      return (
        hex.match(/.{1,4}/g)?.join(':') ||
        data.toString(BinaryToTextEncoding.HEX)
      );
    } else {
      // Unknown IP length
      return data.toString(BinaryToTextEncoding.HEX);
    }
  };

  /**
   * Parse an ExtendedKeyUsage extension from a DER-encoded buffer.
   *
   * @param {Buffer} extnValue
   * @returns {ParsedExtensionData} Parsed extension data
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const parsedData = ExtensionHandler.parseExtendedKeyUsage(extnData);
   *
   * console.log(parsedData);
   * ```
   */
  public static parseExtendedKeyUsage = (
    extnValue: Buffer,
  ): ParsedExtensionData => {
    const { elements } = decodeSequence(extnValue, 0);
    const purposes: string[] = [];

    for (const elem of elements) {
      const oid = decodeObjectIdentifier(elem.content, 0).oid;
      purposes.push(oid);
    }

    return { purposes };
  };

  /**
   * Parse a SubjectKeyIdentifier extension from a DER-encoded buffer.
   *
   * @param {Buffer} extnValue
   * @returns {ParsedExtensionData} Parsed extension data
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const parsedData = ExtensionHandler.parseSubjectKeyIdentifier(extnData);
   *
   * console.log(parsedData);
   * ```
   */
  public static parseSubjectKeyIdentifier = (
    extnValue: Buffer,
  ): ParsedExtensionData => {
    // Directly use the OCTET STRING as the key identifier.
    return { keyIdentifier: extnValue };
  };

  /**
   * Parse an AuthorityKeyIdentifier extension from a DER-encoded buffer.
   *
   * @param {Buffer} extnValue
   * @returns {ParsedExtensionData} Parsed extension data
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const parsedData = ExtensionHandler.parseAuthorityKeyIdentifier(extnData);
   *
   * console.log(parsedData);
   * ```
   */
  public static parseAuthorityKeyIdentifier = (
    extnValue: Buffer,
  ): ParsedExtensionData => {
    const { elements } = decodeSequence(extnValue, 0);
    let keyIdentifier: Buffer | undefined = undefined;

    // AuthorityKeyIdentifier is a SEQUENCE with optional fields.
    for (const elem of elements) {
      // Look for the keyIdentifier field which is typically [0] EXPLICIT.
      const tagClass = elem.tag & 0xc0;
      const tagNumber = elem.tag & 0x1f;
      if (tagClass === 0x80 && tagNumber === 0) {
        keyIdentifier = elem.content;
      }
      // Additional parsing for authorityCertIssuer and authorityCertSerialNumber can be added here.
    }

    return { keyIdentifier: keyIdentifier || Buffer.alloc(0) };
  };

  /**
   * Parse a CRLDistributionPoints extension from a DER-encoded buffer.
   *
   * @param {Buffer} extnValue
   * @returns {ParsedExtensionData} Parsed extension data
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const parsedData = ExtensionHandler.parseCRLDistributionPoints(extnData);
   *
   * console.log(parsedData);
   * ```
   */
  public static parseCRLDistributionPoints = (
    extnValue: Buffer,
  ): ParsedExtensionData => {
    const { elements: dpElements } = decodeSequence(extnValue, 0);
    const distributionPoints: string[] = [];

    // Iterate over each DistributionPoint
    for (const dpElem of dpElements) {
      const { elements: dpFields } = decodeSequence(dpElem.content, 0);

      // Look for the distributionPoint field with context-specific tag [0]
      for (const field of dpFields) {
        if ((field.tag & 0xc0) === 0xa0) {
          // context-specific [0]
          // distributionPoint field found
          const { elements: dpNameElements } = decodeSequence(field.content, 0);

          // Check if the first element is fullName ([0] choice)
          const firstElem = dpNameElements[0];
          if ((firstElem.tag & 0xc0) === 0xa0) {
            // fullName is expected to be a sequence of GeneralName entries
            const { elements: fullNameElements } = decodeSequence(
              firstElem.content,
              0,
            );

            // For each GeneralName, attempt to extract a DNSName as a simple example
            for (const gn of fullNameElements) {
              const tagClass = gn.tag & 0xc0;
              const tagNumber = gn.tag & 0x1f;
              if (tagClass === TAG_CLASS_CONTEXT_SPECIFIC && tagNumber === 2) {
                // [2] DNSName
                distributionPoints.push(
                  gn.content.toString(BinaryToTextEncoding.UTF_8),
                );
              }
              if (tagClass === TAG_CLASS_CONTEXT_SPECIFIC && tagNumber === 6) {
                // [6] URI
                distributionPoints.push(
                  gn.content.toString(BinaryToTextEncoding.UTF_8),
                );
              }
              if (tagClass === TAG_CLASS_CONTEXT_SPECIFIC && tagNumber === 7) {
                // [7] IPAddress
                distributionPoints.push(this.parseIPAddress(gn.content));
              }
            }
          }
        }
      }
    }

    return { distributionPoints };
  };

  /**
   * Parse an AuthorityInfoAccess extension from a DER-encoded buffer.
   *
   * @param {Buffer} extnValue
   * @returns {ParsedExtensionData} Parsed extension data
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const parsedData = ExtensionHandler.parseAuthorityInfoAccess(extnData);
   *
   * console.log(parsedData);
   * ```
   */
  public static parseAuthorityInfoAccess = (
    extnValue: Buffer,
  ): ParsedExtensionData => {
    const { elements: aiaElements } = decodeSequence(extnValue, 0);
    const accessDescriptions: { method: string; location: string }[] = [];

    for (const aiaElem of aiaElements) {
      // Each aiaElem is an AccessDescription SEQUENCE
      const { elements: adElements } = decodeSequence(aiaElem.content, 0);
      if (adElements.length !== 2) {
        continue; // Malformed AccessDescription, skip or handle error.
      }

      // First element: accessMethod (OBJECT IDENTIFIER)
      const method = decodeObjectIdentifier(adElements[0].content, 0).oid;

      // Second element: accessLocation (GeneralName)
      const locationElem = adElements[1];
      let location = '';

      // Attempt to decode a DNSName as an example
      const tagClass = locationElem.tag & 0xc0;
      const tagNumber = locationElem.tag & 0x1f;
      if (tagClass === 0x80 && tagNumber === 2) {
        // [2] DNSName
        location = locationElem.content.toString(BinaryToTextEncoding.UTF_8);
      } else {
        // For other GeneralName types, you could handle accordingly
        location = locationElem.content.toString(BinaryToTextEncoding.UTF_8); // Fallback
      }

      accessDescriptions.push({ method, location });
    }

    return { accessDescriptions };
  };

  /**
   * Ensure that a DER sequence has the expected number of elements.
   *
   * @param {Buffer} data DER-encoded buffer containing the sequence
   * @param {number} expectedLength Expected number of elements in the sequence
   * @param {string} context Context string for error message
   * @returns {ReturnType<typeof decodeDER>[]} Array of decoded elements
   * @throws {ClientError} If the sequence is invalid or has an unexpected number of elements
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { BinaryToTextEncoding } from '@sailfin/oidc';
   * import { decodeDER } from '@sailfin/oidc';
   *
   * const data = Buffer.from('301d0609...', BinaryToTextEncoding.HEX);
   * const elements = ExtensionHandler.ensureSequenceLength(data, 2, 'AlgorithmIdentifier');
   *
   * console.log(elements);
   * ```
   */
  private static ensureSequenceLength(
    data: Buffer,
    expectedLength: number,
    context: string,
  ): any {
    const { elements } = decodeSequence(data, 0);
    if (elements.length !== expectedLength) {
      throw new Error(
        `Invalid ${context} structure. Expected ${expectedLength} elements.`,
      );
    }
    return elements;
  }

  /**
   * Mapping of extension OIDs to their respective parsers.
   *
   * @type {Object.<string, ExtensionParser>}
   */
  public static extensionParsers: { [oid: string]: ExtensionParser } = {
    '2.5.29.19': ExtensionHandler.parseBasicConstraints,
    '2.5.29.15': ExtensionHandler.parseKeyUsage,
    '2.5.29.17': ExtensionHandler.parseSubjectAltName,
    '2.5.29.37': ExtensionHandler.parseExtendedKeyUsage,
    '2.5.29.14': ExtensionHandler.parseSubjectKeyIdentifier,
    '2.5.29.35': ExtensionHandler.parseAuthorityKeyIdentifier,
    '2.5.29.31': ExtensionHandler.parseCRLDistributionPoints,
    '2.5.29.32': ExtensionHandler.parseAuthorityInfoAccess,
  };

  /**
   * Parse a set of extensions from a DER-encoded buffer.
   *
   * @param {ReturnType<typeof decodeDER>[]} extElements Array of DER-encoded extension elements
   * @returns {IExtension[]} Array of parsed extensions
   * @throws {ClientError} If an extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   * import { decodeDER } from '@sailfin/oidc';
   *
   * const extElements = decodeDER(Buffer.from('301f170d313...', BinaryToTextEncoding.HEX)).elements;
   * const extensions = ExtensionHandler.parseExtensions(extElements);
   *
   * console.log(extensions);
   * ```
   */
  public static parseExtensions = (
    extElements: ReturnType<typeof decodeDER>[],
  ): IExtension[] => {
    const extensions: IExtension[] = [];

    for (const extElement of extElements) {
      const { elements } = decodeSequence(extElement.content, 0);
      if (elements.length < 2) {
        throw new ClientError('Invalid extension structure', 'PARSE_ERROR');
      }

      const isExtensionOid = (oid: string): oid is ExtentionOid => {
        return Object.values(ExtentionOid).includes(oid as ExtentionOid);
      };

      // Inside the loop:
      const oid = decodeObjectIdentifier(elements[0].content, 0).oid;

      if (!isExtensionOid(oid)) {
        throw new ClientError(`Unknown OID: ${oid}`, 'PARSE_ERROR');
      }

      let critical = false;
      let extnValueIdx = 1;

      if (elements.length === 3) {
        const boolElem = elements[1];
        if (boolElem.tag === DERTag.BOOLEAN) {
          critical = boolElem.content[0] !== 0;
          extnValueIdx = 2;
        }
      }

      const value = elements[extnValueIdx].content;

      // Delegate to a specific parser if available
      const parser = ExtensionHandler.extensionParsers[oid];
      let parsedData: any = undefined;
      if (parser) {
        try {
          parsedData = parser(value, critical);
        } catch (error) {
          // Handle parsing error for this extension gracefully
          console.error(`Error parsing extension ${oid}:`, error);
        }
      } else {
        // For unknown extensions, you might leave parsedData as raw extnValue or perform generic processing
        parsedData = value;
      }

      extensions.push({
        extnID: oid,
        critical,
        value,
        parsedData,
      });
    }

    return extensions;
  };

  /**
   * Build a BasicConstraints extension from a BasicConstraints object.
   *
   * @param {BasicConstraints} data BasicConstraints object
   * @returns {Buffer} DER-encoded BasicConstraints extension
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const basicConstraints = { cA: true, pathLenConstraint: 2 };
   * const extnValue = ExtensionHandler.buildBasicConstraints(basicConstraints);
   *
   * console.log(extnValue);
   * ```
   */
  public static buildBasicConstraints(data: BasicConstraints): Buffer {
    const elements: Buffer[] = [];
    // Encode BOOLEAN if cA is true
    if (data.cA) {
      elements.push(
        encodeDER(DERTag.BOOLEAN, Buffer.from([data.cA ? 0xff : 0x00])),
      );
    }
    // Encode pathLenConstraint if present
    if (data.pathLenConstraint !== undefined) {
      const plcBuffer = integer(Buffer.from([data.pathLenConstraint]));
      elements.push(plcBuffer);
    }
    return sequence(Buffer.concat(elements));
  }

  /**
   * Build a KeyUsage extension from a KeyUsage object.
   *
   * @param {KeyUsage} usage KeyUsage object
   * @returns {Buffer} DER-encoded KeyUsage extension
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const keyUsage = { usages: ['digitalSignature', 'keyEncipherment'] };
   * const extnValue = ExtensionHandler.buildKeyUsage(keyUsage);
   *
   * console.log(extnValue);
   * ```
   */
  public static buildKeyUsage(usage: KeyUsage): Buffer {
    // Initialize bits array with 0s enough to cover all usages
    const bits = Buffer.alloc(Math.ceil(BIT_USAGE_MAPPING.length / 8), 0);
    for (let i = 0; i < BIT_USAGE_MAPPING.length; i++) {
      if (usage.usages.includes(BIT_USAGE_MAPPING[i])) {
        const byteIndex = Math.floor(i / 8);
        const bitIndex = 7 - (i % 8);
        bits[byteIndex] |= 1 << bitIndex;
      }
    }
    return bitString(bits);
  }

  /**
   * Build a SubjectAltName extension from a SubjectAltName object.
   *
   * @param {SubjectAltName} data SubjectAltName object
   * @returns {Buffer} DER-encoded SubjectAltName extension
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const subjectAltName = {
   *   dnsNames: ['example.com', 'www.example.com'],
   *   ipAddresses: ['24.55.94.16'],
   *   emailAddresses: ['johndoe@example.com'],
   *   uris: ['https://example.com'],
   * };
   *
   * const extnValue = ExtensionHandler.buildSubjectAltName(subjectAltName);
   *
   * console.log(extnValue);
   * ```
   */
  public static buildSubjectAltName(data: SubjectAltName): Buffer {
    const generalNames: Buffer[] = [];

    // Encode each DNS name
    if (data.dnsNames) {
      for (const dns of data.dnsNames) {
        // Context-specific tag [2] for DNSName. Adjust if necessary.
        const encoded = encodeDER(
          0x82,
          Buffer.from(dns, BinaryToTextEncoding.UTF_8),
        );
        generalNames.push(encoded);
      }
    }

    // Encode each IP address
    if (data.ipAddresses) {
      for (const ip of data.ipAddresses) {
        // Context-specific tag [7] for IPAddress. Adjust if necessary.
        const encoded = encodeDER(
          0x87,
          Buffer.from(ip, BinaryToTextEncoding.UTF_8),
        );
        generalNames.push(encoded);
      }
    }

    // Encode each email address
    if (data.emailAddresses) {
      for (const email of data.emailAddresses) {
        // Context-specific tag [1] for RFC822Name (email). Adjust if necessary.
        const encoded = encodeDER(
          0x81,
          Buffer.from(email, BinaryToTextEncoding.UTF_8),
        );
        generalNames.push(encoded);
      }
    }

    // Encode each URI
    if (data.uris) {
      for (const uri of data.uris) {
        // Context-specific tag [6] for URI. Adjust if necessary.
        const encoded = encodeDER(
          0x86,
          Buffer.from(uri, BinaryToTextEncoding.UTF_8),
        );
        generalNames.push(encoded);
      }
    }

    // Wrap all GeneralNames in a sequence
    return sequence(Buffer.concat(generalNames));
  }

  /**
   * Build an ExtendedKeyUsage extension from an ExtendedKeyUsage object.
   *
   * @param {ExtendedKeyUsage} data ExtendedKeyUsage object
   * @returns {Buffer} DER-encoded ExtendedKeyUsage extension
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const extendedKeyUsage = { purposes: ['serverAuth', 'clientAuth'] };
   *
   * const extnValue = ExtensionHandler.buildExtendedKeyUsage(extendedKeyUsage);
   *
   * console.log(extnValue);
   * ```
   */
  public static buildExtendedKeyUsage(data: ExtendedKeyUsage): Buffer {
    // Map each purpose OID to its DER-encoded OBJECT IDENTIFIER
    const oidBuffers = data.purposes.map((oid) => objectIdentifier(oid));

    // Wrap all OID encodings in a DER SEQUENCE
    return sequence(Buffer.concat(oidBuffers));
  }

  /**
   * Build a SubjectKeyIdentifier extension from a SubjectKeyIdentifier object.
   *
   * @param {SubjectKeyIdentifier} data SubjectKeyIdentifier object
   * @returns {Buffer} DER-encoded SubjectKeyIdentifier extension
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const subjectKeyIdentifier = { keyIdentifier: Buffer.from('0123456789abcdef', 'hex') };
   *
   * const extnValue = ExtensionHandler.buildSubjectKeyIdentifier(subjectKeyIdentifier);
   *
   * console.log(extnValue);
   * ```
   */
  public static buildSubjectKeyIdentifier(keyIdentifier: Buffer): Buffer {
    // Wrap the keyIdentifier in an OCTET STRING
    return encodeDER(DERTag.OCTET_STRING, keyIdentifier);
  }

  /**
   * Build an AuthorityKeyIdentifier extension from an AuthorityKeyIdentifier object.
   *
   * @param {AuthorityKeyIdentifier} data AuthorityKeyIdentifier object
   * @returns {Buffer} DER-encoded AuthorityKeyIdentifier extension
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const authorityKeyIdentifier = { keyIdentifier: Buffer.from('0123456789abcdef', 'hex') };
   *
   * const extnValue = ExtensionHandler.buildAuthorityKeyIdentifier(authorityKeyIdentifier);
   *
   * console.log(extnValue);
   * ```
   */
  public static buildAuthorityKeyIdentifier(
    data: AuthorityKeyIdentifier,
  ): Buffer {
    const elements: Buffer[] = [];

    // Build context-specific [0] for keyIdentifier if present
    if (data.keyIdentifier) {
      // Context-specific tag 0: 0x80 (constructed if needed) + 0
      const keyIdOctet = encodeDER(DERTag.OCTET_STRING, data.keyIdentifier);
      // Wrap in context-specific [0]
      const keyIdElement = encodeDER(0xa0, keyIdOctet);
      elements.push(keyIdElement);
    }

    // Build context-specific [1] for authorityCertIssuer if present
    // For simplicity, this example does not implement full GeneralNames encoding.
    // You would need to properly encode GeneralNames based on RFC 5280.
    if (data.authorityCertIssuer) {
      // Placeholder: encode issuer as an OCTET STRING inside [1] context-specific
      const issuerOctet = encodeDER(
        DERTag.OCTET_STRING,
        Buffer.from(data.authorityCertIssuer.join(',')),
      );
      const issuerElement = encodeDER(0xa1, issuerOctet);
      elements.push(issuerElement);
    }

    // Build context-specific [2] for authorityCertSerialNumber if present
    if (data.authorityCertSerialNumber) {
      // Wrap serial number with INTEGER and then in context-specific [2]
      const serialInt = integer(data.authorityCertSerialNumber);
      const serialElement = encodeDER(0xa2, serialInt);
      elements.push(serialElement);
    }

    // Combine all elements into a SEQUENCE
    return sequence(Buffer.concat(elements));
  }
  /**
   * Build a CRLDistributionPoints extension from a CRLDistributionPoints object.
   *
   * @param {CRLDistributionPoints} data CRLDistributionPoints object
   * @returns {Buffer} DER-encoded CRLDistributionPoints extension
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const crlDistributionPoints = { distributionPoints: ['http://example.com'] };
   *
   * const extnValue = ExtensionHandler.buildCRLDistributionPoints(crlDistributionPoints);
   *
   * console.log(extnValue);
   * ```
   */
  public static buildCRLDistributionPoints(
    data: CRLDistributionPoints,
  ): Buffer {
    const distributionPointBuffers: Buffer[] = [];

    // For each distribution point URI, create a simplified DER structure
    for (const uri of data.distributionPoints) {
      // Encode the URI as an IA5String with context-specific tag [6] inside a sequence.
      const generalName = encodeDER(
        0x86, // Context-specific primitive tag [6] for uniformResourceIdentifier (URI)
        Buffer.from(uri, BinaryToTextEncoding.UTF_8),
      );
      // Wrap the GeneralName in a SEQUENCE as fullName (context-specific [0])
      const fullNameSequence = sequence(generalName);
      const distributionPointName = encodeDER(0xa0, fullNameSequence); // Context-specific constructed [0]
      // Wrap distributionPointName in a DistributionPoint SEQUENCE
      const distributionPoint = sequence(distributionPointName);

      distributionPointBuffers.push(distributionPoint);
    }

    // Wrap all DistributionPoint entries in a top-level SEQUENCE
    return sequence(Buffer.concat(distributionPointBuffers));
  }

  /**
   * Build an AuthorityInfoAccess extension from an AuthorityInfoAccess object.
   *
   * @param {AuthorityInfoAccess} data AuthorityInfoAccess object
   * @returns {Buffer} DER-encoded AuthorityInfoAccess extension
   * @throws {ClientError} If the extension structure is invalid or empty
   * @example
   * ```typescript
   * import { ExtensionHandler } from '@sailfin/oidc';
   *
   * const authorityInfoAccess = {
   *   accessDescriptions: [{ method: ' digitallySigned', location: 'http://example.com' }],
   * };
   *
   * const extnValue = ExtensionHandler.buildAuthorityInfoAccess(authorityInfoAccess);
   *
   * console.log(extnValue);
   * ```
   */
  public static buildAuthorityInfoAccess(data: AuthorityInfoAccess): Buffer {
    const accessDescriptionBuffers: Buffer[] = [];

    for (const accessDesc of data.accessDescriptions) {
      // Encode the accessMethod as an OBJECT IDENTIFIER
      const methodDER = objectIdentifier(accessDesc.method);

      // For simplicity, assume location is a URI (GeneralName: [6] IA5String)
      const locationDER = encodeDER(
        0x86, // Context-specific primitive tag [6] for URI
        Buffer.from(accessDesc.location, BinaryToTextEncoding.UTF_8),
      );

      // Wrap location in a SEQUENCE as required for accessLocation (skipping full GeneralName encoding)
      const accessLocationSequence = sequence(locationDER);

      // Combine method and location into a SEQUENCE for AccessDescription
      const accessDescription = sequence(
        Buffer.concat([methodDER, accessLocationSequence]),
      );

      accessDescriptionBuffers.push(accessDescription);
    }

    // Wrap all AccessDescription entries in a SEQUENCE
    return sequence(Buffer.concat(accessDescriptionBuffers));
  }

  /**
   * Generic method to construct an IExtension for a given extension type.
   *
   * @param {string} extnID Extension OID
   * @param {boolean} critical Whether the extension is critical
   * @param {any} value Extension value
   * @returns {IExtension} Constructed extension object
   * @throws {ClientError} If the extension OID is not supported
   */
  public static createExtension(
    extnID: ExtentionOid,
    critical: boolean,
    value: any,
  ): IExtension {
    switch (extnID) {
      case ExtentionOid.BasicConstraints:
        value = this.buildBasicConstraints(value);
        break;
      case ExtentionOid.KeyUsage:
        value = this.buildKeyUsage(value);
        break;
      case ExtentionOid.ExtendedKeyUsage:
        value = this.buildExtendedKeyUsage(value);
        break;
      case ExtentionOid.SubjectAltName:
        value = this.buildSubjectAltName(value);
        break;
      case ExtentionOid.SubjectKeyIdentifier:
        value = this.buildSubjectKeyIdentifier(value);
        break;
      case ExtentionOid.AuthorityKeyIdentifier:
        value = this.buildAuthorityKeyIdentifier(value);
        break;
      case ExtentionOid.CRLDistributionPoints:
        value = this.buildCRLDistributionPoints(value);
        break;
      case ExtentionOid.AuthorityInfoAccess:
        value = this.buildAuthorityInfoAccess(value);
        break;
      default:
        throw new ClientError(`No builder for extension OID ${extnID}`);
    }

    return { extnID, critical, value };
  }
}
