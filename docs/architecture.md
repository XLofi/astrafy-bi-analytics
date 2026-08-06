# Project Architecture

```text
Raw BigQuery sources
├── orders
└── sales
        │
        ▼
Staging
├── stg_orders
└── stg_sales
        │
        ▼
Intermediate
├── int_order_product_metrics
├── int_orders_enriched
├── int_order_rolling_history
└── int_orders_segmented
        │
        ▼
Marts
├── fct_orders
├── fct_orders_segmented
├── fct_orders_segmented_2026
└── fct_order_lines
        │
        ▼
LookML semantic layer
├── Order Performance Explore
└── Product Performance Explore
```

## Raw layer

The source files are loaded into:

```text
astrafy_analytics_raw.orders
astrafy_analytics_raw.sales
```

## Staging layer

| Model | Grain | Purpose |
|---|---|---|
| `stg_orders` | One row per order | Standardizes the order source |
| `stg_sales` | One row per order and product | Standardizes product sales lines |

No business aggregation or year filtering is applied in staging.

## Intermediate layer

| Model | Purpose |
|---|---|
| `int_order_product_metrics` | Aggregates valid sales lines to one row per order |
| `int_orders_enriched` | Joins product metrics to the authoritative order table |
| `int_order_rolling_history` | Counts prior customer orders in a rolling 12-month window |
| `int_orders_segmented` | Applies the New, Returning, and VIP rules |

## Mart layer

| Model | Grain | Purpose |
|---|---|---|
| `fct_orders` | One row per order | Order fact table for 2025 and 2026 |
| `fct_orders_segmented_2026` | One row per 2026 order | Final table including segmentation |

## Why analyses are separate from marts

Small exercise results are stored in `analyses/` because they do not require
permanent BigQuery tables. Reusable, business-facing datasets are materialized
under `models/marts/`.

## LookML semantic layer

The semantic layer contains two separate Explores.

### Order Performance

The `orders` view reads from `fct_orders_segmented` and preserves the
one-row-per-order grain. It supports:

- Order count
- Net revenue
- Average order value
- Unique customers
- Average product units per order
- New, Returning, and VIP analysis

### Product Performance

The `order_lines` view reads from `fct_order_lines` and preserves the
one-row-per-order-and-product grain. It supports:

- Product revenue
- Units sold
- Product-line count
- Distinct order count
- Distinct products
- Purchasing customers
- Product performance by customer segment

The Explores remain separate to avoid fanout between order-level and
product-level metrics.
