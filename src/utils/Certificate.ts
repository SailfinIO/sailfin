import { ALGORITHM_DETAILS_MAP, ATTRIBUTE_DETAILS } from '../constants';
import { Algorithm, ExtentionOid } from '../enums';
import {
  CertificateOptions,
  AlgorithmDetails,
  IExtension,
  IName,
  IRelativeDistinguishedName,
  ISubjectPublicKeyInfo,
  ITbsCertificate,
  IValidity,
  SubjectAltName,
} from '../interfaces';
import { buildAndSignCertificate } from './certUtils';
import { ExtensionHandler } from './ExtensionHandler';
import { randomBytes } from 'crypto';
import { derNull } from './derUtils';

export abstract class Certificate {
  private _subjectCN: string;
  private _subjectAltNames: SubjectAltName[] = [];
  private _subjectAttributes: IRelativeDistinguishedName[] = [];
  private _issuerAttributes: IRelativeDistinguishedName[];
  private _validity: IValidity;
  private _privateKeyPem: string;
  private _extensions: IExtension[] = [];
  private _algorithm: Algorithm;
  private _serialNumber: Buffer;
  private _issuer: IName;
  private _strictSortingEnabled: boolean = false;

  constructor(subjectCN: string, validity: IValidity, privateKeyPem: string) {
    this._subjectCN = subjectCN;
    this._validity = validity;
    this._privateKeyPem = privateKeyPem;
  }

  // Abstract methods for child classes to implement.
  abstract buildSubjectPublicKeyInfo(): ISubjectPublicKeyInfo;
  abstract buildTbsCertificate(spki: ISubjectPublicKeyInfo): ITbsCertificate;

  // Public methods.
  /**
   * Allows the user to mark this certificate as a CA certificate (cA = true).
   * Optionally sets pathLenConstraint if you want to limit subordinate CAs.
   *
   * This method creates or replaces the BasicConstraints extension (OID 2.5.29.19).
   */
  public setIsCA(isCA = true, pathLenConstraint?: number): void {
    // Remove existing BasicConstraints extension if present
    this.extensions = this.extensions.filter(
      (ext) => ext.extnID !== ExtentionOid.BasicConstraints,
    );

    // Use ExtensionHandler to build BasicConstraints extension
    const basicConstraints = { cA: isCA, pathLenConstraint };
    const newExt = ExtensionHandler.createExtension(
      ExtentionOid.BasicConstraints,
      isCA,
      basicConstraints,
    );
    this.extensions.push(newExt);
  }

  public buildCertificate(): string {
    const spki = this.buildSubjectPublicKeyInfo();
    const signatureAlg = this.getSignatureAlgorithm();
    const tbsCertificate = this.buildTbsCertificate(spki);
    const options: CertificateOptions = {
      subjectCN: this.subjectCN,
      validity: this.validity,
      tbsCertificate,
      signAlgorithm: signatureAlg,
      privateKeyPem: this.privateKeyPem,
    };
    return buildAndSignCertificate(options);
  }

  // Protected getters and setters.
  public get extensions(): IExtension[] {
    return this._extensions;
  }

  /**
   * Allows arbitrary extensions to be appended or merged.
   */
  public set extensions(extensions: IExtension[]) {
    this._extensions = extensions.map((ext) =>
      ExtensionHandler.createExtension(ext.extnID, ext.critical, ext.value),
    );
  }

  public set validity(validity: IValidity) {
    this._validity = validity;
  }
  public get validity(): IValidity {
    return this._validity;
  }

  public set privateKeyPem(privateKeyPem: string) {
    this._privateKeyPem = privateKeyPem;
  }
  public get privateKeyPem(): string {
    return this._privateKeyPem;
  }

  public set serialNumber(serialNumber: Buffer) {
    this._serialNumber = serialNumber;
  }
  public get serialNumber(): Buffer {
    return this._serialNumber;
  }

  public set algorithm(algorithm: Algorithm) {
    this._algorithm = algorithm;
  }
  public get algorithm(): Algorithm {
    return this._algorithm;
  }

  public set issuer(issuer: IName) {
    this._issuer = issuer;
  }
  public get issuer(): IName {
    return this._issuer;
  }

  public set issuerAttributes(attributes: Record<string, string>) {
    const rdnSequence = Object.entries(attributes).map(([key, value]) => {
      const attrDetail = ATTRIBUTE_DETAILS[key];
      if (!attrDetail) {
        throw new Error(`Unsupported attribute key: ${key}`);
      }
      return {
        attributes: [
          {
            type: attrDetail.oid,
            value,
          },
        ],
      };
    });
    this._issuerAttributes = rdnSequence;
  }

  public get issuerAttributes(): IRelativeDistinguishedName[] {
    return this._issuerAttributes;
  }

  public set subjectAttributes(attributes: Record<string, string>) {
    this._subjectAttributes = Object.entries(attributes).map(([key, value]) => {
      const attrDetail = ATTRIBUTE_DETAILS[key];
      if (!attrDetail) {
        throw new Error(`Unsupported attribute key: ${key}`);
      }
      return {
        attributes: [
          {
            type: attrDetail.oid,
            value,
          },
        ],
      };
    });
  }
  public get subjectAttributes(): IRelativeDistinguishedName[] {
    return this._subjectAttributes;
  }

  public set subjectAltNames(names: SubjectAltName[]) {
    // Remove existing SubjectAltName extension if present
    this.extensions = this.extensions.filter(
      (ext) => ext.extnID !== ExtentionOid.SubjectAltName,
    );

    // Use ExtensionHandler to build SubjectAltName extension
    const newExt = ExtensionHandler.createExtension(
      ExtentionOid.SubjectAltName, // OID for SubjectAltName
      false,
      names,
    );

    this.extensions.push(newExt);

    // Store the subjectAltNames for later use
    this._subjectAltNames = names;
  }
  public get subjectAltNames(): SubjectAltName[] {
    return this._subjectAltNames;
  }

  public set subjectCN(cn: string) {
    this._subjectCN = cn;
  }
  public get subjectCN(): string {
    return this._subjectCN;
  }

  public get strictSortingEnabled(): boolean {
    return this._strictSortingEnabled;
  }

  public set strictSortingEnabled(value: boolean) {
    this._strictSortingEnabled = value;
  }

  // Protected helper methods.
  public getSignatureAlgorithm(): AlgorithmDetails {
    const { hashName, cryptoAlg, type } = ALGORITHM_DETAILS_MAP[this.algorithm];
    return { hashName, cryptoAlg, type };
  }

  /**
   * Common helper for child classes to build the "base" TBS certificate
   * structure (version, serialNumber, issuer, subject, validity, etc.).
   *
   * The child class can then focus on computing signature OIDs and building
   * the ISubjectPublicKeyInfo.
   */
  protected buildBaseTbsCertificate(
    spki: ISubjectPublicKeyInfo,
    signatureOID: string,
    signatureParams: Buffer = derNull(),
  ): ITbsCertificate {
    // 1) Ensure we have a serial number
    if (!this.serialNumber) {
      this.serialNumber = randomBytes(8); // e.g. 64 bits
    }

    // 2) Build Issuer Name
    const issuerName: IName = this.issuer
      ? this.issuer
      : this._issuerAttributes?.length
        ? { rdnSequence: this._issuerAttributes }
        : {
            rdnSequence: [
              {
                attributes: [
                  {
                    type: ATTRIBUTE_DETAILS.CN?.oid || '2.5.4.3',
                    value: 'Default Issuer',
                  },
                ],
              },
            ],
          };

    // 3) Build Subject Name
    const subjectName: IName = this._subjectAttributes?.length
      ? { rdnSequence: this._subjectAttributes }
      : this._subjectCN
        ? {
            rdnSequence: [
              {
                attributes: [
                  {
                    type: ATTRIBUTE_DETAILS.CN?.oid || '2.5.4.3',
                    value: this._subjectCN.replace(/^CN=/, ''),
                  },
                ],
              },
            ],
          }
        : {
            rdnSequence: [
              {
                attributes: [
                  {
                    type: ATTRIBUTE_DETAILS.CN?.oid || '2.5.4.3',
                    value: 'Default Subject',
                  },
                ],
              },
            ],
          };

    // 4) Build TBS object, pulling validity from the parent's stored `_validity`
    //    and any existing extensions from `_extensions`.
    return {
      version: 2, // X.509 v3
      serialNumber: this.serialNumber,
      signature: {
        algorithm: signatureOID,
        parameters: signatureParams,
      },
      issuer: issuerName,
      validity: {
        notBefore: this._validity.notBefore,
        notAfter: this._validity.notAfter,
      },
      subject: subjectName,
      subjectPublicKeyInfo: spki,
      extensions: this._extensions.length ? this._extensions : undefined,
    };
  }
}
