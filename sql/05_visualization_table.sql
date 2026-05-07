-- ============================================
--            VISUALIZATION TABLE
-- ============================================
-- We will be exporting necessary columns and groups for the building of our dashboard
-- Alot of the columns that will not be used during visualization will be trimmed
-- Run this via `psql` in the terminal

\copy (
    SELECT id
           , y
           , CASE
                WHEN y = 'yes' THEN 1 
                ELSE 0
             END AS conversion
            , CASE
                WHEN campaign BETWEEN 1 AND 2 THEN 'Low Contact'
                WHEN campaign >= 3 THEN 'High Contact'
                ELSE 'Unknown'
              END AS contact_group
            , CASE 
                WHEN age BETWEEN 18 AND 33 THEN '18-33'
                WHEN age BETWEEN 34 AND 39 THEN '33-39'
                WHEN age BETWEEN 40 AND 48 THEN '40-48'
                WHEN age BETWEEN 49 AND 95 THEN '49-95'
                ELSE 'Unknown'
              END AS age_group
            , CASE 
                WHEN balance <= 0 THEN 'Non-Positive'
                WHEN balance BETWEEN 1 AND 335 THEN 'Low Balance'
                WHEN balance BETWEEN 336 AND 1241 THEN 'Mid Balance'
                WHEN balance >= 1242 THEN 'High Balance'
              ELSE 'Unknown'
              END AS balance_group
            , poutcome
            , job 
            , education
            , month
            , balance
    FROM bank_marketing_clean
) TO 'bank_marketing_dashboard.csv' CSV HEADER;