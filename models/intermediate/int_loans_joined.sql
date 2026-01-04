/*
    This model creates a dataset of throughout loan journeys by joining loan applications, customers, and loans data.
    Further calculating key metrics such as time to issuance and outstanding principal amounts.
*/
WITH applications AS (
    SELECT 
        * 
    FROM 
        {{ ref('stg_loan_applications') }}
),
customers AS (
    SELECT 
        * 
    FROM 
        {{ ref('stg_customers') }}
),
loans AS (
    SELECT 
        * 
    FROM 
        {{ ref('stg_loans') }}
)

SELECT
    loans.loan_id,
    applications.application_id,
    customers.customer_id,
    applications.product_id,
    applications.country_code,
    applications.application_started_at,
    loans.loan_issued_at,
    DATE_DIFF('day', applications.application_started_at, loans.loan_issued_at) AS application_to_issuance_days, -- Application to loan issuance date
    loans.loan_status,
    applications.requested_amount AS applied_loan_amount,
    applications.loan_amount AS principal_amount,
    loans.principal_paid_total,
    loans.interest_paid_total,
    CASE
        WHEN loans.loan_status = 'Repaid' THEN 0 
        ELSE (applications.loan_amount - loans.principal_paid_total)
    END AS principal_outstanding_amount
FROM
    loans
LEFT JOIN 
    applications 
USING
    (loan_id)
LEFT JOIN 
    customers 
USING 
    (customer_id)