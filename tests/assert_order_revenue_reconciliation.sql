select
    order_id,
    order_net_sales,
    calculated_order_net_sales,
    revenue_difference

from {{ ref('int_orders_enriched') }}

where abs(revenue_difference) > 0.0001
