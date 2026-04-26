-- ============================================
--              DATA CLEANING SCHEMA
-- ============================================

-- >> bank_marketing_clean is based on: << 
-- 02_data_checks
-- data_cleaning_notes
CREATE TABLE bank_marketing_clean (
    id SERIAL PRIMARY KEY 
    , y TEXT
    , campaign INT
    , contact_group TEXT GENERATED ALWAYS AS (
        CASE
            WHEN campaign BETWEEN 1 AND 2 THEN 'Low Contact'
            WHEN campaign >= 3 THEN 'High Contact'
            ELSE 'Unknown'
        END
    ) STORED
    , contact TEXT 
    , month TEXT
    , day INT
    , age INT
    , job TEXT
    , education TEXT
    , balance NUMERIC
    , poutcome TEXT
);

-- >>> Inserts the data from the raw table <<<

INSERT INTO bank_marketing_clean (
    y, campaign, contact, month, day, 
    age, job, education, balance, poutcome
)
SELECT y
       , campaign
       , contact 
       , month
       , day
       , age
       , REPLACE(job, '.', '') AS job
       , education
       , balance
       , poutcome
FROM bank_marketing_raw