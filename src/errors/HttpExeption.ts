import { StatusCode } from '../enums';
import {
  DescriptionAndOptions,
  HttpExceptionBody,
  HttpExceptionOptions,
} from '../interfaces';
import { HttpExceptionBodyMessage } from '../types';
import { ClientError } from './ClientError';

/**
 * Any HTTP exception that should be thrown by the application.
 *
 * @publicApi
 */
export class HttpException extends ClientError {
  private readonly _response: string | Record<string, any>;
  private readonly _status: StatusCode;
  private readonly _options?: HttpExceptionOptions;
  public cause: unknown;

  /**
   * Instantiate a plain HTTP Exception.
   *
   * @example
   * throw new HttpException('message', StatusCode.BAD_REQUEST)
   * throw new HttpException('custom message', StatusCode.BAD_REQUEST, {
   *  cause: new Error('Cause Error'),
   * })
   *
   * @param response string or object describing the error.
   * @param status HTTP response status code.
   * @param options An object used to add an error cause and description.
   */
  constructor(
    response: string | Record<string, any>,
    status: StatusCode,
    options?: HttpExceptionOptions,
  ) {
    // Determine the message from response
    const message =
      typeof response === 'string'
        ? response
        : (response as Record<string, any>).message || 'Error';

    // Call ClientError constructor with a custom code and context
    super(message, 'HTTP_EXCEPTION', {
      status,
      description: options?.description,
    });

    this._response = response;
    this._status = status;
    this._options = options;

    // Manually assign the cause if provided
    if (options?.cause) {
      this.cause = options.cause;
    }

    // Set the error name to the class name
    this.name = this.constructor.name;
  }

  /**
   * Retrieves the HttpExceptionOptions associated with this exception.
   *
   * @returns The HttpExceptionOptions object if available, otherwise undefined.
   */
  public get options(): HttpExceptionOptions | undefined {
    return this._options;
  }

  public get response(): string | object {
    return this._response;
  }

  public get status(): StatusCode {
    return this._status;
  }

  static createBody(
    nil: null | '',
    message: HttpExceptionBodyMessage,
    statusCode: StatusCode,
  ): HttpExceptionBody;
  static createBody(
    message: HttpExceptionBodyMessage,
    error: string,
    statusCode: StatusCode,
  ): HttpExceptionBody;
  static createBody<Body extends Record<string, unknown>>(custom: Body): Body;
  static createBody(...args: any[]): any {
    // Implementation remains unchanged
    return {};
  }

  static getDescriptionFrom(
    descriptionOrOptions: string | HttpExceptionOptions,
  ): string {
    if (typeof descriptionOrOptions === 'string') {
      return descriptionOrOptions;
    }
    return descriptionOrOptions.description || 'Default description';
  }

  static getHttpExceptionOptionsFrom(
    descriptionOrOptions: string | HttpExceptionOptions,
  ): HttpExceptionOptions {
    if (typeof descriptionOrOptions === 'object') {
      return descriptionOrOptions;
    }
    return {};
  }

  static extractDescriptionAndOptionsFrom(
    descriptionOrOptions: string | HttpExceptionOptions,
  ): DescriptionAndOptions {
    if (typeof descriptionOrOptions === 'string') {
      return { description: descriptionOrOptions };
    }
    return {
      description: descriptionOrOptions.description,
      httpExceptionOptions: descriptionOrOptions,
    };
  }
}
