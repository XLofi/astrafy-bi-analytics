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

## Exercise 2 — Number of orders per month in 2026

| Month | Number of orders |
|---|---:|
| January 2026 | 232 |
| February 2026 | 176 |
| March 2026 | 203 |
| April 2026 | 188 |
| May 2026 | 172 |
| June 2026 | 169 |
| July 2026 | 193 |
| August 2026 | 167 |
| September 2026 | 212 |
| October 2026 | 223 |
| November 2026 | 389 |
| December 2026 | 249 |
| **Total** | **2,573** |

### Implementation

Orders are grouped using `DATE_TRUNC(order_date, MONTH)` after applying
the configured yearly date range.

The result contains one row per calendar month and is sorted
chronologically.

### Validation

The sum of all monthly order counts is **2,573**, matching the result of
Exercise 1.


## Exercise 3 — Average products per order by month

### Metric definition

The number of products in an order is interpreted as the total number
of units purchased:

`qty_product = SUM(product_quantity)`

This differs from:

- `product_line_count`: number of product rows
- `distinct_product_count`: number of different products

The monthly average is calculated from the one-row-per-order
`int_orders_enriched` model using `AVG(qty_product)`.
