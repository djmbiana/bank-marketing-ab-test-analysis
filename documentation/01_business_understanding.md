# Business understanding

## Business context

A Portuguese bank uses direct marketing campaigns through phone calls to promote its term deposit product. Customers may receive multiple calls before deciding whether to subscribe, with outcomes recorded as “yes” or “no”.

## Experiment idea

We want to test whether increasing the number of marketing contacts leads to a higher subscription rate for the bank’s term deposit product.

Since this dataset is observational, meaning customers were not randomly assigned to contact groups, this analysis simulates an A/B style framework using real campaign data. The goal is to compare conversion rates between clients who received fewer contacts versus those who received more, while acknowledging that group differences may reflect underlying client characteristics rather than the effect of contact frequency alone.

## Groups (A vs B)

Group A: Customers who received 1-2 calls  
Group B: Customers who received 3 or more calls 
Measure: Success is measured by the subscription rate, defined as the proportion of customers who subscribed to the term deposit.

## Assumptions

- I assume the number of contacts (campaign) reflects the intensity of the marketing effort
- I assume customers who receieved more contacts are not randomly assigned, which may introduce bias in the results
- I assume the dataset primarily includes contacted customers, so there is no true “no-contact” field.

## Limitations

This analysis simulates an A/B-style comparison using observational data. Since customers are not randomly assigned to contact frequency groups, results may reflect underlying differences between customers rather than the effect of repeated calls alone.