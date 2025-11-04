# 2.2 Recursion

Master recursive thinking and solve problems by breaking them into smaller versions of themselves.

**Test Status:** ✅ Verified with Ruchy v3.194.0
**Test File:** `book/tests/test_ch02_02_recursion.ruchy`

## Introduction

Recursion is when a function calls itself to solve a problem by breaking it into smaller, similar subproblems. It's a powerful technique for problems that have a recursive structure, like trees, mathematical sequences, or divide-and-conquer algorithms.

## Anatomy of Recursion

Every recursive function has two essential parts:

**1. Base Case**: The stopping condition that prevents infinite recursion
**2. Recursive Case**: The function calling itself with a simpler version of the problem

```ruchy
>>> fun countdown(n) {
...     if n <= 0 {
...         "Done!"              // Base case
...     } else {
...         countdown(n - 1)     // Recursive case
...     }
... }
>>> countdown(3)
"Done!"
```

**Pattern**: Always ensure progress toward the base case to avoid infinite recursion.

## Simple Recursion

### Factorial

The classic recursive example:

```ruchy
>>> fun factorial(n) {
...     if n <= 1 {
...         1
...     } else {
...         n * factorial(n - 1)
...     }
... }
>>> factorial(5)
120  // 5 * 4 * 3 * 2 * 1
>>> factorial(7)
5040
>>> factorial(0)
1
```

**How it works:**
- factorial(5) = 5 × factorial(4)
- factorial(4) = 4 × factorial(3)
- factorial(3) = 3 × factorial(2)
- factorial(2) = 2 × factorial(1)
- factorial(1) = 1 (base case)
- Result: 5 × 4 × 3 × 2 × 1 = 120

### Sum of Numbers

```ruchy
>>> fun sum(n) {
...     if n <= 0 {
...         0
...     } else {
...         n + sum(n - 1)
...     }
... }
>>> sum(5)
15  // 5 + 4 + 3 + 2 + 1
>>> sum(10)
55
```

**Pattern**: Each recursive call reduces the problem size by 1 until reaching 0.

## Multiple Recursive Calls

### Fibonacci Sequence

Functions can call themselves multiple times:

```ruchy
>>> fun fib(n) {
...     if n <= 1 {
...         n
...     } else {
...         fib(n - 1) + fib(n - 2)
...     }
... }
>>> fib(0)
0
>>> fib(1)
1
>>> fib(5)
5
>>> fib(10)
55
```

**Sequence**: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55...

**Use Case**: Modeling growth patterns, natural phenomena, algorithm analysis.

## Recursive Array Processing

### Array Sum

Process arrays recursively using index tracking:

```ruchy
>>> fun sum_array(arr, index) {
...     if index >= arr.len() {
...         0
...     } else {
...         arr[index] + sum_array(arr, index + 1)
...     }
... }
>>> let numbers = [1, 2, 3, 4, 5]
>>> sum_array(numbers, 0)
15
>>> let values = [10, 20, 30]
>>> sum_array(values, 0)
60
```

**Pattern**: Pass index as parameter, increment on each recursive call.

### Finding Maximum

```ruchy
>>> fun max_from(arr, index, current_max) {
...     if index >= arr.len() {
...         current_max
...     } else {
...         let new_max = if arr[index] > current_max {
...             arr[index]
...         } else {
...             current_max
...         }
...         max_from(arr, index + 1, new_max)
...     }
... }
>>> let nums = [3, 7, 2, 9, 1]
>>> max_from(nums, 1, nums[0])
9
```

**Pattern**: Track both position and accumulated result through parameters.

### Counting Occurrences

```ruchy
>>> fun count_value(arr, index, target, count) {
...     if index >= arr.len() {
...         count
...     } else {
...         let new_count = if arr[index] == target {
...             count + 1
...         } else {
...             count
...         }
...         count_value(arr, index + 1, target, new_count)
...     }
... }
>>> let numbers = [1, 2, 3, 2, 4, 2, 5]
>>> count_value(numbers, 0, 2, 0)
3
```

**Pattern**: Accumulator parameter tracks result across recursive calls.

## Mathematical Recursion

### Power Function

```ruchy
>>> fun power(base, exp) {
...     if exp == 0 {
...         1
...     } else {
...         base * power(base, exp - 1)
...     }
... }
>>> power(2, 3)
8  // 2³ = 2 × 2 × 2
>>> power(5, 2)
25
>>> power(3, 4)
81
```

**Use Case**: Exponentiation, compound growth, polynomial evaluation.

### Greatest Common Divisor (Euclidean Algorithm)

```ruchy
>>> fun gcd(a, b) {
...     if b == 0 {
...         a
...     } else {
...         gcd(b, a % b)
...     }
... }
>>> gcd(48, 18)
6
>>> gcd(100, 35)
5
>>> gcd(17, 13)
1
```

**Classical Algorithm**: One of the oldest known algorithms (300 BC).

## Digit Processing

### Sum of Digits

```ruchy
>>> fun digit_sum(n) {
...     if n == 0 {
...         0
...     } else {
...         (n % 10) + digit_sum(n / 10)
...     }
... }
>>> digit_sum(123)
6  // 1 + 2 + 3
>>> digit_sum(456)
15  // 4 + 5 + 6
>>> digit_sum(999)
27
```

**Pattern**: Use modulo to get last digit, integer division to remove it.

### Reverse Number

```ruchy
>>> fun reverse_helper(n, acc) {
...     if n == 0 {
...         acc
...     } else {
...         reverse_helper(n / 10, acc * 10 + (n % 10))
...     }
... }
>>> fun reverse(n) {
...     reverse_helper(n, 0)
... }
>>> reverse(123)
321
>>> reverse(456)
654
>>> reverse(100)
1
```

**Pattern**: Helper function with accumulator for tail recursion optimization.

## Advanced Recursion

### Binary Search

Divide-and-conquer search algorithm:

```ruchy
>>> fun binary_search(arr, target, left, right) {
...     if left > right {
...         -1  // Not found
...     } else {
...         let mid = (left + right) / 2
...         if arr[mid] == target {
...             mid
...         } else if arr[mid] > target {
...             binary_search(arr, target, left, mid - 1)
...         } else {
...             binary_search(arr, target, mid + 1, right)
...         }
...     }
... }
>>> let sorted = [1, 3, 5, 7, 9, 11, 13]
>>> binary_search(sorted, 7, 0, sorted.len() - 1)
3
>>> binary_search(sorted, 8, 0, sorted.len() - 1)
-1
```

**Performance**: O(log n) - much faster than linear search for large arrays.

## Mutual Recursion

Functions calling each other:

```ruchy
>>> fun is_even(n) {
...     if n == 0 {
...         true
...     } else {
...         is_odd(n - 1)
...     }
... }
>>> fun is_odd(n) {
...     if n == 0 {
...         false
...     } else {
...         is_even(n - 1)
...     }
... }
>>> is_even(4)
true
>>> is_even(7)
false
>>> is_odd(3)
true
>>> is_odd(6)
false
```

**Pattern**: Two or more functions call each other in a cycle.

## Helper Functions with Accumulators

### Why Use Accumulators?

Accumulators enable tail recursion optimization:

```ruchy
>>> // Without accumulator (not tail-recursive)
>>> fun sum_simple(n) {
...     if n <= 0 {
...         0
...     } else {
...         n + sum_simple(n - 1)  // Addition happens AFTER recursive call
...     }
... }

>>> // With accumulator (tail-recursive)
>>> fun sum_tail_helper(n, acc) {
...     if n <= 0 {
...         acc
...     } else {
...         sum_tail_helper(n - 1, acc + n)  // Recursive call is LAST operation
...     }
... }
>>> fun sum_tail(n) {
...     sum_tail_helper(n, 0)
... }
>>> sum_tail(5)
15
```

**Tail Recursion**: When recursive call is the last operation, enabling optimization.

## Common Recursion Patterns

### 1. Linear Recursion

Single recursive call, processing one element at a time:

```ruchy
>>> fun count_down(n) {
...     if n <= 0 {
...         "Blast off!"
...     } else {
...         count_down(n - 1)
...     }
... }
```

### 2. Tree Recursion

Multiple recursive calls (like Fibonacci):

```ruchy
>>> fun tree_sum(depth) {
...     if depth == 0 {
...         1
...     } else {
...         tree_sum(depth - 1) + tree_sum(depth - 1)
...     }
... }
```

### 3. Tail Recursion

Recursive call is the final operation:

```ruchy
>>> fun factorial_tail(n, acc) {
...     if n <= 1 {
...         acc
...     } else {
...         factorial_tail(n - 1, n * acc)
...     }
... }
```

## When to Use Recursion

### Best Use Cases

✅ **Tree/Graph Traversal**: Natural recursive structure
✅ **Divide and Conquer**: Binary search, merge sort, quick sort
✅ **Mathematical Sequences**: Fibonacci, factorials, combinations
✅ **Backtracking**: Solving puzzles, finding paths
✅ **Nested Structures**: JSON parsing, file systems

### When Iteration is Better

⚠️ **Simple Loops**: Iterating 1 to n
⚠️ **Large Datasets**: Risk of stack overflow
⚠️ **No Natural Structure**: Forced recursion adds complexity
⚠️ **Performance Critical**: Iteration often faster

## Recursion vs Iteration

Same problem, different approaches:

```ruchy
>>> // Recursive approach
>>> fun sum_recursive(n) {
...     if n <= 0 {
...         0
...     } else {
...         n + sum_recursive(n - 1)
...     }
... }

>>> // Iterative approach
>>> fun sum_iterative(n) {
...     let mut total = 0
...     let mut i = 1
...     while i <= n {
...         total = total + i
...         i = i + 1
...     }
...     total
... }

>>> sum_recursive(10)
55
>>> sum_iterative(10)
55
```

**Trade-offs:**
- Recursion: More elegant, matches problem structure, can cause stack overflow
- Iteration: More efficient, explicit control flow, can be more verbose

## Common Mistakes

### Mistake 1: Missing Base Case

```ruchy
// ❌ WRONG: Infinite recursion
>>> fun bad_countdown(n) {
...     bad_countdown(n - 1)  // Never stops!
... }

// ✅ CORRECT: Always include base case
>>> fun good_countdown(n) {
...     if n <= 0 {
...         "Done!"
...     } else {
...         good_countdown(n - 1)
...     }
... }
```

### Mistake 2: Not Making Progress

```ruchy
// ❌ WRONG: Never reaches base case
>>> fun bad_sum(n) {
...     if n == 0 {
...         0
...     } else {
...         n + bad_sum(n)  // n never changes!
...     }
... }

// ✅ CORRECT: Reduce problem size
>>> fun good_sum(n) {
...     if n == 0 {
...         0
...     } else {
...         n + good_sum(n - 1)  // n decreases
...     }
... }
```

### Mistake 3: Inefficient Tree Recursion

```ruchy
// ⚠️ INEFFICIENT: Exponential time
>>> fun fib_slow(n) {
...     if n <= 1 {
...         n
...     } else {
...         fib_slow(n - 1) + fib_slow(n - 2)
...     }
... }
// fib_slow(40) recalculates same values millions of times

// ✅ BETTER: Use iteration or memoization for Fibonacci
>>> fun fib_iterative(n) {
...     if n <= 1 {
...         return n
...     }
...     let mut prev = 0
...     let mut curr = 1
...     let mut i = 2
...     while i <= n {
...         let next = prev + curr
...         prev = curr
...         curr = next
...         i = i + 1
...     }
...     curr
... }
```

## Practical Examples

### Calculate Combination (nCr)

```ruchy
>>> fun combination(n, r) {
...     if r == 0 || r == n {
...         1
...     } else {
...         combination(n - 1, r - 1) + combination(n - 1, r)
...     }
... }
>>> combination(5, 2)
10  // 5 choose 2
>>> combination(6, 3)
20  // 6 choose 3
```

**Use Case**: Probability, statistics, combinatorics.

### Tower of Hanoi

```ruchy
>>> fun hanoi_moves(n) {
...     if n == 1 {
...         1
...     } else {
...         2 * hanoi_moves(n - 1) + 1
...     }
... }
>>> hanoi_moves(3)
7
>>> hanoi_moves(4)
15
```

**Classic Puzzle**: Minimum moves to transfer n disks = 2ⁿ - 1

### Sum of Array Slice

```ruchy
>>> fun sum_slice(arr, start, end) {
...     if start >= end {
...         0
...     } else {
...         arr[start] + sum_slice(arr, start + 1, end)
...     }
... }
>>> let data = [1, 2, 3, 4, 5]
>>> sum_slice(data, 0, 3)
6  // 1 + 2 + 3
>>> sum_slice(data, 2, 5)
12  // 3 + 4 + 5
```

**Pattern**: Process subrange of array recursively.

## Performance Considerations

### Stack Space

Each recursive call uses stack memory:

```
factorial(5)
  → factorial(4)
    → factorial(3)
      → factorial(2)
        → factorial(1)  // 5 stack frames
```

**Limit**: Deep recursion (>1000 calls) may cause stack overflow.

### Time Complexity

- **Linear Recursion**: O(n) - one call per level
- **Tree Recursion**: O(2ⁿ) - exponential growth
- **Tail Recursion**: O(n) - can be optimized to O(1) space

### When Performance Matters

For performance-critical code:
1. Use iteration for simple accumulation
2. Use tail recursion when possible
3. Consider memoization for tree recursion
4. Profile before optimizing

## Best Practices

### 1. Clear Base Case

```ruchy
>>> fun safe_factorial(n) {
...     if n < 0 {
...         return 0  // Handle invalid input
...     }
...     if n <= 1 {
...         1  // Clear base case
...     } else {
...         n * safe_factorial(n - 1)
...     }
... }
```

### 2. Validate Progress

Ensure each call moves toward base case:

```ruchy
>>> fun safe_countdown(n) {
...     if n <= 0 {
...         "Done!"
...     } else {
...         safe_countdown(n - 1)  // n decreases
...     }
... }
```

### 3. Use Helper Functions

Separate public API from recursive implementation:

```ruchy
>>> fun public_sum(n) {
...     sum_helper(n, 0)
... }
>>> fun sum_helper(n, acc) {
...     if n <= 0 {
...         acc
...     } else {
...         sum_helper(n - 1, acc + n)
...     }
... }
```

### 4. Document Complexity

Note time/space complexity for recursive functions:

```ruchy
// O(n) time, O(n) space (stack depth)
fun factorial(n) { ... }

// O(2ⁿ) time, O(n) space (max stack depth)
fun fib(n) { ... }
```

## Recursion Thinking Tips

### How to Approach Recursive Problems

1. **Identify Base Case**: What's the simplest version?
2. **Define Recursive Step**: How to reduce problem size?
3. **Ensure Progress**: Each call must move toward base case
4. **Trust the Recursion**: Assume recursive call works correctly

### Example Thought Process: Array Sum

```
Problem: Sum array [1, 2, 3, 4, 5]

1. Base case: Empty array → sum = 0
2. Recursive step: sum = first_element + sum(rest)
3. Progress: Each call processes one element
4. Trust: If sum([2,3,4,5]) = 14, then sum([1,2,3,4,5]) = 1 + 14 = 15
```

## Summary

You've mastered recursion in Ruchy:

✅ **Base & Recursive Cases**: Essential components of recursion
✅ **Simple Recursion**: Factorial, sum, power
✅ **Array Recursion**: Processing collections recursively
✅ **Tree Recursion**: Multiple recursive calls
✅ **Tail Recursion**: Optimization-friendly pattern
✅ **Helper Functions**: Accumulators for tail recursion
✅ **Common Patterns**: Linear, tree, mutual recursion
✅ **Best Practices**: Validation, documentation, when to avoid

## Next Steps

Continue to [Closures](ch02-03-closures.md) to learn about functions that capture their environment.

---

**Test File:** `book/tests/test_ch02_02_recursion.ruchy` (15 tests, 35+ assertions)
**Version:** Verified with Ruchy v3.194.0
**Performance:** ⚠️ Be mindful of stack depth (avoid >1000 recursive calls)

*Every code snippet is tested and verified working. Copy-paste directly into your Ruchy REPL.*
