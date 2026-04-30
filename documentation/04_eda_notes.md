# EDA 

## Overall Conversion
- From 45,211 recorded clients:
  - 39,992 did not subscribe to the bank's term deposit while 5289 did subscribe to the term deposit
  - 88.30% don't end up subscribing
  - 11.70% of clients are the ones who end up subscribing 

## A/B Comparison
- Grouping the clients into Low Contact and High contact offers more context to the conversion rates
  - 30,049 clients have been contacted 1-2 times (Low Contact)
  - 15,162 clients have been contacted 3+ times (High Contact) 
- Splitting into conversion rates, we can see the following
    - Low contact: 
      - 13.19% of clients do subscribe
      - 86.81% of clients don't subscribe
    - High contact:
      - 8.75% of clients do subscribe
      - 91.25% of clients don't subscribe

## Key Observation
- Groups are uneven in size. Low contact has 30,049 clients while High contact has 15,162 clients.
- Low contact shows higher conversion rates (13.19%) than high contact (8.75%)
- This pattern counters our inital hypothesis of more contact = higher conversion rate
- Group assignment is likely not random as clients in High Contact may be harder to convert or require repeated follow-ups
- The observed difference may reflect underlying client characteristics rather than contact frequency alone

## Segmentation Insights

### age
- We divided the ages within the dataset into quartiles. This is so that the age ranges can have a similar number of clients
  - Group 1: 18-33 
  - Group 2: 33-39
  - Group 3: 39-48
  - Group 4: 48-95
- Successful conversion rates are relatively similar across age groups, ranging from ~9% to ~14%  
  - Group 1: 14.04%
  - Group 2: 10.43%
  - Group 3: 9.07%
  - Group 4: 13.25%
- There is a slight dip among middle age clients (33-48), with higher rates observed in the youngest and oldest groups
- This suggests that age appears to have a limited association with conversion rates
- When segmented with our A/B groups, the pattern of higher conversions among Low Contact clients persists across the quartile 
    - Group 1: Low Contact (15.59%) vs High Contact (10.58%)
    - Group 2: Low Contact (11.37%) vs High Contact (8.54%)
    - Group 3: Low Contact (10.22%) vs High Contact (7.00%)
    - Group 4: Low Contact (15.42%) vs High Contact (9.14%)
- This indicates that the lower conversion rate in High Contact groups is consistent regardless of age

### job

### balance

### education

### poutcome
- poutcome is the previous outcome of past marketing campaigns by the bank
- We will be comparing 'unknown' poutcome results with 'known' ones by grouping all of the known poutcome results under one category known as 'known'
  - It is important to note that the unknown category may represent either clients not previously contacted or missing historical data, so these interpretations should be taken cautiously
- In the dataset, there 36,959 clients with unknown history while 8252 have known history
- Clients with known poutcome history show significantly higher conversion rates compared to clients who have unknown poutcome history
- The difference is meaningful (23.06% vs 9.16%), suggesting that prior campaign outcomes are associated with client conversion rates 
- When segmented with our A/B groups, the pattern of lower conversion among High Contact clients persists across both segments
    - Unknown: Low Contact (10.19%) vs High Contact (7.32%)
    - Known: Low Contact (24.52%) vs High Contact (18.39%)
- This indicates that lower conversion rates in High Contact groups are consistent across different client histories 
- Keep in mind, this pattern may reflect underlying client behavior rather than contact frequency alone, as group assignment is not random.

### what changed? what stood out? is what i should write here