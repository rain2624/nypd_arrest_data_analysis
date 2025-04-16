{{
    config(
        materialized='table'
    )
}}
SELECT 
  pd_cd, 
  ky_cd, 
  MAX(upper(pd_desc)) AS pd_desc,  -- or MIN, or any aggregator
  MAX(upper(ofns_desc)) AS ofns_desc,
  {{ dbt_utils.generate_surrogate_key(['pd_cd', 'ky_cd']) }} AS offense_id
FROM {{ ref("stg_nypd_arrest_2008_2023") }}
WHERE pd_cd IS NOT NULL AND ky_cd IS NOT NULL
GROUP BY pd_cd, ky_cd