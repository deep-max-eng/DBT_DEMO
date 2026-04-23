{{ config(
    materialized='table'
) }}

with daily_weather as
(

    Select 
    date(time) as daily_weather,
    weather,
    temp,
    humidity,
    pressure,
    clouds
    from {{ source('demo', 'weather') }}

    
)

,

daily_weather_agg as (

select 
daily_weather,
weather,
--count(weather),

--ROW_NUMBER() over (partition by daily_weather order by count(weather) desc) as row_number
round(avg(temp),2) as avg_temp,
round(avg(pressure),2) as avg_pressure,
round(avg(humidity),2) as avg_humidity,
round(avg(clouds),2) as avg_clouds
from daily_weather
group by daily_weather,weather

QUALIFY ROW_NUMBER() over (partition by daily_weather order by count(weather) desc) = 1
)

select 
*
from daily_weather_agg