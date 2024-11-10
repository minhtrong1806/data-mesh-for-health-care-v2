WITH MSPB_raw AS (
    SELECT
        "Facility ID" AS facility_id,
        "Measure ID" AS measure_id,
        "Measure Name" AS measure_name,
        CAST("Score" AS FLOAT) AS score,
        "Start Date" AS start_date,
        "End Date" AS end_date
    FROM {{source("cost-value","Medicare_Hospital_Spending_Per_Patient-Hospital.csv")}} 
    WHERE Score NOT IN ('Not Available'))

SELECT
    facility_id,
    measure_id,
    measure_name,
    score,
    start_date,
    end_date
FROM MSPB_raw