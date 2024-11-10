WITH deaths_raw AS (
    SELECT 
        "Facility ID" AS facility_id,
        "Facility Name" AS facility_name,
        "Measure Name" AS measure_name,
        CAST(Score AS FLOAT) AS score,
        CAST(Denominator AS INTEGER) AS denominator,
        "Compared to National" AS compared_to_national,
        "Start Date" AS start_date,
        "End Date" AS end_date
    FROM {{source("clinical-outcomes","Complications_and_Deaths-Hospital.csv")}} 
    WHERE 
        score NOT IN ('Not Available') 
        AND denominator NOT IN ('Not Available', 'Not Applicable')
        AND "measure_name" SIMILAR TO 'Death rate for%')
    
SELECT 
    facility_id,
    facility_name,
    measure_name,
    score,
    denominator,
    CASE
        WHEN compared_to_national = 'No Different Than the National Rate' THEN 'Neutral'
        WHEN compared_to_national = 'Better than the National Benchmark' THEN 'Better'
        WHEN compared_to_national = 'Worse than the National Benchmark' THEN 'Worse'
    END AS comparison_to_national,
    start_date,
    end_date
FROM deaths_raw
