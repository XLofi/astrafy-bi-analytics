# Source Preparation and BigQuery Ingestion

## Local files

```text
data/orders_recrutement.xlsx
data/sales_recrutement.xlsx
```

The `data/` directory is excluded from Git.

## Profile and prepare

```bash
python scripts/profile_sources.py
python scripts/check_order_reconciliation.py
python scripts/prepare_orders.py
python scripts/prepare_sales.py
```

Generated CSVs:

```text
data/orders.csv
data/sales.csv
```

## Create the raw dataset

```bash
export PROJECT_ID="$(gcloud config get-value project)"
export BQ_LOCATION="US"
export RAW_DATASET="astrafy_analytics_raw"

bq --location="$BQ_LOCATION" mk   --dataset   --description="Raw source data for the Astrafy BI Analytics challenge"   "${PROJECT_ID}:${RAW_DATASET}"
```

## Load orders

```bash
bq --location="$BQ_LOCATION" load   --replace   --source_format=CSV   --skip_leading_rows=1   "${PROJECT_ID}:${RAW_DATASET}.orders"   data/orders.csv   "date_date:DATE,customers_id:INT64,orders_id:INT64,net_sales:NUMERIC"
```

## Load sales

```bash
bq --location="$BQ_LOCATION" load   --replace   --source_format=CSV   --skip_leading_rows=1   "${PROJECT_ID}:${RAW_DATASET}.sales"   data/sales.csv   "date_date:DATE,customer_id:INT64,order_id:INT64,products_id:INT64,net_sales:NUMERIC,qty:INT64"
```

## Profiling results

### Orders

- Rows: 3,661
- Unique orders: 3,661
- Date range: 2025-07-09 to 2026-12-31
- Missing values: 0
- Duplicate order IDs: 0

### Sales

- Rows: 28,361
- Unique orders: 3,662
- Unique products: 9,196
- Date range: 2025-07-09 to 2026-12-31
- Missing values: 0
- Duplicate `order_id + product_id` combinations: 0
- Quantity range: 1 to 50
