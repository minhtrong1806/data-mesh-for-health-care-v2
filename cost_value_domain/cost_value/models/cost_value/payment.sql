WITH payment_raw AS (
    SELECT
        "Facility ID" AS facility_id,
        "Payment Measure ID" AS payment_measure_id,
        "Payment Measure Name" AS payment_measure_name,
        "Payment Category" AS payment_category,
        "Denominator" AS denominator,
        CAST(REPLACE(REPLACE("Payment", '$', ''), ',', '') AS DECIMAL(10, 2)) AS payment,
        "Start Date" AS start_date,
        "End Date" AS end_date
    FROM {{source("cost-value","Payment_and_Value_of_Care-Hospital.csv")}} 
    WHERE payment NOT IN ('Not Available'))

SELECT
    facility_id,
    payment_measure_name,
    payment_category,
    denominator,
    payment,
    start_date,
    end_date
FROM payment_raw