with source as (
    select * from {{ source('schema', 'nypd_arrest_2008_2023') }}
    where arrest_key is not null
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['arrest_key']) }} as row_number,
        CAST(arrest_key AS STRING) AS arrest_key,
        CAST(arrest_date as DATE) AS arrest_date,
        CAST(pd_cd AS INT64) AS pd_cd,
        CAST(pd_desc AS STRING) AS pd_desc,
        CAST(ky_cd AS FLOAT64) AS ky_cd,
        CAST(ofns_desc AS STRING) AS ofns_desc,
        CAST(law_code AS STRING) AS law_code,
        CAST(law_cat_cd AS STRING) AS law_cat_cd,
        CAST(arrest_boro AS STRING) AS arrest_boro,
        CAST(arrest_precinct AS INT64) AS arrest_precinct,
        CAST(jurisdiction_code AS INT64) AS jurisdiction_code,
        CAST(age_group AS STRING) AS age_group,
        CAST(perp_sex AS STRING) AS perp_sex,
        CAST(perp_race AS STRING) AS perp_race,
        CAST(x_coord_cd AS FLOAT64) AS x_coord_cd,
        CAST(y_coord_cd AS FLOAT64) AS y_coord_cd,
        ROUND(CAST(latitude AS FLOAT64), 4) AS latitude,
        ROUND(CAST(longitude AS FLOAT64), 4) AS longitude

    from source

)

select * from renamed
