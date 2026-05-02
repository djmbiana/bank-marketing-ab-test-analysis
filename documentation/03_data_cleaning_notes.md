# Data Cleaning

## Notes before cleaning:
- This dataset uses "unknown" to represent missing values
- Most of the time, unknown is used over NULL
- To address this, i chose to check for both 'unknown' and NULL
- Unknowns are treated as NULLs only for aggregation/grouping where appropriate, but retained as a category when meaningful

## Target variable: (y)
- No NULLs, 'unknown', or missing values.
- Only contains 'yes' or 'no' values.
- The number of 'no' responses is significantly higher than 'yes'

## Treatment variable: campaign
- No NULLs or zero values within the campaign
- A good amount of clients were only called 1-2 times
- This affects our A/B testing later on as the amount of clients called 3+ times drops off dramatically
- This shifts the testing to analyze Low vs High Contact intensity
  - This will ask the question "Does contacting clients 3+ times lead to higher subscription rates?"
  - Group A = Clients who have only received 1-2 calls
  - Group B = Clients with 3+ calls
- Clients in the 3+ group may not be randomly assigned and could represent harder-to-convert cases, which may bias comparisons
- Comparison will be based on subscription rate (y)

## Supporting variables: 

### Contact column
- No NULLs present within the contact column
- 29,285 clients were contacted via cellular, making it the most common contact method
- 13,020 contact records are labeled as unknown
- 2,909 clients were contacted via telephone
- Contact method may influence subscription rates and may explain differences between groups
- We will keep contact and treat 'unknown' as its own category
- It will be used for segmentation checks (e.g., comparing conversion rates by contact method) and as a contextual support when interpreting A/B results
- The large number of unknowns might reflect missing logging rather than a true category, so interpretations involving these unknowns should be made cautiously

### Month & day columns
- No NULLs or Unknowns, making these fields clean and ready for analysis.
- month is a text field and day is an integer field
- These variables can be used to analyze the number of subscriptions by month as a contextual support when interpreting A/B results
- The month may help when trying to capture seasonal effects that influence subscription rates
- Since month is stored as text, it may require transformation for proper ordering during analysis

## Segmentation variables:

### Job column
- No NULLs present within the job column
- Standardization: normalize values (e.g., admin. -> admin) to ensure consistent categories
- 288 records are labeled as “unknown”. this is a small share and will be retained as its own category 
- Job column will be used for segmentation to compare subscription rates across occupations and provide context when interpreting A/B results

### Age column
- No NULLs or unknown present in the age column
- Age will be used for segmentation to compare subscription rates across different age groups
- Age may be grouped into ranges during analysis to simplify comparisons and identify patterns in behavior
- Exact group boundaries will be defined during EDA based on the distribution of the data

### Balance column
- No NULLs or unknown present, making it usable for analysis
- 7,280 clients have balances of zero or below, while 37,931 clients have positive balances
- Clients with zero or negative balances may indicate financial constraints, which could influence subscription behavior
- Balance will be used for segmentation to compare subscription rates across different financial profiles


### Poutcome column
- No NULLs present
- 36,959 clients have an 'unknown' poutcome. While 4,901 have a 'failed' outcome, 1,840 have an 'other' outcome, and 1,511 have a 'successful' outcome.
- The unknown category may represent either clients not previously contacted or missing historical data, so it should be interpreted cautiously
- Poutcome will be kept and unknown will be treated like its own category
- This will be utilized for segmentation to see the comparison of clients with a known vs unknown previous campaign outcomes and their subscription rates during A/B analysis.
- Clients with a previous "success" outcome may be more responsive to current marketing efforts

### Education column
- No NULLs present
- 23,202 clients have secondary education, followed by 13,301 with tertiary education, 6,851 with primary education, and 1,857 with 'unknown' educational attainment
- The 'unknown' category may represent missing historical data and should be interpreted cautiously
- Unknown will be kept and treated as its own category
- This will be used for segmentation to compare subscription rates based on educational attainment.

Since this is observational data, differences in outcomes may be influenced by underlying client characteristics rather than contact frequency alone