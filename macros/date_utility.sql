{% macro function1(x) %}
    CASE 
    WHEN TO_TIMESTAMP({{x}}) < CURRENT_DATE THEN 'PAST'
    ELSE 'FUTURE'
    eND

{% endmacro %}


{% macro day_type(a) %}
    CASE 
    WHEN dayNAME(TO_TIMESTAMP({{a}})) in ('Sat','Sun')
    THEN 'WEEKEND'
    ELSE 'BUSINESSDAY'
    END
{% endmacro %}