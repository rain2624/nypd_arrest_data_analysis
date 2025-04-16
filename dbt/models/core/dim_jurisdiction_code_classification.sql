{{
    config(materialized='table')
}}

select distinct jurisdiction_code,
case when jurisdiction_code = 0 then 'PATROL'
    when jurisdiction_code = 1 then 'TRANSIT'
    when jurisdiction_code = 2 then 'HOUSING'
    when jurisdiction_code > 3 then 'NON NYPD JURISDICTION' else "UNKNOWN" end as jurisdiction_desc
from {{ ref("stg_nypd_arrest_2008_2023") }}