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
    -- Financial Aggregations
    SUM(principal_paid) AS principal_paid_total,
    SUM(interest_paid) AS interest_paid_total,
    SUM(maintenance_fee_paid) AS fees_paid_total,
    -- Date Aggregations
    MIN(report_date) AS first_repayment_date,
    MAX(report_date) AS last_repayment_date,
    
    -- Transactional metrics
    COUNT(*) AS number_of_repayments,
    
    -- Total cash collected from this loan
    SUM(principal_paid + interest_paid + maintenance_fee_paid) AS collections_total

FROM repayment_data
GROUP BY 1