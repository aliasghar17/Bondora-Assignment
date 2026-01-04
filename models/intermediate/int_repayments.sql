{{ 
    config(
    materialized='table'
    ) 
}}
/*
    This model aggregates repayment data to provide a summary of repayments per loan.
    It calculates total principal paid, interest paid, fees paid, and other key metrics.
*/
WITH repayment_data AS (
    SELECT 
        * 
    FROM 
        {{ ref('stg_repayments') }}
)

SELECT
    loan_id,
    -- Aggregations
    SUM(principal_paid) AS principal_paid_total,
    SUM(interest_paid) AS interest_paid_total,
    SUM(maintenance_fee_paid) AS fees_paid_total,
    -- Dates
    MIN(report_date) AS first_repayment_date,
    MAX(report_date) AS last_repayment_date,
    
    COUNT(*) AS number_of_repayments, -- Total number of repayments made
    
    SUM(principal_paid + interest_paid + maintenance_fee_paid) AS collections_total -- Total amount collected

FROM repayment_data
GROUP BY 1