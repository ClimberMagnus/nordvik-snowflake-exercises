-- Local sandbox: load the raw CSVs into DuckDB as raw_* tables.
-- From the repository root:   python3 tools/build_duckdb.py
create or replace table raw_customers                as select * from read_csv_auto('data/raw/customers.csv', header=true, all_varchar=true);
create or replace table raw_b2b_accounts             as select * from read_csv_auto('data/raw/b2b_accounts.csv', header=true, all_varchar=true);
create or replace table raw_products                 as select * from read_csv_auto('data/raw/products.csv', header=true, all_varchar=true);
create or replace table raw_product_category_history as select * from read_csv_auto('data/raw/product_category_history.csv', header=true, all_varchar=true);
create or replace table raw_stores                   as select * from read_csv_auto('data/raw/stores.csv', header=true, all_varchar=true);
create or replace table raw_orders                   as select * from read_csv_auto('data/raw/orders.csv', header=true, all_varchar=true);
create or replace table raw_order_lines              as select * from read_csv_auto('data/raw/order_lines.csv', header=true, all_varchar=true);
create or replace table raw_returns                  as select * from read_csv_auto('data/raw/returns.csv', header=true, all_varchar=true);
create or replace table raw_subscriptions            as select * from read_csv_auto('data/raw/subscriptions.csv', header=true, all_varchar=true);
create or replace table raw_fx_rates                 as select * from read_csv_auto('data/raw/fx_rates.csv', header=true, all_varchar=true);
create or replace table raw_budget                   as select * from read_csv_auto('data/raw/budget.csv', header=true, all_varchar=true);
create or replace table raw_calendar                 as select * from read_csv_auto('data/raw/calendar.csv', header=true, all_varchar=true);
