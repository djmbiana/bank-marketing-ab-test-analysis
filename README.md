# Bank Marketing Contact Analysis

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

Dataset: https://archive.ics.uci.edu/dataset/222/bank+marketing

---

## Executive Summary

- Low Contact clients (1-2 calls) converted ~51% more often than High Contact clients (3+ calls): 13.19% vs. 8.75%
- Account balance and prior campaign outcome were the strongest predictors of conversion, outperforming all demographic variables
- Findings suggest banks may improve marketing efficiency by prioritizing high-quality leads earlier in the sales funnel rather than increasing contact frequency

---

## Key Finding

**More calls did not mean more conversions.**

Low Contact clients outperformed High Contact clients across every segment tested: age, job, education, balance tier, and contact method. The pattern held without exception.

| Group | Conversion Rate |
|---|---|
| Low Contact (1-2 calls) | 13.19% |
| High Contact (3+ calls) | 8.75% |

---

## What Drove Conversions

**Balance was the clearest signal.**

| Balance Tier | Conversion Rate |
|---|---|
| Non-Positive | 6.90% |
| Low | 9.86% |
| Mid | 12.27% |
| High | 15.72% |

High-balance clients converted at more than twice the rate of non-positive balance clients. Prior successful campaign outcomes showed a similar pattern: clients with a positive `poutcome` converted at substantially higher rates regardless of contact frequency.

Demographic variables (age, job, education) showed weaker associations by comparison.

---

## Dashboard

<img width="2767" height="2184" alt="bank-marketing-dashboard-2" src="https://github.com/user-attachments/assets/a8e807a7-0aa6-454f-85e4-4685415952b1" />


---

## Statistical Validation

A chi-square test confirmed the contact frequency-conversion association is statistically significant (χ² = 191.28, p < 0.001). Because this is observational data, the result reflects association rather than causation. Clients in high-contact groups may differ in underlying characteristics that independently affect conversion likelihood.

---

## Methodology

- **Stack:** PostgreSQL, Power BI, Python (chi-square test)
- **Approach:** Simulated A/B comparison on observational data: Low Contact (1-2 calls) vs. High Contact (3+ calls)
- **Techniques:** Conditional aggregation, window functions (NTILE), chained CTEs, chi-square significance testing
- **Segmentation:** Balance tier, age quartile, job, education, contact method, prior campaign outcome

Groups were not randomly assigned. Conversion rate differences may reflect pre-existing client characteristics rather than the effect of contact frequency alone.

---

## Selected Queries

<details>
<summary>Contact group conversion rates</summary>

```sql
SELECT contact_group,
       ROUND(COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS conversion_rate
FROM bank_marketing_clean
GROUP BY contact_group;
-- Low Contact: 13.19% | High Contact: 8.75%
```

</details>

<details>
<summary>Balance tier analysis (chained CTEs + NTILE)</summary>

```sql
WITH balance_base AS (
    SELECT id, y, balance, contact_group,
           CASE WHEN balance > 0 THEN 'Positive' ELSE 'Non-Positive' END AS balance_type
    FROM bank_marketing_clean
),
positive_balance_ntile AS (
    SELECT *, NTILE(3) OVER (ORDER BY balance) AS balance_tertile
    FROM balance_base WHERE balance > 0
),
balance_grouped AS (
    SELECT *,
           CASE balance_tertile WHEN 1 THEN 'Low' WHEN 2 THEN 'Mid' WHEN 3 THEN 'High' END AS balance_group
    FROM positive_balance_ntile
    UNION ALL
    SELECT *, NULL, 'Non-Positive' FROM balance_base WHERE balance <= 0
)
SELECT balance_group,
       ROUND(COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS conversion_rate
FROM balance_grouped
GROUP BY balance_group;
-- Non-Positive: 6.90% | Low: 9.86% | Mid: 12.27% | High: 15.72%
```

</details>

---

## Limitations

- Observational data: clients were not randomly assigned to contact frequency groups
- High-contact clients may be inherently harder to convert, independent of contact frequency
- `unknown` values in contact method, poutcome, job, and education introduce uncertainty and should be interpreted cautiously
- Causal conclusions require a properly randomized experiment

---

## Future Work

- Confidence intervals for conversion rate differences
- Logistic regression to isolate strongest conversion predictors
- Propensity score matching to better approximate causal inference
