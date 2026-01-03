SELECT
    UPPER(CountryCode) AS country_code,
    CountryName AS country_name
FROM
    read_json_auto('source_data/countries.json')