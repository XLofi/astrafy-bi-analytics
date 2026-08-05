{% set exercise_year = var('exercise_year') | int %}
{% set next_year = exercise_year + 1 %}

select
    date_trunc(order_date, month) as order_month,
    count(*) as number_of_orders,
    round(avg(qty_product), 2) as average_products_per_order

from {{ ref('int_orders_enriched') }}

where order_date >= date('{{ exercise_year }}-01-01')
  and order_date < date('{{ next_year }}-01-01')

group by order_month
order by order_month
