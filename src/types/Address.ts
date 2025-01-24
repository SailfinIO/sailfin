/**
 * @fileoverview
 * Defines the `Address` and `ExtendedAddress` types for representing address data
 * and extending it with additional custom properties. These types allow for flexible
 * address structures with optional extensions.
 *
 * @module src/types/Address
 */

import { UnknownObject } from '../interfaces';
import { Override } from './Override';

/**
 * Represents an object that extends the base address structure.
 *
 * The `ExtendedAddress` type is a placeholder for additional custom properties
 * that can be added to the base address structure.
 *
 * @typedef {ExtendedAddress}
 * @type {UnknownObject}
 *
 * @example
 * ```typescript
 * type MyExtendedAddress = ExtendedAddress & {
 *   latitude?: number;
 *   longitude?: number;
 * };
 *
 * const address: MyExtendedAddress = {
 *   street_address: '123 Main St',
 *   locality: 'Anytown',
 *   latitude: 40.7128,
 *   longitude: -74.0060,
 * };
 * ```
 */
export type ExtendedAddress = UnknownObject;

/**
 * Represents a flexible address structure with optional properties and extensions.
 *
 * The `Address` type defines a base structure for address-related data, including
 * standard fields like `formatted`, `street_address`, and `country`. It can be extended
 * with additional fields using the `ExtendedAddress` type parameter.
 *
 * @template ExtendedAddress Additional fields to extend the base address structure.
 *
 * @typedef {Address<ExtendedAddress>}
 * @type {Override<{
 *   formatted?: string;
 *   street_address?: string;
 *   locality?: string;
 *   region?: string;
 *   postal_code?: string;
 *   country?: string;
 * }, ExtendedAddress>}
 *
 * @property {string} [formatted] - A fully formatted address string.
 * @property {string} [street_address] - The street address component.
 * @property {string} [locality] - The city or locality.
 * @property {string} [region] - The state, province, or region.
 * @property {string} [postal_code] - The postal or ZIP code.
 * @property {string} [country] - The country name or code.
 *
 * @example
 * ```typescript
 * type BaseAddress = Address;
 *
 * const address: BaseAddress = {
 *   formatted: '123 Main St, Anytown, USA',
 *   street_address: '123 Main St',
 *   locality: 'Anytown',
 *   region: 'CA',
 *   postal_code: '90210',
 *   country: 'USA',
 * };
 *
 * type CustomAddress = Address<{
 *   latitude?: number;
 *   longitude?: number;
 * }>;
 *
 * const customAddress: CustomAddress = {
 *   street_address: '123 Main St',
 *   locality: 'Anytown',
 *   latitude: 40.7128,
 *   longitude: -74.0060,
 * };
 * ```
 */
export type Address<ExtendedAddress extends {} = UnknownObject> = Override<
  {
    formatted?: string;
    street_address?: string;
    locality?: string;
    region?: string;
    postal_code?: string;
    country?: string;
  },
  ExtendedAddress
>;
