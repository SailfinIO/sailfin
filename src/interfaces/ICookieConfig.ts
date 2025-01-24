import { CookieOptions } from './CookieOptions';

export interface ICookieConfig {
  name: string;
  secret: string;
  options: CookieOptions;
}
