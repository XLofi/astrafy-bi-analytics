{% set exercise_year = var('exercise_year') | int %}
{% set next_year = exercise_year + 1 %}

select
    order_id,
    order_date

from {{ ref('fct_orders_segmented_2026') }}

where order_date < date('{{ exercise_year }}-01-01')
   or order_date >= date('{{ next_year }}-01-01')
