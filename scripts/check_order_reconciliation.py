from pathlib import Path

import pandas as pd


PROJECT_DIR = Path(__file__).resolve().parent.parent
DATA_DIR = PROJECT_DIR / "data"

ORDERS_PATH = DATA_DIR / "orders_recrutement.xlsx"
SALES_PATH = DATA_DIR / "sales_recrutement.xlsx"


def main() -> None:
    orders = pd.read_excel(ORDERS_PATH)
    sales = pd.read_excel(SALES_PATH)

    order_ids = set(orders["orders_id"])
    sales_order_ids = set(sales["order_id"])

    sales_without_order = sales_order_ids - order_ids
    orders_without_sales = order_ids - sales_order_ids

    print("Orders dataset")
    print(f"Unique order IDs: {len(order_ids):,}")

    print("\nSales dataset")
    print(f"Unique order IDs: {len(sales_order_ids):,}")

    print("\nSales orders missing from orders")
    print(f"Count: {len(sales_without_order):,}")
    print(sorted(sales_without_order))

    print("\nOrders missing from sales")
    print(f"Count: {len(orders_without_sales):,}")
    print(sorted(orders_without_sales))

    if sales_without_order:
        print("\nDetails of sales orders missing from orders:")
        print(
            sales.loc[
                sales["order_id"].isin(sales_without_order)
            ].to_string(index=False)
        )

    if orders_without_sales:
        print("\nDetails of orders missing from sales:")
        print(
            orders.loc[
                orders["orders_id"].isin(orders_without_sales)
            ].to_string(index=False)
        )


if __name__ == "__main__":
    main()
