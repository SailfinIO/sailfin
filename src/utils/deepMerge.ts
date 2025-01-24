import { ClientError } from '../errors';
import { IClientConfig } from '../interfaces';

/**
 * Recursively merges two objects. For any overlapping properties:
 * - If both properties are plain objects, they are merged recursively.
 * - Otherwise, the property from the source object overrides the target.
 *
 * @param target - The target object.
 * @param source - The source object.
 * @returns The merged object.
 */
export const deepMerge = <
  T extends Partial<IClientConfig | Record<string, any>>,
  U extends Partial<IClientConfig | Record<string, any>>,
>(
  target: T,
  source: U,
): IClientConfig | Record<string, any> => {
  const output: any = { ...target };

  for (const key in source) {
    if (
      Object.prototype.hasOwnProperty.call(source, key) &&
      source[key] !== undefined &&
      source[key] !== null
    ) {
      if (
        isPlainObject(source[key]) &&
        key in target &&
        isPlainObject((target as any)[key])
      ) {
        output[key] = deepMerge((target as any)[key], source[key]);
      } else if (Array.isArray(source[key])) {
        // Replace arrays entirely
        output[key] = source[key];
      } else {
        output[key] = source[key];
      }
    }
  }

  return output;
};

/**
 * Checks if a value is a plain object (i.e., not a class instance).
 *
 * @param item - The value to check.
 * @returns True if the value is a plain object, false otherwise.
 */
function isPlainObject(item: any): item is Record<string, any> {
  return Object.prototype.toString.call(item) === '[object Object]';
}

/**
 * Validates that all required fields in IClientConfig are present and non-empty.
 *
 * @param config - The configuration object to validate.
 * @throws {ClientError} If any required fields are missing or invalid.
 */
export function validateConfig(config: Partial<IClientConfig>): void {
  const requiredFields: (keyof IClientConfig)[] = [
    'clientId',
    'clientSecret',
    'discoveryUrl',
    'redirectUri',
  ];

  const missingFields = requiredFields.filter((field) => {
    const value = config[field];
    if (value === undefined || value === null) {
      return true;
    }
    if (typeof value === 'string' && value.trim() === '') {
      return true;
    }
    return false;
  });

  if (missingFields.length > 0) {
    throw new ClientError(
      `Missing required configuration field(s): ${missingFields.join(', ')}`,
      'CONFIG_ERROR',
    );
  }
}
