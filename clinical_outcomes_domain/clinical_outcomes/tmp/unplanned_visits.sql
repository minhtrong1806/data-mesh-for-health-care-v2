WITH unplanned_visits_clean AS (
    SELECT
        "Facility_ID",
        "Measure_ID",
        "Measure_Name",
		CAST(
            CASE 
                WHEN "Number_of_Patients" IN ('Not Available', 'Not Applicable') 
					THEN NULL  
				ELSE "Number_of_Patients" 
            END AS FLOAT) AS total_patients,
			
		CAST(
            CASE 
                WHEN "Number_of_Patients_Returned" IN ('Not Available', 'Not Applicable') 
					THEN NULL  
				ELSE "Number_of_Patients_Returned" 
            END AS FLOAT) AS returned_patients,

        "Start_Date",
        "End_Date"
    FROM {{source("care_db","unplanned_hospital_visits")}} 
    WHERE "Number_of_Patients" IS NOT NULL
)

SELECT
    "Facility_ID",
    "Measure_ID",
    "Measure_Name",
    (SUM(returned_patients) / SUM(total_patients)) * 100 AS avg_return_rate,
    CASE 
      WHEN (SUM(returned_patients) / SUM(total_patients)) * 100 <= 5 THEN 'Low Risk'
      WHEN (SUM(returned_patients) / SUM(total_patients)) * 100 BETWEEN 5 AND 10 THEN 'Moderate Risk'
      ELSE 'High Risk'
    END AS "Risk_Level",
    MIN("Start_Date") AS start_date,
    MAX("End_Date") AS end_date
FROM unplanned_visits_clean
GROUP BY "Facility_ID", "Measure_ID", "Measure_Name"