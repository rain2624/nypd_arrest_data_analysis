{{
    config(
        materialized='table'
    )
}}

WITH date_spine AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2008-01-01' as date)",  
        end_date="cast('2023-12-31' as date)"
    ) }}
)

SELECT 
    CAST(date_day AS DATE) AS date_id,
    EXTRACT(YEAR FROM date_day) AS year,
    EXTRACT(MONTH FROM date_day) AS month,
    EXTRACT(DAY FROM date_day) AS day,
    EXTRACT(QUARTER FROM date_day) AS quarter_number,
    FORMAT_DATE('%B', date_day) AS month_name,
    CAST('Q' || CAST(EXTRACT(QUARTER FROM date_day) AS STRING) AS STRING) AS quarter,
    EXTRACT(WEEK FROM date_day) AS week_number,
    FORMAT_DATE('%A', date_day) AS week_name,
    CASE 
        WHEN EXTRACT(DAYOFWEEK FROM date_day) IN (1, 7) THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS day_type
FROM date_spine