{{
    config(
        materialized = 'table'
    )
}}
-- {{ dbt_utils.generate_surrogate_key(['longitude', 'latitude', 'arrest_boro']) }} as  location_id

WITH base AS (
    SELECT
        latitude,
        longitude,
        arrest_boro AS arrest_boro_short,
        case when upper(arrest_boro) = 'B' then 'BRONX'
            when upper(arrest_boro) = 'M' then 'MANHATTAN'
            when upper(arrest_boro) = 'S' then 'STATEN ISLAND'
            when upper(arrest_boro) = 'K' then 'BROOKLYN'
            when upper(arrest_boro) = 'Q' then 'QUEENS'
            else 'UNKNOWN' end as arrest_boro,
        arrest_precinct
    FROM `elaborate-haven-440913-q2.nypd_data_modelling.stg_nypd_arrest_2008_2023`
    WHERE latitude IS NOT NULL AND longitude IS NOT NULL
    GROUP BY latitude, longitude, arrest_boro, arrest_precinct, arrest_boro_short
)

SELECT
    DENSE_RANK() OVER (
        ORDER BY latitude, longitude, arrest_boro_short, arrest_precinct
    ) AS location_id,
    latitude,
    longitude,
    arrest_boro_short,
    arrest_precinct,
    arrest_boro
FROM base



    
    
