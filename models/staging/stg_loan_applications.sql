SELECT
    CAST(application_id AS VARCHAR) AS application_id,
    CAST(applicant_id AS VARCHAR) AS customer_id,
    UPPER(country_code) AS country_code,
    CAST(loan_product_type_id AS VARCHAR) AS product_id,
    CAST(application_started_at AS TIMESTAMP) AS application_started_at,
    CAST(requested_amount AS DECIMAL(18,2)) AS requested_amount,
    CAST(issued_loan_id AS VARCHAR) AS loan_id,
    CAST(loan_issued_at AS TIMESTAMP) AS loan_issued_at,
    CAST(issued_amount AS DECIMAL(18,2)) AS loan_amount
FROM
    read_csv_auto('source_data/loanapplications.csv')