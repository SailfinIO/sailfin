import { LogLevel } from '../enums';
import { ILogger } from './ILogger';

export interface ILoggingConfig {
  logLevel: LogLevel;
  logger?: ILogger; // Optional, can be provided by the user
}
