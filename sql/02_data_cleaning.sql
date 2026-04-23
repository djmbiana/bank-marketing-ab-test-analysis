-- Checking the target vairable (y column)
SELECT COUNT(CASE WHEN y = 'yes' THEN 1 END) AS yes_count
       , COUNT(CASE WHEN y = 'no' THEN 1 END) AS no_count
       , COUNT(CASE WHEN y = 'unknown' THEN 1 END) AS unknown_count
       , COUNT(CASE WHEN y IS NULL THEN 1 END) AS null_count
FROM bank_marketing_raw;

-- Checking the treatment variable (campaign column)
-- UNKNOWN is not checked as campaign is an integer

-- Checking for zeroes and nulls
SELECT COUNT(CASE WHEN campaign = 0 THEN 1 END) AS zero_count
       , COUNT(CASE WHEN campaign IS NULL THEN 1 END) AS null_count
FROM bank_marketing_raw;

-- Counting the amount of calls per campaign value
SELECT campaign
       , COUNT(campaign) AS campaign_count
FROM bank_marketing_raw
GROUP BY campaign
ORDER BY campaign;

-- Checking CONTACT types and their counts
SELECT contact
       , COUNT(contact)
       , COUNT(CASE WHEN contact IS NULL THEN 1 END) AS null_count
FROM bank_marketing_raw
GROUP BY contact;

-- Checking month count and days
SELECT month
       , COUNT(day)
FROM bank_marketing_raw
GROUP BY month;

-- Supporting columns
-- Job Column
SELECT job
       , COUNT(job) AS job_count
       , COUNT(CASE WHEN job IS NULL THEN 1 END) AS null_count
FROM bank_marketing_raw
GROUP BY job;