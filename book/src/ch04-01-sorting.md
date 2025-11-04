# Chapter 4.1: Sorting Algorithms

Sorting is one of the most fundamental operations in computer science. It arranges elements in a specific order (usually ascending or descending), enabling efficient searching, data analysis, and organization. This chapter explores classic sorting algorithms, their implementation in Ruchy, and when to use each one.

## Why Sorting Matters

Sorted data enables:
- **Fast searching**: Binary search requires sorted data (O(log n) vs O(n))
- **Data analysis**: Finding medians, quartiles, and outliers
- **Optimization**: Many algorithms work better on sorted input
- **User interfaces**: Displaying data in meaningful order
- **Database operations**: Efficient joins and indexing

## Understanding Sorting

### Sorting Characteristics

1. **Time Complexity**: How long the algorithm takes relative to input size
2. **Space Complexity**: Additional memory required beyond input array
3. **Stability**: Whether equal elements maintain their relative order
4. **Adaptivity**: Whether algorithm performs better on partially sorted input
5. **In-place**: Whether sorting happens within the original array

### Comparison-Based Sorting

Most sorting algorithms work by comparing elements:
```ruchy
if arr[i] > arr[j] {
    // Swap or rearrange
}
```

The minimum time complexity for comparison-based sorting is **O(n log n)**.

## Simple Sorting Algorithms

### Bubble Sort

Repeatedly steps through the array, comparing adjacent elements and swapping them if they're in the wrong order.

```ruchy
// Bubble Sort - O(n²) time, O(1) space
fun bubble_sort(arr) {
    let mut sorted = arr;
    let mut changed = true;

    while changed {
        changed = false;
        let mut i = 0;

        while i < sorted.len() - 1 {
            if sorted[i] > sorted[i + 1] {
                // Swap adjacent elements
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                changed = true;
            }
            i = i + 1;
        }
    }

    sorted
}

let numbers = [64, 34, 25, 12, 22, 11, 90];
let sorted = bubble_sort(numbers);
// Result: [11, 12, 22, 25, 34, 64, 90]
```

**How it works:**
1. Compare each pair of adjacent elements
2. Swap if they're in wrong order
3. Repeat until no swaps needed
4. Largest element "bubbles up" to end each pass

**Characteristics:**
- **Time**: O(n²) average and worst case, O(n) best case (already sorted)
- **Space**: O(1) - sorts in place
- **Stable**: Yes - equal elements maintain order
- **Adaptive**: Yes - optimized version detects sorted arrays

**When to use:**
- Small datasets (< 10 elements)
- Educational purposes
- Nearly sorted data
- Simplicity is priority

### Selection Sort

Finds the minimum element and places it at the beginning, then repeats for the remaining array.

```ruchy
// Selection Sort - O(n²) time, O(1) space
fun selection_sort(arr) {
    let mut sorted = arr;
    let mut i = 0;

    while i < sorted.len() {
        // Find minimum in remaining array
        let mut min_idx = i;
        let mut j = i + 1;

        while j < sorted.len() {
            if sorted[j] < sorted[min_idx] {
                min_idx = j;
            }
            j = j + 1;
        }

        // Swap minimum with current position
        if min_idx != i {
            let temp = sorted[i];
            sorted[i] = sorted[min_idx];
            sorted[min_idx] = temp;
        }

        i = i + 1;
    }

    sorted
}

let numbers = [64, 25, 12, 22, 11];
let sorted = selection_sort(numbers);
// Result: [11, 12, 22, 25, 64]
```

**How it works:**
1. Find the minimum element in unsorted portion
2. Swap it with the first unsorted element
3. Move boundary between sorted and unsorted portions
4. Repeat until entire array is sorted

**Characteristics:**
- **Time**: O(n²) in all cases (always scans remaining array)
- **Space**: O(1) - sorts in place
- **Stable**: No - relative order of equal elements may change
- **Adaptive**: No - doesn't benefit from partial sorting

**When to use:**
- Minimizing number of swaps is important
- Small datasets
- Memory writes are expensive (makes only n swaps)

### Insertion Sort

Builds sorted array one element at a time by inserting each element into its correct position.

```ruchy
// Insertion Sort - O(n²) time, O(1) space
fun insertion_sort(arr) {
    let mut sorted = arr;
    let mut i = 1;

    while i < sorted.len() {
        let key = sorted[i];
        let mut j = i - 1;

        // Shift elements greater than key to the right
        while j >= 0 && sorted[j] > key {
            sorted[j + 1] = sorted[j];
            j = j - 1;
        }

        // Insert key at correct position
        sorted[j + 1] = key;
        i = i + 1;
    }

    sorted
}

let numbers = [12, 11, 13, 5, 6];
let sorted = insertion_sort(numbers);
// Result: [5, 6, 11, 12, 13]
```

**How it works:**
1. Start with second element (first is "sorted")
2. Compare with elements in sorted portion
3. Shift larger elements to the right
4. Insert current element at correct position
5. Repeat for all elements

**Characteristics:**
- **Time**: O(n²) worst case, O(n) best case (sorted)
- **Space**: O(1) - sorts in place
- **Stable**: Yes - maintains relative order
- **Adaptive**: Yes - very fast on nearly sorted data

**When to use:**
- Small datasets (< 50 elements)
- Nearly sorted data (O(n) performance)
- Online sorting (elements arrive one at a time)
- Stable sort is required

## Efficient Sorting Algorithms

### Merge Sort

Divide-and-conquer algorithm that splits array into halves, sorts them recursively, and merges results.

```ruchy
// Merge two sorted arrays
fun merge(left, right) {
    let mut result = [];
    let mut i = 0;
    let mut j = 0;

    // Merge while both have elements
    while i < left.len() && j < right.len() {
        if left[i] <= right[j] {
            result = result + [left[i]];
            i = i + 1;
        } else {
            result = result + [right[j]];
            j = j + 1;
        }
    }

    // Add remaining elements from left
    while i < left.len() {
        result = result + [left[i]];
        i = i + 1;
    }

    // Add remaining elements from right
    while j < right.len() {
        result = result + [right[j]];
        j = j + 1;
    }

    result
}

// Merge Sort - O(n log n) time, O(n) space
fun merge_sort(arr) {
    // Base case: arrays of 0 or 1 element are sorted
    if arr.len() <= 1 {
        return arr;
    }

    // Split array in half
    let mid = arr.len() / 2;
    let mut left = [];
    let mut right = [];
    let mut i = 0;

    while i < mid {
        left = left + [arr[i]];
        i = i + 1;
    }

    while i < arr.len() {
        right = right + [arr[i]];
        i = i + 1;
    }

    // Recursively sort both halves
    let sorted_left = merge_sort(left);
    let sorted_right = merge_sort(right);

    // Merge sorted halves
    merge(sorted_left, sorted_right)
}

let numbers = [38, 27, 43, 3, 9, 82, 10];
let sorted = merge_sort(numbers);
// Result: [3, 9, 10, 27, 38, 43, 82]
```

**How it works:**
1. Divide array into two halves
2. Recursively sort each half
3. Merge the two sorted halves
4. Base case: single element is already sorted

**Characteristics:**
- **Time**: O(n log n) in all cases (consistent performance)
- **Space**: O(n) - requires temporary arrays for merging
- **Stable**: Yes - maintains relative order
- **Adaptive**: No - always performs same number of operations

**When to use:**
- Large datasets
- Stable sort is required
- Consistent performance needed (no worst case)
- Linked lists (very efficient)

### Quick Sort

Divide-and-conquer algorithm that picks a pivot and partitions array around it.

```ruchy
// Partition array around pivot
fun partition(arr, low, high) {
    let pivot = arr[high];  // Choose last element as pivot
    let mut i = low - 1;    // Index of smaller element
    let mut result = arr;
    let mut j = low;

    while j < high {
        // If current element is smaller than pivot
        if result[j] < pivot {
            i = i + 1;
            // Swap arr[i] and arr[j]
            let temp = result[i];
            result[i] = result[j];
            result[j] = temp;
        }
        j = j + 1;
    }

    // Swap pivot to correct position
    let temp = result[i + 1];
    result[i + 1] = result[high];
    result[high] = temp;

    {arr: result, pivot_idx: i + 1}
}

// Quick Sort helper with range
fun quick_sort_range(arr, low, high) {
    if low < high {
        // Partition and get pivot index
        let part = partition(arr, low, high);
        let sorted = part.arr;
        let pi = part.pivot_idx;

        // Recursively sort elements before and after partition
        let left_sorted = quick_sort_range(sorted, low, pi - 1);
        let right_sorted = quick_sort_range(left_sorted, pi + 1, high);

        right_sorted
    } else {
        arr
    }
}

// Quick Sort - O(n log n) average, O(n²) worst
fun quick_sort(arr) {
    if arr.len() <= 1 {
        return arr;
    }
    quick_sort_range(arr, 0, arr.len() - 1)
}

let numbers = [10, 7, 8, 9, 1, 5];
let sorted = quick_sort(numbers);
// Result: [1, 5, 7, 8, 9, 10]
```

**How it works:**
1. Choose a pivot element
2. Partition array: elements < pivot on left, > pivot on right
3. Recursively sort left and right partitions
4. Pivot is now in its final position

**Characteristics:**
- **Time**: O(n log n) average, O(n²) worst case (already sorted with bad pivot)
- **Space**: O(log n) for recursion stack
- **Stable**: No - relative order may change
- **Adaptive**: Can be optimized for partially sorted data

**When to use:**
- Large datasets
- Average case performance is priority
- In-place sorting with minimal space
- General-purpose sorting

## Specialized Sorting

### Counting Sort

Non-comparison based sort for integers in a known range. Counts occurrences of each value.

```ruchy
// Counting Sort - O(n + k) where k is range
fun counting_sort(arr, max_val) {
    // Initialize count array
    let mut counts = [];
    let mut i = 0;
    while i <= max_val {
        counts = counts + [0];
        i = i + 1;
    }

    // Count occurrences
    for num in arr {
        counts[num] = counts[num] + 1;
    }

    // Build sorted array from counts
    let mut sorted = [];
    let mut i = 0;
    while i <= max_val {
        let mut j = 0;
        while j < counts[i] {
            sorted = sorted + [i];
            j = j + 1;
        }
        i = i + 1;
    }

    sorted
}

let numbers = [4, 2, 2, 8, 3, 3, 1];
let sorted = counting_sort(numbers, 10);
// Result: [1, 2, 2, 3, 3, 4, 8]
```

**Characteristics:**
- **Time**: O(n + k) where k is the range of input
- **Space**: O(k) for count array
- **Stable**: Can be implemented stably
- **Not comparison-based**: Breaks O(n log n) lower bound

**When to use:**
- Small range of integers
- Many duplicate values
- Linear time is required

### Three-Way Partitioning (Dutch Flag)

Partitions array into three sections: less than, equal to, and greater than a pivot.

```ruchy
// Three-way partition around pivot
fun partition_three_way(arr, pivot) {
    let mut low = [];    // Elements < pivot
    let mut equal = [];  // Elements = pivot
    let mut high = [];   // Elements > pivot

    for num in arr {
        if num < pivot {
            low = low + [num];
        } else if num == pivot {
            equal = equal + [num];
        } else {
            high = high + [num];
        }
    }

    // Concatenate three partitions
    low + equal + high
}

let numbers = [5, 2, 8, 5, 1, 5, 9, 3];
let partitioned = partition_three_way(numbers, 5);
// Result: [2, 1, 3, 5, 5, 5, 8, 9]
//         |< 5 ->|  |= 5|  |>5|
```

**When to use:**
- Many duplicate values
- Need to partition around a value
- Quick sort optimization

## Custom Sorting

### Sorting in Descending Order

```ruchy
// Sort in descending order (largest first)
fun bubble_sort_desc(arr) {
    let mut sorted = arr;
    let mut changed = true;

    while changed {
        changed = false;
        let mut i = 0;
        while i < sorted.len() - 1 {
            // Reversed comparison: swap if current < next
            if sorted[i] < sorted[i + 1] {
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                changed = true;
            }
            i = i + 1;
        }
    }

    sorted
}

let numbers = [5, 2, 8, 1, 9];
let sorted = bubble_sort_desc(numbers);
// Result: [9, 8, 5, 2, 1]
```

### Sorting Structs by Field

```ruchy
// Sort people by age
fun sort_by_age(people) {
    let mut sorted = people;
    let mut changed = true;

    while changed {
        changed = false;
        let mut i = 0;
        while i < sorted.len() - 1 {
            // Compare age field
            if sorted[i].age > sorted[i + 1].age {
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                changed = true;
            }
            i = i + 1;
        }
    }

    sorted
}

let people = [
    {name: "Alice", age: 30},
    {name: "Bob", age: 25},
    {name: "Charlie", age: 35}
];

let sorted = sort_by_age(people);
// Result: Bob (25), Alice (30), Charlie (35)
```

### Multi-Level Sorting

```ruchy
// Sort by age, then by name if ages are equal
fun sort_by_age_then_name(people) {
    let mut sorted = people;
    let mut changed = true;

    while changed {
        changed = false;
        let mut i = 0;
        while i < sorted.len() - 1 {
            let should_swap = sorted[i].age > sorted[i + 1].age ||
                             (sorted[i].age == sorted[i + 1].age &&
                              sorted[i].name > sorted[i + 1].name);

            if should_swap {
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                changed = true;
            }
            i = i + 1;
        }
    }

    sorted
}
```

## Sorting Utilities

### Checking if Array is Sorted

```ruchy
// Check if array is sorted in ascending order
fun is_sorted(arr) {
    let mut i = 0;
    while i < arr.len() - 1 {
        if arr[i] > arr[i + 1] {
            return false;
        }
        i = i + 1;
    }
    true
}

is_sorted([1, 2, 3, 4, 5]);  // true
is_sorted([1, 3, 2, 4]);     // false
is_sorted([5]);              // true
is_sorted([]);               // true
```

### Reversing an Array

```ruchy
// Reverse array elements
fun reverse_array(arr) {
    let mut reversed = [];
    let mut i = arr.len();

    while i > 0 {
        i = i - 1;
        reversed = reversed + [arr[i]];
    }

    reversed
}

let sorted = [1, 2, 3, 4, 5];
let desc = reverse_array(sorted);
// Result: [5, 4, 3, 2, 1]
```

### Finding Top K Elements

```ruchy
// Get the k smallest elements
fun top_k(arr, k) {
    // Sort the array
    let mut sorted = arr;
    let mut changed = true;

    while changed {
        changed = false;
        let mut i = 0;
        while i < sorted.len() - 1 {
            if sorted[i] > sorted[i + 1] {
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                changed = true;
            }
            i = i + 1;
        }
    }

    // Take first k elements
    let mut result = [];
    let mut i = 0;
    while i < k && i < sorted.len() {
        result = result + [sorted[i]];
        i = i + 1;
    }

    result
}

let numbers = [7, 10, 4, 3, 20, 15];
let top3 = top_k(numbers, 3);
// Result: [3, 4, 7]
```

### Finding Median

```ruchy
// Find median of array (middle value when sorted)
fun find_median(arr) {
    // Sort the array
    let mut sorted = arr;
    let mut changed = true;

    while changed {
        changed = false;
        let mut i = 0;
        while i < sorted.len() - 1 {
            if sorted[i] > sorted[i + 1] {
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                changed = true;
            }
            i = i + 1;
        }
    }

    // Find median
    let mid = sorted.len() / 2;

    if sorted.len() % 2 == 0 {
        // Even: average of two middle elements
        (sorted[mid - 1] + sorted[mid]) / 2
    } else {
        // Odd: middle element
        sorted[mid]
    }
}

find_median([7, 3, 5, 1, 9]);  // 5
find_median([7, 3, 5, 1]);     // 4 (average of 3 and 5)
```

## Performance Analysis

### Time Complexity Comparison

| Algorithm | Best | Average | Worst | Space |
|-----------|------|---------|-------|-------|
| Bubble Sort | O(n) | O(n²) | O(n²) | O(1) |
| Selection Sort | O(n²) | O(n²) | O(n²) | O(1) |
| Insertion Sort | O(n) | O(n²) | O(n²) | O(1) |
| Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) |
| Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) |
| Counting Sort | O(n + k) | O(n + k) | O(n + k) | O(k) |

### Stability Comparison

**Stable Sorts** (preserve relative order of equal elements):
- Bubble Sort ✓
- Insertion Sort ✓
- Merge Sort ✓
- Counting Sort ✓ (with care)

**Unstable Sorts** (may change relative order):
- Selection Sort ✗
- Quick Sort ✗ (standard implementation)

### When to Use Each Algorithm

```ruchy
// Decision tree for choosing sort algorithm

fun choose_sort(size, range_known, need_stable, memory_constrained) {
    if size < 10 {
        "Insertion Sort"  // Fast for tiny arrays
    } else if range_known && memory_constrained == false {
        "Counting Sort"   // Linear time for integers
    } else if need_stable {
        "Merge Sort"      // Stable O(n log n)
    } else if memory_constrained {
        "Quick Sort"      // In-place O(n log n) average
    } else {
        "Merge Sort"      // Consistent O(n log n)
    }
}
```

## Practical Examples

### Example 1: Sorting Student Records

```ruchy
// Sort students by grade (descending), then name (ascending)
fun sort_students(students) {
    let mut sorted = students;
    let mut changed = true;

    while changed {
        changed = false;
        let mut i = 0;
        while i < sorted.len() - 1 {
            let should_swap = sorted[i].grade < sorted[i + 1].grade ||
                             (sorted[i].grade == sorted[i + 1].grade &&
                              sorted[i].name > sorted[i + 1].name);

            if should_swap {
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                changed = true;
            }
            i = i + 1;
        }
    }

    sorted
}

let students = [
    {name: "Alice", grade: 90},
    {name: "Bob", grade: 85},
    {name: "Charlie", grade: 90},
    {name: "David", grade: 95}
];

let sorted = sort_students(students);
// Result: David (95), Alice (90), Charlie (90), Bob (85)
```

### Example 2: Finding Closest Pair

```ruchy
// Find pair of numbers with smallest difference
fun find_closest_pair(arr) {
    // Sort the array
    let mut sorted = arr;
    let mut changed = true;

    while changed {
        changed = false;
        let mut i = 0;
        while i < sorted.len() - 1 {
            if sorted[i] > sorted[i + 1] {
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                changed = true;
            }
            i = i + 1;
        }
    }

    // Find minimum difference between adjacent elements
    let mut min_diff = sorted[1] - sorted[0];
    let mut pair = {first: sorted[0], second: sorted[1]};
    let mut i = 1;

    while i < sorted.len() - 1 {
        let diff = sorted[i + 1] - sorted[i];
        if diff < min_diff {
            min_diff = diff;
            pair = {first: sorted[i], second: sorted[i + 1]};
        }
        i = i + 1;
    }

    pair
}

let numbers = [10, 22, 28, 29, 30, 40];
let closest = find_closest_pair(numbers);
// Result: {first: 28, second: 29} (difference of 1)
```

### Example 3: Merging Sorted Arrays

```ruchy
// Merge two already-sorted arrays efficiently
fun merge_sorted_arrays(arr1, arr2) {
    let mut result = [];
    let mut i = 0;
    let mut j = 0;

    // Merge while both have elements
    while i < arr1.len() && j < arr2.len() {
        if arr1[i] <= arr2[j] {
            result = result + [arr1[i]];
            i = i + 1;
        } else {
            result = result + [arr2[j]];
            j = j + 1;
        }
    }

    // Add remaining elements
    while i < arr1.len() {
        result = result + [arr1[i]];
        i = i + 1;
    }

    while j < arr2.len() {
        result = result + [arr2[j]];
        j = j + 1;
    }

    result
}

let sorted1 = [1, 3, 5, 7];
let sorted2 = [2, 4, 6, 8];
let merged = merge_sorted_arrays(sorted1, sorted2);
// Result: [1, 2, 3, 4, 5, 6, 7, 8]
```

## Optimization Techniques

### Early Termination

```ruchy
// Bubble sort with early termination
fun bubble_sort_optimized(arr) {
    let mut sorted = arr;
    let mut changed = true;

    while changed {
        changed = false;
        let mut i = 0;
        while i < sorted.len() - 1 {
            if sorted[i] > sorted[i + 1] {
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                changed = true;
            }
            i = i + 1;
        }
    }

    sorted
}

// If no swaps occur in a pass, array is sorted
// Best case: O(n) for already sorted arrays
```

### Reducing Comparison Range

```ruchy
// Bubble sort optimization: reduce range each pass
fun bubble_sort_range_optimized(arr) {
    let mut sorted = arr;
    let mut end = sorted.len() - 1;

    while end > 0 {
        let mut new_end = 0;
        let mut i = 0;

        while i < end {
            if sorted[i] > sorted[i + 1] {
                let temp = sorted[i];
                sorted[i] = sorted[i + 1];
                sorted[i + 1] = temp;
                new_end = i;  // Last swap position
            }
            i = i + 1;
        }

        end = new_end;  // Elements after this are sorted
    }

    sorted
}
```

### Hybrid Approaches

```ruchy
// Use insertion sort for small subarrays in merge sort
fun merge_sort_hybrid(arr, threshold) {
    if arr.len() <= threshold {
        return insertion_sort(arr);  // Use insertion for small arrays
    }

    // Standard merge sort for larger arrays
    let mid = arr.len() / 2;
    let mut left = [];
    let mut right = [];
    let mut i = 0;

    while i < mid {
        left = left + [arr[i]];
        i = i + 1;
    }

    while i < arr.len() {
        right = right + [arr[i]];
        i = i + 1;
    }

    let sorted_left = merge_sort_hybrid(left, threshold);
    let sorted_right = merge_sort_hybrid(right, threshold);

    merge(sorted_left, sorted_right)
}
```

## Best Practices

1. **Choose appropriate algorithm**: Consider data size, range, and constraints

2. **Test with edge cases**:
   - Empty array
   - Single element
   - Already sorted
   - Reverse sorted
   - All duplicates

3. **Consider stability**: Use stable sorts when order of equal elements matters

4. **Optimize for common case**: Use insertion sort for small arrays, quick sort for random data

5. **Handle duplicates efficiently**: Three-way partitioning for many duplicates

6. **Validate input**: Check for null, empty, or invalid data

7. **Measure performance**: Profile with real data to choose best algorithm

## Common Pitfalls

```ruchy
// PITFALL 1: Off-by-one errors
// Wrong:
while i < arr.len() {  // Will access arr[len] - out of bounds!
    if arr[i] > arr[i + 1] { ... }
}

// Correct:
while i < arr.len() - 1 {  // Stops before last element
    if arr[i] > arr[i + 1] { ... }
}

// PITFALL 2: Not handling equal elements in stable sorts
// Ensure equal elements maintain order

// PITFALL 3: Infinite loops in bubble sort
// Always include termination condition
let mut changed = true;
while changed {  // Must set changed = false each iteration
    changed = false;
    // ... sorting logic
}
```

## Summary

Sorting is a fundamental operation with many algorithms, each with different trade-offs:

- **Bubble, Selection, Insertion Sort**: Simple O(n²) algorithms for small data
- **Merge Sort**: Stable O(n log n) with O(n) space, consistent performance
- **Quick Sort**: O(n log n) average, in-place, fast in practice
- **Counting Sort**: O(n + k) for integers in known range
- **Stability**: Important when equal elements must maintain order
- **Custom sorting**: Sort by any field or custom comparison
- **Utilities**: Check sorted, reverse, find median, top K

Choose the right algorithm based on:
- Data size
- Memory constraints
- Stability requirements
- Expected data distribution
- Performance requirements

Sorting enables efficient searching, data analysis, and many other algorithms!
