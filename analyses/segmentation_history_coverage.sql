with orders as (

    select *
    from {{ ref('fct_orders') }}

),

data_bounds as (

    select
        min(order_date) as first_available_order_date,
        max(order_date) as last_available_order_date

    from orders

)

select
    first_available_order_date,
    last_available_order_date,
    date_add(
        first_available_order_date,
        interval 12 month
    ) as first_date_with_complete_12_month_history,

    countif(
        order_date >= date '2026-01-01'
        and order_date < date_add(
            first_available_order_date,
            interval 12 month
        )
    ) as orders_with_incomplete_history,

    countif(
        order_date >= date_add(
            first_available_order_date,
            interval 12 month
        )
        and order_date < date '2027-01-01'
    ) as orders_with_complete_history

from orders
cross join data_bounds

group by
    first_available_order_date,
    last_available_order_date
