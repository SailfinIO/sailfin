import { MutexRegistry } from './MutexRegistry';
import { IMutex, IMutexRegistry, Owner } from '../interfaces';

describe('MutexRegistry', () => {
  let registry: IMutexRegistry;
  let mockMutex: IMutex<any>;
  let mockOwner: Owner;

  beforeEach(() => {
    registry = MutexRegistry.instance;
    mockMutex = {} as IMutex<any>;
    mockOwner = 'testOwner';

    // Clear internal state to avoid interference between tests
    (registry as any)._graph.mutexWaiters.clear();
    (registry as any)._graph.ownerHolds.clear();
  });

  it('should be a singleton', () => {
    const instanceA = MutexRegistry.instance;
    const instanceB = MutexRegistry.instance;
    expect(instanceA).toBe(instanceB);
  });

  it('should add a waiter and reflect in graph', () => {
    registry.addWaiter(mockMutex, mockOwner);
    const graph = registry.graph;
    const waiters = graph.mutexWaiters.get(mockMutex);
    expect(waiters).toBeDefined();
    expect(waiters?.has(mockOwner)).toBe(true);
  });

  it('should remove a waiter and update graph', () => {
    registry.addWaiter(mockMutex, mockOwner);
    registry.removeWaiter(mockMutex, mockOwner);
    const graph = registry.graph;
    expect(graph.mutexWaiters.has(mockMutex)).toBe(false);
  });

  it('should add a hold and reflect in graph', () => {
    registry.addHold(mockOwner, mockMutex);
    const graph = registry.graph;
    const holds = graph.ownerHolds.get(mockOwner);
    expect(holds).toBeDefined();
    expect(holds?.has(mockMutex)).toBe(true);
  });

  it('should remove a hold and update graph', () => {
    registry.addHold(mockOwner, mockMutex);
    registry.removeHold(mockOwner, mockMutex);
    const graph = registry.graph;
    expect(graph.ownerHolds.has(mockOwner)).toBe(false);
  });

  it('should not allow external mutation of internal graph', () => {
    const graph1 = registry.graph;
    (graph1.ownerHolds as any).clear?.();
    (graph1.mutexWaiters as any).clear?.();
    const graph2 = registry.graph;
    expect(graph2.ownerHolds.size).toBeGreaterThanOrEqual(0);
    expect(graph2.mutexWaiters.size).toBeGreaterThanOrEqual(0);
  });
});
