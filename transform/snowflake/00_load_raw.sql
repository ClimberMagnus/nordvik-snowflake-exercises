-- Nordvik training data set - Snowflake load script.
-- Everything lands as VARCHAR, exactly as a raw landing zone behaves. All typing and
-- cleaning happens in the dbt staging models, which is the point of the exercise.
--
--   1. snowsql / Snowsight worksheet: run this file down to the PUT section
--   2. from the repository root, PUT the CSVs on the stage (snowsql or the UI)
--   3. run the COPY INTO block
--   4. cd transform/dbt && dbt build

create database if not exists NORDVIK;
create schema   if not exists NORDVIK.RAW;
use schema NORDVIK.RAW;

create or replace file format NORDVIK.RAW.CSV_FF
    type = csv
    field_delimiter = ','
    skip_header = 1
    field_optionally_enclosed_by = '"'
    empty_field_as_null = true
    null_if = ('', 'NULL')
    trim_space = false;

-- "if not exists", not "or replace": replacing the stage deletes any files already on it.
create stage if not exists NORDVIK.RAW.NORDVIK_STAGE file_format = NORDVIK.RAW.CSV_FF;


create or replace table NORDVIK.RAW.CUSTOMERS (
    KUNDNR                     varchar,
    EMAIL                      varchar,
    FORNAMN                    varchar,
    EFTERNAMN                  varchar,
    ADRESS                     varchar,
    POSTNR                     varchar,
    ORT                        varchar,
    LAND                       varchar,
    KUND_TYP                   varchar,
    ORG_ID                     varchar,
    REG_DATUM                  varchar,
    MARKNAD_OK                 varchar
);

create or replace table NORDVIK.RAW.B2B_ACCOUNTS (
    ORG_ID                     varchar,
    ORG_NAMN                   varchar,
    ORGNR                      varchar,
    PARENT_ORG_ID              varchar,
    LAND                       varchar,
    BRANSCH                    varchar,
    AVTAL_START                varchar
);

create or replace table NORDVIK.RAW.PRODUCTS (
    ART_NR                     varchar,
    ART_NAMN                   varchar,
    KATEGORI                   varchar,
    UNDERKAT                   varchar,
    VARUMARKE                  varchar,
    INKOPSPRIS                 varchar,
    LISTPRIS                   varchar,
    LANSERING                  varchar,
    AKTIV                      varchar
);

create or replace table NORDVIK.RAW.PRODUCT_CATEGORY_HISTORY (
    ART_NR                     varchar,
    KATEGORI                   varchar,
    GILTIG_FROM                varchar,
    GILTIG_TOM                 varchar
);

create or replace table NORDVIK.RAW.STORES (
    BUTIK_ID                   varchar,
    BUTIK_NAMN                 varchar,
    LAND                       varchar,
    STAD                       varchar,
    OPPNAD                     varchar,
    STANGD                     varchar,
    BUTIK_TYP                  varchar
);

create or replace table NORDVIK.RAW.ORDERS (
    ORDER_ID                   varchar,
    KUNDNR                     varchar,
    ORG_ID                     varchar,
    ORDER_DATUM                varchar,
    LEV_DATUM                  varchar,
    FAKT_DATUM                 varchar,
    KANAL                      varchar,
    BUTIK_ID                   varchar,
    VALUTA                     varchar,
    LAND                       varchar,
    STAT_CD                    varchar,
    ORD_TYP                    varchar
);

create or replace table NORDVIK.RAW.ORDER_LINES (
    ORDER_ID                   varchar,
    RAD_NR                     varchar,
    ART_NR                     varchar,
    ANTAL                      varchar,
    ENHETSPRIS                 varchar,
    RABATT_BELOPP              varchar,
    MOMS_SATS                  varchar,
    BELOPP_1                   varchar,
    BELOPP_2                   varchar
);

create or replace table NORDVIK.RAW.RETURNS (
    RETUR_ID                   varchar,
    ORDER_ID                   varchar,
    RAD_NR                     varchar,
    ART_NR                     varchar,
    ANTAL                      varchar,
    RETUR_DATUM                varchar,
    ORSAK_KOD                  varchar
);

create or replace table NORDVIK.RAW.SUBSCRIPTIONS (
    ABO_ID                     varchar,
    KUNDNR                     varchar,
    PLAN                       varchar,
    START_DATUM                varchar,
    SLUT_DATUM                 varchar,
    STATUS                     varchar,
    MANADSBELOPP               varchar,
    VALUTA                     varchar
);

create or replace table NORDVIK.RAW.FX_RATES (
    DATUM                      varchar,
    VALUTA                     varchar,
    KURS_SEK                   varchar
);

create or replace table NORDVIK.RAW.BUDGET (
    AR                         varchar,
    MANAD                      varchar,
    LAND                       varchar,
    KATEGORI                   varchar,
    BUDGET_NETTO_SEK           varchar
);

create or replace table NORDVIK.RAW.CALENDAR (
    DATUM                      varchar,
    AR                         varchar,
    MANAD                      varchar,
    MANAD_NAMN                 varchar,
    AR_MANAD                   varchar,
    KVARTAL                    varchar,
    RAKENSKAPSAR               varchar,
    RAKENSKAPSAR_NAMN          varchar,
    RAKENSKAPSMANAD            varchar,
    RAKENSKAPSKVARTAL          varchar,
    VECKA                      varchar,
    VECKODAG                   varchar,
    HELG                       varchar
);

-- the ticket corpus, for Cortex Search; the file is in data/docs/, not data/raw/
create or replace table NORDVIK.RAW.SUPPORT_TICKETS (
    TICKET_ID                  varchar,
    DATUM                      varchar,
    KUNDNR                     varchar,
    KANAL                      varchar,
    ART_NR                     varchar,
    AMNE                       varchar,
    BETYG                      varchar,
    TEXT                       varchar
);


-- ---- upload (snowsql, or drag-and-drop in Snowsight) --------------------------

-- PUT file://data/raw/customers.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/b2b_accounts.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/products.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/product_category_history.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/stores.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/orders.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/order_lines.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/returns.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/subscriptions.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/fx_rates.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/budget.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/raw/calendar.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;

-- PUT file://data/docs/04_support_tickets_and_reviews.csv @NORDVIK.RAW.NORDVIK_STAGE AUTO_COMPRESS=TRUE;


-- ---- load --------------------------------------------------------------------
-- Stage paths are prefixes, so customers.csv matches both a Snowsight upload
-- (customers.csv) and a PUT with AUTO_COMPRESS (customers.csv.gz). Upload one or the
-- other, not both, or the table loads twice.

copy into NORDVIK.RAW.CUSTOMERS from @NORDVIK.RAW.NORDVIK_STAGE/customers.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.B2B_ACCOUNTS from @NORDVIK.RAW.NORDVIK_STAGE/b2b_accounts.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.PRODUCTS from @NORDVIK.RAW.NORDVIK_STAGE/products.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.PRODUCT_CATEGORY_HISTORY from @NORDVIK.RAW.NORDVIK_STAGE/product_category_history.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.STORES from @NORDVIK.RAW.NORDVIK_STAGE/stores.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.ORDERS from @NORDVIK.RAW.NORDVIK_STAGE/orders.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.ORDER_LINES from @NORDVIK.RAW.NORDVIK_STAGE/order_lines.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.RETURNS from @NORDVIK.RAW.NORDVIK_STAGE/returns.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.SUBSCRIPTIONS from @NORDVIK.RAW.NORDVIK_STAGE/subscriptions.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.FX_RATES from @NORDVIK.RAW.NORDVIK_STAGE/fx_rates.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.BUDGET from @NORDVIK.RAW.NORDVIK_STAGE/budget.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.CALENDAR from @NORDVIK.RAW.NORDVIK_STAGE/calendar.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';

copy into NORDVIK.RAW.SUPPORT_TICKETS from @NORDVIK.RAW.NORDVIK_STAGE/04_support_tickets_and_reviews.csv file_format = NORDVIK.RAW.CSV_FF on_error = 'abort_statement';


-- ---- sanity ------------------------------------------------------------------
select 'orders' t, count(*) n from NORDVIK.RAW.ORDERS
union all select 'order_lines', count(*) from NORDVIK.RAW.ORDER_LINES
union all select 'customers',   count(*) from NORDVIK.RAW.CUSTOMERS
union all select 'returns',     count(*) from NORDVIK.RAW.RETURNS
union all select 'tickets',     count(*) from NORDVIK.RAW.SUPPORT_TICKETS;
-- expected: 50001, 104551, 3000, 3127, 200

