type Scope = 0 | 1 | 2; // Corresponds to DEFAULT, TRANSIENT, REQUEST

export type Provider = {
  provide: any;
  useFactory: (...args: any[]) => any | Promise<any>;
  useExisting?: any;
  useValue?: any;
  useClass?: any;
  inject?: any[];
  scope?: Scope;
};
