-- ============================================
--              DATA CHECKS  
-- ============================================

-- --------------------------------------------
--  target variable (y column)
-- --------------------------------------------
SELECT COUNT(CASE WHEN y = 'yes' THEN 1 END) AS yes_count
       , COUNT(CASE WHEN y = 'no' THEN 1 END) AS no_count
       , COUNT(CASE WHEN y = 'unknown' THEN 1 END) AS unknown_count
       , COUNT(CASE WHEN y IS NULL THEN 1 END) AS null_count
FROM bank_marketing_raw;

-- -------------------------------------------------
--  treatment variable (campaign column)
-- -------------------------------------------------

-- checking for zeroes and nulls
SELECT COUNT(CASE WHEN campaign = 0 THEN 1 END) AS zero_count
       , COUNT(CASE WHEN campaign IS NULL THEN 1 END) AS null_count
FROM bank_marketing_raw;

-- counting the amount of calls per campaign value
SELECT campaign
       , COUNT(campaign) AS campaign_count
FROM bank_marketing_raw
GROUP BY campaign
ORDER BY campaign;

-- --------------------------------------------
-- supporting variables
-- --------------------------------------------

-- >>> contact ccolumn <<<

-- checking CONTACT types and their counts
SELECT contact
       , COUNT(contact)
       , COUNT(CASE WHEN contact IS NULL THEN 1 END) AS null_count
FROM bank_marketing_raw
GROUP BY contact;

-- >>> month & day column <<<

-- Checking month count and days
SELECT month
       , COUNT(day)
FROM bank_marketing_raw
GROUP BY month;

-- --------------------------------------------
-- segmentation variables
-- --------------------------------------------

-- >>> Job Column <<<
SELECT job
       , COUNT(*) AS total_rows
       , COUNT(job) AS non_null_count
       , COUNT(*) - COUNT(job) AS null_count
FROM bank_marketing_raw
GROUP BY job;

-- >>> Age column <<<
SELECT COUNT(*) 
       , COUNT(age) AS non_null
       , COUNT(*) - COUNT(age) AS null_values
FROM bank_marketing_raw;

-- >>> Balance column <<< 
SELECT COUNT(*) AS total_rows 
       , COUNT(balance) AS non_null_rows
       , COUNT(*) - COUNT(balance) AS null_rows
       , COUNT(CASE WHEN balance <= 0 THEN 1 END) AS zero_negative_balance
       , COUNT(CASE WHEN balance > 0 THEN 1 END) AS non_zero_balance
FROM bank_marketing_raw;

-- >>> Poutcome column <<<
SELECT poutcome
       , COUNT(*) AS total_rows
       , COUNT(poutcome) AS non_null_rows
       , COUNT(*) - COUNT(poutcome) AS null_rows
FROM bank_marketing_raw
GROUP BY poutcome
ORDER BY non_null_rows DESC;

-- >>> Education column <<<
SELECT education
       , COUNT(*) AS total_rows
       , COUNT(education) AS non_null_rows
       , COUNT(*) - COUNT(education) AS null_rows
FROM bank_marketing_raw
GROUP BY education
ORDER BY non_null_rows DESC;