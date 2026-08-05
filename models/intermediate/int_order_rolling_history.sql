with orders as (

    select *
    from {{ ref('fct_orders') }}

),

data_bounds as (

    select
        min(order_date) as first_available_order_date

    from orders

),

rolling_history as (

    select
        current_order.order_id,
        current_order.customer_id,
        current_order.order_date,
        current_order.order_net_sales,
        current_order.qty_product,

        count(prior_order.order_id) as prior_orders_12m,

        current_order.order_date >= date_add(
            data_bounds.first_available_order_date,
            interval 12 month
        ) as has_complete_12_month_history

    from orders as current_order

    cross join data_bounds

    left join orders as prior_order
        on current_order.customer_id = prior_order.customer_id

        and prior_order.order_date >= date_sub(
            current_order.order_date,
            interval 12 month
        )

        and prior_order.order_date < current_order.order_date

    group by
        current_order.order_id,
        current_order.customer_id,
        current_order.order_date,
        current_order.order_net_sales,
        current_order.qty_product,
        data_bounds.first_available_order_date

)

select *
from rolling_history
