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


-->> segementation variable analysis <<

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
GROUP BY contact_group, poutcome_clean
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
GROUP BY contact_group, poutcome_clean
ORDER BY poutcome_clean;