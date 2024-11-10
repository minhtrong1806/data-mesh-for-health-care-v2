WITH infection_raw AS (     
    SELECT 
        "Facility ID" AS facility_id,
        "Facility Name" AS facility_name,
        "Measure Name" AS measure_name,
        CAST(Score AS FLOAT) AS score,
        "Compared to National" AS compared_to_national,
        "Start Date" AS start_date,
        "End Date" AS end_date
    FROM "clinical-outcomes".raw."Healthcare_Associated_Infections-Hospital.csv"
    WHERE score NOT IN ('Not Available', '--'))

SELECT 
    facility_id,
    facility_name,
    measure_name,
    score,
    compared_to_national,
    start_date,
    end_date
FROM infection_raw