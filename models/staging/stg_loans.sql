SELECT
    CAST(loan_id AS VARCHAR) AS loan_id,
    loan_status,
    CAST(loan_issued_at AS TIMESTAMP) AS loan_issued_at,
    CAST(loan_repaid_at AS TIMESTAMP) AS loan_repaid_at,
    CAST(principal_balance AS DECIMAL(18,2)) AS principal_balance,
    CAST(principal_debt AS DECIMAL(18,2)) AS principal_debt,
    CAST(principal_paid_total AS DECIMAL(18,2)) AS principal_paid_total,
    CAST(interest_paid_total AS DECIMAL(18,2)) AS interest_paid_total,
    CAST(maintenance_fee_paid_total AS DECIMAL(18,2)) AS maintenance_fee_paid_total
FROM
    read_csv_auto('source_data/loans.csv')