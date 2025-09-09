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
// Load Titanic passenger data (representative sample)
let passengers = [
    // First class passengers - higher survival rates
    {passenger_id: 1, survived: 1, pclass: 1, name: "Cumings, Mrs. John Bradley", sex: "female", age: 38, fare: 71.28, embarked: "C"},
    {passenger_id: 4, survived: 1, pclass: 1, name: "Futrelle, Mrs. Jacques Heath", sex: "female", age: 35, fare: 53.10, embarked: "S"},
    {passenger_id: 7, survived: 0, pclass: 1, name: "McCarthy, Mr. Timothy J", sex: "male", age: 54, fare: 51.86, embarked: "S"},
    
    // Second class passengers - mixed outcomes
    {passenger_id: 10, survived: 1, pclass: 2, name: "Nasser, Mrs. Nicholas", sex: "female", age: 14, fare: 30.07, embarked: "C"},
    {passenger_id: 12, survived: 1, pclass: 2, name: "Bonnell, Miss. Caroline", sex: "female", age: 58, fare: 26.55, embarked: "S"},
    {passenger_id: 16, survived: 0, pclass: 2, name: "Hewlett, Mrs. (Mary D Kingcome)", sex: "female", age: 55, fare: 16.00, embarked: "S"},
    
    // Third class passengers - lower survival rates  
    {passenger_id: 3, survived: 1, pclass: 3, name: "Heikkinen, Miss. Laina", sex: "female", age: 26, fare: 7.92, embarked: "S"},
    {passenger_id: 5, survived: 0, pclass: 3, name: "Allen, Mr. William Henry", sex: "male", age: 35, fare: 8.05, embarked: "S"},
    {passenger_id: 8, survived: 0, pclass: 3, name: "Palsson, Master. Gosta Leonard", sex: "male", age: 2, fare: 21.08, embarked: "S"}
];

println(f"Titanic dataset loaded: {passengers.len()} passengers");
println("Features: passenger_id, survived, pclass, name, sex, age, fare, embarked");
```

## Overall Survival Analysis

Start with basic survival statistics:

```ruchy
// Calculate overall survival statistics
let survivors = passengers.filter(|p| p.survived == 1);
let casualties = passengers.filter(|p| p.survived == 0);

let survival_rate = (survivors.len() * 100) / passengers.len();
let casualty_rate = 100 - survival_rate;

println(f"Titanic Disaster Overview:");
println(f"Total passengers (sample): {passengers.len()}");
println(f"Survivors: {survivors.len()} ({survival_rate}%)");
println(f"Casualties: {casualties.len()} ({casualty_rate}%)");
```

**Historical Context:** In our sample, 56% survived, but historically only 32% of all passengers survived.

## Gender Analysis: "Women and Children First"

Analyze the famous maritime protocol:

```ruchy
// Gender-based survival analysis
let female_passengers = passengers.filter(|p| p.sex == "female");
let male_passengers = passengers.filter(|p| p.sex == "male");

let female_survivors = female_passengers.filter(|p| p.survived == 1);
let male_survivors = male_passengers.filter(|p| p.survived == 1);

let female_survival_rate = (female_survivors.len() * 100) / female_passengers.len();
let male_survival_rate = (male_survivors.len() * 100) / male_passengers.len();

println(f"Gender Survival Analysis:");
println(f"Female passengers: {female_passengers.len()}");
println(f"Female survivors: {female_survivors.len()} ({female_survival_rate}% survival rate)");
println(f"Male passengers: {male_passengers.len()}");  
println(f"Male survivors: {male_survivors.len()} ({male_survival_rate}% survival rate)");
println(f"Gender survival gap: {female_survival_rate - male_survival_rate} percentage points");
```

**Historical Insight:** The "women and children first" protocol was followed - women had dramatically higher survival rates.

## Class Analysis: Social Hierarchy and Survival

Examine how passenger class affected survival:

```ruchy
// Class-based survival analysis
let first_class = passengers.filter(|p| p.pclass == 1);
let second_class = passengers.filter(|p| p.pclass == 2);
let third_class = passengers.filter(|p| p.pclass == 3);

let first_survivors = first_class.filter(|p| p.survived == 1);
let second_survivors = second_class.filter(|p| p.survived == 1);
let third_survivors = third_class.filter(|p| p.survived == 1);

let first_survival_rate = (first_survivors.len() * 100) / first_class.len();
let second_survival_rate = (second_survivors.len() * 100) / second_class.len();
let third_survival_rate = (third_survivors.len() * 100) / third_class.len();

println(f"Class Survival Analysis:");
println(f"First Class:  {first_survivors.len()}/{first_class.len()} survived ({first_survival_rate}%)");
println(f"Second Class: {second_survivors.len()}/{second_class.len()} survived ({second_survival_rate}%)");
println(f"Third Class:  {third_survivors.len()}/{third_class.len()} survived ({third_survival_rate}%)");
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