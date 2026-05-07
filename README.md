# Bank Marketing A/B Analysis (SQL + Power BI Project)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-000000?style=for-the-badge&logo=databricks&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

Dataset: https://archive.ics.uci.edu/dataset/222/bank+marketing

---

## Overview
This project analyzes a bank marketing dataset to evaluate whether the number of marketing contacts influences client subscription rates for term deposits.

Using SQL, the project explores conversion patterns, segments clients across multiple dimensions, and evaluates whether increased contact frequency leads to higher conversion rates.

## Key Question:
Does contacting clients more frequently lead to higher subscription rates?

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
- Created A/B groups based on contact frequency:
  - Low Contact (1–2 calls)
  - High Contact (3+ calls)
- Performed segmentation analysis across:
  - client demographics (age, job, education)
  - financial variables (balance)
  - campaign variables (contact, poutcome)
  - Used aggregation and conditional logic (CASE, GROUP BY, CTEs) to compute client conversion rates

## Dashboard Summary

![Dashboard for A/B Test Analysis](dashboard/bank-marketing-dashboard-img.png)

The A/B dashboard focuses on comparing successful conversion rates between Low Contact and High Contact client groups across multiple variables.

Key findings:
- Low Contact groups consistently achieved higher conversion rates
- Higher client balances are associated with higher conversion rates
- Previous successful campaign outcomes show the strongest association with successful client conversions
- Demographic variables such as education, occupation, and age show weaker relationships compared to balance and poutcome

This dashboard was made to provide a concise business summary of the exploratory analysis conducted in PostgreSQL

## Project Structure:
```
BANK-MARKETING-AB-TEST
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
├── .gitignore
└── README.md
```

## Status:
- Completed exploratory analysis and dashboard visualization in PostgreSQL and Power BI.
- Future improvements may include predictive modeling and advanced statistical testing.