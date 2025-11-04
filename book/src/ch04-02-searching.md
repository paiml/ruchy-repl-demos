# Chapter 4.2: Search Algorithms

Searching is the process of finding a specific element in a collection of data. It's one of the most common operations in programming, appearing in everything from database queries to array lookups. This chapter explores fundamental search algorithms, their implementations in Ruchy, and when to use each approach.

## Why Searching Matters

Efficient searching enables:
- **Data retrieval**: Finding specific records quickly
- **Validation**: Checking if element exists
- **Analysis**: Finding patterns, duplicates, or missing data
- **Optimization**: Many algorithms depend on fast search
- **User experience**: Instant results improve usability

## Basic Searching

### Linear Search (Sequential Search)

The simplest search algorithm: check each element one by one until target is found.

```ruchy
// Linear Search - O(n) time, O(1) space
fun linear_search(arr, target) {
    let mut i = 0;

    while i < arr.len() {
        if arr[i] == target {
            return i;  // Found at index i
        }
        i = i + 1;
    }

    -1  // Not found (return -1 by convention)
}

let numbers = [64, 34, 25, 12, 22, 11, 90];
linear_search(numbers, 12);  // Returns 3
linear_search(numbers, 99);  // Returns -1 (not found)
```

**How it works:**
1. Start at beginning of array
2. Compare each element with target
3. Return index if found
4. Return -1 if not found after checking all elements

**Characteristics:**
- **Time**: O(n) - must check every element in worst case
- **Space**: O(1) - no extra memory needed
- **Requirements**: Works on unsorted data
- **Best case**: O(1) - target is first element
- **Worst case**: O(n) - target is last or not present

**When to use:**
- Small arrays (< 100 elements)
- Unsorted data
- Data changes frequently (no time to sort)
- Simplicity is priority
- Single search operation

### Linear Search with Early Exit

```ruchy
// Return immediately when found
fun linear_search_early_exit(arr, target) {
    for item in arr {
        if item == target {
            return true;  // Found
        }
    }
    false  // Not found
}
```

## Binary Search

Binary search is a dramatically faster algorithm for **sorted arrays**. It repeatedly divides the search space in half.

### Iterative Binary Search

```ruchy
// Binary Search - O(log n) time, O(1) space
// REQUIRES: Array must be sorted!
fun binary_search(arr, target) {
    let mut left = 0;
    let mut right = arr.len() - 1;

    while left <= right {
        let mid = left + (right - left) / 2;  // Avoid overflow

        if arr[mid] == target {
            return mid;  // Found at mid
        } else if arr[mid] < target {
            left = mid + 1;  // Search right half
        } else {
            right = mid - 1;  // Search left half
        }
    }

    -1  // Not found
}

let sorted = [11, 12, 22, 25, 34, 64, 90];
binary_search(sorted, 25);  // Returns 3
binary_search(sorted, 99);  // Returns -1
```

**How it works:**
1. Start with entire sorted array
2. Compare middle element with target
3. If equal, found!
4. If target < middle, search left half
5. If target > middle, search right half
6. Repeat until found or search space is empty

**Characteristics:**
- **Time**: O(log n) - divides problem in half each step
- **Space**: O(1) - iterative version uses constant space
- **Requirements**: Array MUST be sorted
- **Efficiency**: 1000 elements → ~10 comparisons (vs 500 average for linear)

**Performance comparison:**
- Array size: 100 → Binary: ~7 steps, Linear: ~50 steps
- Array size: 1,000,000 → Binary: ~20 steps, Linear: ~500,000 steps

### Recursive Binary Search

```ruchy
// Binary search with recursion
fun binary_search_recursive(arr, target, left, right) {
    if left > right {
        return -1;  // Not found (base case)
    }

    let mid = left + (right - left) / 2;

    if arr[mid] == target {
        mid  // Found
    } else if arr[mid] < target {
        binary_search_recursive(arr, target, mid + 1, right)
    } else {
        binary_search_recursive(arr, target, left, mid - 1)
    }
}

// Wrapper function
fun binary_search(arr, target) {
    binary_search_recursive(arr, target, 0, arr.len() - 1)
}

let sorted = [1, 3, 5, 7, 9, 11, 13, 15];
binary_search(sorted, 7);  // Returns 3
```

**Recursive characteristics:**
- **Space**: O(log n) - call stack grows with recursion depth
- **Readability**: Often clearer logic
- **Stack limit**: May hit stack overflow on very large arrays

## Finding Occurrences

### Find First Occurrence

```ruchy
// Find the first (leftmost) occurrence of target
fun find_first(arr, target) {
    let mut first = -1;
    let mut i = 0;

    while i < arr.len() {
        if arr[i] == target {
            first = i;
            break;  // Found first occurrence
        }
        i = i + 1;
    }

    first
}

let numbers = [1, 2, 3, 3, 3, 4, 5];
find_first(numbers, 3);  // Returns 2
```

### Find Last Occurrence

```ruchy
// Find the last (rightmost) occurrence of target
fun find_last(arr, target) {
    let mut last = -1;
    let mut i = arr.len();

    while i > 0 {
        i = i - 1;
        if arr[i] == target {
            last = i;
            break;  // Found last occurrence
        }
    }

    last
}

let numbers = [1, 2, 3, 3, 3, 4, 5];
find_last(numbers, 3);  // Returns 4
```

### Find All Occurrences

```ruchy
// Find all indices where target appears
fun find_all(arr, target) {
    let mut indices = [];
    let mut i = 0;

    while i < arr.len() {
        if arr[i] == target {
            indices = indices + [i];
        }
        i = i + 1;
    }

    indices
}

let numbers = [1, 2, 3, 3, 3, 4, 5, 3];
let all_3s = find_all(numbers, 3);
// Returns [2, 3, 4, 7]
```

### Count Occurrences

```ruchy
// Count how many times target appears
fun count_occurrences(arr, target) {
    let mut count = 0;

    for item in arr {
        if item == target {
            count = count + 1;
        }
    }

    count
}

let numbers = [1, 2, 3, 3, 3, 4, 5];
count_occurrences(numbers, 3);  // Returns 3
```

## Finding Min and Max

### Find Minimum Element

```ruchy
// Find smallest element in array
fun find_min(arr) {
    if arr.len() == 0 {
        return -1;  // Empty array
    }

    let mut min = arr[0];
    let mut i = 1;

    while i < arr.len() {
        if arr[i] < min {
            min = arr[i];
        }
        i = i + 1;
    }

    min
}

let numbers = [64, 34, 25, 12, 22, 11, 90];
find_min(numbers);  // Returns 11
```

### Find Maximum Element

```ruchy
// Find largest element in array
fun find_max(arr) {
    if arr.len() == 0 {
        return -1;  // Empty array
    }

    let mut max = arr[0];
    let mut i = 1;

    while i < arr.len() {
        if arr[i] > max {
            max = arr[i];
        }
        i = i + 1;
    }

    max
}

let numbers = [64, 34, 25, 12, 22, 11, 90];
find_max(numbers);  // Returns 90
```

### Find Both Min and Max

```ruchy
// Find both minimum and maximum in one pass
fun find_min_max(arr) {
    if arr.len() == 0 {
        return {min: -1, max: -1};
    }

    let mut min = arr[0];
    let mut max = arr[0];
    let mut i = 1;

    while i < arr.len() {
        if arr[i] < min {
            min = arr[i];
        }
        if arr[i] > max {
            max = arr[i];
        }
        i = i + 1;
    }

    {min: min, max: max}
}

let numbers = [64, 34, 25, 12, 22, 11, 90];
let result = find_min_max(numbers);
// Returns {min: 11, max: 90}
```

## Advanced Binary Search Variants

### Find Insert Position

Find where to insert target to maintain sorted order.

```ruchy
// Find index where target should be inserted
fun find_insert_pos(arr, target) {
    let mut left = 0;
    let mut right = arr.len();

    while left < right {
        let mid = left + (right - left) / 2;

        if arr[mid] < target {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    left
}

let sorted = [1, 3, 5, 7, 9];
find_insert_pos(sorted, 0);   // Returns 0 (insert at beginning)
find_insert_pos(sorted, 4);   // Returns 2 (insert between 3 and 5)
find_insert_pos(sorted, 10);  // Returns 5 (insert at end)
```

### Lower Bound (First >= Target)

```ruchy
// Find first element >= target
fun lower_bound(arr, target) {
    let mut left = 0;
    let mut right = arr.len();

    while left < right {
        let mid = left + (right - left) / 2;

        if arr[mid] < target {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    left
}

let sorted = [1, 2, 2, 2, 3, 5];
lower_bound(sorted, 2);  // Returns 1 (first 2)
```

### Upper Bound (First > Target)

```ruchy
// Find first element > target
fun upper_bound(arr, target) {
    let mut left = 0;
    let mut right = arr.len();

    while left < right {
        let mid = left + (right - left) / 2;

        if arr[mid] <= target {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    left
}

let sorted = [1, 2, 2, 2, 3, 5];
upper_bound(sorted, 2);  // Returns 4 (first element after 2s)
```

## Search in Rotated Sorted Array

A sorted array that has been rotated (e.g., [4,5,6,7,0,1,2] from [0,1,2,3,4,5,6,7]).

```ruchy
// Search in rotated sorted array
fun search_rotated(arr, target) {
    let mut left = 0;
    let mut right = arr.len() - 1;

    while left <= right {
        let mid = left + (right - left) / 2;

        if arr[mid] == target {
            return mid;
        }

        // Determine which half is sorted
        if arr[left] <= arr[mid] {
            // Left half is sorted
            if target >= arr[left] && target < arr[mid] {
                right = mid - 1;  // Target in left half
            } else {
                left = mid + 1;   // Target in right half
            }
        } else {
            // Right half is sorted
            if target > arr[mid] && target <= arr[right] {
                left = mid + 1;   // Target in right half
            } else {
                right = mid - 1;  // Target in left half
            }
        }
    }

    -1
}

let rotated = [4, 5, 6, 7, 0, 1, 2];
search_rotated(rotated, 0);  // Returns 4
search_rotated(rotated, 6);  // Returns 2
```

## Jump Search

Combines benefits of linear and binary search by jumping ahead by fixed steps.

```ruchy
// Jump Search - O(√n) time
fun jump_search(arr, target) {
    let n = arr.len();
    let step = 3;  // Jump size (typically sqrt(n), simplified here)
    let mut prev = 0;

    // Jump forward until we overshoot
    while prev < n && arr[prev] < target {
        let next = prev + step;
        if next >= n || arr[next] >= target {
            break;  // Target is in this block
        }
        prev = next;
    }

    // Linear search within the block
    let mut i = prev;
    while i < n && i < prev + step {
        if arr[i] == target {
            return i;
        }
        i = i + 1;
    }

    -1
}

let sorted = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
jump_search(sorted, 7);   // Returns 3
jump_search(sorted, 15);  // Returns 7
```

**Characteristics:**
- **Time**: O(√n) - better than linear, worse than binary
- **Best for**: Large arrays on systems with slow backward jumps
- **Advantages**: Only jumps forward, cache-friendly

## Search with Predicates

Search for elements matching a condition instead of exact value.

```ruchy
// Find first element matching predicate
fun find_first_matching(arr, predicate) {
    let mut i = 0;

    while i < arr.len() {
        if predicate(arr[i]) {
            return i;
        }
        i = i + 1;
    }

    -1
}

// Example predicates
fun is_even(n) {
    n % 2 == 0
}

fun is_greater_than_50(n) {
    n > 50
}

let numbers = [11, 23, 35, 48, 52, 67];
find_first_matching(numbers, is_even);  // Returns 3 (48 is first even)
find_first_matching(numbers, is_greater_than_50);  // Returns 4 (52)
```

### Find All Matching Predicate

```ruchy
// Find all elements matching predicate
fun find_all_matching(arr, predicate) {
    let mut results = [];
    let mut i = 0;

    while i < arr.len() {
        if predicate(arr[i]) {
            results = results + [arr[i]];
        }
        i = i + 1;
    }

    results
}

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
let evens = find_all_matching(numbers, is_even);
// Returns [2, 4, 6, 8, 10]
```

## Searching in 2D Arrays

### Linear Search in 2D

```ruchy
// Search in 2D array (matrix)
fun search_2d(matrix, target) {
    let mut row = 0;

    while row < matrix.len() {
        let mut col = 0;
        while col < matrix[row].len() {
            if matrix[row][col] == target {
                return {row: row, col: col, found: true};
            }
            col = col + 1;
        }
        row = row + 1;
    }

    {row: -1, col: -1, found: false}
}

let matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
];

search_2d(matrix, 5);  // Returns {row: 1, col: 1, found: true}
```

### Search in Sorted 2D Array

```ruchy
// Search in row-wise and column-wise sorted matrix
fun search_sorted_2d(matrix, target) {
    if matrix.len() == 0 {
        return false;
    }

    let mut row = 0;
    let mut col = matrix[0].len() - 1;  // Start top-right

    while row < matrix.len() && col >= 0 {
        if matrix[row][col] == target {
            return true;
        } else if matrix[row][col] > target {
            col = col - 1;  // Move left
        } else {
            row = row + 1;  // Move down
        }
    }

    false
}

let sorted_matrix = [
    [1,  4,  7, 11],
    [2,  5,  8, 12],
    [3,  6,  9, 16],
    [10, 13, 14, 17]
];

search_sorted_2d(sorted_matrix, 5);  // true
```

## Special Search Problems

### Find Missing Number

Given array of n-1 numbers from 1 to n, find missing number.

```ruchy
// Find missing number using sum formula
fun find_missing(arr, n) {
    // Expected sum: 1 + 2 + ... + n = n*(n+1)/2
    let expected_sum = n * (n + 1) / 2;

    let mut actual_sum = 0;
    for num in arr {
        actual_sum = actual_sum + num;
    }

    expected_sum - actual_sum
}

let numbers = [1, 2, 4, 5, 6];  // Missing 3
find_missing(numbers, 6);  // Returns 3
```

### Find Duplicate Elements

```ruchy
// Find all duplicate elements
fun find_duplicates(arr) {
    let mut duplicates = [];
    let mut i = 0;

    while i < arr.len() {
        let mut j = i + 1;
        let mut is_duplicate = false;

        // Check if already in duplicates list
        for dup in duplicates {
            if dup == arr[i] {
                is_duplicate = true;
                break;
            }
        }

        if !is_duplicate {
            // Check if appears later in array
            while j < arr.len() {
                if arr[i] == arr[j] {
                    duplicates = duplicates + [arr[i]];
                    break;
                }
                j = j + 1;
            }
        }

        i = i + 1;
    }

    duplicates
}

let numbers = [1, 2, 3, 2, 4, 3, 5];
let dups = find_duplicates(numbers);
// Returns [2, 3]
```

### Find Peak Element

An element greater than its neighbors.

```ruchy
// Find a peak element (greater than neighbors)
fun find_peak(arr) {
    if arr.len() == 0 {
        return -1;
    }

    if arr.len() == 1 {
        return 0;
    }

    // Check first element
    if arr[0] > arr[1] {
        return 0;
    }

    // Check last element
    if arr[arr.len() - 1] > arr[arr.len() - 2] {
        return arr.len() - 1;
    }

    // Check middle elements
    let mut i = 1;
    while i < arr.len() - 1 {
        if arr[i] > arr[i - 1] && arr[i] > arr[i + 1] {
            return i;
        }
        i = i + 1;
    }

    -1
}

let numbers = [1, 3, 20, 4, 1, 0];
find_peak(numbers);  // Returns 2 (value 20)
```

## Performance Comparison

### Search Algorithm Comparison

| Algorithm | Time (Average) | Time (Worst) | Space | Requires Sorted |
|-----------|----------------|--------------|-------|-----------------|
| Linear Search | O(n) | O(n) | O(1) | No |
| Binary Search | O(log n) | O(log n) | O(1) | Yes |
| Jump Search | O(√n) | O(√n) | O(1) | Yes |
| Interpolation | O(log log n) | O(n) | O(1) | Yes, uniform |

### When to Use Each Algorithm

```ruchy
// Decision tree for choosing search algorithm
fun choose_search(size, is_sorted, changes_frequently) {
    if !is_sorted {
        "Linear Search"  // Only option for unsorted
    } else if size < 100 {
        "Linear Search"  // Small size, simplicity wins
    } else if changes_frequently {
        "Linear Search"  // Avoid re-sorting overhead
    } else if size < 10000 {
        "Binary Search"  // Best general-purpose
    } else {
        "Jump Search"    // Large arrays, cache-friendly
    }
}
```

## Practical Examples

### Example 1: Search in Address Book

```ruchy
// Search contacts by name
fun search_contact(contacts, name) {
    let mut i = 0;

    while i < contacts.len() {
        if contacts[i].name == name {
            return contacts[i];
        }
        i = i + 1;
    }

    {name: "", phone: "", found: false}
}

let contacts = [
    {name: "Alice", phone: "555-0100"},
    {name: "Bob", phone: "555-0200"},
    {name: "Charlie", phone: "555-0300"}
];

search_contact(contacts, "Bob");
// Returns {name: "Bob", phone: "555-0200"}
```

### Example 2: Finding Range of Target

```ruchy
// Find start and end indices of target
fun search_range(arr, target) {
    let mut start = -1;
    let mut end = -1;
    let mut i = 0;

    // Find first occurrence
    while i < arr.len() {
        if arr[i] == target {
            start = i;
            break;
        }
        i = i + 1;
    }

    if start == -1 {
        return {start: -1, end: -1};  // Not found
    }

    // Find last occurrence
    i = arr.len();
    while i > 0 {
        i = i - 1;
        if arr[i] == target {
            end = i;
            break;
        }
    }

    {start: start, end: end}
}

let numbers = [5, 7, 7, 8, 8, 8, 10];
search_range(numbers, 8);
// Returns {start: 3, end: 5}
```

### Example 3: Search with Fuzzy Match

```ruchy
// Find items that start with prefix
fun search_prefix(items, prefix) {
    fun starts_with(str, prefix) {
        if prefix.len() > str.len() {
            return false;
        }

        let mut i = 0;
        while i < prefix.len() {
            if str[i] != prefix[i] {
                return false;
            }
            i = i + 1;
        }

        true
    }

    let mut results = [];

    for item in items {
        if starts_with(item, prefix) {
            results = results + [item];
        }
    }

    results
}

let words = ["apple", "application", "apply", "banana", "append"];
search_prefix(words, "app");
// Returns ["apple", "application", "apply", "append"]
```

### Example 4: Binary Search in Real World

```ruchy
// Dictionary lookup using binary search
fun dictionary_lookup(dictionary, word) {
    let mut left = 0;
    let mut right = dictionary.len() - 1;

    while left <= right {
        let mid = left + (right - left) / 2;

        if dictionary[mid].word == word {
            return dictionary[mid].definition;
        } else if dictionary[mid].word < word {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    "Word not found"
}

let dictionary = [
    {word: "apple", definition: "A fruit"},
    {word: "banana", definition: "A yellow fruit"},
    {word: "cherry", definition: "A red fruit"}
];

dictionary_lookup(dictionary, "banana");
// Returns "A yellow fruit"
```

## Optimization Tips

### Early Exit Optimization

```ruchy
// Stop searching once condition is met
fun find_first_greater_than(arr, threshold) {
    for item in arr {
        if item > threshold {
            return item;  // Found, exit immediately
        }
    }
    -1
}
```

### Caching Search Results

```ruchy
// Simple cache for repeated searches
fun create_search_cache() {
    let mut cache = [];

    fun search_with_cache(arr, target) {
        // Check cache first
        for entry in cache {
            if entry.target == target {
                return entry.index;  // Cache hit
            }
        }

        // Search array
        let mut i = 0;
        while i < arr.len() {
            if arr[i] == target {
                // Add to cache
                cache = cache + [{target: target, index: i}];
                return i;
            }
            i = i + 1;
        }

        -1
    }

    search_with_cache
}
```

### Binary Search for Sorted Structs

```ruchy
// Binary search on struct field
fun binary_search_by_id(records, target_id) {
    let mut left = 0;
    let mut right = records.len() - 1;

    while left <= right {
        let mid = left + (right - left) / 2;

        if records[mid].id == target_id {
            return records[mid];
        } else if records[mid].id < target_id {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    {id: -1, name: "", found: false}
}
```

## Best Practices

1. **Check if sorted**: Binary search only works on sorted data

2. **Handle edge cases**:
   - Empty array
   - Single element
   - Target not in array
   - Duplicate elements

3. **Choose appropriate algorithm**:
   - Small/unsorted → Linear search
   - Large/sorted → Binary search
   - Many searches → Consider indexing

4. **Avoid integer overflow**: Use `left + (right - left) / 2` instead of `(left + right) / 2`

5. **Return consistent values**: -1 for "not found" is convention

6. **Document requirements**: Clearly state if array must be sorted

7. **Consider preprocessing**: Sorting once enables many fast binary searches

## Common Pitfalls

```ruchy
// PITFALL 1: Binary search on unsorted array
// Wrong:
let unsorted = [3, 1, 4, 1, 5];
binary_search(unsorted, 4);  // Wrong! Array not sorted

// Correct:
let sorted = [1, 1, 3, 4, 5];
binary_search(sorted, 4);  // Correct

// PITFALL 2: Off-by-one in binary search bounds
// Wrong:
while left < right {  // Missing =, may skip valid element
    ...
}

// Correct:
while left <= right {  // Include case where left == right
    ...
}

// PITFALL 3: Integer overflow (less common in Ruchy)
// Use: mid = left + (right - left) / 2
// Not: mid = (left + right) / 2

// PITFALL 4: Modifying array during search
// Don't change array while searching unless intended
```

## Summary

Searching is fundamental to programming. Key takeaways:

- **Linear Search**: O(n), works on any data, simple
- **Binary Search**: O(log n), requires sorted data, very fast
- **Jump Search**: O(√n), middle ground, cache-friendly
- **Variants**: First/last occurrence, insert position, rotated arrays
- **Special problems**: Missing numbers, duplicates, peaks
- **2D search**: Row/column strategies for matrices

Choose algorithm based on:
- Data size
- Whether data is sorted
- Frequency of searches
- Memory constraints
- Modification frequency

Understanding search algorithms enables efficient data retrieval and forms the foundation for more advanced data structures and algorithms!
