{{
    config(materialized='table')
}}

WITH dim_fact_table AS(
    SELECT 
        f.row_number, f.arrest_key, 
        f.pd_cd, f.ky_cd, offsn.offense_id,
        f.law_cat_cd, f.law_code, 
        law_cl.law_dim_id, 
        f.jurisdiction_code,
        f.longitude, f.latitude,
        f.arrest_boro, f.arrest_precinct,
        location.location_id,
        f.age_group, f.perp_race, 
        f.perp_sex,
        suspects.suspect_id,
        f.arrest_date
    FROM {{ ref("stg_nypd_arrest_2008_2023") }} f
    LEFT JOIN {{ ref("dim_offense_classification") }} offsn
    ON 
        f.pd_cd = offsn.pd_cd 
        AND f.ky_cd = offsn.ky_cd
    LEFT JOIN {{ ref("dim_law_classification") }} as law_cl
    ON 
        f.law_cat_cd = law_cl.law_cat_cd 
        AND f.law_code = law_cl.law_code
    LEFT JOIN {{ ref("dim_location") }} as location
    ON
        f.latitude = location.latitude
        AND f.longitude = location.longitude
        AND f.arrest_boro = location.arrest_boro_short
        AND f.arrest_precinct = location.arrest_precinct
    LEFT JOIN {{ ref("dim_suspect_dtls") }} as suspects
    ON
        f.age_group = suspects.age_group
        AND f.perp_race = suspects.perp_race
        AND f.perp_sex = suspects.perp_sex
)
select 
    row_number, arrest_key,
    arrest_date, offense_id,
    law_dim_id, location_id,
    jurisdiction_code,
    suspect_id
from dim_fact_table