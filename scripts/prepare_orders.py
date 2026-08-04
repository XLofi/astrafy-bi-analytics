from pathlib import Path

import pandas as pd


PROJECT_DIR = Path(__file__).resolve().parent.parent
INPUT_PATH = PROJECT_DIR / "data" / "orders_recrutement.xlsx"
OUTPUT_PATH = PROJECT_DIR / "data" / "orders.csv"

EXPECTED_COLUMNS = [
    "date_date",
    "customers_id",
    "orders_id",
    "net_sales",
]


def main() -> None:
    orders = pd.read_excel(INPUT_PATH)

    actual_columns = orders.columns.tolist()

    if actual_columns != EXPECTED_COLUMNS:
        raise ValueError(
            f"Unexpected columns.\n"
            f"Expected: {EXPECTED_COLUMNS}\n"
            f"Received: {actual_columns}"
        )

    orders["date_date"] = pd.to_datetime(
        orders["date_date"],
        errors="raise",
    )

    if orders.isna().any().any():
        raise ValueError("The orders dataset contains missing values.")

    if orders["orders_id"].duplicated().any():
        duplicated_orders = orders.loc[
            orders["orders_id"].duplicated(keep=False),
            "orders_id",
        ].unique()

        raise ValueError(
            f"Duplicate order IDs found: {duplicated_orders[:10]}"
        )

    orders.to_csv(
        OUTPUT_PATH,
        index=False,
        date_format="%Y-%m-%d",
        float_format="%.10f",
    )

    print(f"Orders exported successfully: {OUTPUT_PATH}")
    print(f"Rows exported: {len(orders):,}")
    print(f"Unique orders: {orders['orders_id'].nunique():,}")
    print(f"Minimum date: {orders['date_date'].min().date()}")
    print(f"Maximum date: {orders['date_date'].max().date()}")


if __name__ == "__main__":
    main()
