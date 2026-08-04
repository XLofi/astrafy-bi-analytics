# Astrafy BI Analytics Take-Home Challenge

## Exercise 1 — Number of orders in 2026

### Result

There are **2,573 orders** in 2026.(1088 in 2025).

### Business definition

An order is identified by one unique `order_id` in the `stg_orders`
model.

### Implementation

The analysis filters orders using the following interval:

- `order_date >= 2026-01-01`
- `order_date < 2027-01-01`

The year is configured through the `exercise_year` dbt variable, allowing
the same query to be reused for another year.

### Data-quality validation

The `order_id` column is tested for:

- Non-null values
- Uniqueness

Because the model has a tested one-row-per-order grain, the analysis uses
`COUNT(*)` rather than `COUNT(DISTINCT order_id)`.
