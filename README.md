# Astrafy BI Analytics Take-Home Challenge

This repository contains the analytics engineering solution for the Astrafy
**Looker / BI / Analytics / Insights Engineer** take-home challenge.

The implementation covers all three parts of the challenge:

- **Part 1 — Coding Challenge:** dbt and BigQuery transformations, tests,
  documentation, customer segmentation, and Exercises 1–6.
- **Part 2 — LookML Semantic Layer:** modular order and product Explores,
  business-oriented dimensions and measures, drill-downs, dynamic customer
  segmentation, and Conversational Analytics metadata.
- **Part 3 — Dashboard Design:** a proposed daily marketing dashboard covering
  revenue, orders, customers, segmentation, products, and optional forecasting.

## Technology stack

- BigQuery
- dbt Core 1.12 and dbt-bigquery 1.12
- Python 3.12
- pandas and openpyxl
- Git and GitHub

## Documentation
- [Marketing dashboard design](docs/dashboard_design.md)
- [Marketing dashboard PDF](docs/dashboard/Marketing_Daily_Performance_Dashboard.pdf)

### Project documentation

- [Architecture](docs/architecture.md)
- [Environment and setup](docs/setup.md)
- [Source preparation and ingestion](docs/source_ingestion.md)
- [Assumptions and limitations](docs/assumptions.md)
- [Data-quality controls](docs/data_quality.md)
- [Performance and cost considerations](docs/performance.md)
- [Final validation summary](docs/validation_summary.md)

### Exercise documentation

- [Exercise 1 — Number of orders in 2026](docs/exercises/exercise_01.md)
- [Exercise 2 — Orders per month in 2026](docs/exercises/exercise_02.md)
- [Exercise 3 — Average products per order](docs/exercises/exercise_03.md)
- [Exercise 4 — Order table for 2025 and 2026](docs/exercises/exercise_04.md)
- [Exercise 5 — Customer order segmentation](docs/exercises/exercise_05.md)
- [Exercise 6 — Final segmented 2026 table](docs/exercises/exercise_06.md)

## Semantic layer status

The LookML project currently exposes two business-facing Explores:

| Explore | Grain | Primary use |
|---|---|---|
| `Order Performance` | One row per order | Revenue, orders, average order value, customers, product quantities, and customer segmentation |
| `Product Performance` | One row per order and product | Product revenue, units sold, product penetration, customers, and segment-level product performance |

The semantic layer reads from:

```text
fct_orders_segmented
fct_order_lines
```

The order and product Explores are kept separate to prevent order-level
measures from being multiplied by product-level rows.

## Quick start

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install dbt-bigquery pandas openpyxl

dbt debug
dbt build
```

Generate the dbt documentation catalogue:

```bash
dbt docs generate
dbt docs serve --port 8080 --no-browser
```

## Current build result

```text
Models: 10
Analyses: 7
Data tests: 82
Passes: 91
Warnings: 1
Errors: 0
Skipped: 0
Total executed nodes: 92
```

The single warning corresponds to one documented orphan sales order.
