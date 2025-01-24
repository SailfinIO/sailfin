// src/decorators/Route.ts
import { RequestMethod } from '../enums/RequestMethod';
import { MetadataManager } from './MetadataManager';
import { IMethodMetadata } from '../interfaces';

export function Route(
  method: RequestMethod = RequestMethod.GET,
  path: string = '/',
): MethodDecorator {
  return (target, propertyKey: string | symbol) => {
    MetadataManager.setMethodMetadata(target.constructor, propertyKey, {
      route: { method, path },
    });
  };
}
