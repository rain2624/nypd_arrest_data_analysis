{{
    config(materialized='table')
}}

select distinct coalesce(upper(perp_race), "UNKNOWN") as perp_race, 
coalesce(upper(perp_sex), "UNKNOWN") as perp_sex,
coalesce(age_group, "UNKNOWN") as age_group,
{{ dbt_utils.generate_surrogate_key(['age_group','perp_sex', 'perp_race']) }} as suspect_id 
from {{ ref("stg_nypd_arrest_2008_2023") }}

