import { MaxHeap } from './MaxHeap';

describe('MaxHeap', () => {
  let maxHeap: MaxHeap<number>;

  beforeEach(() => {
    const comparator = (a: number, b: number) => b - a;
    maxHeap = new MaxHeap<number>(comparator);
  });

  test('should initialize an empty heap', () => {
    expect(maxHeap.size).toBe(0);
  });

  test('should insert elements and maintain max-heap property', () => {
    maxHeap.insert(10);
    maxHeap.insert(20);
    maxHeap.insert(5);

    expect(maxHeap.peek()).toBe(20);
  });

  test('should extract the maximum element', () => {
    maxHeap.insert(10);
    maxHeap.insert(20);
    maxHeap.insert(5);

    expect(maxHeap.extract()).toBe(20);
    expect(maxHeap.extract()).toBe(10);
    expect(maxHeap.extract()).toBe(5);
  });

  test('should handle custom comparator', () => {
    const stringComparator = (a: string, b: string) => b.localeCompare(a);
    const stringHeap = new MaxHeap<string>(stringComparator);

    stringHeap.insert('apple');
    stringHeap.insert('banana');
    stringHeap.insert('cherry');

    expect(stringHeap.peek()).toBe('cherry');
  });
});
