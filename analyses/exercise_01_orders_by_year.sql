{% set exercise_year = var('exercise_year') | int %}
{% set next_year = exercise_year + 1 %}

select
    count(*) as number_of_orders

from {{ ref('stg_orders') }}

where order_date >= date('{{ exercise_year }}-01-01')
  and order_date < date('{{ next_year }}-01-01')
