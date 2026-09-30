# Setup — before the day

**Everything below must be green before the day.** Nothing kills a hands-on block faster
than installing a CLI at 13:05. When the smoke test passes, tell Magnus.

Do the setup on your Climber laptop, not on a customer-issued machine.

## Accounts and access

- [ ] Claude work account active, Claude desktop app installed and signed in
- [ ] Snowsight login to account `DXHGGSH-CLIMBERAB_PARTNER` with your Climber account
      (Entra SSO), with role `_SEC_CL_SNOWFLAKE_DEVELOPERS`. If you don't have that role,
      tell Magnus
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
- [ ] Cortex Code desktop app, optional. It's also in Snowsight
- [ ] VS Code extensions: Snowflake, and the official dbt extension

## Configuration

1. **Key pair.** dbt and the Snowflake CLI sign in with a key pair, not the browser. With
   the browser, every dbt run and every command your AI assistant runs opens a new login.
   Users can't set their own key in this account, so the Snowflake admins set it on your
   user. Follow whichever of these they ask for:

   - **They send you a key pair:** save the private key as `~/.ssh/snowflake_key.p8`, then
     delete the message or file it came in.
   - **You generate it:** in Git Bash, then send them only the contents of
     `snowflake_key.pub`:

     ```bash
     mkdir -p ~/.ssh
     openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out ~/.ssh/snowflake_key.p8 -nocrypt
     openssl rsa -in ~/.ssh/snowflake_key.p8 -pubout -out ~/.ssh/snowflake_key.pub
     ```

   Either way, the private key stays on your laptop. It never goes in a repo, a chat or
   an email reply. You keep this access after the day.

2. **dbt profile.** Copy `transform/dbt/profiles.example.yml` to `~/.dbt/profiles.yml`
   and fill in your Snowflake user name, the key path and `schema: DBT_<your initials>`.
   The account, role and warehouse are already filled in. dbt creates
   `DBT_<INITIALS>_STAGING` and `DBT_<INITIALS>_MARTS` from that on the first build.

3. **Snowflake CLI connection.** Run `snow connection add`, name it `nordvik`, and use
   account `DXHGGSH-CLIMBERAB_PARTNER`, your user name, key-pair auth (`SNOWFLAKE_JWT`)
   with the same `.p8` file, role `_SEC_CL_SNOWFLAKE_DEVELOPERS` and warehouse
   `NORDVIK_WH`.

4. **Claude Code and Snowflake.** Nothing more to set up. Claude Code runs `snow sql -c
   nordvik ...` itself, using the connection from step 3. An MCP server is optional: the
   Climber Snowflake connector in Claude desktop works for read-only queries, but it
   can't create objects, so it won't do for the build blocks.

## Smoke test — all five must pass

| # | Check | Expected |
|---|---|---|
| 1 | Log in to Snowsight with your Climber account | You see database `NORDVIK` |
| 2 | `select count(*) from NORDVIK.RAW.ORDERS` | 50001 |
| 3 | `cd transform/dbt && dbt debug` | All checks passed, no browser login |
| 4 | `snow sql -c nordvik -q "select current_role(), current_warehouse()"` | `_SEC_CL_SNOWFLAKE_DEVELOPERS`, `NORDVIK_WH` |
| 5 | Ask Claude Code: "use the snow CLI connection nordvik to list the tables in NORDVIK.RAW" | The raw tables listed, `ORDERS`, `CUSTOMERS` and so on, with no browser login |

If step 3 or 4 fails on the key, check that the path points at the `.p8` file, not the
`.pub`. If a browser login opens, the connection or profile is still set to SSO.

## Fallback

If Snowflake isn't working on the day, `pip install duckdb` and
`python tools/build_duckdb.py` loads the raw data locally in seconds, so you can still do
the modelling work. Try it once now, so you know it works on your laptop.
