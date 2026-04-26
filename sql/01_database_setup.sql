-- ============================================
--              DATABASE SETUP 
-- ============================================

-- >>> database creation <<<
-- PostgreSQL will be used for this project
-- Execute in PostgreSQL (psql)
-- CREATE DATABASE bank_marketing

-- >>> bank marketing table <<<
-- bank_marketing_raw contains the raw CSV data
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

-- >>> Loading the data into the Postgres table <<<
-- Load Data (Note: This was run in the terminal via the psql command)
-- \copy bank_marketing_raw(
--     age, job, marital, education, default_status, balance,
--     housing, loan, contact, day, month, duration,
--     campaign, pdays, previous, poutcome, y
-- )
-- FROM 'data/raw/bank-full.csv'
-- DELIMITER ';'
-- CSV HEADER;

-- >>> Sanity check: Row Count <<<
SELECT COUNT(*) 
FROM bank_marketing_raw;