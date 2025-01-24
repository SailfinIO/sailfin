import { Provider } from '../types/Provider';

export interface DynamicModule {
  module: any;
  providers?: Provider[];
  exports?: any[];
  imports?: any[];
  controllers?: any[];
  global?: boolean;
}
