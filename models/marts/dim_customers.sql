SELECT
    customer_id,
    first_name,
    last_name,
    email,
    phone_number,
    country_code
FROM {{ ref('stg_customers') }}