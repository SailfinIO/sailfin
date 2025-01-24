import { Heap } from './Heap';

describe('Heap', () => {
  let heap: Heap<number>;

  beforeEach(() => {
    heap = new Heap<number>((a, b) => a - b);
  });

  test('should initialize an empty heap', () => {
    expect(heap.size).toBe(0);
    expect(heap.isEmpty()).toBe(true);
  });

  test('should insert elements and maintain heap property', () => {
    heap.insert(3);
    heap.insert(1);
    heap.insert(2);

    expect(heap.size).toBe(3);
    expect(heap.peek()).toBe(3);
  });

  test('should extract the maximum element and maintain heap property', () => {
    heap.insert(3);
    heap.insert(1);
    heap.insert(2);

    expect(heap.extract()).toBe(3);
    expect(heap.size).toBe(2);
    expect(heap.peek()).toBe(2);
  });

  test('should throw an error when extracting from an empty heap', () => {
    expect(() => heap.extract()).toThrow('Heap is empty');
  });

  test('should peek the maximum element without removing it', () => {
    heap.insert(3);
    heap.insert(1);
    heap.insert(2);

    expect(heap.peek()).toBe(3);
    expect(heap.size).toBe(3);
  });

  test('should build a heap from an existing array', () => {
    const items = [3, 1, 2];
    heap.buildHeap(items);

    expect(heap.size).toBe(3);
    expect(heap.peek()).toBe(3);
  });

  test('should convert heap to array', () => {
    heap.insert(3);
    heap.insert(1);
    heap.insert(2);

    expect(heap.toArray()).toEqual([3, 1, 2]);
  });
});
