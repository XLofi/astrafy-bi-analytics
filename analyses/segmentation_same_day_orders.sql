with customer_days as (

    select
        customer_id,
        order_date,
        count(*) as orders_on_same_day

    from {{ ref('fct_orders') }}

    group by
        customer_id,
        order_date

    having count(*) > 1

)

select
    count(*) as customer_day_groups,
    sum(orders_on_same_day) as affected_orders,
    countif(
        order_date >= date '2026-01-01'
        and order_date < date '2027-01-01'
    ) as customer_day_groups_in_2026,
    sum(
        case
            when order_date >= date '2026-01-01'
             and order_date < date '2027-01-01'
            then orders_on_same_day
            else 0
        end
    ) as affected_orders_in_2026

from customer_days
