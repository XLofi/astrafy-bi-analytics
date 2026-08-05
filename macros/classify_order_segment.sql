{% macro classify_order_segment(prior_orders_12m) %}

case
    when {{ prior_orders_12m }} = 0
        then 'New'

    when {{ prior_orders_12m }} between 1 and 3
        then 'Returning'

    when {{ prior_orders_12m }} >= 4
        then 'VIP'

    else 'Unknown'
end

{% endmacro %}
