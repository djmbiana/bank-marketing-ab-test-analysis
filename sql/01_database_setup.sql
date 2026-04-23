-- Setup: Bank Marketing Analysis
CREATE TABLE bank_marketing_raw (
    id SERIAL PRIMARY KEY
    , age INT
    , job TEXT
    , marital TEXT
    , education TEXT
    , default_status TEXT
    , balance NUMERIC
    , housing TEXT
    , loan TEXT
    , contact TEXT
    , day INT
    , month TEXT
    , duration INT
    , campaign INT
    , pdays INT
    , previous INT
    , poutcome TEXT
    , y TEXT
);

-- Load Data (Note: This was run in the terminal via the psql command)
-- \copy bank_marketing_raw(
--     age, job, marital, education, default_status, balance,
--     housing, loan, contact, day, month, duration,
--     campaign, pdays, previous, poutcome, y
-- )
-- FROM 'data/raw/bank-full.csv'
-- DELIMITER ';'
-- CSV HEADER;

-- Confirmation
SELECT COUNT(*) FROM bank_marketing_raw;