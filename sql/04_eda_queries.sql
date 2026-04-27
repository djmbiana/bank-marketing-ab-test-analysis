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