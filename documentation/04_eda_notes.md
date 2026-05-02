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

## Supporting variable insights

### Contact method
- This will give us insight if conversion rates differ by contact method
  - Cellular: Successful conversion (14.92%) vs Unsuccessful conversion (85.08%)  
  - Unknown: Successful conversion (4.07) vs Unsuccessful conversion (95.93%)
  - Telephone: Successful conversion (13.42%) vs Unsuccessful conversion (86.58%) 
- Conversion rates are similar between Cellular (14.92%) and Telephone (13.42%) 
- The 'unknown' category shows a significantly lower conversion rate (4.07%)
- This may reflect missing or incomplete contact data rather than a true contact method
- Note: The amount of unknown contact methods may reflect missing logging, so interpretations were made cautiously 

#### Segmenting contact with A/B groups
- When segmenting contact with our A/B groups, higher conversion rates for Low Contact groups are observed across contact methods
    - Low contact:
      - Telephone: 17.01%
      - Cellular: 16.76%
      - Unknown: 4.28%
    - High contact:
      - Cellular: 11.05%
      - Telephone: 8.89%
      - Unknown: 3.65%
- This tells us that the lower conversion rate in High Contact groups is consistent across different contact methods
- While the pattern remains consistent, the magnitude of the difference between Low and High Contact groups varies slightly across contact methods


### Month & day 
- Month will be used to analyze potential seasonal effects influencing subscription rates
- May had the highest volume of client contacts (13,766) but also one of the lowest conversion rates (6.72%)
- March shows the highest conversion rate (51.99%) but is one of the lowest-volume months (477), making it less reliable
- Months with higher conversion rates often have low sample sizes, which may inflate percentages and reduce reliability
- To address this, we will focus on months with total_clients >= 1000 to ensure more stable estimates
- Within the high volume months, the pattern of lower conversion rates in high contact groups remains consistent

## Segmentation Insights

### Age
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

#### Segmenting Age with A/B Groups
- When segmented with our A/B groups, the pattern of higher conversions among Low Contact clients persists across the quartile 
    - Group 1: Low Contact (15.59%) vs High Contact (10.58%)
    - Group 2: Low Contact (11.37%) vs High Contact (8.54%)
    - Group 3: Low Contact (10.22%) vs High Contact (7.00%)
    - Group 4: Low Contact (15.42%) vs High Contact (9.14%)
- This indicates that the lower conversion rate in High Contact groups is consistent regardless of age

### Job
- Job will be used to compare subscription rates across occupations and provide context with our A/B groups
- The 'unknown' within the job column will be treated with caution as this may represent missing historical data 
- Occupations which have fewer clients may inflate the subscription rates of those occupations. 
  - To address this, we will only be looking at occupations where total_clients >= 1000
- Retired clients show the highest successful conversion rate (22.79%), though this should be interpreted alongside sample sizes and other factors
- Higher conversion rates are observed across a range of occupantions (e.g., management, admin, unemployed), rather than being concentrated on a single group
  - With this in mind, we can say that occupation shows some variation in conversion rates, though differences across most occupations are relatively modest 
  - the 22.79% of retired does support and give context on the age column, where elderly registered as having higher conversion rates

#### Segmenting Job with A/B Groups
- Segmenting it into our A/B groups, we can see that the pattern of higher conversion rates in Low Contact groups persists across occupations 
    - Management: Low Contact (15.41%) vs High Contact (10.68%)
    - Admin: Low Contact (13.63%) vs High Contact (8.81%)
    - Technician: Low Contact (12.60%) vs High Contact (8.21%)
- This indicates that the lower conversion rate in High Contact groups is consistent regardless of occupation
  

### Balance

#### Grouping balance for effective analysis
- Prior to analysis:
  - Isolate the account balances of balance > 0 and balance <= 0 (Done by labeling each account 'Positive' or 'Non-Positive')
  - After the Positive accounts have been isolated, we will group them by balanced bins for analysis. This will be for statistical balance and stability 
  - Lastly, we will combine the isolated Positives back with the Negative accounts to create more structured groupings known as:
    - Non-Positive
    - Low Balance
    - Mid Balance
    - High Balance

#### Conversion rates
- Successful conversion rates increase steadily across balance groups
  - Non-Positive: 6.90%
  - Low Balance: 9.86%
  - Mid Balance: 12.27%
  - High Balance: 15.72%
- This suggests a clear positive association between account balance and conversion rate
 
#### AVG balance
- Average account balance of clients who said yes vs clients who said no   
- account balance of clients who had successful conversion rates:
  - Non-Positive: -126.70
  - Low Balance: 158.20
  - Mid Balance: 710.74
  - High Balance: 4178.09
- Account balance of clients who did not have successful conversion rates:
  - Non-Positive: -167.12
  - Low Balance: 140.88
  - Mid Balance: 688.54
  - High Balance: 4123.58 
- While conversion rates differ from each balance group, the average balance per balance group is similar between converters and non-converters

#### Segmenting Balance with A/B groups 
- Lower conversion rates in High Contact groups persist even when controlling for client balance  
- This indicates that the observed A/B pattern is consistent across different balance segments and is not explained by different client account balances 


### Education
- We will be comparing conversion rates based on the educational attainment of each client
- This will be interpreted cautiously as the 'unknown' category may represent missing data
- Individuals with tertiary education have the highest successful conversion rates (15.01%)
- The remaining groups show similar conversion rates,   suggesting a limited association of client educational attainment and conversion rates

#### Segmenting it with A/B groups
- Higher conversion rates in Low Contact groups remain persistent even when segmented by education attainment of clients
- This gives us insight that the observed A/B pattern is consistent across different education attainment however results involving the 'unknown' category should be interpreted cautiously

### Poutcome
- poutcome is the previous outcome of past marketing campaigns by the bank
- We will be comparing 'unknown' poutcome results with 'known' ones by grouping all of the known poutcome results under one category known as 'known'
  - It is important to note that the unknown category may represent either clients not previously contacted or missing historical data, so these interpretations should be taken cautiously
- In the dataset, there 36,959 clients with unknown history while 8252 have known history
- Clients with known poutcome history show significantly higher conversion rates compared to clients who have unknown poutcome history
- The difference is meaningful (23.06% vs 9.16%), suggesting that prior campaign outcomes are associated with client conversion rates 

#### Segmented poutcome with A/B Groups
- When segmented with our A/B groups, the pattern of lower conversion among High Contact clients persists across both segments
    - Unknown: Low Contact (10.19%) vs High Contact (7.32%)
    - Known: Low Contact (24.52%) vs High Contact (18.39%)
- This indicates that lower conversion rates in High Contact groups are consistent across different client histories 
- Keep in mind, this pattern may reflect underlying client behavior rather than contact frequency alone, as group assignment is not random.

## Synthesis

### What stayed consistent?
The main consistency within the Bank's Marketing campaigns is that Low Contact clients have higher successful conversion rates compared to High Contact clients. This pattern is observed across the following client segments:
- age
- job
- education
- month
- balance
- poutcome
This reveals that the observed A/B pattern is robust and persits regardless of differences in client characteristics.

### What actually influences conversion?


### What surprised me?

### What's the limitation?

### Business implications

### Reccomendations

### Suggest next steps