import { MetadataManager } from './MetadataManager';

export const Universal = (): ClassDecorator => {
  return (target: Function) => {
    MetadataManager.setClassMetadata(target, { universal: true });
  };
};
