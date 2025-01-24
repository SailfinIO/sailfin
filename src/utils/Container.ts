// src/utils/Container.ts
export class Container {
  private static services = new Map<string | symbol, any>();

  /**
   * Registers a service with a given token.
   * @param token The dependency token.
   * @param instance The instance to register.
   */
  public static register<T>(token: string | symbol, instance: T): void {
    if (this.services.has(token)) {
      throw new Error(
        `Service with token '${token.toString()}' is already registered.`,
      );
    }
    this.services.set(token, instance);
  }

  /**
   * Resolves a service by its token.
   * @param token The dependency token.
   * @returns The resolved service instance.
   */
  public static resolve<T>(token: string | symbol): T {
    const service = this.services.get(token);
    if (!service) {
      throw new Error(
        `Service with token '${token.toString()}' is not registered.`,
      );
    }
    return service;
  }
}
