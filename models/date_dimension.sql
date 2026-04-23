{{ config(
    materialized='table'
) }}

WITH CTE AS(

    select 
    TO_TIMESTAMP(STARTED_AT) as STARTED_AT,
    date(to_timestamp(STARTED_AT)) AS DATE_STARTED_AT,
    hour(to_timestamp(STARTED_AT)) as HOUR_STARTED_AT,

    CASE 
    WHEN dayNAME(TO_TIMESTAMP(STARTED_AT)) in ('Sat','Sun')
    THEN 'WEEKEND'
    ELSE 'BUSINESSDAY'
    END AS DAY_TYPE,

    {{day_type('STARTED_AT')}} as day_type_function,
    
    CASE 
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (12,1,2)
    THEN 'WINTER'
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (3,4,5)
    THEN 'SPRING'
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) in (6,7,8)
    THEN 'SUMMER'
    ELSE 'AUTUMN'
    END AS STATION_OF_YEAR,

    {{get_season('STARTED_AT')}} as STATION_OF_YEAR_FUNCTION,
    {{function1('STARTED_AT')}} as Status


    FROM {{ source('demo', 'bike') }}
    where STARTED_AT!='started_at'
)
select * from CTE