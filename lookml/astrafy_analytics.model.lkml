connection: "astrafy_bigquery"

include: "/lookml/views/orders.view.lkml"
include: "/lookml/views/order_lines.view.lkml"

explore: orders {
  label: "Order Performance"

  description: "
    Business-facing order-level analysis. Use this Explore to analyze
    revenue, order volume, average order value, product quantities,
    customer segmentation, and customer behavior without product-line
    fanout.
  "

  group_label: "Astrafy Analytics"
}

explore: order_lines {
  label: "Product Performance"

  description: "
    Business-facing product-level analysis. Use this Explore to analyze
    product revenue, quantities, order penetration, purchasing customers,
    and performance by customer segment.
  "

  group_label: "Astrafy Analytics"
}
