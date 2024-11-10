WITH value_raw AS (
    SELECT
        "Facility ID" AS facility_id,
        "Value of Care Display ID" AS value_of_care_display_id,
        "Value of Care Display Name" AS value_of_care_display_name,
        "Value of Care Category" AS value_of_care_category,
        "Start Date" AS start_date,
        "End Date" AS end_date
    FROM "cost-value".raw."Payment_and_Value_of_Care-Hospital.csv")

SELECT 
    facility_id,
    value_of_care_display_id,
    value_of_care_display_name,
    value_of_care_category,
    start_date,
    end_date
FROM value_raw
