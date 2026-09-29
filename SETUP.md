# Setup — before the day

**Everything below must be green before the day.** Nothing kills a hands-on block faster
than installing a CLI at 13:05. When the smoke test passes, tell Magnus.

Do the setup on your Climber laptop, not on a customer-issued machine.

## Accounts and access

- [ ] Claude work account active, Claude desktop app installed and signed in
- [ ] Snowflake login to the training account (username from Magnus), password reset
      done, MFA set up if the account enforces it
- [ ] You can clone this repo from git.climber.cloud
- [ ] Watched the T2 "Claude basics" session or its recording

## Installs

- [ ] VS Code, latest
- [ ] Git, configured with your name and email, able to clone and push to git.climber.cloud
- [ ] Claude Code: `claude --version` runs and you're logged in with your work account
- [ ] Python 3.10+: `python --version`
- [ ] dbt 2.0 and DuckDB: `python -m pip install -r requirements.txt` (a virtual env is
      fine). `dbt --version` must show `dbt 2.x`. If it shows 1.x, an old dbt Core is
      first on your PATH. Remove it or deactivate that virtual env.
- [ ] Snowflake CLI: `snow --version`
- [ ] Cortex Code CLI, if you want it in VS Code as well as in Snowsight
- [ ] VS Code extensions: Snowflake, and the official dbt extension

## Configuration

1. **Generate a key pair** and send the **public** key to Magnus. The private key stays
   on your laptop and never goes in a repo. In Git Bash:

   ```bash
   mkdir -p ~/.ssh
   openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out ~/.ssh/snowflake_key.p8 -nocrypt
   openssl rsa -in ~/.ssh/snowflake_key.p8 -pubout -out ~/.ssh/snowflake_key.pub
   ```

   Send the contents of `snowflake_key.pub`.

2. **dbt profile.** Copy `transform/dbt/profiles.example.yml` to `~/.dbt/profiles.yml`
   and fill in account, user, key path and `schema: DBT_<your initials>`. dbt creates
   `DBT_<INITIALS>_STAGING` and `DBT_<INITIALS>_MARTS` from that on the first build.

3. **Snowflake CLI connection.** Run `snow connection add`, name it `nordvik`, and use
   key-pair auth (`SNOWFLAKE_JWT`), role `NORDVIK_TRAINING` and warehouse `NORDVIK_WH`.

4. **Snowflake MCP in Claude Code.** Follow the setup note sent out with this list.

## Smoke test — all five must pass

| # | Check | Expected |
|---|---|---|
| 1 | Log in to Snowsight with the training user | You see database `NORDVIK` |
| 2 | `select count(*) from NORDVIK.RAW.ORDERS` | 50001 |
| 3 | `cd transform/dbt && dbt debug` | All checks passed |
| 4 | `snow sql -c nordvik -q "select current_role()"` | `NORDVIK_TRAINING` |
| 5 | Ask Claude Code: "list the tables in NORDVIK.RAW via the Snowflake MCP" | The raw tables listed, `ORDERS`, `CUSTOMERS` and so on |

If step 3 fails on the key, check that `private_key_path` points at the `.p8` file,
not the `.pub`.

## Fallback

If Snowflake isn't working on the day, `pip install duckdb` and
`python tools/build_duckdb.py` loads the raw data locally in seconds, so you can still do
the modelling work. Try it once now, so you know it works on your laptop.
