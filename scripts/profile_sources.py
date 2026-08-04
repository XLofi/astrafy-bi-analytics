from pathlib import Path

import pandas as pd


PROJECT_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = PROJECT_DIR / "data"

ORDERS_PATH = DATA_DIR / "orders_recrutement.xlsx"
SALES_PATH = DATA_DIR / "sales_recrutement.xlsx"


def profile_dataframe(name: str, dataframe: pd.DataFrame) -> None:
    print(f"\n{'=' * 60}")
    print(name)
    print("=" * 60)

    print(f"Rows: {len(dataframe):,}")
    print(f"Columns: {len(dataframe.columns)}")

    print("\nColumn names:")
    print(dataframe.columns.tolist())

    print("\nData types:")
    print(dataframe.dtypes)

    print("\nNull values:")
    print(dataframe.isna().sum())

    print("\nFirst five rows:")
    print(dataframe.head())


def main() -> None:
    if not ORDERS_PATH.exists():
        raise FileNotFoundError(f"Missing file: {ORDERS_PATH}")

    if not SALES_PATH.exists():
        raise FileNotFoundError(f"Missing file: {SALES_PATH}")

    orders = pd.read_excel(ORDERS_PATH)
    sales = pd.read_excel(SALES_PATH)

    profile_dataframe("ORDERS", orders)
    profile_dataframe("SALES", sales)


if __name__ == "__main__":
    main()
