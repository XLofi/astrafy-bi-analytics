{% set exercise_year = var('exercise_year') | int %}
{% set next_year = exercise_year + 1 %}

with expected as (

    select
        count(*) as expected_order_count

    from {{ ref('stg_orders') }}

    where order_date >= date('{{ exercise_year }}-01-01')
      and order_date < date('{{ next_year }}-01-01')

),

actual as (

    select
        count(*) as actual_order_count

    from {{ ref('fct_orders_segmented_2026') }}

)

select
    expected_order_count,
    actual_order_count

from expected
cross join actual

where expected_order_count != actual_order_count
