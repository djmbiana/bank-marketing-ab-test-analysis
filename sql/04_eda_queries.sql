-- ============================================
--               EDA QUERIES
-- ============================================

-->>> inital row analysis<<<

-- shows the row count of each 'y' 
SELECT y
       , COUNT(*) AS total_rows
FROM bank_marketing_clean
GROUP BY y;

-- shows the conversion rate percentage
SELECT ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage 
FROM bank_marketing_clean;

-- checks the successful conversion rate between the two groups
SELECT contact_group 
        , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage  
FROM bank_marketing_clean
GROUP BY contact_group;

-- counts the amount of clients who are low contact and high contact as well as their conversion
SELECT contact_group
       , COUNT(*) AS total_clients
       , COUNT(CASE WHEN y = 'no' THEN 1 END) AS no_count
       , COUNT(CASE WHEN y = 'yes' THEN 1 END) AS yes_count
FROM bank_marketing_clean
GROUP BY contact_group;

-- shows the conversion percentages of both groups
SELECT contact_group 
        , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage 
FROM bank_marketing_clean
GROUP BY contact_group;

-->> supporting variable analysis<<

-- Contact

-- Shows the contact method and the amount of clients per contact method, as well as their conversion rates
SELECT contact
       , COUNT(*) AS total_rows
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM bank_marketing_clean
GROUP BY contact;

-- Segmented with our A/B groups
SELECT contact_group
       , contact
       , COUNT(*) AS total_rows
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM bank_marketing_clean
GROUP BY contact_group
         , contact
ORDER BY contact_group;

-- month
SELECT month
       , COUNT(*) AS total_clients
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM bank_marketing_clean
GROUP BY month;

-- Segmenting it with A/B groups
SELECT contact_group
       , month
       , COUNT(*) AS total_clients
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM bank_marketing_clean
GROUP BY contact_group
         , month
HAVING COUNT(*) >= 1000
ORDER BY contact_group;


-->> segementation variable analysis <<

-- age divided into quartiles, getting the MIN and MAX per quartile to show the age range
-- the conversion rate per age range is also taken
WITH age_quartile AS (
    SELECT *
           , NTILE(4) OVER (ORDER BY age) AS age_group
    FROM bank_marketing_clean
)

SELECT age_group
       , MIN(age) AS min_age
       , MAX(age) AS max_age
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM age_quartile
GROUP BY age_group
ORDER BY age_group;

-- segmented age into our A/B groups
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

-- job

-- Total client count and conversion rates 
SELECT job
       , COUNT(*) AS total_clients
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM bank_marketing_clean
GROUP BY job
HAVING COUNT(*) >= 1000
ORDER BY yes_percentage DESC;

-- Segemented job into A/B groups
SELECT contact_group
       , job
       , COUNT(*) AS total_clients
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM bank_marketing_clean
GROUP BY contact_group 
         , job
HAVING COUNT(*) >= 1000
ORDER BY contact_group ASC 
         , yes_percentage DESC;

-- balance 

-- CTE
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

-- Queries which use the CTE

-- Conversion rates per balance_group
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

-- AVG balance of yes_conversion and no_conversion < DO TOMORROW
SELECT balance_group
       , ROUND(AVG(CASE WHEN y = 'yes' THEN balance END), 2) AS avg_yes_balance
       , ROUND(AVG(CASE WHEN y = 'no' THEN balance END), 2) AS avg_yes_balance
FROM balance_grouped
GROUP BY balance_group;

-- education

-- poutcome

-- total row count, with their conversion rates
WITH poutcome_analysis AS (
    SELECT *
           , CASE
                WHEN poutcome IN ('success', 'other', 'failure') THEN 'known'
                ELSE poutcome
            END AS poutcome_clean
    FROM bank_marketing_clean
)

SELECT contact_group
       , poutcome_clean
       , COUNT(*) AS total_rows
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM poutcome_analysis
GROUP BY contact_group
         , poutcome_clean
ORDER BY poutcome_clean;

-- How does this segmentation affect our A/B groups?
WITH poutcome_analysis AS (
    SELECT *
           , CASE
                WHEN poutcome IN ('success', 'other', 'failure') THEN 'known'
                ELSE poutcome
            END AS poutcome_clean
    FROM bank_marketing_clean
)

SELECT contact_group
       , poutcome_clean
       , COUNT(*) AS total_rows
       , ROUND(
            COUNT(CASE WHEN y = 'yes' THEN 1 END) * 100.0 / COUNT(*),
            2) AS yes_percentage 
       , ROUND(
            COUNT(CASE WHEN y = 'no' THEN 1 END) * 100.0 / COUNT(*),
             2) AS no_percentage
FROM poutcome_analysis
GROUP BY contact_group
         , poutcome_clean
ORDER BY poutcome_clean;