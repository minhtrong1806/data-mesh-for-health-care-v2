WITH timely_care_clean AS (
    SELECT
        "Facility_ID",
        "Measure_ID",
        "Measure_Name",
        CASE 
            WHEN "Score" IN ('very high', 'high') THEN 
                (SELECT MAX(CAST("Score" AS FLOAT))
                 FROM "care_db".public."complications_and_deaths" 
                 WHERE "Score" IS NOT NULL AND "Score" NOT IN ('very high', 'high', 'low', 'medium', 'Not Available'))
            WHEN "Score" = 'low' THEN 
                (SELECT MIN(CAST("Score" AS FLOAT)) 
                 FROM "care_db".public."complications_and_deaths" 
                 WHERE "Score" IS NOT NULL AND "Score" NOT IN ('very high', 'high', 'low', 'medium', 'Not Available'))
            WHEN "Score" = 'medium' THEN 
                (SELECT AVG(CAST("Score" AS FLOAT)) 
                 FROM "care_db".public."complications_and_deaths" 
                 WHERE "Score" IS NOT NULL AND "Score" NOT IN ('very high', 'high', 'low', 'medium','Not Available'))
            ELSE 
                CAST(NULLIF("Score", 'Not Available') AS FLOAT)
        END AS score,
        "Start_Date",
        "End_Date"
    FROM {{source("care_db","timely_and_effective_care")}}
    WHERE "Score" IS NOT NULL
)

SELECT
    "Facility_ID",
    "Measure_ID",
    "Measure_Name",
    AVG(score) AS avg_score,
    CASE 
      WHEN AVG(score) >= 90 THEN 'Excellent'
      WHEN AVG(score) BETWEEN 70 AND 89 THEN 'Good'
      ELSE 'Needs Improvement'
    END AS "Effectiveness_Level",
    MIN("Start_Date") AS start_date,
    MAX("End_Date") AS end_date
FROM timely_care_clean
GROUP BY "Facility_ID", "Measure_ID", "Measure_Name"
