import { Certificate } from './Certificate';
import { Algorithm, ExtentionOid } from '../enums';
import { ExtensionHandler } from './ExtensionHandler';
import { derNull } from './derUtils';
import {
  ISubjectPublicKeyInfo,
  ITbsCertificate,
  IValidity,
  IExtension,
} from '../interfaces';
import { ALGORITHM_DETAILS_MAP } from '../constants';
import { buildAndSignCertificate } from './certUtils';

// Create a dummy subclass to instantiate Certificate
class DummyCertificate extends Certificate {
  buildSubjectPublicKeyInfo(): ISubjectPublicKeyInfo {
    // Return a dummy SubjectPublicKeyInfo object
    return {
      algorithm: { algorithm: '1.2.840.113549.1.1.1' }, // rsaEncryption OID
      subjectPublicKey: Buffer.from('dummyPublicKey'),
    };
  }

  buildTbsCertificate(spki: ISubjectPublicKeyInfo): ITbsCertificate {
    // Use the protected helper to build a basic TBS certificate
    const signatureOID = '1.2.840.113549.1.1.11'; // Example OID for sha256WithRSAEncryption
    return this.buildBaseTbsCertificate(spki, signatureOID, derNull());
  }
}

// Mock the dependencies
jest.mock('./certUtils', () => ({
  buildAndSignCertificate: jest.fn(() => 'dummyCertificate'),
}));

jest.mock('./ExtensionHandler', () => ({
  ExtensionHandler: {
    createExtension: jest.fn((extnID, critical, value) => ({
      extnID,
      critical,
      value: Buffer.from(JSON.stringify(value)),
    })),
  },
}));

jest.mock('./derUtils', () => ({
  derNull: jest.fn(() => Buffer.from('NULL')),
}));

describe('Certificate Class', () => {
  let cert: DummyCertificate;
  const validity: IValidity = {
    notBefore: new Date('2023-01-01T00:00:00Z'),
    notAfter: new Date('2024-01-01T00:00:00Z'),
  };
  const privateKeyPem = 'dummyPrivateKeyPem';

  beforeEach(() => {
    cert = new DummyCertificate('Test CN', validity, privateKeyPem);
    // Reset mocks before each test
    jest.clearAllMocks();
  });

  test('should set CA extension correctly using setIsCA', () => {
    cert.setIsCA(true, 3);

    // Verify that ExtensionHandler.createExtension was called with correct parameters
    expect(ExtensionHandler.createExtension).toHaveBeenCalledWith(
      ExtentionOid.BasicConstraints,
      true,
      { cA: true, pathLenConstraint: 3 },
    );

    // Verify that the extension was added to certificate's extensions
    const caExtension = cert.extensions.find(
      (ext) => ext.extnID === ExtentionOid.BasicConstraints,
    );
    expect(caExtension).toBeDefined();

    // Check the value stored in the extension
    const parsedValue = JSON.parse(caExtension!.value.toString());
    expect(parsedValue).toEqual({ cA: true, pathLenConstraint: 3 });
  });

  test('should set SubjectAltName extension when subjectAltNames setter is used', () => {
    const altNames = [{ names: ['example.com'], dnsNames: ['example.com'] }];
    cert.subjectAltNames = altNames;

    // Verify ExtensionHandler.createExtension call for SubjectAltName
    expect(ExtensionHandler.createExtension).toHaveBeenCalledWith(
      ExtentionOid.SubjectAltName,
      false,
      altNames,
    );

    // Check that the extension was added
    const sanExtension = cert.extensions.find(
      (ext) => ext.extnID === ExtentionOid.SubjectAltName,
    );
    expect(sanExtension).toBeDefined();
    const parsedValue = JSON.parse(sanExtension!.value.toString());
    expect(parsedValue).toEqual(altNames);
  });

  test('should update validity using setter and getter', () => {
    const newValidity: IValidity = {
      notBefore: new Date('2022-01-01T00:00:00Z'),
      notAfter: new Date('2023-01-01T00:00:00Z'),
    };
    cert.validity = newValidity;
    expect(cert.validity).toEqual(newValidity);
  });

  test('should update privateKeyPem using setter and getter', () => {
    const newKey = 'newPrivateKeyPem';
    cert.privateKeyPem = newKey;
    expect(cert.privateKeyPem).toBe(newKey);
  });

  test('should correctly build certificate using buildCertificate', () => {
    // Setup algorithm and serial number to ensure consistency
    cert.algorithm = Algorithm.RS256; // Assuming RS256 exists in ALGORITHM_DETAILS_MAP

    // Execute buildCertificate which should use the mocked buildAndSignCertificate
    const result = cert.buildCertificate();

    expect(buildAndSignCertificate).toHaveBeenCalledTimes(1);

    // Check that the result is the mocked string
    expect(result).toBe('dummyCertificate');

    // Verify that buildAndSignCertificate was called with options containing correct data
    const callArgs = (buildAndSignCertificate as jest.Mock).mock.calls[0][0];
    expect(callArgs).toHaveProperty('subjectCN', 'Test CN');
    expect(callArgs).toHaveProperty('validity', validity);
    expect(callArgs).toHaveProperty('privateKeyPem', privateKeyPem);

    // Ensure algorithm details are correct based on ALGORITHM_DETAILS_MAP
    const expectedAlgDetails = ALGORITHM_DETAILS_MAP[Algorithm.RS256];
    expect(callArgs.signAlgorithm).toMatchObject({
      hashName: expectedAlgDetails.hashName,
      cryptoAlg: expectedAlgDetails.cryptoAlg,
      type: expectedAlgDetails.type,
    });

    // Check that tbsCertificate contains expected properties (issuer, subject, etc.)
    expect(callArgs.tbsCertificate).toHaveProperty('issuer');
    expect(callArgs.tbsCertificate).toHaveProperty('subject');
    expect(callArgs.tbsCertificate).toHaveProperty('subjectPublicKeyInfo');
  });

  test('should throw error for unsupported attribute key in issuerAttributes', () => {
    expect(() => {
      cert.issuerAttributes = { UnsupportedKey: 'value' };
    }).toThrow('Unsupported attribute key: UnsupportedKey');
  });

  test('should throw error for unsupported attribute key in subjectAttributes', () => {
    expect(() => {
      cert.subjectAttributes = { UnsupportedKey: 'value' };
    }).toThrow('Unsupported attribute key: UnsupportedKey');
  });

  test('should properly set subjectCN and subjectAltNames', () => {
    cert.subjectCN = 'New CN';
    expect(cert.subjectCN).toBe('New CN');

    const altNames = [
      { names: ['alt.example.com'], dnsNames: ['alt.example.com'] },
    ];
    cert.subjectAltNames = altNames;
    expect(cert.subjectAltNames).toEqual(altNames);
  });
});
