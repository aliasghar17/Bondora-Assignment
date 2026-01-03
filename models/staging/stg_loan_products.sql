SELECT
    CAST(loanPproductTypeId AS VARCHAR) AS product_id,
    CAST(loanProductType AS VARCHAR) AS product_name
FROM
    read_csv_auto('source_data/loan_product.csv')