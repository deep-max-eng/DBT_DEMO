{% macro get_season(s) %}
    CASE 
    WHEN MONTH(TO_TIMESTAMP({{s}})) in (12,1,2)
    THEN 'WINTER'
    WHEN MONTH(TO_TIMESTAMP({{s}})) in (3,4,5)
    THEN 'SPRING'
    WHEN MONTH(TO_TIMESTAMP({{s}})) in (6,7,8)
    THEN 'SUMMER'
    ELSE 'AUTUMN'
    END
{% endmacro %}