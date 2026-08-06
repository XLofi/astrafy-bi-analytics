connection: "astrafy_bigquery"

include: "/lookml/views/*.view.lkml"

explore: orders {
  label: "Order Performance"

  description: "
    Business-facing order analysis for the 2026 exercise year.
    Use this Explore to analyze revenue, order volume, customer
    segmentation, product quantities, and customer behavior.
  "
}
