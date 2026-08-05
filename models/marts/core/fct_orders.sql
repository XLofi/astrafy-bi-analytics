{{
    config(
        materialized = "table",
        partition_by = {
            "field": "order_date",
            "data_type": "date",
            "granularity": "day"
        },
        cluster_by = ["customer_id"]
    )
}}

{% set start_year = var('order_history_start_year') | int %}
{% set end_year = var('exercise_year') | int %}
{% set next_year = end_year + 1 %}

select
    order_id,
    customer_id,
    order_date,
    order_net_sales,
    qty_product

from {{ ref('int_orders_enriched') }}

where order_date >= date('{{ start_year }}-01-01')
  and order_date < date('{{ next_year }}-01-01')
