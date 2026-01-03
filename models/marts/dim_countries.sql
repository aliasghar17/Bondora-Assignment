SELECT
    country_code,
    country_name
FROM
    {{ ref('stg_countries') }}