/*
    This model creates the fact table for loans by combining loan details with aggregated repayment data.
    It includes key financial metrics and performance indicators for each loan.
*/
WITH loans AS (
    SELECT 
        * 
    FROM 
        {{ ref('int_loans_joined') }}
),

repayments AS (
    SELECT 
        * 
    FROM 
        {{ ref('int_repayments') }}
)

SELECT
    -- Keys
    loans.loan_id,
    loans.application_id,
    loans.customer_id,
    loans.product_id,
    loans.country_code,

    -- Loan Status & Timing
    loans.loan_status,
    loans.loan_issued_at,
    loans.application_to_issuance_days,

    -- Principle Amount Financial Facts 
    loans.applied_loan_amount,
    loans.principal_amount,
    loans.principal_paid_total,
    COALESCE(repayments.principal_paid_total, 0) AS principal_paid_verified, -- Reconciled principal paid
    loans.principal_outstanding_amount,

    -- Other Financial Facts 
    loans.interest_paid_total,
    COALESCE(repayments.fees_paid_total, 0) AS fees_paid_total,
    COALESCE(repayments.collections_total, 0) AS collections_total,

    -- Performance Metrics
    COALESCE(repayments.number_of_repayments, 0) AS number_of_repayments,
    repayments.first_repayment_date,
    repayments.last_repayment_date,
    CASE
        WHEN loans.loan_status = 'Active'
        THEN DATE_DIFF('day', repayments.last_repayment_date, CURRENT_DATE)
        ELSE NULL
    END AS days_since_last_repayment, -- Potential risk factor for active loans

    -- Flag: Is the loan principal fully recovered?
    CASE 
        WHEN COALESCE(repayments.principal_paid_total, 0) >= loans.principal_amount THEN TRUE 
        ELSE FALSE 
    END AS is_principal_recovered

FROM 
    loans
LEFT JOIN 
    repayments 
USING 
    (loan_id)