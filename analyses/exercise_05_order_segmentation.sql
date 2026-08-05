{% set exercise_year = var('exercise_year') | int %}
{% set next_year = exercise_year + 1 %}

select
    order_id,
    customer_id,
    order_date,
    prior_orders_12m,
    order_segmentation,
    has_complete_12_month_history

from {{ ref('int_orders_segmented') }}

where order_date >= date('{{ exercise_year }}-01-01')
  and order_date < date('{{ next_year }}-01-01')

order by
    order_date,
    order_id
