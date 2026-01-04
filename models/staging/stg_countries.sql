SELECT
    CAST(UPPER(CountryCode) AS VARCHAR) AS country_code,
    CAST(CountryName AS VARCHAR) AS country_name
FROM
    read_json_auto('source_data/countries.json')