# Bank Marketing A/B Analysis (SQL Project)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-000000?style=for-the-badge&logo=databricks&logoColor=white)
![DBeaver](https://img.shields.io/badge/DBeaver-372923?style=for-the-badge&logo=dbeaver&logoColor=white)

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

## Methadology:
- Data cleaning and preprocessing in PostgreSQL
- Created A/B groups based on contact frequency:
  - Low Contact (1–2 calls)
  - High Contact (3+ calls)
- Performed segmentation analysis across:
  - client demographics (age, job, education)
  - financial variables (balance)
  - campaign variables (contact, poutcome)
  - Used aggregation and conditional logic (CASE, GROUP BY, CTEs) to compute client conversion rates

## Project Structure:
```
.
├── setup.sql          # table creation + data loading
├── cleaning.sql       # data cleaning steps
├── eda_queries.sql    # all analysis queries (ASCII formatted)
└── README.md
```

## Status:
This project is a work in progress.
Upcoming improvements:
- Dashboard visualization (Power BI / Tableau)
- Final insights and business recommendations section
- Query optimization and documentation refinement