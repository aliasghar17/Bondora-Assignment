SELECT
    CAST(borrower_id AS VARCHAR) AS customer_id,
    UPPER(country_of_residency) AS country_code,
    first_name,
    last_name,
    CAST(phone_number AS VARCHAR) AS phone_number,
    email
FROM
    read_csv_auto('source_data/customers.csv')