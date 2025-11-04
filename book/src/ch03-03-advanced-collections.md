# 3.3 Advanced Collections

Master advanced collection patterns and data structures using Ruchy's arrays and structs.

**Test Status:** ✅ Verified with Ruchy v3.194.0
**Test File:** `book/tests/test_ch03_03_advanced_collections.ruchy`

## Introduction

While arrays and structs are Ruchy's fundamental collection types, you can build sophisticated data structures by combining them. This chapter covers sets, stacks, queues, and other advanced patterns that solve real-world problems.

## Sets - Unique Collections

### Creating a Set

Remove duplicates from array:

```ruchy
>>> let items = [1, 2, 2, 3, 1, 4, 3, 5]
>>> let mut set = []
>>> for item in items {
...     let mut found = false
...     for s in set {
...         if s == item {
...             found = true
...             break
...         }
...     }
...     if !found {
...         set = set + [item]
...     }
... }
>>> set
[1, 2, 3, 4, 5]
```

**Pattern**: Check for existence before adding.

### Set Union

Combine two sets:

```ruchy
>>> let set1 = [1, 2, 3]
>>> let set2 = [3, 4, 5]
>>> let mut union = set1
>>> for item in set2 {
...     let mut found = false
...     for u in union {
...         if u == item {
...             found = true
...             break
...         }
...     }
...     if !found {
...         union = union + [item]
...     }
... }
>>> union
[1, 2, 3, 4, 5]
```

**Use Case**: Merging unique items from multiple sources.

### Set Intersection

Find common elements:

```ruchy
>>> let set1 = [1, 2, 3, 4]
>>> let set2 = [3, 4, 5, 6]
>>> let mut intersection = []
>>> for item in set1 {
...     let mut in_set2 = false
...     for s in set2 {
...         if s == item {
...             in_set2 = true
...             break
...         }
...     }
...     if in_set2 {
...         intersection = intersection + [item]
...     }
... }
>>> intersection
[3, 4]
```

**Use Case**: Finding shared items, common permissions.

### Set Difference

Elements in first set but not second:

```ruchy
>>> let set1 = [1, 2, 3, 4]
>>> let set2 = [3, 4, 5]
>>> let mut difference = []
>>> for item in set1 {
...     let mut in_set2 = false
...     for s in set2 {
...         if s == item {
...             in_set2 = true
...             break
...         }
...     }
...     if !in_set2 {
...         difference = difference + [item]
...     }
... }
>>> difference
[1, 2]
```

**Use Case**: Finding what's unique to one collection.

## Stacks - LIFO (Last In, First Out)

### Stack Operations

```ruchy
>>> let mut stack = []
>>> // Push
>>> stack = stack + [1]
>>> stack = stack + [2]
>>> stack = stack + [3]
>>> // Peek (look at top)
>>> let top = stack[stack.len() - 1]
>>> top
3
>>> // Pop (remove from end)
>>> let popped = stack[stack.len() - 1]
>>> let mut new_stack = []
>>> let mut i = 0
>>> while i < stack.len() - 1 {
...     new_stack = new_stack + [stack[i]]
...     i = i + 1
... }
>>> stack = new_stack
>>> popped
3
>>> stack
[1, 2]
```

**Pattern**:
- Push: Append to end
- Pop: Remove from end
- Peek: Read last element

**Use Case**: Undo operations, expression evaluation, backtracking.

## Queues - FIFO (First In, First Out)

### Queue Operations

```ruchy
>>> let mut queue = []
>>> // Enqueue (add to end)
>>> queue = queue + [1]
>>> queue = queue + [2]
>>> queue = queue + [3]
>>> // Peek front
>>> let front = queue[0]
>>> front
1
>>> // Dequeue (remove from front)
>>> let dequeued = queue[0]
>>> let mut new_queue = []
>>> let mut i = 1
>>> while i < queue.len() {
...     new_queue = new_queue + [queue[i]]
...     i = i + 1
... }
>>> queue = new_queue
>>> dequeued
1
>>> queue
[2, 3]
```

**Pattern**:
- Enqueue: Append to end
- Dequeue: Remove from front
- Peek: Read first element

**Use Case**: Task queues, breadth-first search, scheduling.

## Tuples - Fixed-Size Collections

Use arrays as tuples for fixed-size data:

```ruchy
>>> let point = [10, 20]  // (x, y)
>>> point[0]
10
>>> point[1]
20
>>> let person = ["Alice", 30, "Engineer"]  // (name, age, job)
>>> person[0]
"Alice"
>>> person[1]
30
```

**Use Case**: Function multiple returns, coordinate pairs.

## Pairs

Use struct for named pair:

```ruchy
>>> let pair = {first: 10, second: 20}
>>> pair.first
10
>>> pair.second
20
>>> // Swap
>>> let swapped = {first: pair.second, second: pair.first}
>>> swapped
{first: 20, second: 10}
```

**Use Case**: Key-value pairs, min-max results.

## Multi-Dimensional Arrays

### 3D Arrays

```ruchy
>>> let cube = [
...     [[1, 2], [3, 4]],
...     [[5, 6], [7, 8]]
... ]
>>> cube[0][0][0]
1
>>> cube[1][1][1]
8
>>> cube[0][1][0]
3
```

**Access**: `array[depth][row][col]`

**Use Case**: 3D graphics, scientific data, game boards.

### Jagged Arrays

Non-rectangular arrays:

```ruchy
>>> let jagged = [
...     [1, 2],
...     [3, 4, 5],
...     [6]
... ]
>>> jagged[0].len()
2
>>> jagged[1].len()
3
>>> jagged[2].len()
1
>>> jagged[1][2]
5
```

**Pattern**: Each row can have different length.

**Use Case**: Variable-length records, sparse data.

## Circular Buffer (Ring Buffer)

Fixed-size buffer that wraps around:

```ruchy
>>> let capacity = 3
>>> let mut buffer = [0, 0, 0]
>>> let mut write_pos = 0
>>> // Write values
>>> buffer[write_pos % capacity] = 10
>>> write_pos = write_pos + 1
>>> buffer[write_pos % capacity] = 20
>>> write_pos = write_pos + 1
>>> buffer[write_pos % capacity] = 30
>>> write_pos = write_pos + 1
>>> // Overwrite first position
>>> buffer[write_pos % capacity] = 40
>>> write_pos = write_pos + 1
>>> buffer
[40, 20, 30]
```

**Pattern**: Use modulo (%) to wrap index.

**Use Case**: Logging, streaming data, recent history.

## Priority Queue

Elements with priority:

```ruchy
>>> let mut pq = []
>>> pq = pq + [{value: "Low", priority: 3}]
>>> pq = pq + [{value: "High", priority: 1}]
>>> pq = pq + [{value: "Medium", priority: 2}]
>>> // Find highest priority (lowest number)
>>> let mut min_priority = pq[0].priority
>>> let mut min_index = 0
>>> let mut i = 1
>>> while i < pq.len() {
...     if pq[i].priority < min_priority {
...         min_priority = pq[i].priority
...         min_index = i
...     }
...     i = i + 1
... }
>>> pq[min_index].value
"High"
```

**Pattern**: Lower priority number = higher priority.

**Use Case**: Task scheduling, event processing, A* search.

## Sparse Array

Store only non-zero/non-default values:

```ruchy
>>> let mut sparse = []
>>> sparse = sparse + [{index: 0, value: 10}]
>>> sparse = sparse + [{index: 100, value: 20}]
>>> sparse = sparse + [{index: 1000, value: 30}]
>>> // Lookup
>>> let target_index = 100
>>> let mut found_value = -1
>>> for entry in sparse {
...     if entry.index == target_index {
...         found_value = entry.value
...         break
...     }
... }
>>> found_value
20
```

**Pattern**: Array of {index, value} pairs.

**Use Case**: Large arrays with few values, sparse matrices.

## Linked List Structure

Nodes with next pointers:

```ruchy
>>> let nodes = [
...     {value: 10, next: 1},
...     {value: 20, next: 2},
...     {value: 30, next: -1}  // -1 means null/end
... ]
>>> // Traverse
>>> let mut current = 0
>>> let mut values = []
>>> while current != -1 {
...     values = values + [nodes[current].value]
...     current = nodes[current].next
... }
>>> values
[10, 20, 30]
```

**Pattern**: Array of nodes with index pointers.

**Use Case**: When insertion/deletion is frequent.

## Graph Adjacency List

Represent graphs:

```ruchy
>>> let graph = [
...     {node: "A", neighbors: ["B", "C"]},
...     {node: "B", neighbors: ["A", "D"]},
...     {node: "C", neighbors: ["A"]},
...     {node: "D", neighbors: ["B"]}
... ]
>>> // Find neighbors of "B"
>>> let mut b_neighbors = []
>>> for entry in graph {
...     if entry.node == "B" {
...         b_neighbors = entry.neighbors
...         break
...     }
... }
>>> b_neighbors
["A", "D"]
```

**Pattern**: Array of {node, neighbors} structs.

**Use Case**: Social networks, dependency graphs, routing.

## Practical Examples

### Undo Stack

```ruchy
>>> let mut history = []
>>> // Record actions
>>> history = history + [{action: "type", text: "Hello"}]
>>> history = history + [{action: "type", text: " World"}]
>>> // Undo (pop from stack)
>>> if history.len() > 0 {
...     let last_action = history[history.len() - 1]
...     // Remove last action
...     let mut new_history = []
...     let mut i = 0
...     while i < history.len() - 1 {
...         new_history = new_history + [history[i]]
...         i = i + 1
...     }
...     history = new_history
... }
>>> history.len()
1
```

### Task Queue with Priority

```ruchy
>>> let mut tasks = []
>>> tasks = tasks + [{name: "Critical Bug", priority: 1}]
>>> tasks = tasks + [{name: "Feature Request", priority: 3}]
>>> tasks = tasks + [{name: "Security Fix", priority: 1}]
>>> // Process highest priority first
>>> while tasks.len() > 0 {
...     // Find highest priority
...     let mut min_priority = tasks[0].priority
...     let mut min_index = 0
...     let mut i = 1
...     while i < tasks.len() {
...         if tasks[i].priority < min_priority {
...             min_priority = tasks[i].priority
...             min_index = i
...         }
...         i = i + 1
...     }
...     // Process and remove
...     let task = tasks[min_index]
...     // ... process task ...
...     // Remove from queue
...     let mut new_tasks = []
...     i = 0
...     while i < tasks.len() {
...         if i != min_index {
...             new_tasks = new_tasks + [tasks[i]]
...         }
...         i = i + 1
...     }
...     tasks = new_tasks
... }
```

### LRU Cache (Least Recently Used)

```ruchy
>>> let capacity = 3
>>> let mut cache = []
>>> // Add items
>>> cache = cache + [{key: "a", value: 1, timestamp: 0}]
>>> cache = cache + [{key: "b", value: 2, timestamp: 1}]
>>> cache = cache + [{key: "c", value: 3, timestamp: 2}]
>>> // Access updates timestamp
>>> let access_key = "a"
>>> let mut i = 0
>>> while i < cache.len() {
...     if cache[i].key == access_key {
...         cache[i] = {key: cache[i].key, value: cache[i].value, timestamp: 3}
...         break
...     }
...     i = i + 1
... }
>>> // When full, evict least recently used (lowest timestamp)
>>> if cache.len() >= capacity {
...     let mut min_time = cache[0].timestamp
...     let mut min_index = 0
...     i = 1
...     while i < cache.len() {
...         if cache[i].timestamp < min_time {
...             min_time = cache[i].timestamp
...             min_index = i
...         }
...         i = i + 1
...     }
...     // Remove least recently used
...     let mut new_cache = []
...     i = 0
...     while i < cache.len() {
...         if i != min_index {
...             new_cache = new_cache + [cache[i]]
...         }
...         i = i + 1
...     }
...     cache = new_cache
... }
```

## Performance Considerations

### Set Operations Complexity

```
Uniqueness check:    O(n²) - check each element against set
Union:               O(n*m) - n and m are set sizes
Intersection:        O(n*m)
Difference:          O(n*m)
```

**Optimization**: Sort sets first for O(n log n) operations.

### Stack vs Queue

```
Stack (array-based):
  Push:  O(1) - append to end
  Pop:   O(n) - rebuild array
  Peek:  O(1) - access last

Queue (array-based):
  Enqueue: O(1) - append to end
  Dequeue: O(n) - rebuild array
  Peek:    O(1) - access first
```

**Trade-off**: Simple implementation vs performance.

## Common Patterns

### Check Before Add

```ruchy
>>> fun add_unique(set, item) {
...     let mut found = false
...     for s in set {
...         if s == item {
...             found = true
...             break
...         }
...     }
...     if !found {
...         set + [item]
...     } else {
...         set
...     }
... }
```

### Find and Remove

```ruchy
>>> fun remove_item(arr, item) {
...     let mut result = []
...     for a in arr {
...         if a != item {
...             result = result + [a]
...         }
...     }
...     result
... }
```

### Find Min/Max with Index

```ruchy
>>> fun find_min_index(arr) {
...     let mut min_val = arr[0]
...     let mut min_idx = 0
...     let mut i = 1
...     while i < arr.len() {
...         if arr[i] < min_val {
...             min_val = arr[i]
...             min_idx = i
...         }
...         i = i + 1
...     }
...     min_idx
... }
```

## Best Practices

### 1. Choose Right Structure

```ruchy
// ✅ Stack for LIFO
>>> let mut undo_stack = []

// ✅ Queue for FIFO
>>> let mut task_queue = []

// ✅ Set for uniqueness
>>> let mut unique_ids = []
```

### 2. Document Structure

```ruchy
>>> // Priority queue: {value, priority}
>>> // Lower priority number = higher priority
>>> let mut pq = []
```

### 3. Encapsulate Operations

```ruchy
>>> fun push_stack(stack, item) {
...     stack + [item]
... }
>>> fun pop_stack(stack) {
...     let popped = stack[stack.len() - 1]
...     let mut new_stack = []
...     let mut i = 0
...     while i < stack.len() - 1 {
...         new_stack = new_stack + [stack[i]]
...         i = i + 1
...     }
...     {value: popped, stack: new_stack}
... }
```

## Common Mistakes

### Mistake 1: Forgetting Bounds Check

```ruchy
// ❌ WRONG: May access invalid index
>>> let stack = []
>>> let top = stack[stack.len() - 1]  // Error if empty!

// ✅ CORRECT: Check first
>>> if stack.len() > 0 {
...     let top = stack[stack.len() - 1]
... }
```

### Mistake 2: Modifying During Iteration

```ruchy
// ❌ WRONG: Modifying collection while iterating
>>> let mut set = [1, 2, 3]
>>> for item in set {
...     set = set + [item * 2]  // Creates confusion!
... }

// ✅ CORRECT: Build new collection
>>> let original = [1, 2, 3]
>>> let mut doubled = []
>>> for item in original {
...     doubled = doubled + [item * 2]
... }
```

### Mistake 3: Inefficient Removal

```ruchy
// ⚠️ INEFFICIENT: O(n²) for many removals
>>> let mut arr = [1, 2, 3, 4, 5]
>>> arr = remove_item(arr, 2)
>>> arr = remove_item(arr, 4)

// ✅ BETTER: Single pass filter
>>> let to_remove = [2, 4]
>>> let mut result = []
>>> for item in arr {
...     let mut should_remove = false
...     for r in to_remove {
...         if item == r {
...             should_remove = true
...             break
...         }
...     }
...     if !should_remove {
...         result = result + [item]
...     }
... }
```

## Summary

You've mastered advanced collections in Ruchy:

✅ **Sets**: Unique elements, union, intersection, difference
✅ **Stacks**: LIFO operations (push, pop, peek)
✅ **Queues**: FIFO operations (enqueue, dequeue)
✅ **Tuples**: Fixed-size collections
✅ **Multi-dimensional**: 3D arrays, jagged arrays
✅ **Circular Buffer**: Ring buffer with wraparound
✅ **Priority Queue**: Ordered by priority
✅ **Sparse Array**: Efficient storage for sparse data
✅ **Linked Lists**: Node-based structures
✅ **Graphs**: Adjacency list representation
✅ **Best Practices**: Structure selection, documentation, encapsulation

## Next Steps

Continue to [Trees and Graphs](ch03-04-tree-graph.md) to learn about hierarchical and network data structures.

---

**Test File:** `book/tests/test_ch03_03_advanced_collections.ruchy` (15 tests, 40+ assertions)
**Version:** Verified with Ruchy v3.194.0
**Performance:** ⚠️ Array-based structures have O(n) operations; optimize when needed

*Every code snippet is tested and verified working. Copy-paste directly into your Ruchy REPL.*
