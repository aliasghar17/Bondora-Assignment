SELECT
    CAST(loan_id AS VARCHAR) AS loan_id,
    CAST(report_date AS DATE) AS report_date,
    CAST(principal_balance AS DECIMAL(18,2)) AS principal_balance,
    CAST(principal_debt AS DECIMAL(18,2)) AS principal_debt,
    CAST(principal_paid AS DECIMAL(18,2)) AS principal_paid,
    CAST(interest_paid AS DECIMAL(18,2)) AS interest_paid,
    CAST(maintenance_fee_paid AS DECIMAL(18,2)) AS maintenance_fee_paid
FROM
    read_csv_auto('source_data/repayments.csv')