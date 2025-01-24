import { MetadataManager } from './MetadataManager';

export type Path = string | string[];

export const RouteHandler = (path: Path): ClassDecorator => {
  return (target: Function) => {
    MetadataManager.setClassMetadata(target, { path });
  };
};
