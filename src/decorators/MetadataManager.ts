// src/decorators/MetadataManager.ts

/**
 * @fileoverview Manages class-level and method-level metadata using an in-memory Cache.
 * @module decorators/MetadataManager
 * @see module:cache/Cache
 * @see module:decorators/KeyFactory
 */
import {
  IClassMetadata,
  IMethodMetadata,
  ICache,
  IRouteMetadata,
  ILogger,
} from '../interfaces';
import { Cache } from '../cache/Cache';
import { KeyFactory } from './KeyFactory';
import { Logger } from '../utils';

/**
 * Manages class-level and method-level metadata using an in-memory Cache.
 */
export class MetadataManager {
  /**
   * Logger implementation for logging metadata operations.
   */
  private static logger: ILogger = new Logger(MetadataManager.name);

  /**
   * Private getter for class metadata cache with lazy initialization.
   */
  private static get classMetadataCache(): ICache<IClassMetadata> {
    if (!this._classMetadataCache) {
      this._classMetadataCache = new Cache<IClassMetadata>(this.logger);
    }
    return this._classMetadataCache;
  }

  /**
   * Private getter for method metadata cache with lazy initialization.
   */
  private static get methodMetadataCache(): ICache<IMethodMetadata> {
    if (!this._methodMetadataCache) {
      this._methodMetadataCache = new Cache<IMethodMetadata>(this.logger);
    }
    return this._methodMetadataCache;
  }

  /**
   * Private getter for route metadata cache with lazy initialization.
   */
  private static get routeMetadataCache(): ICache<IRouteMetadata> {
    if (!this._routeMetadataCache) {
      this._routeMetadataCache = new Cache<IRouteMetadata>(this.logger);
    }
    return this._routeMetadataCache;
  }

  // Private static properties to hold the caches
  private static _classMetadataCache: ICache<IClassMetadata> | null = null;
  private static _methodMetadataCache: ICache<IMethodMetadata> | null = null;
  private static _routeMetadataCache: ICache<IRouteMetadata> | null = null;

  /**
   * Attach (merge) metadata to a class (constructor function).
   * @param {Function} target - The constructor function.
   * @param {Partial<IClassMetadata>} metadata - The metadata to attach.
   * @throws {TypeError} If target is not a constructor function.
   * @returns {void}
   */
  public static setClassMetadata(
    target: Function,
    metadata: Partial<IClassMetadata>,
  ): void {
    if (typeof target !== 'function') {
      throw new TypeError(
        'setClassMetadata expects a constructor function as the target.',
      );
    }

    const ctorKey = KeyFactory.getKeyForFunction(target);
    const cacheKey = `class:${ctorKey}`;
    const existing = this.classMetadataCache.get(cacheKey) || {};
    const merged = { ...existing, ...metadata };
    this.classMetadataCache.set(cacheKey, merged);
  }

  /**
   * Retrieve metadata attached to a class constructor.
   * @param {Function} target - The constructor function.
   * @throws {TypeError} If target is not a constructor function.
   * @returns {IClassMetadata | undefined} The metadata attached to the class.
   */
  public static getClassMetadata(target: Function): IClassMetadata | undefined {
    if (typeof target !== 'function') {
      throw new TypeError(
        'getClassMetadata expects a constructor function as the target.',
      );
    }

    const ctorKey = KeyFactory.getKeyForFunction(target);
    const cacheKey = `class:${ctorKey}`;
    return this.classMetadataCache.get(cacheKey);
  }

  /**
   * Attach (merge) metadata to a method (by property name).
   * @param {Function} targetConstructor - The constructor function.
   * @param {string | symbol} propertyKey - The method name.
   * @param {Partial<IMethodMetadata>} metadata - The metadata to attach.
   * @throws {TypeError} If targetConstructor is not a constructor function.
   * @throws {TypeError} If propertyKey is not a string.
   * @returns {void}
   */
  public static setMethodMetadata(
    targetConstructor: Function,
    propertyKey: string | symbol,
    metadata: Partial<IMethodMetadata>,
  ): void {
    if (typeof targetConstructor !== 'function') {
      throw new TypeError(
        'setMethodMetadata expects a constructor function as the targetConstructor.',
      );
    }
    if (typeof propertyKey !== 'string' && typeof propertyKey !== 'symbol') {
      throw new TypeError(
        'setMethodMetadata expects a string or symbol as the propertyKey.',
      );
    }

    const key =
      typeof propertyKey === 'symbol' ? propertyKey.toString() : propertyKey;
    const ctorKey = KeyFactory.getKeyForFunction(targetConstructor);
    const cacheKey = `method:${ctorKey}:${key}`;
    const existing = this.methodMetadataCache.get(cacheKey) || {};
    const merged = { ...existing, ...metadata };
    this.methodMetadataCache.set(cacheKey, merged);
  }

  /**
   * Retrieve metadata attached to a specific method on a class constructor.
   * @param {Function} targetConstructor - The constructor function.
   * @param {string | symbol} propertyKey - The method name.
   * @throws {TypeError} If targetConstructor is not a constructor function.
   * @throws {TypeError} If propertyKey is not a string.
   * @returns {IMethodMetadata | undefined} The metadata attached to the method.
   */
  public static getMethodMetadata(
    targetConstructor: Function,
    propertyKey: string | symbol,
  ): IMethodMetadata | undefined {
    if (typeof targetConstructor !== 'function') {
      throw new TypeError(
        'getMethodMetadata expects a constructor function as the targetConstructor.',
      );
    }
    if (typeof propertyKey !== 'string' && typeof propertyKey !== 'symbol') {
      throw new TypeError(
        'getMethodMetadata expects a string or symbol as the propertyKey.',
      );
    }

    const key =
      typeof propertyKey === 'symbol' ? propertyKey.toString() : propertyKey;
    const ctorKey = KeyFactory.getKeyForFunction(targetConstructor);
    const cacheKey = `method:${ctorKey}:${key}`;
    return this.methodMetadataCache.get(cacheKey);
  }

  /**
   * Sets metadata for a specific route.
   * @param method HTTP method (e.g., 'GET', 'POST').
   * @param path Route path (e.g., '/login').
   * @param metadata Metadata to attach.
   * @throws {TypeError} If method or path is not a string.
   */
  public static setRouteMetadata(
    method: string,
    path: string,
    metadata: IRouteMetadata,
  ): void {
    if (typeof method !== 'string') {
      throw new TypeError(
        `setRouteMetadata expects 'method' to be a string, received ${typeof method}.`,
      );
    }
    if (typeof path !== 'string') {
      throw new TypeError(
        `setRouteMetadata expects 'path' to be a string, received ${typeof path}.`,
      );
    }

    const cacheKey = `route:${method.toUpperCase()}:${path}`;
    const existing = this.routeMetadataCache.get(cacheKey) || {};
    const merged = { ...existing, ...metadata };
    this.routeMetadataCache.set(cacheKey, merged);
  }

  /**
   * Retrieves metadata for a specific route.
   * @param method HTTP method.
   * @param path Route path.
   * @throws {TypeError} If method or path is not a string.
   * @returns Metadata attached to the route.
   */
  public static getRouteMetadata(
    method: string,
    path: string,
  ): IRouteMetadata | undefined {
    // Skip static files
    if (/\.(js|css|map|ico|png|jpg|jpeg|gif|svg)$/.test(path)) {
      return undefined;
    }

    if (typeof method !== 'string') {
      throw new TypeError(
        `getRouteMetadata expects 'method' to be a string, received ${typeof method}.`,
      );
    }
    if (typeof path !== 'string') {
      throw new TypeError(
        `getRouteMetadata expects 'path' to be a string, received ${typeof path}.`,
      );
    }

    const cacheKey = `route:${method.toUpperCase()}:${path}`;
    return this.routeMetadataCache.get(cacheKey);
  }

  /**
   * For testing: Clear all metadata from class-level, method-level, and route-level caches.
   * @returns {void}
   */
  public static reset(): void {
    if (
      this._classMetadataCache &&
      this._methodMetadataCache &&
      this._routeMetadataCache
    ) {
      this._classMetadataCache.clear();
      this._methodMetadataCache.clear();
      this._routeMetadataCache.clear();
    } else {
      this.logger.warn('MetadataManager caches are already cleared.');
    }
  }
}
