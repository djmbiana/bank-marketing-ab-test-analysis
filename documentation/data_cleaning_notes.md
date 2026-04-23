# Data Cleaning

## Notes before cleaning:
- This dataset uses "unknown" to represent missing values
- Most of the time, unknown is used over NULL
- To address this, i chose to check for both 'unknown' and NULL
- Unknowns will be treated as NULL's. It may simplify analysis but it could remove some of the information
- Both NULL and Unknown will be filtered out for variables used in grouping/overall metrics. However, NULL and unknown will be reatined when these variables when they carry meaning (ex: contact)

## Target variable: (y)
- No NULL, 'unknown', or missing values.
- Only contains 'yes' or 'no' values.
- The number of 'no' responses is significantly higher than 'yes'

## Treatment variable: campaign
- No NULL or zero values within the campaign
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
- It will be used for segmentation checks (e.g.comparing conversion rates by contact method) and as a contextual support when interpreting A/B results
- The large number of unknowns might reflect missing logging rather than a true category, so interpretations involving these unknowns should be made cautiously

### Month & day columns
- No NULLs or Unknowns, making these fields clean and ready for analysis.
- month is a text field and day is an integer field
- These variables can be used to analyze the number of subscriptions by month as a contextual support when interpreting A/B results
- The month may help when trying to capture seasonal effects that influence subscription rates
- Since month is stored as text, it may require transformation for proper ordering during analysis