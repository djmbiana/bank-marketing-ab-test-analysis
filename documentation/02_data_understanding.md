# Data Understanding

## Columns that are present and what they mean

| Column | Data Type | Meaning |
| --- | --- | --- |
| age | Integer | The age of the client that was called |
| job | Text | Lists the type of occupation that the contacted client works for.  (Categorical with the following values: "admin","unknown","unemployed","management","housemaid","entrepreneur","student", "blue-collar","self-employed","retired","technician","services") |
| marital | Text | Lists the marital status of the client (Categorical with the following values: "married","divorced","single"; note: "divorced" means divorced or widowed) |
| education | Text | Lists the education level of the client ( Categorical with the following values: "unknown","secondary","primary","tertiary") |
| default | Boolean (Yes or No) | Checks if the client has failed to pay off a loan |
| balance | Numeric | Average yearly balance of the client |
| housing | Binary | Checks if the client has a housing loan |
| loan | Binary | Checks if the client has a personal loan |
| contact | Text | The communication type used to contact the client (Categorical with the following values: "unknown","telephone","cellular") |
| day_of_week | Date | Day of the month when the last contact occurred |
| month | Date | Month when the last contact occurred |
| duration | Integer | Call duration in seconds per client. Affects the output (Ex: if duration = 0 then y = 'no'). The duration is not known until after a call is performed. |
| campaign | Integer | Number of times the client was called during the campaign |
| pdays | Integer | Number of days that have passed since the client was contacted (from a previous campaign). '-1' means the contact was not contacted previously. |
| previous | Integer | Number of contacts performed before this campaign for the specific client |
| poutcome | Text | Outcome of the previous marketing campaign (Categorical with the following valeus: "unknown","other","failure","success") |
| y   | Binary | Checks if the client subscribing to a term deposit |

## Core Columns

### Target variable

- *y*  
    - This column indicates whether the customer subscribed to the term deposit (yes/no)

### Treatment variable

- *campaign*
    - This column represents the number of contacts and will be used to analyze whether increased contact frequency is associated with higher subscription rates

### Supporting variables

- These columns add support to why a specified effect happened
    - contact: The type of communication used with the client
    - month, day_of_week: The day and month in which the call happened
- NOTE:  The duration variable will be excluded from the analysis as it is only known AFTER the call and directly influences the outcome

### Segmentation variables

- These are customer characteristics that will prove useful
    - age
    - job
    - balance
    - education
    - default
    - housing
    - loan
- age, job, and balance provide insight into the customer’s demographic and financial profile.
- The education, default, housing, and loan provide insight into the customer’s financial stability and obligations

## Key Variables Summary

This analysis aims to answer the question: “Is increased contact frequency associated with higher subscription rates?”

The *y* column is used as the target variable, indicating whether a client subscribed to the term deposit (yes/no). The treatment variable is *campaign,* which represents the number of times a client was contacted and it is used to analyze whether increased contact frequency is associated with higher subscription rates.

Additional variables such as *contact* and *month and day_of_week* provide context on how and when clients were contacted. The *duration* variable is excluded, as it is only known after the call has ended and may lead to misleading conclusions (ex. longer call duration appearing to increase subscription likelihood)