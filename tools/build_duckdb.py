#!/usr/bin/env python3
"""Load the raw CSVs into a local DuckDB file. A zero-setup fallback if Snowflake is
not working on the day: you get the same raw tables, as raw_*, to model on."""
import duckdb, os, sys
base = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
os.chdir(base)
db = sys.argv[1] if len(sys.argv) > 1 else "nordvik.duckdb"
if os.path.exists(db):
    os.remove(db)
con = duckdb.connect(db)
con.execute(open("transform/duckdb/load_raw.sql").read())
for (t,) in con.execute("select table_name from information_schema.tables "
                        "where table_name like 'raw_%' order by 1").fetchall():
    print(f"{t:32s} {con.execute(f'select count(*) from {t}').fetchone()[0]:>8d}")
print(f"\nbuilt {db}")
