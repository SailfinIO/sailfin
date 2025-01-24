export class Heap<T> {
  protected items: T[];
  private comparator: (a: T, b: T) => number;

  constructor(comparator: (a: T, b: T) => number, items?: T[]) {
    this.comparator = comparator;
    this.items = items ? [...items] : [];
    // Build heap from initial items if provided
    if (items && items.length > 0) {
      for (let i = Math.floor(this.size / 2); i >= 0; i--) {
        this.heapifyDown(i);
      }
    }
  }

  public get size(): number {
    return this.items.length;
  }

  public isEmpty(): boolean {
    return this.size === 0;
  }

  protected getParentIndex(index: number): number {
    return Math.floor((index - 1) / 2);
  }

  protected getLeftChildIndex(index: number): number {
    return 2 * index + 1;
  }

  protected getRightChildIndex(index: number): number {
    return 2 * index + 2;
  }

  protected swap(index1: number, index2: number): void {
    [this.items[index1], this.items[index2]] = [
      this.items[index2],
      this.items[index1],
    ];
  }

  protected heapifyDown(index: number): void {
    let largest = index;
    const left = this.getLeftChildIndex(index);
    const right = this.getRightChildIndex(index);

    if (
      left < this.size &&
      this.comparator(this.items[left], this.items[largest]) > 0
    ) {
      largest = left;
    }
    if (
      right < this.size &&
      this.comparator(this.items[right], this.items[largest]) > 0
    ) {
      largest = right;
    }
    if (largest !== index) {
      this.swap(index, largest);
      this.heapifyDown(largest);
    }
  }

  protected heapifyUp(index: number): void {
    let currentIndex = index;
    while (
      currentIndex > 0 &&
      this.comparator(
        this.items[currentIndex],
        this.items[this.getParentIndex(currentIndex)],
      ) > 0
    ) {
      this.swap(currentIndex, this.getParentIndex(currentIndex));
      currentIndex = this.getParentIndex(currentIndex);
    }
  }

  public insert(item: T): void {
    this.items.push(item);
    this.heapifyUp(this.size - 1);
  }

  public extract(): T {
    if (this.size === 0) {
      throw new Error('Heap is empty');
    }
    const root = this.items[0];
    const lastItem = this.items.pop();
    if (this.size > 0 && lastItem !== undefined) {
      this.items[0] = lastItem;
      this.heapifyDown(0);
    }
    return root;
  }

  public peek(): T {
    if (this.size === 0) {
      throw new Error('Heap is empty');
    }
    return this.items[0];
  }

  public toArray(): T[] {
    return [...this.items];
  }

  public buildHeap(items: T[]): void {
    this.items = [...items];
    for (let i = Math.floor(this.size / 2); i >= 0; i--) {
      this.heapifyDown(i);
    }
  }

  public clear(): void {
    this.items = [];
  }
}
