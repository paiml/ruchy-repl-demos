# 8.4 Feature Correlation: Wine Quality Dataset

**Advanced Analytics: Predicting Quality Through Chemistry**

The Wine Quality dataset represents the pinnacle of feature correlation analysis in data science. With 11 chemical features predicting wine quality scores, it demonstrates how multiple variables interact to determine outcomes - perfect for understanding correlation, feature importance, and prediction modeling.

## What You'll Learn

- Multi-feature correlation analysis
- Chemical feature interpretation
- Quality prediction modeling  
- Feature ranking by importance
- Domain knowledge integration
- Advanced filtering and aggregation

## The Dataset

```ruchy
// Wine Quality dataset: 11 chemical features + quality score
let wines = [
    // Red wines with various quality levels
    {wine_type: "red", fixed_acidity: 7.4, volatile_acidity: 0.7, citric_acid: 0.0, residual_sugar: 1.9, chlorides: 0.076, free_sulfur_dioxide: 11, total_sulfur_dioxide: 34, density: 0.9978, ph: 3.51, sulphates: 0.56, alcohol: 9.4, quality: 5},
    {wine_type: "red", fixed_acidity: 7.8, volatile_acidity: 0.88, citric_acid: 0.0, residual_sugar: 2.6, chlorides: 0.098, free_sulfur_dioxide: 25, total_sulfur_dioxide: 67, density: 0.9968, ph: 3.2, sulphates: 0.68, alcohol: 9.8, quality: 5},
    {wine_type: "red", fixed_acidity: 6.2, volatile_acidity: 0.21, citric_acid: 0.29, residual_sugar: 1.6, chlorides: 0.039, free_sulfur_dioxide: 24, total_sulfur_dioxide: 92, density: 0.99114, ph: 3.27, sulphates: 0.5, alcohol: 11.2, quality: 7},
    
    // White wines - different chemical profiles
    {wine_type: "white", fixed_acidity: 7.0, volatile_acidity: 0.27, citric_acid: 0.36, residual_sugar: 20.7, chlorides: 0.045, free_sulfur_dioxide: 45, total_sulfur_dioxide: 170, density: 0.1001, ph: 3.0, sulphates: 0.45, alcohol: 8.8, quality: 6},
    {wine_type: "white", fixed_acidity: 6.3, volatile_acidity: 0.3, citric_acid: 0.34, residual_sugar: 1.6, chlorides: 0.049, free_sulfur_dioxide: 14, total_sulfur_dioxide: 132, density: 0.994, ph: 3.3, sulphates: 0.49, alcohol: 9.5, quality: 6},
    
    // Premium quality wine (quality 8)
    {wine_type: "white", fixed_acidity: 7.7, volatile_acidity: 0.64, citric_acid: 0.21, residual_sugar: 2.2, chlorides: 0.077, free_sulfur_dioxide: 32, total_sulfur_dioxide: 133, density: 0.9906, ph: 3.27, sulphates: 0.45, alcohol: 12.0, quality: 8}
];

println(f"Wine Quality dataset: {wines.len()} wines with 11 chemical features");
println("Quality scale: 0-10 (most wines score 5-7)");
```

## Quality Distribution Analysis

Start by understanding the quality distribution:

```ruchy
// Analyze quality score distribution
let quality_scores = wines.map(|w| w.quality);
let avg_quality = quality_scores.sum() / quality_scores.len();
let min_quality = match quality_scores.min() { Some(x) => x, None => 0 };
let max_quality = match quality_scores.max() { Some(x) => x, None => 0 };

println(f"Quality Distribution:");
println(f"Average quality: {avg_quality:.1f}/10");
println(f"Quality range: {min_quality} - {max_quality}");

// Categorize wines by quality
let low_quality = wines.filter(|w| w.quality <= 5);
let medium_quality = wines.filter(|w| w.quality == 6);  
let high_quality = wines.filter(|w| w.quality >= 7);

println(f"Quality categories:");
println(f"Low (≤5): {low_quality.len()} wines");
println(f"Medium (6): {medium_quality.len()} wines");
println(f"High (≥7): {high_quality.len()} wines");
```

## Alcohol Content Correlation

Analyze the strongest predictor of wine quality:

```ruchy
// Alcohol vs Quality correlation
let high_quality_alcohol = high_quality.map(|w| w.alcohol);
let low_quality_alcohol = low_quality.map(|w| w.alcohol);

let avg_high_alcohol = high_quality_alcohol.sum() / high_quality_alcohol.len();
let avg_low_alcohol = low_quality_alcohol.sum() / low_quality_alcohol.len();

println(f"Alcohol Content Analysis:");
println(f"High quality wines avg alcohol: {avg_high_alcohol:.1f}%");
println(f"Low quality wines avg alcohol: {avg_low_alcohol:.1f}%");
println(f"Alcohol correlation: {avg_high_alcohol - avg_low_alcohol:.1f} percentage point difference");

// Create alcohol-based segments
let high_alcohol_wines = wines.filter(|w| w.alcohol > 10.5);
let low_alcohol_wines = wines.filter(|w| w.alcohol <= 10.5);

let high_alcohol_avg_quality = high_alcohol_wines.map(|w| w.quality).sum() / high_alcohol_wines.len();
let low_alcohol_avg_quality = low_alcohol_wines.map(|w| w.quality).sum() / low_alcohol_wines.len();

println(f"Segmentation:");
println(f"High alcohol wines (>10.5%): Avg quality {high_alcohol_avg_quality:.2f}");
println(f"Low alcohol wines (≤10.5%): Avg quality {low_alcohol_avg_quality:.2f}");
```

**Key Finding:** Higher alcohol content strongly correlates with higher wine quality.

## Sulphates Impact Analysis

Examine sulphates as quality predictors:

```ruchy
// Sulphates vs Quality analysis
let high_sulphate_wines = wines.filter(|w| w.sulphates > 0.5);
let low_sulphate_wines = wines.filter(|w| w.sulphates <= 0.5);

let high_sulphate_avg_quality = high_sulphate_wines.map(|w| w.quality).sum() / high_sulphate_wines.len();
let low_sulphate_avg_quality = low_sulphate_wines.map(|w| w.quality).sum() / low_sulphate_wines.len();

println(f"Sulphates Impact:");
println(f"High sulphates (>0.5): Avg quality {high_sulphate_avg_quality:.2f}");
println(f"Low sulphates (≤0.5): Avg quality {low_sulphate_avg_quality:.2f}");
println("Wine chemistry: Sulphates act as preservatives and antioxidants");
```

**Domain Knowledge:** Sulphates prevent wine spoilage and preserve flavor compounds.

## Volatile Acidity: The Quality Killer

Analyze volatile acidity as a wine fault indicator:

```ruchy
// Volatile acidity impact on quality
let low_volatile_acidity = wines.filter(|w| w.volatile_acidity <= 0.4);
let high_volatile_acidity = wines.filter(|w| w.volatile_acidity > 0.4);

let low_va_avg_quality = low_volatile_acidity.map(|w| w.quality).sum() / low_volatile_acidity.len();
let high_va_avg_quality = if high_volatile_acidity.len() > 0 { 
    high_volatile_acidity.map(|w| w.quality).sum() / high_volatile_acidity.len() 
} else { 0 };

println(f"Volatile Acidity Analysis:");
println(f"Low volatile acidity (≤0.4): Avg quality {low_va_avg_quality:.2f}");
println(f"High volatile acidity (>0.4): Avg quality {high_va_avg_quality:.2f}");
println("Wine faults: High volatile acidity indicates spoilage or poor fermentation");
```

**Critical Insight:** Volatile acidity above 0.6 typically indicates wine defects.

## pH and Acidity Balance

Explore the relationship between pH and wine quality:

```ruchy
// pH analysis across wine types
let ph_values = wines.map(|w| w.ph);
let avg_ph = ph_values.sum() / ph_values.len();

println(f"pH Analysis:");
println(f"Average wine pH: {avg_ph:.2f} (acidic, as expected)");
println("Wine chemistry: pH 3.0-3.8 is ideal for stability and taste");

// Fixed acidity by wine type
let red_wines = wines.filter(|w| w.wine_type == "red");
let white_wines = wines.filter(|w| w.wine_type == "white");

let red_avg_acidity = red_wines.map(|w| w.fixed_acidity).sum() / red_wines.len();
let white_avg_acidity = white_wines.map(|w| w.fixed_acidity).sum() / white_wines.len();

println(f"Acidity by type:");
println(f"Red wines avg acidity: {red_avg_acidity:.2f}");
println(f"White wines avg acidity: {white_avg_acidity:.2f}");
```

## Sweetness Categorization

Analyze residual sugar patterns:

```ruchy
// Sweetness analysis
let dry_wines = wines.filter(|w| w.residual_sugar <= 4.0);      // Dry
let off_dry_wines = wines.filter(|w| w.residual_sugar > 4.0 && w.residual_sugar <= 12.0); // Off-dry  
let sweet_wines = wines.filter(|w| w.residual_sugar > 12.0);    // Sweet

println(f"Sweetness Categories:");
println(f"Dry wines (≤4g sugar): {dry_wines.len()}");
println(f"Off-dry wines (4-12g sugar): {off_dry_wines.len()}");
println(f"Sweet wines (>12g sugar): {sweet_wines.len()}");

// Quality by sweetness
let dry_avg_quality = if dry_wines.len() > 0 { dry_wines.map(|w| w.quality).sum() / dry_wines.len() } else { 0 };
let sweet_avg_quality = if sweet_wines.len() > 0 { sweet_wines.map(|w| w.quality).sum() / sweet_wines.len() } else { 0 };

println(f"Quality by sweetness:");
println(f"Dry wines average quality: {dry_avg_quality:.2f}");
println(f"Sweet wines average quality: {sweet_avg_quality:.2f}");
```

## Multi-Feature Prediction Model

Build a comprehensive quality predictor using multiple features:

```ruchy
// Advanced prediction model using multiple features
println("Multi-Feature Quality Prediction Model:");
println("Prediction rules:");
println("1. High quality: alcohol > 10.0 AND sulphates > 0.45 AND volatile_acidity < 0.6");
println("2. Medium quality: 2 of 3 conditions met");
println("3. Low quality: ≤1 condition met");

var correct_predictions = 0;
let total_predictions = wines.len();

for wine in wines {
    let alcohol_good = wine.alcohol > 10.0;
    let sulphates_good = wine.sulphates > 0.45;
    let acidity_good = wine.volatile_acidity < 0.6;
    
    let conditions_met = (if alcohol_good { 1 } else { 0 }) +
                        (if sulphates_good { 1 } else { 0 }) +
                        (if acidity_good { 1 } else { 0 });
    
    let predicted_high_quality = conditions_met >= 2;
    let actual_high_quality = wine.quality >= 6;
    
    if predicted_high_quality == actual_high_quality {
        correct_predictions = correct_predictions + 1;
    }
}

let prediction_accuracy = (correct_predictions * 100) / total_predictions;
println(f"Model accuracy: {prediction_accuracy}% ({correct_predictions}/{total_predictions})");
```

## Feature Engineering: Wine Profiles

Create composite scores and wine profiles:

```ruchy
// Engineer wine quality profiles
let wine_profiles = wines.map(|w| {
    let alcohol_tier = if w.alcohol > 11.0 { "high" } else if w.alcohol > 9.5 { "medium" } else { "low" };
    let acidity_balance = if w.fixed_acidity > 7.5 { "acidic" } else if w.fixed_acidity > 6.5 { "balanced" } else { "mild" };
    let sweetness_level = if w.residual_sugar > 10.0 { "sweet" } else if w.residual_sugar > 3.0 { "off_dry" } else { "dry" };
    
    // Composite quality score
    let wine_score = 
        (if w.alcohol > 10.0 { 2 } else { 0 }) +
        (if w.sulphates > 0.5 { 2 } else { 0 }) +
        (if w.volatile_acidity < 0.4 { 1 } else { 0 }) +
        (if w.ph > 3.0 && w.ph < 3.5 { 1 } else { 0 });
    
    {
        wine_type: w.wine_type,
        actual_quality: w.quality,
        alcohol_tier: alcohol_tier,
        acidity_balance: acidity_balance,
        sweetness_level: sweetness_level,
        composite_score: wine_score
    }
});

println(f"Wine Profile Examples:");
for i in 0..2 {
    let profile = wine_profiles[i];
    println(f"Wine {i + 1}: {profile.wine_type}, Quality={profile.actual_quality}, Alcohol={profile.alcohol_tier}, Score={profile.composite_score}/6");
}
```

## Feature Importance Ranking

Rank features by their correlation with quality:

```ruchy
println(f"Feature Importance Ranking (from wine chemistry research):");
println("1. 🥇 Alcohol Content: Strongest quality predictor");
println("2. 🥈 Volatile Acidity: Wine fault indicator (inverse correlation)");
println("3. 🥉 Sulphates: Preservation and antioxidant properties");
println("4. pH Balance: Acidity-alkalinity equilibrium");
println("5. Fixed Acidity: Tartaric acid levels");
println("6. Citric Acid: Freshness and preservative");
println("7. Residual Sugar: Sweetness level");
println("8. Chlorides: Salt content");
println("9. Free/Total SO2: Preservative levels");
println("10. Density: Alcohol and sugar content indicator");
```

## Domain Insights

**Winemaking Recommendations:**

```ruchy
println(f"🍷 WINEMAKING QUALITY FACTORS:");
println("• Target alcohol: 10-12% for premium wines");
println("• Monitor volatile acidity: Keep below 0.4 g/L");
println("• Optimize sulphates: 0.5-0.7 g/L range");  
println("• Balance pH: 3.0-3.5 for stability");
println("• Control sweetness: Most quality wines are dry to off-dry");

println(f"🚨 QUALITY RED FLAGS:");
println("• Volatile acidity > 0.6: Likely wine defects");
println("• Alcohol < 9%: May lack body and complexity");
println("• pH > 3.8: Potential bacterial spoilage risk");
println("• Excessive sulfur dioxide: Over-preservation");
```

## Key Takeaways

1. **Alcohol dominance**: Strongest single predictor of wine quality
2. **Volatile acidity**: Critical fault indicator - low is essential
3. **Sulphates matter**: Natural preservatives improve stability  
4. **pH balance**: Critical for taste and preservation
5. **Multiple features**: Best predictions use 3+ chemical properties

## Next Steps

- Try the [complete Wine Quality demo](../demos/repl/08-data-science/wine_quality_demo.ruchy)
- Explore advanced ML: Random Forest, SVM classification
- Study [Boston Housing regression analysis](ch08-03-visualization.md)
- Review [statistical fundamentals with Iris](ch08-01-statistics.md)

---

**Complete Demo File:** [`wine_quality_demo.ruchy`](../demos/repl/08-data-science/wine_quality_demo.ruchy)

*Every code snippet is tested and verified working. Copy-paste directly into your Ruchy REPL.*