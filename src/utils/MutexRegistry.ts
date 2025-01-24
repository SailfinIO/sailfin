// MutexRegistry.ts
import { IMutexRegistry, DependencyGraph, IMutex, Owner } from '../interfaces';

export class MutexRegistry implements IMutexRegistry {
  private static _instance: MutexRegistry = new MutexRegistry();
  private readonly _graph: DependencyGraph = {
    mutexWaiters: new Map(),
    ownerHolds: new Map(),
  };

  private constructor() {}
  public static get instance(): IMutexRegistry {
    return MutexRegistry._instance;
  }
  /**
   * Provides a read-only snapshot of the dependency graph.
   * Returning deep copies to prevent external mutation.
   */
  public get graph(): DependencyGraph {
    // Create shallow copies of the maps and sets for read-only access.
    const mutexWaitersCopy = new Map<IMutex<any>, Set<Owner>>();
    for (const [mutex, owners] of this._graph.mutexWaiters.entries()) {
      mutexWaitersCopy.set(mutex, new Set(owners));
    }

    const ownerHoldsCopy = new Map<Owner, Set<IMutex<any>>>();
    for (const [owner, mutexes] of this._graph.ownerHolds.entries()) {
      ownerHoldsCopy.set(owner, new Set(mutexes));
    }

    return {
      mutexWaiters: mutexWaitersCopy,
      ownerHolds: ownerHoldsCopy,
    };
  }

  public addWaiter(mutex: IMutex<any>, owner: Owner): void {
    let waiters = this._graph.mutexWaiters.get(mutex);
    if (!waiters) {
      waiters = new Set();
      this._graph.mutexWaiters.set(mutex, waiters);
    }
    waiters.add(owner);
  }

  public removeWaiter(mutex: IMutex<any>, owner: Owner): void {
    const waiters = this._graph.mutexWaiters.get(mutex);
    if (waiters) {
      waiters.delete(owner);
      if (waiters.size === 0) {
        this._graph.mutexWaiters.delete(mutex);
      }
    }
  }

  public addHold(owner: Owner, mutex: IMutex<any>): void {
    let holds = this._graph.ownerHolds.get(owner);
    if (!holds) {
      holds = new Set();
      this._graph.ownerHolds.set(owner, holds);
    }
    holds.add(mutex);
  }

  public removeHold(owner: Owner, mutex: IMutex<any>): void {
    const holds = this._graph.ownerHolds.get(owner);
    if (holds) {
      holds.delete(mutex);
      if (holds.size === 0) {
        this._graph.ownerHolds.delete(owner);
      }
    }
  }
}
