{{ config(
    materialized='view'
) }}


SELECT
    comp."Facility_ID",
    comp."avg_score" AS complications_score,
    comp."Risk_Level" AS complications_risk,
    mh."avg_score" AS maternal_health_score,
    mh."Risk_Level" AS maternal_health_risk,
    tc."avg_score" AS timely_care_score,
    tc."Effectiveness_Level" AS timely_care_effectiveness,
    uv."avg_return_rate" AS unplanned_return_rate,
    uv."Risk_Level" AS unplanned_risk
FROM "clinical-outcomes"."data_product".complications comp
LEFT JOIN "clinical-outcomes"."data_product"."maternal_health" mh ON comp."Facility_ID" = mh."Facility_ID"
LEFT JOIN "clinical-outcomes"."data_product"."timely_care" tc ON comp."Facility_ID" = tc."Facility_ID"
LEFT JOIN "clinical-outcomes"."data_product"."unplanned_visits" uv ON comp."Facility_ID" = uv."Facility_ID"