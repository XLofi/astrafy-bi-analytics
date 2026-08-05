from pathlib import Path

import pandas as pd


PROJECT_DIR = Path(__file__).resolve().parent.parent
INPUT_PATH = PROJECT_DIR / "data" / "sales_recrutement.xlsx"
OUTPUT_PATH = PROJECT_DIR / "data" / "sales.csv"

EXPECTED_COLUMNS = [
    "date_date",
    "customer_id",
    "order_id",
    "products_id",
    "net_sales",
    "qty",
]


def main() -> None:
    sales = pd.read_excel(INPUT_PATH)

    actual_columns = sales.columns.tolist()

    if actual_columns != EXPECTED_COLUMNS:
        raise ValueError(
            f"Unexpected columns.\n"
            f"Expected: {EXPECTED_COLUMNS}\n"
            f"Received: {actual_columns}"
        )

    sales["date_date"] = pd.to_datetime(
        sales["date_date"],
        errors="raise",
    )

    if sales.isna().any().any():
        raise ValueError("The sales dataset contains missing values.")

    if (sales["qty"] <= 0).any():
        invalid_rows = sales.loc[sales["qty"] <= 0]

        raise ValueError(
            f"Found {len(invalid_rows)} rows with zero or negative quantity."
        )

    duplicated_lines = sales.duplicated(
        subset=["order_id", "products_id"],
        keep=False,
    )

    if duplicated_lines.any():
        duplicate_count = duplicated_lines.sum()

        raise ValueError(
            f"Found {duplicate_count} duplicated order-product rows."
        )

    sales.to_csv(
        OUTPUT_PATH,
        index=False,
        date_format="%Y-%m-%d",
        float_format="%.10f",
    )

    print(f"Sales exported successfully: {OUTPUT_PATH}")
    print(f"Rows exported: {len(sales):,}")
    print(f"Unique orders: {sales['order_id'].nunique():,}")
    print(f"Unique products: {sales['products_id'].nunique():,}")
    print(f"Minimum date: {sales['date_date'].min().date()}")
    print(f"Maximum date: {sales['date_date'].max().date()}")
    print(f"Minimum quantity: {sales['qty'].min()}")
    print(f"Maximum quantity: {sales['qty'].max()}")


if __name__ == "__main__":
    main()
