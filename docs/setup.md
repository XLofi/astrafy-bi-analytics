# Environment and Setup

## Requirements

- Python 3.12 or compatible
- Google Cloud CLI
- BigQuery CLI
- Google Cloud project with the BigQuery API enabled
- Application Default Credentials
- dbt Core with the BigQuery adapter

## Python environment

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install dbt-bigquery pandas openpyxl
```

## Google Cloud authentication

```bash
gcloud auth login
gcloud auth application-default login
gcloud config set project YOUR_GCP_PROJECT_ID
```

## dbt profile

Create or update `~/.dbt/profiles.yml`:

```yaml
astrafy_analytics:
  target: dev

  outputs:
    dev:
      type: bigquery
      method: oauth
      project: YOUR_GCP_PROJECT_ID
      dataset: astrafy_analytics
      location: US
      threads: 4
      priority: interactive
```

Validate the connection:

```bash
dbt debug
```

## Variables

```yaml
vars:
  exercise_year: 2026
  order_history_start_year: 2025
```

Override a variable:

```bash
dbt show   --select exercise_01_orders_by_year   --vars '{"exercise_year": 2025}'
```

## Build and docs

```bash
dbt parse
dbt build
dbt docs generate
dbt docs serve --port 8080 --no-browser
```
