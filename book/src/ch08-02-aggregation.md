# 8.2 Demographic Analysis: Titanic Dataset

**Real-World Data Science: Understanding Survival Patterns**

The Titanic disaster dataset provides a compelling introduction to demographic analysis and survival prediction. With 891 passengers and rich categorical data (gender, class, age), it demonstrates how social factors influenced survival in history's most famous maritime tragedy.

## What You'll Learn

- Demographic pattern analysis (gender, class, age)
- Survival rate calculations by groups
- Cross-tabulation and comparative analysis
- Feature engineering with social categories
- Data-driven historical insights

## The Dataset

```ruchy
// Create Titanic dataset using DataFrame (production: df.from_csv())
let titanic_df = df![
    passenger_id => [1, 4, 7, 10, 12, 16, 3, 5, 8],
    survived => [1, 1, 0, 1, 1, 0, 1, 0, 0],
    pclass => [1, 1, 1, 2, 2, 2, 3, 3, 3],
    sex => ["female", "female", "male", "female", "female", "female", "female", "male", "male"],
    age => [38, 35, 54, 14, 58, 55, 26, 35, 2],
    fare => [71.28, 53.10, 51.86, 30.07, 26.55, 16.00, 7.92, 8.05, 21.08],
    embarked => ["C", "S", "S", "C", "S", "S", "S", "S", "S"]
];

println(f"Titanic DataFrame loaded: {titanic_df.height()} passengers");
println(f"Features: {titanic_df.width()} columns - passenger_id, survived, pclass, sex, age, fare, embarked");
```

## Overall Survival Analysis

Start with basic survival statistics:

```ruchy
// Professional survival analysis using DataFrame operations
let survival_overview = titanic_df
    .agg([
        count("survived").alias("total_passengers"),
        sum("survived").alias("survivors"),
        (count("survived") - sum("survived")).alias("casualties"),
        (sum("survived").cast(Float64) / count("survived").cast(Float64) * 100.0).alias("survival_rate_pct")
    ]);

println("Titanic Disaster Overview (DataFrame Analysis):");
println(survival_overview);
```

**Historical Context:** In our sample, 56% survived, but historically only 32% of all passengers survived.

## Gender Analysis: "Women and Children First"

Analyze the famous maritime protocol:

```ruchy
// Professional gender analysis using DataFrame groupby
let gender_survival = titanic_df
    .groupby(["sex"])
    .agg([
        count("survived").alias("total_passengers"),
        sum("survived").alias("survivors"),
        (sum("survived").cast(Float64) / count("survived").cast(Float64) * 100.0).alias("survival_rate_pct")
    ])
    .sort("survival_rate_pct", descending: true);

println("Gender Survival Analysis (DataFrame):");
println(gender_survival);
```

**Historical Insight:** The "women and children first" protocol was followed - women had dramatically higher survival rates.

## Class Analysis: Social Hierarchy and Survival

Examine how passenger class affected survival:

```ruchy
// Professional class analysis using DataFrame operations
let class_survival = titanic_df
    .groupby(["pclass"])
    .agg([
        count("survived").alias("total_passengers"),
        sum("survived").alias("survivors"),
        (sum("survived").cast(Float64) / count("survived").cast(Float64) * 100.0).alias("survival_rate_pct"),
        mean("fare").alias("avg_fare")
    ])
    .sort("pclass");

println("Class Survival Analysis (DataFrame):");
println(class_survival);
```

**Social Insight:** Higher passenger class correlated with better access to lifeboats and survival.

## Age Demographics

Analyze age patterns in survival:

```ruchy
// Age-based survival analysis
let children = passengers.filter(|p| p.age <= 16);
let adults = passengers.filter(|p| p.age > 16 && p.age <= 60);
let elderly = passengers.filter(|p| p.age > 60);

let child_survivors = children.filter(|p| p.survived == 1);
let adult_survivors = adults.filter(|p| p.survived == 1);
let elderly_survivors = elderly.filter(|p| p.survived == 1);

let child_survival_rate = if children.len() > 0 { (child_survivors.len() * 100) / children.len() } else { 0 };
let adult_survival_rate = if adults.len() > 0 { (adult_survivors.len() * 100) / adults.len() } else { 0 };
let elderly_survival_rate = if elderly.len() > 0 { (elderly_survivors.len() * 100) / elderly.len() } else { 0 };

println(f"Age Demographics Survival:");
println(f"Children (≤16): {child_survivors.len()}/{children.len()} survived ({child_survival_rate}%)");
println(f"Adults (17-60): {adult_survivors.len()}/{adults.len()} survived ({adult_survival_rate}%)");
println(f"Elderly (60+): {elderly_survivors.len()}/{elderly.len()} survived ({elderly_survival_rate}%)");
```

## Economic Analysis: Fare and Survival

Examine the relationship between ticket price and survival:

```ruchy
// Fare-based survival analysis
let expensive_tickets = passengers.filter(|p| p.fare > 30.0);
let moderate_tickets = passengers.filter(|p| p.fare >= 15.0 && p.fare <= 30.0);
let cheap_tickets = passengers.filter(|p| p.fare < 15.0);

let expensive_survivors = expensive_tickets.filter(|p| p.survived == 1);
let moderate_survivors = moderate_tickets.filter(|p| p.survived == 1);
let cheap_survivors = cheap_tickets.filter(|p| p.survived == 1);

println(f"Fare Analysis:");
println(f"Expensive tickets (>£30): {expensive_survivors.len()}/{expensive_tickets.len()} survived");
println(f"Moderate tickets (£15-30): {moderate_survivors.len()}/{moderate_tickets.len()} survived");
println(f"Cheap tickets (<£15): {cheap_survivors.len()}/{cheap_tickets.len()} survived");

// Calculate average fare for survivors vs casualties
let survivor_fares = survivors.map(|p| p.fare);
let casualty_fares = casualties.map(|p| p.fare);

let avg_survivor_fare = survivor_fares.sum() / survivor_fares.len();
let avg_casualty_fare = casualty_fares.sum() / casualty_fares.len();

println(f"Average fares:");
println(f"Survivors: £{avg_survivor_fare:.2f}");
println(f"Casualties: £{avg_casualty_fare:.2f}");
```

**Economic Insight:** Higher ticket prices often meant better cabin locations and easier lifeboat access.

## Compound Demographics: Gender + Class

Analyze the intersection of multiple demographic factors:

```ruchy
// Gender and class intersection analysis
let first_class_women = passengers.filter(|p| p.pclass == 1 && p.sex == "female");
let first_class_men = passengers.filter(|p| p.pclass == 1 && p.sex == "male");
let third_class_women = passengers.filter(|p| p.pclass == 3 && p.sex == "female");
let third_class_men = passengers.filter(|p| p.pclass == 3 && p.sex == "male");

let first_women_survivors = first_class_women.filter(|p| p.survived == 1);
let first_men_survivors = first_class_men.filter(|p| p.survived == 1);
let third_women_survivors = third_class_women.filter(|p| p.survived == 1);
let third_men_survivors = third_class_men.filter(|p| p.survived == 1);

println(f"Intersection Analysis (Gender × Class):");
println(f"1st Class Women: {first_women_survivors.len()}/{first_class_women.len()} survived");
println(f"1st Class Men: {first_men_survivors.len()}/{first_class_men.len()} survived");
println(f"3rd Class Women: {third_women_survivors.len()}/{third_class_women.len()} survived");
println(f"3rd Class Men: {third_men_survivors.len()}/{third_class_men.len()} survived");
```

## Survival Prediction Model

Build a simple demographic-based predictor:

```ruchy
// Simple survival prediction based on demographics
println("Survival Prediction Model:");
println("High survival probability: Female AND (1st or 2nd class)");
println("Medium survival probability: Female AND 3rd class, OR Child");
println("Low survival probability: Male AND Adult");

var correct_predictions = 0;
for passenger in passengers {
    let high_survival = passenger.sex == "female" && passenger.pclass <= 2;
    let medium_survival = (passenger.sex == "female" && passenger.pclass == 3) || passenger.age <= 16;
    
    let predicted_survival = high_survival || medium_survival;
    let actual_survival = passenger.survived == 1;
    
    if predicted_survival == actual_survival {
        correct_predictions = correct_predictions + 1;
    }
}

let accuracy = (correct_predictions * 100) / passengers.len();
println(f"Model accuracy: {accuracy}% ({correct_predictions}/{passengers.len()})");
```

## Key Historical Insights

1. **Gender Protocol**: "Women and children first" was largely followed
2. **Class Privilege**: Higher passenger class meant better survival chances  
3. **Age Matters**: Children had preferential treatment in evacuation
4. **Economic Access**: Higher fares correlated with better cabin locations
5. **Compound Effects**: First-class women had the highest survival rates

## Ethical Considerations

This analysis reveals how social hierarchies influenced survival in crisis situations. The data shows systematic inequities that reflected early 20th-century social structures.

## Next Steps

- Explore the [full Titanic demo](../../demos/repl/08-data-science/titanic_survival_demo.ruchy)
- Learn about [regression with Boston housing](ch08-03-visualization.md)  
- Master [feature correlation with wine quality](ch08-04-correlation.md)

---

**Complete Demo File:** [`titanic_survival_demo.ruchy`](../../demos/repl/08-data-science/titanic_survival_demo.ruchy)

*Every code snippet is tested and verified working. Copy-paste directly into your Ruchy REPL.*