{{ config(
    materialized='table'
) }}

with cte as(
select *
from {{ ref('trip_fact') }} t
left join {{ ref('daily_weather') }} w on
t.TRIP_DATE = w.daily_weather

LIMIT 10
)

SELECT * FROM CTE