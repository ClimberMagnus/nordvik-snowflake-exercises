# Nordvik Outdoor AB — Business and Reporting Handbook

*Internal. Maintained by Group Business Control. Last revised August 2026.*
*If you are new to reporting at Nordvik, read this before you touch a number.*

---

## 1. What Nordvik is

Nordvik Outdoor AB was founded in Gothenburg in 2011 as a single bike workshop. Today
the group sells e-bikes, bicycles, outdoor clothing, camping equipment, accessories and
service parts across four countries: Sweden, Norway, Finland and the Netherlands.

Revenue comes from three places, and almost every misunderstanding in this company
starts with someone forgetting that there are three and not one:

**The webshop.** One platform, four country storefronts, roughly 55 per cent of order
volume. Customers can check out as guests, and a meaningful share of them do. A guest
order has no customer number on it at all. It is still a sale.

**The stores.** Fourteen locations at the time of writing, plus one that has closed.
Most are full-line stores; Linköping and the old Gothenburg location are outlets, and
Utrecht was a seasonal pop-up that ran from June 2025 to March 2026. Store staff are
supposed to attach the customer's loyalty number to every transaction. In practice
roughly one in five store sales is rung up without one.

**B2B and leasing.** Corporate customers, municipalities and the Swedish benefit-bike
(*förmånscykel*) programme. This is our fastest-growing segment and by far the most
irritating to report on, for reasons in section 6.

The service subscription — Nordvik Care, in Basic, Plus and Pro tiers — sits alongside
all three. It is not counted as sales. See section 7.

## 2. The financial year

**Nordvik's financial year runs 1 May to 30 April.** It is named after the year in
which it ends. FY2026 means 1 May 2025 to 30 April 2026.

This matters more than people expect. When a commercial manager says "last year" they
almost always mean the financial year. When someone in the Dutch organisation says
"last year" they usually mean the calendar year, because that is what their previous
employer used. When a report says "2025" with no other qualifier, nobody can tell you
which one it means without opening it.

Say which one you mean. Every time.

## 3. The source systems, and what the columns are called

Sales data comes out of the ERP with its original column names, which are Swedish
abbreviations from the 2014 implementation. Nobody has renamed them because too much
downstream depends on them. The important ones:

| Column | What it actually is |
|---|---|
| `KUNDNR` | Customer number. Blank on guest and anonymous cash sales. |
| `ORG_ID` | Corporate account, only on B2B orders. |
| `ORDER_DATUM` | Date the order was placed. |
| `LEV_DATUM` | Date it shipped or was handed over. Blank if not yet shipped. |
| `FAKT_DATUM` | Invoice date. Blank until invoiced. |
| `KANAL` | WEB, BUTIK or B2B. |
| `BUTIK_ID` | Store. **On web orders this holds the literal string `WEB`, and on B2B orders `B2B`. Neither is a store.** |
| `STAT_CD` | Order status. See below. |
| `ORD_TYP` | STD for a normal sale, LEASING for a benefit-bike or corporate lease. |
| `ANTAL` | Quantity. |
| `ENHETSPRIS` | Unit price, excluding VAT, in the order currency. |
| `RABATT_BELOPP` | Discount on the line, as a positive amount to subtract. |
| `MOMS_SATS` | VAT rate applied. |
| `BELOPP_1` | Line amount **excluding VAT, after discount**. |
| `BELOPP_2` | Line amount **including VAT**. |

`BELOPP_1` and `BELOPP_2` are the two most misread columns in the company. There is no
way to tell from the name which is which. It is the first one.

### Status codes

| `STAT_CD` | Meaning |
|---|---|
| 10 | Registered. Payment authorised but nothing has left the warehouse. |
| 20 | Picked and shipped. |
| 30 | Invoiced. |
| 90 | Cancelled. |

**Only status 30 counts as a sale.** Status 10 and 20 are in flight; they will mostly
become 30 within a few weeks, but they are not revenue yet and must never be included
in a period figure. Status 90 is cancelled and counts as nothing, ever. There are a few
thousand of them and they carry full line amounts, so including them inflates a year by
several per cent.

You will also find `ORD_TYP = PRESENT` in very old extracts. That was the gift-card
order type, discontinued in 2022. Ignore it.

### Country codes

`LAND` appears on both the customer record and the order. It is free text and it is a
mess, because three different source systems have written to it over the years. Sweden
appears as `SE`, `se`, `Sverige` and `Sweden`, and the other three countries have the
same problem. They all mean the same country. Harmonise before you group.

Product categories have the same disease: `E-bikes`, `E-bike`, `E-Bikes` and `Elcykel`
are one category, not four.

## 4. What "net sales" means

The official definition, and the only one Group Business Control will sign:

> **Net sales** = the sum of `BELOPP_1` on order lines belonging to orders with status
> 30, after deduction of returns, converted to SEK.

Unpacked, because every clause of that sentence is a decision somebody gets wrong:

- **`BELOPP_1`, not `BELOPP_2`.** Net sales is excluding VAT. VAT is not ours.
- **After discount.** `BELOPP_1` is already net of `RABATT_BELOPP`. Do not subtract it
  twice. If you want gross-before-discount, it is `ANTAL × ENHETSPRIS`, and the gap
  between the two is about thirteen per cent of the top line, so it is not a rounding
  difference.
- **Status 30 only.**
- **After returns.** See section 5, which is the hard part.
- **Converted to SEK.** See section 8.
- **By order date.** Commercial reporting places a sale in the period of `ORDER_DATUM`.
  Finance places it on the invoice date. The two therefore do not tie at month end and
  are not supposed to. Section 8 again.

## 5. Returns, and the 2025 migration

This is the single largest trap in our data and everyone gets caught by it once.

**Before 1 January 2025**, the old order system recorded a return by writing a
*negative line back onto the original order*, with a line number of 90 or higher. The
return therefore carries the date of the original order, not the date of the return.
There is no way to say in which month a 2023 return happened. If you filter order lines
to positive quantities you will overstate every period before 2025.

**From 1 January 2025**, returns moved to their own table, with a real return date, a
reason code, and a reference back to the original order and line. Nothing was
backfilled. The old negative lines were left where they were.

So a query that sums net sales across the whole history has to handle both mechanisms,
and a query that reports returns *by month* only works from 2025 onwards. A dashboard
built on the returns table alone will show zero returns before 2025, which is wrong and
has been presented to the board at least once.

The return table carries quantity but no amount. To value a return you join back to the
original order line and use its `ENHETSPRIS`. Returns are always at the price actually
paid, never at list price.

### Reason codes

| Code | Reason |
|---|---|
| 01 | Size or fit |
| 02 | Defective product |
| 03 | Changed mind, returned within the withdrawal period |
| 04 | Wrong item delivered |
| 05 | Damaged in transit |

Code 02 is the one to watch. A cluster of 02 on a single article is a quality incident,
and quality incidents are handled by the product team, not by commercial.

## 6. Who counts as a customer

There is no single right answer to "how many customers do we have", and pretending
otherwise has caused more arguments than any other topic in this handbook.

Three definitions are in active use, all of them defensible:

**Commercial definition.** A customer is a distinct `KUNDNR` with at least one status-30
order in the period. This is what the sales dashboard shows and what we report to the
board. It ignores guest and anonymous orders entirely — they have no customer number to
count — so it understates the number of buying households by a wide margin.

**Marketing definition.** A customer is a distinct *person*, deduplicated across
registrations. We have a great many duplicate registrations: the same person signs up
again with a different email when they cannot remember their password, and the store
staff create a new record rather than search for an existing one. Marketing deduplicates
on first name, last name and postcode, which catches most of them and occasionally
merges two people who share a household and a name. This number is roughly twelve per
cent lower than the commercial one.

**Finance definition.** For B2B, the customer is the *contracting group*, not the
individual legal entity. A municipal group with four subsidiaries placing orders under
four different `ORG_ID` values is one customer for credit and one customer for the
account plan. The parent is on the account record; follow `PARENT_ORG_ID` up until it
is blank, and that is the customer.

Marketing has also asked more than once for a *household* count — distinct address, not
distinct person — for direct mail. That is a fourth number. It has never been adopted
officially, but it gets quoted in mailing briefs.

Whichever you use, say which one you used.

### Active and churned

A customer is **active** if they have placed a status-30 order in the last twelve
months, rolling. A customer has **churned** if they placed an order more than
twenty-four months ago and none since. The twelve-month gap between the two is
deliberate: a Nordvik customer who buys a bike does not need another one next spring,
and calling them churned after a year would make the number meaningless.

Subscription churn is a different thing entirely and uses the subscription status. Do
not mix the two in the same chart.

## 7. Subscriptions

Nordvik Care has three tiers: Basic, Plus and Pro. A subscription has a status of
ACTIVE, PAUSED or CANCELLED, and a monthly amount **in the customer's local currency**.

**Monthly recurring revenue is the sum of the monthly amount for ACTIVE subscriptions
only, converted to SEK.** Paused subscriptions bill nothing while paused and must be
excluded; they are not cancelled, so they are not churn either, and people who filter on
`STATUS <> 'CANCELLED'` overstate MRR by roughly ten per cent. Cancelled subscriptions
have an end date; active and paused ones do not.

Subscription revenue is **not** part of net sales. It is reported separately. If someone
asks for "total revenue" ask them whether they want subscriptions in it, because the
answer is different depending on who is asking.

## 8. Currency

Order amounts are stored in the currency of the order: SEK in Sweden, NOK in Norway,
EUR in Finland and the Netherlands. **Adding amounts across countries without converting
is the most common single error in ad hoc analysis here.** It produces a number that
looks plausible and is meaningless.

Commercial reporting converts at the daily rate on the **order date**. Finance converts
at the month-end average rate on the **invoice date**, for statutory reasons set out in
the finance policy. The two figures differ, typically by well under a per cent, and both
are correct within their own frame. Do not try to make them tie. Do say which you used.

VAT rates differ by country — 25 per cent in Sweden and Norway, 25.5 per cent in
Finland, 21 per cent in the Netherlands — which is another reason never to compare
`BELOPP_2` across countries.

## 9. Budget

Budget is set once a year at **country × product category × month**, in SEK, in the
autumn planning round.

There is no store-level budget. There is no product-level budget. There is no weekly
budget. Every year somebody asks for a store's performance against budget and every year
the answer is that the number does not exist. It can be allocated down, but an allocated
number is an assumption, not a target, and it should never be presented as though the
store had been given it.

## 10. Store reporting and like-for-like

Like-for-like store sales compare stores that were trading for the full twelve months of
**both** periods being compared. A store that opened during either period is excluded
from the comparison entirely — not pro-rated — and reported separately as new-space
growth.

Outlets and pop-ups are excluded from like-for-like regardless of how long they have
traded, because their pricing and assortment are not comparable to a full-line store.

Web is not a store and never enters like-for-like.

## 11. B2B and leasing, in detail

A benefit-bike or corporate lease is booked as **one order** on the day the agreement is
signed, at the full contract value, and then invoiced monthly over the term. This means:

- The sale lands entirely in one month in commercial reporting, and is spread over
  thirty-six months in finance. Neither is wrong.
- A single large B2B order can dominate a store's month, because the order is attributed
  to the store where the agreement was signed even though the bikes are delivered
  directly to the employer.
- A cancelled lease comes back as a return of the whole order value in the month of
  cancellation. **A store can therefore show negative net sales for a month.** It has
  happened, it is not a data error, and someone will ask about it.

B2B orders carry no `KUNDNR`, only an `ORG_ID`. Do not expect to find a person.
