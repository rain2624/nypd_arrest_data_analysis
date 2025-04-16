{{
    config(
        materialized='table'
    )
}}

select distinct law_code,
{{ dbt_utils.generate_surrogate_key(['law_code', 'law_cat_cd']) }} as law_dim_id, 
upper(law_cat_cd) as law_cat_cd,
case when upper(law_cat_cd) = 'M' then 'Misdemeanor'
    when upper(law_cat_cd) = 'V' then 'Violation'
    when upper(law_cat_cd) = 'F' then 'Felony'
    else 'Other' end as law_category
from {{ ref("stg_nypd_arrest_2008_2023") }}
