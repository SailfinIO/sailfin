import { Heap } from './Heap';
export class MaxHeap<T> extends Heap<T> {
  constructor(comparator: (a: T, b: T) => number, items?: T[]) {
    super((a, b) => comparator(b, a), items);
  }
}
