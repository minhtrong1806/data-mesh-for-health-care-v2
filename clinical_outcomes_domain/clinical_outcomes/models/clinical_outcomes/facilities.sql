WITH facilities_raw AS (
    SELECT 
        "Facility ID" AS facility_id,
        "Facility Name" AS facility_name,
        Address AS address,
        "City/Town" AS city_town,
        State AS state,
        CAST( "ZIP Code" AS INTEGER) AS zip_code,
        "County/Parish" AS county_parish,
        "Telephone Number" AS telephone_number
    FROM "clinical-outcomes".raw."Complications_and_Deaths-Hospital.csv"
)
SELECT DISTINCT
    facility_id,
    facility_name,
    address,
    city_town,
    state,
    zip_code,
    county_parish,
    telephone_number
FROM facilities_raw
ORDER BY facility_id