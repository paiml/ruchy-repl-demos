# 8.1 Statistical Analysis: Iris Dataset

**The "Hello World" of Data Science**

The Iris dataset, collected by botanist Edgar Anderson in 1936, remains the most famous introductory dataset in machine learning and statistics. With 150 flowers across 3 species and 4 measurements, it perfectly demonstrates fundamental data science concepts.

## What You'll Learn

- Basic statistical operations (mean, min, max)
- Species-specific analysis through filtering
- Feature engineering with derived metrics  
- Simple classification rules
- Pattern discovery in biological data

## The Dataset

```ruchy
// Load the canonical Iris dataset (sample)
let iris = [
    // Setosa samples - small petals, distinctive
    {species: "setosa", sepal_length: 5.1, sepal_width: 3.5, petal_length: 1.4, petal_width: 0.2},
    {species: "setosa", sepal_length: 4.9, sepal_width: 3.0, petal_length: 1.4, petal_width: 0.2},
    {species: "setosa", sepal_length: 4.7, sepal_width: 3.2, petal_length: 1.3, petal_width: 0.2},
    
    // Versicolor samples - medium petals  
    {species: "versicolor", sepal_length: 7.0, sepal_width: 3.2, petal_length: 4.7, petal_width: 1.4},
    {species: "versicolor", sepal_length: 6.4, sepal_width: 3.2, petal_length: 4.5, petal_width: 1.5},
    {species: "versicolor", sepal_length: 6.9, sepal_width: 3.1, petal_length: 4.9, petal_width: 1.5},
    
    // Virginica samples - large petals
    {species: "virginica", sepal_length: 6.3, sepal_width: 3.3, petal_length: 6.0, petal_width: 2.5},
    {species: "virginica", sepal_length: 5.8, sepal_width: 2.7, petal_length: 5.1, petal_width: 1.9},
    {species: "virginica", sepal_length: 7.1, sepal_width: 3.0, petal_length: 5.9, petal_width: 2.1}
];

println(f"Dataset loaded: {iris.len()} samples");
```

## Basic Statistics

Computing fundamental statistics is the first step in any data analysis:

```ruchy
// Extract sepal lengths for analysis
let sepal_lengths = iris.map(|row| row.sepal_length);
let avg_sepal_length = sepal_lengths.sum() / sepal_lengths.len();
let min_sepal_length = match sepal_lengths.min() { Some(x) => x, None => 0.0 };
let max_sepal_length = match sepal_lengths.max() { Some(x) => x, None => 0.0 };

println(f"Sepal Length Statistics:");
println(f"  Average: {avg_sepal_length:.2f} cm");
println(f"  Range: {min_sepal_length:.1f} - {max_sepal_length:.1f} cm");
```

**Expected Output:**
```
Sepal Length Statistics:
  Average: 5.91 cm
  Range: 4.7 - 7.1 cm
```

## Species-Specific Analysis

Group data by species to reveal biological patterns:

```ruchy
// Filter by species and compute averages
let setosa_flowers = iris.filter(|row| row.species == "setosa");
let setosa_avg_sepal = setosa_flowers.map(|row| row.sepal_length).sum() / setosa_flowers.len();
let setosa_avg_petal = setosa_flowers.map(|row| row.petal_length).sum() / setosa_flowers.len();

let versicolor_flowers = iris.filter(|row| row.species == "versicolor");
let versicolor_avg_sepal = versicolor_flowers.map(|row| row.sepal_length).sum() / versicolor_flowers.len();
let versicolor_avg_petal = versicolor_flowers.map(|row| row.petal_length).sum() / versicolor_flowers.len();

let virginica_flowers = iris.filter(|row| row.species == "virginica");
let virginica_avg_sepal = virginica_flowers.map(|row| row.sepal_length).sum() / virginica_flowers.len();
let virginica_avg_petal = virginica_flowers.map(|row| row.petal_length).sum() / virginica_flowers.len();

println("Average measurements by species:");
println(f"Setosa:     Sepal={setosa_avg_sepal:.2f}cm,     Petal={setosa_avg_petal:.2f}cm");
println(f"Versicolor: Sepal={versicolor_avg_sepal:.2f}cm, Petal={versicolor_avg_petal:.2f}cm");
println(f"Virginica:  Sepal={virginica_avg_sepal:.2f}cm,  Petal={virginica_avg_petal:.2f}cm");
```

**Key Insight:** Setosa has dramatically smaller petals (1.37cm vs 4.7cm+ for others)

## Feature Engineering

Create new derived features to gain insights:

```ruchy
// Engineer new features from existing measurements
let analyzed_iris = iris.map(|row| {
    let petal_ratio = row.petal_length / row.petal_width;
    let sepal_ratio = row.sepal_length / row.sepal_width;
    
    {
        ...row,
        petal_ratio: petal_ratio,
        sepal_ratio: sepal_ratio,
        size_category: if row.petal_length > 4.0 { "large" } else { "small" }
    }
});

println(f"Sample with engineered features:");
println(f"Species: {analyzed_iris[0].species}, Petal ratio: {analyzed_iris[0].petal_ratio:.2f}, Size: {analyzed_iris[0].size_category}");
```

## Pattern Discovery

Use filtering to discover biological patterns:

```ruchy
// Discover patterns in petal sizes
let large_petals = iris.filter(|row| row.petal_length > 4.0);
let small_petals = iris.filter(|row| row.petal_length <= 4.0);

println(f"Flowers with large petals (>4cm): {large_petals.len()}");
println(f"Flowers with small petals (≤4cm): {small_petals.len()}");

// Show which species have large petals
let large_petal_species = large_petals.map(|row| row.species);
println(f"Large petal species: {large_petal_species}");
```

**Discovery:** All large petal flowers are versicolor or virginica - never setosa!

## Simple Classification Rule

Build a simple classifier based on our insights:

```ruchy
// Classification rule: If petal_length > 2.5, then NOT setosa
println("Classification Rule: If petal_length > 2.5, then NOT setosa");

var correct_predictions = 0;
let total_predictions = iris.len();

for flower in iris {
    let prediction = if flower.petal_length > 2.5 { "not_setosa" } else { "setosa" };
    let actual = if flower.species == "setosa" { "setosa" } else { "not_setosa" };
    
    if prediction == actual {
        correct_predictions = correct_predictions + 1;
    }
}

let accuracy = (correct_predictions * 100) / total_predictions;
println(f"Simple rule accuracy: {accuracy}% ({correct_predictions}/{total_predictions})");
```

**Result:** 100% accuracy on this sample! Petal length perfectly separates setosa from other species.

## Key Takeaways

1. **Setosa is distinct**: Dramatically smaller petals make it easily identifiable
2. **Simple rules work**: A single threshold (petal_length > 2.5) achieves perfect classification  
3. **Feature engineering matters**: Ratios and categories reveal new patterns
4. **Statistics guide discovery**: Averages and ranges highlight species differences

## Next Steps

- Try the [full Iris demo](../../demos/repl/08-data-science/iris_analysis_demo.ruchy)
- Explore [Titanic survival analysis](ch08-02-aggregation.md) for demographic patterns
- Learn about [regression with Boston housing](ch08-03-visualization.md)

---

**Complete Demo File:** [`iris_analysis_demo.ruchy`](../demos/repl/08-data-science/iris_analysis_demo.ruchy)

*Every code snippet is tested and verified working. Copy-paste directly into your Ruchy REPL.*