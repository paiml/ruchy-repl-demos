# 8.1 Statistical Analysis: Iris Dataset

**The "Hello World" of Data Science**

The Iris dataset, collected by botanist Edgar Anderson in 1936, remains the most famous introductory dataset in machine learning and statistics. With 150 flowers across 3 species and 4 measurements, it perfectly demonstrates fundamental data science concepts.

**Test Status:** ✅ Verified with Ruchy v3.194.0
**Test File:** `book/tests/test_ch08_01_iris_statistics.ruchy`
**Pattern Reference:** `demos/repl/08-data-science/transformations/03_groupby_aggregate.ruchy`

## What You'll Learn

- Basic statistical operations (mean, min, max) using manual calculations
- Species-specific analysis through manual grouping
- Feature engineering with derived metrics
- Simple classification rules
- Pattern discovery in biological data
- **Data Science Without DataFrame**: Manual array operations for statistics

## The Dataset

```ruchy
// Create the Iris dataset using array of structs (Ruchy native pattern)
// In production: Load from CSV and parse into structs

let iris_flowers = [
    {species: "setosa", sepal_length: 5.1, sepal_width: 3.5, petal_length: 1.4, petal_width: 0.2},
    {species: "setosa", sepal_length: 4.9, sepal_width: 3.0, petal_length: 1.4, petal_width: 0.2},
    {species: "setosa", sepal_length: 4.7, sepal_width: 3.2, petal_length: 1.3, petal_width: 0.2},
    {species: "versicolor", sepal_length: 7.0, sepal_width: 3.2, petal_length: 4.7, petal_width: 1.4},
    {species: "versicolor", sepal_length: 6.4, sepal_width: 3.2, petal_length: 4.5, petal_width: 1.5},
    {species: "versicolor", sepal_length: 6.9, sepal_width: 3.1, petal_length: 4.9, petal_width: 1.5},
    {species: "virginica", sepal_length: 6.3, sepal_width: 3.3, petal_length: 6.0, petal_width: 2.5},
    {species: "virginica", sepal_length: 5.8, sepal_width: 2.7, petal_length: 5.1, petal_width: 1.9},
    {species: "virginica", sepal_length: 7.1, sepal_width: 3.0, petal_length: 5.9, petal_width: 2.1}
];

println(f"Dataset loaded: {iris_flowers.len()} flower samples");
```

**Pattern**: Array of structs is the Ruchy-native way to work with structured data. Each flower is a struct with named fields.

## Basic Statistics

Computing fundamental statistics using manual calculations:

```ruchy
// Calculate mean, min, max for sepal length using manual operations
let mut total = 0.0;
let mut min_sepal = iris_flowers[0].sepal_length;
let mut max_sepal = iris_flowers[0].sepal_length;

for flower in iris_flowers {
    total = total + flower.sepal_length;

    if flower.sepal_length < min_sepal {
        min_sepal = flower.sepal_length;
    }
    if flower.sepal_length > max_sepal {
        max_sepal = flower.sepal_length;
    }
}

let avg_sepal = total / iris_flowers.len();

println("Sepal Length Statistics:");
println(f"  Average: {avg_sepal:.2} cm");
println(f"  Range: {min_sepal} - {max_sepal} cm");
```

**Expected Output:**
```
Sepal Length Statistics:
  Average: 6.02 cm
  Range: 4.7 - 7.1 cm
```

**Pattern**: Manual accumulation with for loops. This is the foundational pattern for all statistics in Ruchy.

## Species-Specific Analysis

Group data by species using manual grouping (Split-Apply-Combine pattern):

```ruchy
// Manual groupby: Split data into groups, apply aggregations, combine results
let mut setosa_total = 0.0;
let mut setosa_count = 0;
let mut versicolor_total = 0.0;
let mut versicolor_count = 0;
let mut virginica_total = 0.0;
let mut virginica_count = 0;

// Split and apply
for flower in iris_flowers {
    if flower.species == "setosa" {
        setosa_total = setosa_total + flower.sepal_length;
        setosa_count = setosa_count + 1;
    } else if flower.species == "versicolor" {
        versicolor_total = versicolor_total + flower.sepal_length;
        versicolor_count = versicolor_count + 1;
    } else if flower.species == "virginica" {
        virginica_total = virginica_total + flower.sepal_length;
        virginica_count = virginica_count + 1;
    }
}

// Combine: Calculate averages
let setosa_avg = setosa_total / setosa_count;
let versicolor_avg = versicolor_total / versicolor_count;
let virginica_avg = virginica_total / virginica_count;

println("Average sepal length by species:");
println(f"  Setosa:     {setosa_avg:.2} cm ({setosa_count} flowers)");
println(f"  Versicolor: {versicolor_avg:.2} cm ({versicolor_count} flowers)");
println(f"  Virginica:  {virginica_avg:.2} cm ({virginica_count} flowers)");
```

**Expected Output:**
```
Average sepal length by species:
  Setosa:     4.90 cm (3 flowers)
  Versicolor: 6.77 cm (3 flowers)
  Virginica:  6.40 cm (3 flowers)
```

**Pattern**: Manual groupby using if/else branches. This is the **Split-Apply-Combine** pattern implemented explicitly.

## Multi-field Analysis: Petal Length (Key Insight!)

Analyze petal length to discover the key discriminating feature:

```ruchy
// Analyze petal length by species - this reveals the classification key!
let mut setosa_petal_total = 0.0;
let mut setosa_petal_count = 0;
let mut versicolor_petal_total = 0.0;
let mut versicolor_petal_count = 0;
let mut virginica_petal_total = 0.0;
let mut virginica_petal_count = 0;

for flower in iris_flowers {
    if flower.species == "setosa" {
        setosa_petal_total = setosa_petal_total + flower.petal_length;
        setosa_petal_count = setosa_petal_count + 1;
    } else if flower.species == "versicolor" {
        versicolor_petal_total = versicolor_petal_total + flower.petal_length;
        versicolor_petal_count = versicolor_petal_count + 1;
    } else if flower.species == "virginica" {
        virginica_petal_total = virginica_petal_total + flower.petal_length;
        virginica_petal_count = virginica_petal_count + 1;
    }
}

let setosa_petal_avg = setosa_petal_total / setosa_petal_count;
let versicolor_petal_avg = versicolor_petal_total / versicolor_petal_count;
let virginica_petal_avg = virginica_petal_total / virginica_petal_count;

println("Average petal length by species:");
println(f"  Setosa:     {setosa_petal_avg:.2} cm");
println(f"  Versicolor: {versicolor_petal_avg:.2} cm");
println(f"  Virginica:  {virginica_petal_avg:.2} cm");
```

**Expected Output:**
```
Average petal length by species:
  Setosa:     1.37 cm
  Versicolor: 4.70 cm
  Virginica:  5.67 cm
```

**Key Insight:** Setosa has dramatically smaller petals (1.37cm vs 4.7cm+ for others) - this is the perfect discriminating feature!

## Feature Engineering

Create new derived features to gain insights:

```ruchy
// Calculate petal ratio for each flower (feature engineering)
let mut petal_ratios = [];

for flower in iris_flowers {
    let ratio = flower.petal_length / flower.petal_width;
    petal_ratios = petal_ratios + [ratio];
}

println(f"Petal ratios calculated: {petal_ratios.len()} values");
println(f"Sample ratios: {petal_ratios[0]:.1}, {petal_ratios[1]:.1}, {petal_ratios[2]:.1}");

// Calculate sepal ratio
let mut sepal_ratios = [];

for flower in iris_flowers {
    let ratio = flower.sepal_length / flower.sepal_width;
    sepal_ratios = sepal_ratios + [ratio];
}

println(f"Sepal ratios calculated: {sepal_ratios.len()} values");
```

**Pattern**: Create new arrays of derived values. Feature engineering helps reveal patterns.

## Pattern Discovery

Use conditional logic to discover biological patterns:

```ruchy
// Discover pattern: Large vs small petals
let mut large_petal_count = 0;
let mut small_petal_count = 0;
let mut large_petal_species = [];
let mut small_petal_species = [];

for flower in iris_flowers {
    if flower.petal_length > 4.0 {
        large_petal_count = large_petal_count + 1;
        large_petal_species = large_petal_species + [flower.species];
    } else {
        small_petal_count = small_petal_count + 1;
        small_petal_species = small_petal_species + [flower.species];
    }
}

println("Petal size pattern analysis:");
println(f"  Large petals (>4.0 cm): {large_petal_count} flowers");
println(f"  Small petals (≤4.0 cm): {small_petal_count} flowers");

// Check if all small petals are setosa
let mut all_setosa = true;
for species in small_petal_species {
    if species != "setosa" {
        all_setosa = false;
    }
}

if all_setosa {
    println("  Discovery: ALL small petal flowers are setosa!");
} else {
    println("  Discovery: Small petals found in multiple species");
}
```

**Expected Output:**
```
Petal size pattern analysis:
  Large petals (>4.0 cm): 6 flowers
  Small petals (≤4.0 cm): 3 flowers
  Discovery: ALL small petal flowers are setosa!
```

**Discovery:** All large petal flowers are versicolor or virginica - never setosa! This is a perfect classification rule.

## Simple Classification Rule

Build a simple classifier based on our insights:

```ruchy
// Classification rule: If petal_length > 2.5, then NOT setosa
println("Classification Rule: If petal_length > 2.5, then NOT setosa");

let mut correct = 0;
let mut total = 0;

for flower in iris_flowers {
    total = total + 1;

    // Predict
    let predicted_setosa = flower.petal_length <= 2.5;

    // Actual
    let actual_setosa = flower.species == "setosa";

    // Check if correct
    if predicted_setosa == actual_setosa {
        correct = correct + 1;
    }
}

let accuracy = (correct * 100) / total;

println(f"Classification accuracy: {accuracy}% ({correct}/{total})");
```

**Expected Output:**
```
Classification Rule: If petal_length > 2.5, then NOT setosa
Classification accuracy: 100% (9/9)
```

**Result:** 100% accuracy on this sample! Petal length perfectly separates setosa from other species.

## Complete Analysis Function

Putting it all together in a reusable pattern:

```ruchy
// Reusable function: Calculate statistics for any species
fun analyze_species(flowers, species_name) {
    let mut sepal_l_total = 0.0;
    let mut sepal_w_total = 0.0;
    let mut petal_l_total = 0.0;
    let mut petal_w_total = 0.0;
    let mut count = 0;

    for flower in flowers {
        if flower.species == species_name {
            sepal_l_total = sepal_l_total + flower.sepal_length;
            sepal_w_total = sepal_w_total + flower.sepal_width;
            petal_l_total = petal_l_total + flower.petal_length;
            petal_w_total = petal_w_total + flower.petal_width;
            count = count + 1;
        }
    }

    println(f"Species: {species_name} ({count} flowers)");
    println(f"  Sepal length avg: {sepal_l_total / count:.2} cm");
    println(f"  Sepal width avg:  {sepal_w_total / count:.2} cm");
    println(f"  Petal length avg: {petal_l_total / count:.2} cm");
    println(f"  Petal width avg:  {petal_w_total / count:.2} cm");
}

// Use it:
analyze_species(iris_flowers, "setosa");
analyze_species(iris_flowers, "versicolor");
analyze_species(iris_flowers, "virginica");
```

**Pattern**: Encapsulate repeated analysis logic in functions. This is the foundation for building a data science toolkit in Ruchy.

## Key Takeaways

1. **Setosa is distinct**: Dramatically smaller petals make it easily identifiable
2. **Simple rules work**: A single threshold (petal_length > 2.5) achieves perfect classification
3. **Feature engineering matters**: Ratios and categories reveal new patterns
4. **Statistics guide discovery**: Averages and ranges highlight species differences
5. **Manual operations work**: Ruchy's array operations and for loops are powerful enough for real data science

## Data Science Without DataFrame

This chapter demonstrates that **you don't need a DataFrame library** to do effective data science:

- **Arrays of structs** provide structured data
- **For loops** enable groupby operations (Split-Apply-Combine)
- **Conditional logic** enables filtering and pattern discovery
- **Manual calculations** for statistics are clear and explicit
- **Functions** encapsulate reusable analysis patterns

**Philosophy**: Explicit is better than magic. Understanding how statistics work builds better intuition than black-box library calls.

## Performance Notes

- **Dataset size**: This sample has 9 flowers. Full Iris dataset has 150.
- **Complexity**: All operations are O(n) - single pass through data
- **Memory**: Arrays of structs are memory-efficient
- **Scalability**: Pattern scales to thousands of records

For datasets with millions of records, consider:
- Parallel processing (Ruchy supports threading)
- Streaming calculations (process data in chunks)
- External tools (export to specialized systems)

## Next Steps

- Try the complete demo: `demos/repl/08-data-science/iris_analysis.ruchy`
- Explore [Titanic survival analysis](ch08-02-aggregation.md) for demographic patterns
- Learn about [correlation with wine quality](ch08-04-correlation.md)
- Study [manual groupby patterns](../../demos/repl/08-data-science/transformations/03_groupby_aggregate.ruchy)

## Exercises

1. **Extended Statistics**: Calculate standard deviation for each species
2. **Multiple Features**: Analyze sepal width by species
3. **Compound Rules**: Build classifier using both petal length AND petal width
4. **Feature Combinations**: Try petal_length * petal_width as discriminating feature
5. **Full Dataset**: Expand to all 150 Iris flowers and test classification accuracy

---

**Test File:** `book/tests/test_ch08_01_iris_statistics.ruchy` (10 tests, 30+ assertions)
**Pattern Reference:** `demos/repl/08-data-science/transformations/03_groupby_aggregate.ruchy`
**Version:** Verified with Ruchy v3.194.0

*Every code snippet is tested and verified working. Copy-paste directly into your Ruchy REPL or save as a .ruchy file.*
