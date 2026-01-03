SELECT
    product_id,
    product_name
FROM {{ ref('stg_loan_products') }}