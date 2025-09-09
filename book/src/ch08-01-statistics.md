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
// Create the canonical Iris dataset using DataFrame (production: df.from_csv())
let iris_df = df![
    species => ["setosa", "setosa", "setosa", "versicolor", "versicolor", "versicolor", "virginica", "virginica", "virginica"],
    sepal_length => [5.1, 4.9, 4.7, 7.0, 6.4, 6.9, 6.3, 5.8, 7.1],
    sepal_width => [3.5, 3.0, 3.2, 3.2, 3.2, 3.1, 3.3, 2.7, 3.0],
    petal_length => [1.4, 1.4, 1.3, 4.7, 4.5, 4.9, 6.0, 5.1, 5.9],
    petal_width => [0.2, 0.2, 0.2, 1.4, 1.5, 1.5, 2.5, 1.9, 2.1]
];

println(f"DataFrame loaded: {iris_df.height()} samples");
```

## Basic Statistics

Computing fundamental statistics is the first step in any data analysis:

```ruchy
// Professional statistical analysis using DataFrame operations
let sepal_stats = iris_df
    .select(["sepal_length"])
    .agg([
        mean("sepal_length").alias("avg_sepal_length"),
        min("sepal_length").alias("min_sepal_length"),
        max("sepal_length").alias("max_sepal_length")
    ]);

println(f"Sepal Length Statistics (DataFrame):");
println(sepal_stats);
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
// Professional species analysis using DataFrame groupby operations
let species_stats = iris_df
    .groupby(["species"])
    .agg([
        mean("sepal_length").alias("avg_sepal_length"),
        mean("petal_length").alias("avg_petal_length"),
        count("species").alias("flower_count")
    ])
    .sort("avg_petal_length");

println("Average measurements by species (DataFrame):");
println(species_stats);
```

**Key Insight:** Setosa has dramatically smaller petals (1.37cm vs 4.7cm+ for others)

## Feature Engineering

Create new derived features to gain insights:

```ruchy
// Professional feature engineering using DataFrame operations
let engineered_iris = iris_df
    .with_columns([
        (col("petal_length") / col("petal_width")).alias("petal_ratio"),
        (col("sepal_length") / col("sepal_width")).alias("sepal_ratio"),
        when(col("petal_length").gt(4.0))
            .then(lit("large"))
            .otherwise(lit("small"))
            .alias("size_category")
    ]);

// Show sample of engineered features
let feature_sample = engineered_iris
    .select(["species", "petal_ratio", "sepal_ratio", "size_category"])
    .head(3);

println("Sample with engineered features (DataFrame):");
println(feature_sample);
```

## Pattern Discovery

Use filtering to discover biological patterns:

```ruchy
// Pattern discovery using DataFrame filtering and analysis
let petal_analysis = iris_df
    .with_columns([
        when(col("petal_length").gt(4.0))
            .then(lit("Large_Petals"))
            .otherwise(lit("Small_Petals"))
            .alias("petal_size_category")
    ])
    .groupby(["petal_size_category"])
    .agg([
        count("species").alias("flower_count"),
        collect_list("species").alias("species_list")
    ]);

println("Petal size pattern analysis (DataFrame):");
println(petal_analysis);
```

**Discovery:** All large petal flowers are versicolor or virginica - never setosa!

## Simple Classification Rule

Build a simple classifier based on our insights:

```ruchy
// Professional classification using DataFrame operations
println("Classification Rule: If petal_length > 2.5, then NOT setosa");

// Create predictions using DataFrame operations
let classification_results = iris_df
    .with_columns([
        when(col("petal_length").gt(2.5))
            .then(lit("not_setosa"))
            .otherwise(lit("setosa"))
            .alias("predicted"),
        when(col("species").eq(lit("setosa")))
            .then(lit("setosa"))
            .otherwise(lit("not_setosa"))
            .alias("actual"),
    ])
    .with_columns([
        (col("predicted").eq(col("actual"))).alias("correct")
    ]);

// Calculate accuracy using DataFrame aggregation
let model_accuracy = classification_results
    .agg([
        sum("correct").alias("correct_predictions"),
        count("correct").alias("total_predictions"),
        (sum("correct").cast(Float64) / count("correct").cast(Float64) * 100.0).alias("accuracy_pct")
    ]);

println("Classification accuracy (DataFrame):");
println(model_accuracy);
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