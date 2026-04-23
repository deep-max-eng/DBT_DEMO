{{ config(
    materialized='table'
) }}

with BIKE as 
(
select distinct 
START_STATION_NAME as STATION_NAME,
START_STATION_ID as STATION_ID,
START_LAT,
START_LNG
from {{ source('demo', 'bike') }}
where RIDE_ID !='ride_id'



)

select * from BIKE