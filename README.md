# Bank Marketing Campaign Analysis (SQL + Power BI Project)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-000000?style=for-the-badge&logo=databricks&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

Dataset: https://archive.ics.uci.edu/dataset/222/bank+marketing

---

## Overview
This project analyzes a bank marketing dataset to evaluate whether the number of marketing contacts is associated with client subscription rates for term deposits.

Using SQL, the project simulates an A/B-style comparison using observational data, grouping clients by contact frequency and exploring conversion patterns across multiple client segments. Since clients were not randomly assigned to contact groups, findings reflect associations rather than causal conclusions.

This project also runs a chi-square test to evaluate whether the association between contact frequency and client subscription outcomes is statistically signifiacnt.

## Key Question:
- Is contacting clients more frequently associated with higher subscription rates?

## Key Findings:

- Low Contact clients (1–2 calls) consistently show higher conversion rates than High Contact clients (3+ calls)
- This pattern persists across:
  - balance
  - age
  - job
  - education
  - contact method
  - previous campaign outcomes (poutcome)
- Balance and previous campaign outcome (poutcome) show the strongest association with conversion rates
- Higher contact frequency does not appear to improve conversion and may reflect harder-to-convert clients

## Methodology:
- Data cleaning and preprocessing in PostgreSQL
- Simulated a Low Contact vs. High Contact comparison using observational data:
  - Low Contact (Group A): Clients contacted 1–2 times
  - High Contact (Group B): Clients contacted 3+ times
  - Note: Groups are not randomly assigned. Differences in conversion rates may reflect underlying client characteristics
- Performed segmentation analysis across:
  - client demographics (age, job, education)
  - financial variables (balance)
  - campaign variables (contact, poutcome)
  - Used aggregation and conditional logic (CASE, GROUP BY, CTEs) to compute client conversion rates

## SQL Findings:

### Contact Group Conversion Rates
Computes subscription rates across Low and High Contact groups using conditional aggregation

```sql
SELECT contact_group 
        , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage 
FROM bank_marketing_clean
GROUP BY contact_group;

-- results: 
-- Low Contact clients at 13.19% yes vs 86.81% no
-- High Contact clients at 8.75% yes vs 91.25% no
```

### Age Segmentation Using Window Functions
Divides clients into quartile age groups using NTILE() and computes the conversion rate per age group while segmenting with our contact groups.

```sql
WITH age_quartile AS (
    SELECT *
           , NTILE(4) OVER (ORDER BY age) AS age_group
    FROM bank_marketing_clean
)

SELECT contact_group
       , age_group
       , MIN(age) AS min_age
       , MAX(age) AS max_age
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM age_quartile
GROUP BY contact_group
         , age_group
ORDER BY age_group;

-- Results:
-- Low contact outperforms High Contact across all age quartiles (e.x. ages 18-33: 15.59% vs 10.58%)
```

### Balance Group Analysis Using Chained CTEs
Segments client balances into structured groups using a multi-step CTE with NTILE() and UNION ALL, then computes conversion rates per group.

```sql
WITH balance_base AS(
    SELECT id 
           , y 
           , balance
           , contact_group
           , CASE
                WHEN balance > 0 THEN 'Positive'
                WHEN balance <= 0 THEN 'Non-Positive'
                ELSE 'Unknown'
             END AS balance_type 
FROM bank_marketing_clean
), positive_balance_ntile AS(
    SELECT *
           , NTILE(3) OVER (ORDER BY balance) AS balance_tertile
    FROM balance_base
    WHERE balance > 0
), balance_grouped AS(
    SELECT * 
           , CASE 
                WHEN balance_tertile = 1 THEN 'Low Balance'
                WHEN balance_tertile = 2 THEN 'Mid Balance'
                WHEN balance_tertile = 3 THEN 'High Balance'
                ELSE 'Non-Positive'
             END AS balance_group
    FROM positive_balance_ntile
    UNION ALL 
    SELECT *
           , NULL AS balance_tertile
           , 'Non-Positive' AS balance_group
    FROM balance_base
    WHERE balance <= 0
)

SELECT balance_group
       , COUNT(*) AS total_rows
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM balance_grouped
GROUP BY balance_group;

-- Results:
-- Non-Positive: 6.90% | Low Balance: 9.86% | Mid Balance: 12.27% | High Balance: 15.72%
```

## Dashboard Summary

![Dashboard for the Analysis](dashboard/bank-marketing-dashboard-img.png)

The dashboard focuses on comparing successful conversion rates between Low Contact and High Contact client groups across multiple variables.

Key findings:
- Low Contact groups consistently achieved higher conversion rates
- Higher client balances are associated with higher conversion rates
- Previous successful campaign outcomes show the strongest association with successful client conversions
- Demographic variables such as education, occupation, and age show weaker relationships compared to balance and poutcome

This dashboard was made to provide a concise business summary of the exploratory analysis conducted in PostgreSQL

## Project Structure:

```
BANK-MARKETING-CONTACT-ANALYSIS
│
├── dashboard (contains Power BI dashboard files and exports)
│   ├── bank-marketing-dashboard-img.png
│   ├── bank-marketing-dashboard.pbix
│   └── bank-marketing-dashboard.pdf
│
├── data (contains all datasets used in the project)
│   ├── processed
│   │   ├── bank_marketing_clean.csv
│   │   └── bank_marketing_dashboard.csv
│   └── raw
│       └── bank-full.csv
│
├── documentation (contains notes for each stage of the analysis process)
│
├── sql (contains all SQL scripts used in the project)
│   ├── 01_database_setup.sql
│   ├── 02_data_checks.sql
│   ├── 03_data_cleaning.sql
│   ├── 04_eda_queries.sql
│   └── 05_visualization_table.sql
│
├── tests (contains python scripts for testing variables)    
│   └── chi-square_test.py
│
│
├── .gitignore
└── README.md
```

## Limitations
- This is an observational analysis - clients were not randomly assigned to contact frequency groups
- Differences in conversion rates may reflect underlying client characteristics rather than the direct effect of contact frequency
- The presence of 'unknown' categories in several columns (contact method, poutcome, job, education) introduces uncertainty and should be interpreted cautiously
- A properly randomized experiment would be needed to establish causal conclusions

## Chi-Test Interpretation
A chi-square test was conducted on this dataset to evaluate whether the difference in conversion rates between Low Contact and High Contact groups has statistical significance. The results (χ² = 191.28, p < 0.001) indicates that the association between contact frequency and subscription outcome is statistically significant and is unlikely to be due to chance. However, because this is observational data, the result may reflect an association rather than a causal relationship as clients in High Contact groups may differ in underlying characteristics that independently influence conversion likelihood.

## Status
Completed: exploratory analysis, simulated group comparison, statistical testing, and dashboard visualization.

## Future Improvements
- Confidence intervals for conversion rate differences
- Logistic regression to identify strongest predictors of conversion
- Deeper causal analysis via properly randomized experiment design