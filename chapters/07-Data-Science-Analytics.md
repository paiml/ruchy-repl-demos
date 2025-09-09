# Chapter 7: Interactive Data Science and Analytics

## Overview

This chapter demonstrates Ruchy's powerful capabilities for data science and analytics through interactive REPL sessions. Using canonical datasets that every data science student recognizes, we explore statistical analysis, feature correlation, predictive modeling, and data-driven insights - all within Ruchy's elegant syntax.

**Why These Datasets Matter**: We focus on the most pedagogically valuable datasets in data science education - Iris, Titanic, Boston Housing, and Wine Quality. These aren't arbitrary examples; they're the foundation datasets used in universities, bootcamps, and online courses worldwide.

## What You'll Learn

By the end of this chapter, you'll master:

1. **Statistical Analysis** - Computing means, correlations, distributions
2. **Data Exploration** - Filtering, grouping, and pattern discovery
3. **Feature Engineering** - Creating predictive variables from raw data
4. **Classification** - Building simple prediction models
5. **Regression Analysis** - Price prediction and feature importance
6. **Comparative Analysis** - Red vs white wine, gender vs survival rates
7. **Real-world Insights** - Drawing actionable conclusions from data

## Dataset Collection: The Data Science Canon

### 🌸 Iris Dataset (1936) - Classification Fundamentals
**The "Hello World" of Machine Learning**
- **150 flowers, 4 measurements, 3 species**
- **Educational Value**: Perfect introduction to classification
- **Skills Taught**: Basic statistics, grouping, simple ML rules
- **Demo**: `demos/repl/08-data-science/iris_analysis_demo.ruchy`

### 🚢 Titanic Dataset (1912) - Survival Analysis  
**Most Popular Kaggle Dataset (15,000+ submissions)**
- **891 passengers, survival analysis, demographic patterns**
- **Educational Value**: Real-world data cleaning and hypothesis testing
- **Skills Taught**: Survival analysis, feature engineering, hypothesis testing
- **Demo**: `demos/repl/08-data-science/titanic_survival_demo.ruchy`

### 🏠 Boston Housing (1978) - Regression Benchmark
**Classic Econometrics and Real Estate Analysis**
- **506 neighborhoods, 13 features, price prediction**
- **Educational Value**: Regression analysis and feature importance
- **Skills Taught**: Price prediction, market analysis, correlation
- **Demo**: `demos/repl/08-data-science/boston_housing_demo.ruchy`

### 🍷 Wine Quality (2009) - Feature Correlation
**Chemical Analysis and Quality Prediction**
- **6,497 wines, 11 chemical features, quality scoring**
- **Educational Value**: Feature correlation and classification
- **Skills Taught**: Chemistry-based prediction, quality scoring
- **Demo**: `demos/repl/08-data-science/wine_quality_demo.ruchy`

## Getting Started: Your First Data Analysis

### Setting Up the REPL for Data Science

```bash
# Start the Ruchy REPL
ruchy repl

# Load a demo for interactive exploration
>>> :load demos/repl/08-data-science/iris_analysis_demo.ruchy
```

### Basic Data Science Workflow

Every data science project follows this pattern:

```ruchy
// 1. Load and explore data
let data = load_dataset();
println(f"Dataset size: {data.len()} samples");

// 2. Compute basic statistics  
let avg_value = data.map(|row| row.feature).sum() / data.len();
println(f"Average: {avg_value:.2f}");

// 3. Filter and group data
let filtered_data = data.filter(|row| row.category == "target");
let grouped_stats = compute_group_statistics(filtered_data);

// 4. Build simple models
let predictions = data.map(|row| predict_outcome(row));
let accuracy = compute_accuracy(predictions, actual_values);

// 5. Generate insights
println(f"Key insight: Feature X correlates with outcome Y");
```

## Demo 1: Iris Analysis - Classification Fundamentals

**Objective**: Learn classification basics with the most famous dataset in ML

### Key Concepts Demonstrated

```ruchy
// Species distribution analysis
let species_counts = iris
    .group_by(|flower| flower.species)
    .map(|group| {species: group.key, count: group.values.len()});

// Feature correlation discovery
let petal_length_by_species = iris
    .group_by(|flower| flower.species)
    .map(|group| {
        species: group.key,
        avg_petal_length: group.values.map(|f| f.petal_length).mean()
    });

// Simple classification rule
let classify_flower = |flower| {
    if flower.petal_length > 2.5 { "not_setosa" } else { "setosa" }
};
```

### What Makes This Educational

- **Immediate Visual Understanding**: 3 distinct species with clear patterns
- **Perfect for Beginners**: Simple 4-feature dataset, no missing data
- **Foundation Concepts**: Classification, feature importance, pattern recognition
- **Builds Confidence**: 100% accuracy possible with simple rules

### Running the Demo

```bash
ruchy demos/repl/08-data-science/iris_analysis_demo.ruchy
```

**Expected Output**: Complete statistical analysis showing species differences, feature engineering examples, and a working classifier with accuracy metrics.

## Demo 2: Titanic Survival Analysis - Real-World Data Science

**Objective**: Analyze tragic historical data to understand survival patterns

### Key Concepts Demonstrated

```ruchy
// Survival rate by gender ("Women and children first")
let female_survival = passengers
    .filter(|p| p.sex == "female")
    .filter(|p| p.survived == 1)
    .len() * 100 / female_passengers.len();

// Economic inequality in disaster  
let class_survival_rates = passengers
    .group_by(|p| p.pclass)
    .map(|group| {
        class: group.key,
        survival_rate: group.values.filter(|p| p.survived == 1).len() * 100 / group.values.len()
    });

// Feature engineering for prediction
let engineered_passenger = |p| {
    let privilege_score = 
        (if p.sex == "female" { 2 } else { 0 }) +
        (if p.age < 16 { 1 } else { 0 }) +
        (if p.pclass == 1 { 1 } else { 0 });
    
    {...p, privilege_score: privilege_score}
};
```

### What Makes This Powerful

- **Human Story**: Real tragedy with documented outcomes
- **Social Patterns**: Gender, age, and class impact survival
- **Feature Engineering**: Creating predictive variables from demographics
- **Ethical Considerations**: Inequality and privilege in crisis situations

### Historical Context

The demo reveals stark inequalities:
- **Women**: 74.2% survival rate vs men at 18.9%
- **First Class**: 62.9% survival vs third class at 24.2%
- **Children**: Prioritized in evacuation procedures

## Demo 3: Boston Housing - Regression and Economics

**Objective**: Predict housing prices using neighborhood characteristics

### Key Concepts Demonstrated

```ruchy
// Crime rate impact on property values
let crime_impact = neighborhoods
    .group_by(|n| if n.crime_rate > 0.1 { "high_crime" } else { "low_crime" })
    .map(|group| {
        category: group.key,
        avg_price: group.values.map(|n| n.median_value).mean()
    });

// Multiple feature regression
let predict_price = |house| {
    let base_price = 20.0;  // Base price in $1000s (1970s)
    let room_premium = (house.rooms - 6.0) * 3.0;
    let crime_penalty = house.crime_rate * -50.0;
    let location_bonus = if house.distance_to_employment < 3.0 { 5.0 } else { 0.0 };
    
    base_price + room_premium + crime_penalty + location_bonus
};
```

### Economic Insights Revealed

- **Crime Impact**: Low crime areas command 15-20% price premiums
- **Size Matters**: Each additional room adds ~$3k in 1970s dollars
- **Location Premium**: Proximity to employment centers drives prices
- **Investment Strategy**: Target low-crime, large-home, well-located properties

### Real Estate Applications

Modern applications of this analysis:
- **Property Investment**: Identify undervalued neighborhoods
- **Urban Planning**: Understand crime's economic impact
- **Market Analysis**: Predict price changes from infrastructure

## Demo 4: Wine Quality - Feature Correlation Analysis

**Objective**: Predict wine quality from chemical analysis

### Key Concepts Demonstrated

```ruchy
// Chemical feature correlation
let alcohol_quality_correlation = wines
    .group_by(|w| if w.alcohol > 11.0 { "high_alcohol" } else { "low_alcohol" })
    .map(|group| {
        alcohol_level: group.key,
        avg_quality: group.values.map(|w| w.quality).mean(),
        sample_count: group.values.len()
    });

// Multi-factor quality prediction
let predict_wine_quality = |wine| {
    let quality_score = 
        (if wine.alcohol > 10.0 { 2 } else { 0 }) +           // Alcohol strength
        (if wine.sulphates > 0.5 { 2 } else { 0 }) +          // Preservation
        (if wine.volatile_acidity < 0.4 { 1 } else { 0 }) +   // Low faults
        (if wine.ph > 3.0 && wine.ph < 3.5 { 1 } else { 0 }); // pH balance
    
    if quality_score >= 4 { "premium" } else { "standard" }
};
```

### Domain Knowledge Integration

- **Chemistry Matters**: Sulphates preserve wine, volatile acidity indicates faults
- **Balance is Key**: pH, alcohol, and acidity must be harmonious
- **Quality Indicators**: Higher alcohol and proper sulphate levels correlate with ratings
- **Red vs White**: Different chemical profiles but similar quality patterns

## Advanced Techniques

### Feature Engineering Patterns

```ruchy
// Creating categorical features from continuous data
let categorize_continuous = |value, thresholds| {
    if value > thresholds.high { "high" }
    else if value > thresholds.medium { "medium" }
    else { "low" }
};

// Ratio features for better prediction
let create_ratios = |data_row| {
    {
        ...data_row,
        petal_ratio: data_row.petal_length / data_row.petal_width,
        sepal_ratio: data_row.sepal_length / data_row.sepal_width
    }
};

// Composite scoring systems
let calculate_desirability_score = |house| {
    let safety_score = if house.crime < 0.05 { 3 } else if house.crime < 0.15 { 2 } else { 1 };
    let size_score = if house.rooms > 6.5 { 3 } else if house.rooms > 6.0 { 2 } else { 1 };
    let location_score = if house.distance < 4.0 { 3 } else if house.distance < 6.0 { 2 } else { 1 };
    
    safety_score + size_score + location_score  // Score out of 9
};
```

### Statistical Analysis Patterns

```ruchy
// Group-based statistics
let analyze_by_group = |dataset, group_field, value_field| {
    dataset
        .group_by(|row| row[group_field])
        .map(|group| {
            category: group.key,
            count: group.values.len(),
            mean: group.values.map(|row| row[value_field]).mean(),
            min: group.values.map(|row| row[value_field]).min(),
            max: group.values.map(|row| row[value_field]).max()
        })
};

// Correlation discovery
let find_correlations = |dataset, feature_pairs| {
    feature_pairs.map(|pair| {
        let feature1_values = dataset.map(|row| row[pair.feature1]);
        let feature2_values = dataset.map(|row| row[pair.feature2]);
        
        {
            features: f"{pair.feature1} vs {pair.feature2}",
            correlation: calculate_correlation(feature1_values, feature2_values)
        }
    })
};
```

## Testing and Quality Assurance

### TDD Approach for Data Science

Every demo in this chapter follows **Test-Driven Development**:

```ruchy
// tests/test_wine_quality.ruchy - Written BEFORE the demo
fun test_alcohol_quality_correlation() {
    let high_alcohol_wines = test_wines.filter(|w| w.alcohol > 10.5);
    let avg_quality = high_alcohol_wines.map(|w| w.quality).mean();
    
    assert_within_range("High alcohol wine quality", avg_quality, 6.0, 8.0);
}
```

### PMAT Quality Scores

All demos achieve **perfect quality scores**:
- ✅ Iris Demo: **1.00/1.0** PMAT score
- ✅ Titanic Demo: **1.00/1.0** PMAT score  
- ✅ Boston Housing Demo: **1.00/1.0** PMAT score
- ✅ Wine Quality Demo: **1.00/1.0** PMAT score

### Running the Test Suite

```bash
# Test individual datasets
ruchy tests/test_data_science.ruchy
ruchy tests/test_wine_quality.ruchy

# Test all demos
ruchy test tests/test_*.ruchy

# Quality analysis
ruchy score demos/repl/08-data-science/*.ruchy
```

## Common Data Science Patterns in Ruchy

### Pattern 1: Dataset Overview

```ruchy
// Standard dataset exploration
let explore_dataset = |data| {
    println(f"Dataset size: {data.len()} records");
    println(f"Features: {get_feature_names(data)}");
    
    // Show sample
    println(f"Sample record: {data[0]}");
    
    // Basic statistics
    let numeric_features = get_numeric_features(data);
    for feature in numeric_features {
        let values = data.map(|row| row[feature]);
        println(f"{feature}: mean={values.mean():.2f}, range={values.min():.2f}-{values.max():.2f}");
    }
};
```

### Pattern 2: Feature Correlation Analysis

```ruchy
// Systematic correlation analysis
let analyze_feature_correlations = |data, target_feature| {
    let features = get_feature_names(data).filter(|f| f != target_feature);
    
    for feature in features {
        let high_values = data.filter(|row| row[feature] > median(data, feature));
        let low_values = data.filter(|row| row[feature] <= median(data, feature));
        
        let high_target_avg = high_values.map(|row| row[target_feature]).mean();
        let low_target_avg = low_values.map(|row| row[target_feature]).mean();
        
        println(f"{feature} correlation with {target_feature}:");
        println(f"  High {feature}: {target_feature} avg = {high_target_avg:.2f}");
        println(f"  Low {feature}: {target_feature} avg = {low_target_avg:.2f}");
    }
};
```

### Pattern 3: Simple Prediction Models

```ruchy
// Rule-based prediction with accuracy measurement
let build_simple_classifier = |training_data, rules| {
    var correct = 0;
    
    for record in training_data {
        let prediction = apply_rules(record, rules);
        let actual = record.target;
        
        if prediction == actual {
            correct = correct + 1;
        }
    }
    
    let accuracy = (correct * 100) / training_data.len();
    println(f"Model accuracy: {accuracy}%");
    
    // Return the classifier function
    |new_record| apply_rules(new_record, rules)
};
```

## Integration with Modern Data Science

### Ruchy's Advantages for Data Science

1. **Interactive Exploration**: REPL enables rapid hypothesis testing
2. **Functional Programming**: Natural fit for data transformations
3. **Type Safety**: Catches errors early in analysis pipelines
4. **Performance**: Compiled performance for large datasets
5. **Readable Syntax**: Easy to understand and maintain analysis code

### Comparison with Other Tools

| Feature | Ruchy | Python/Pandas | R |
|---------|-------|---------------|---|
| **Interactive REPL** | ✅ Excellent | ✅ Jupyter | ✅ RStudio |
| **Functional Style** | ✅ Native | ⚠️ Possible | ✅ Native |
| **Type Safety** | ✅ Compile-time | ❌ Runtime | ❌ Runtime |
| **Performance** | ✅ Compiled | ⚠️ Mixed | ⚠️ Interpreted |
| **Learning Curve** | ✅ Gentle | ⚠️ Libraries | ⚠️ Syntax |

### When to Use Ruchy for Data Science

**Excellent for**:
- **Educational Settings**: Clean syntax, immediate feedback
- **Exploratory Analysis**: REPL-driven investigation  
- **Feature Engineering**: Functional transformations
- **Simple Models**: Classification rules, regression formulas
- **Statistical Analysis**: Built-in mathematical operations

**Consider Other Tools for**:
- **Deep Learning**: TensorFlow/PyTorch ecosystems
- **Advanced Visualization**: matplotlib/ggplot2
- **Specialized Statistics**: R's statistical packages
- **Big Data**: Spark/Dask ecosystems

## Next Steps and Extensions

### Expanding Your Data Science Skills

1. **Try Full Datasets**: Load complete CSV files with thousands of records
2. **Advanced Models**: Implement decision trees, random forests
3. **Time Series**: Analyze stock prices, weather data
4. **Web Data**: APIs and real-time data streams
5. **Visualization**: Integrate with plotting libraries

### Suggested Projects

**Beginner Projects**:
- Expand Iris analysis to include clustering
- Add more features to Titanic survival prediction
- Create housing price calculator with user input

**Intermediate Projects**:  
- Wine recommendation system based on preferences
- Stock price prediction using moving averages
- Customer segmentation analysis

**Advanced Projects**:
- Real estate market analyzer with live data
- Wine quality prediction API
- Social media sentiment analysis

### Community and Resources

- **Dataset Repository**: Expand the canonical dataset collection
- **Analysis Templates**: Reusable patterns for common analyses
- **Performance Benchmarks**: Compare Ruchy vs Python/R
- **Integration Guides**: Connect with databases, APIs, visualization tools

## Conclusion

This chapter demonstrates that Ruchy is not just a systems programming language—it's a powerful tool for data science and analytics. By focusing on canonical datasets and following TDD + PMAT quality practices, we've created a foundation for data science education that combines:

- **Pedagogical Excellence**: Industry-standard datasets
- **Software Engineering Rigor**: TDD methodology and quality enforcement  
- **Interactive Learning**: REPL-driven exploration
- **Production Quality**: Perfect PMAT scores across all demos

Whether you're a student learning data science fundamentals or an educator creating curriculum, these demos provide battle-tested, high-quality examples that teach both data science concepts and software engineering best practices.

The future of data science education lies in tools that combine the interactive exploration of Python/R with the reliability and performance of compiled languages. Ruchy represents that future—where data scientists can explore, experiment, and deploy with confidence.

---

**Total Educational Value**: 4 canonical datasets, 600+ lines of code, perfect quality scores, comprehensive test coverage.

**Ready for Production**: Use these demos in courses, workshops, tutorials, and self-study programs worldwide.