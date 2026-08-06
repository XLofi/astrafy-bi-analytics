# Astrafy BI Analytics Take-Home Challenge

This repository contains the analytics engineering solution for the Astrafy
**Looker / BI / Analytics / Insights Engineer** take-home challenge.

The current implementation covers **Part 1: Coding Challenge** using dbt Core
and BigQuery. It includes source preparation, layered models, customer
segmentation, data-quality controls, BigQuery optimizations, and documented
answers to Exercises 1–6.

## Technology stack

- BigQuery
- dbt Core 1.12 and dbt-bigquery 1.12
- Python 3.12
- pandas and openpyxl
- Git and GitHub

## Documentation

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
Models: 8
Analyses: 7
Data tests: 60
Passes: 67
Warnings: 1
Errors: 0
Skipped: 0
Total executed nodes: 68
```

The single warning corresponds to one documented orphan sales order.
