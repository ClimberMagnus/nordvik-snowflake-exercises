# Nordvik — Snowflake exercises

The data set for the Snowflake track on the Climber AI training day: *set up a semantic
view, create an agent, and make it good.*

It is built so that a competent agent pointed at the raw tables gets most questions
wrong. Your job this afternoon is the modelling work that fixes that, and measuring how
much it helped.

Nothing here is real. Nordvik Outdoor AB does not exist, and no customer data of any kind
was used to build it.

**Before the day:** work through [SETUP.md](SETUP.md). Everything in it must be green
before 13:00.

---

## The company

Nordvik Outdoor AB sells e-bikes, bicycles, outdoor clothing, camping gear, accessories
and service parts in Sweden, Norway, Finland and the Netherlands, through a webshop,
fourteen stores and a corporate/benefit-bike channel, with a service subscription
alongside.

It has the data estate of a company that has grown by adding systems: Swedish ERP column
names from 2014, several source systems writing into the same fields, a returns process
that changed halfway through the history, and departments that don't always mean the
same thing by the same word.

## What is in the box

```
data/raw/              12 CSVs, 9 MB, ~180 000 rows. Raw. Nothing is cleaned.
data/docs/             three documents and a ticket corpus - the material for your skills
transform/dbt/         dbt project: source definitions and a profile template. The models are yours to write.
transform/snowflake/   the DDL, stage and COPY INTO used to load NORDVIK.RAW (for reference)
transform/duckdb/      load script for the local fallback
tools/build_duckdb.py  local fallback: loads the raw CSVs into DuckDB
```

The raw tables: `customers`, `b2b_accounts`, `products`, `product_category_history`,
`stores`, `orders`, `order_lines`, `returns`, `subscriptions`, `fx_rates`, `budget`,
`calendar`, plus `support_tickets` from the ticket corpus.

## Where things live in Snowflake

| Schema | What | You can |
|---|---|---|
| `NORDVIK.RAW` | The raw tables, already loaded. The same for everyone. | Read |
| `NORDVIK.DBT_<INITIALS>_STAGING` | Your staging models (dbt creates it) | Build |
| `NORDVIK.DBT_<INITIALS>_MARTS` | Your star schema (dbt creates it) | Build |
| `NORDVIK.DBT_<INITIALS>` | Your semantic view, Cortex Search service, agent, scratch work | Build |

Everyone shares one role, so you *can* drop someone else's schema. Don't.

---

## The afternoon

13:00 framing · 13:20 baseline · 13:55 transform and semantic layer · break · 14:55
agent and skills · 15:40 wrap.

The ten questions are posted in the track channel at 13:20.

### 13:20 — baseline (35 min)

Point an agent straight at `NORDVIK.RAW`, with no semantic layer, no descriptions and no
skills. Run the ten questions and write down the score. Read
`data/docs/01_nordvik_business_and_reporting_handbook.md` while you do.

*Checkpoint: post your baseline score and the first answer you knew was wrong.*

### 13:55 — transform and semantic layer (45 min)

Build a star schema with dbt, from `NORDVIK.RAW` into your own schemas. `transform/dbt/`
has the project, the source definitions and a profile template.

Then build a **semantic view** over your marts. The mechanical part is quick. What
decides your score is everything around it:

- **Synonyms** for the source names a business user might type. The columns are Swedish
  ERP abbreviations, and the agent won't guess what they mean.
- **A description on every measure** that says exactly which rows and which amount it
  counts. A measure called "net sales" with no definition isn't a definition.
- **Time periods the way the business reports them**, as first-class dimensions, not
  something the agent has to work out.
- **Verified queries** for the questions you already know are ambiguous.
- **What the model does not contain.** If the semantic view doesn't say so, the agent
  will invent it.

*Checkpoint: post one measure definition you had to make a judgement call on.*

### 14:55 — agent and skills (45 min)

- A **Cortex Agent** over your semantic view, plus a **Cortex Search** service over the
  ticket corpus (`NORDVIK.RAW.SUPPORT_TICKETS`, the same content as
  `data/docs/04_support_tickets_and_reviews.csv`). Some questions need the numbers and the
  text together.
- **Skills** from the three documents in `data/docs/`. They are deliberately raw and not
  shaped like skills. Deciding what belongs in a skill is part of the exercise.
- Re-run the ten questions and record the new score.

Our Cortex Agent skills from the demo webinar (churn, forecasting, period-over-period,
RFM) are worth reading as examples of shape. Don't copy them; the definitions here are
different on purpose.

*Checkpoint: post your before and after score.*

### 15:40 — wrap

Which problem did nobody catch, and did your agent ever refuse to answer?

---

## If Snowflake isn't working

```bash
pip install duckdb
python tools/build_duckdb.py
```

This loads the same raw tables into `nordvik.duckdb` in a few seconds, as `raw_customers`,
`raw_orders` and so on, so you can still do the modelling work locally. Tell the
facilitator, because the agent part of the afternoon needs Snowflake.
