# Finance Policy 4.2 — Revenue Recognition, Returns and Currency Translation

**Nordvik Outdoor AB, group finance. Approved by the CFO, effective 1 May 2025.**
**Applies to statutory and management reporting produced by the finance function.
It does not govern commercial dashboards, which follow the Business Handbook.**

---

## 4.2.1 Scope

This policy covers the recognition of revenue from goods sold through all channels, the
treatment of returns, the treatment of leasing arrangements, and the translation of
foreign-currency transactions into the group presentation currency, SEK.

Where this policy and the commercial reporting definitions diverge, both are retained
deliberately. Finance reports on the statutory basis. Commercial reports on the order
basis. Reconciliation between the two is performed quarterly and the bridge is published
in the closing pack. Attempts to force the two to agree in a single report have been
made twice and abandoned twice.

## 4.2.2 Point of recognition

Revenue on a goods sale is recognised **on the invoice date** (`FAKT_DATUM`), being the
point at which control passes to the customer for our delivery terms. Orders that are
registered or shipped but not yet invoiced (`STAT_CD` 10 and 20) are **not** revenue and
are not accrued. Cancelled orders (`STAT_CD` 90) are never recognised.

Commercial reporting recognises the same sale on the order date (`ORDER_DATUM`). The
resulting timing difference is immaterial at year level and material at month level,
particularly in April and May where the financial year boundary falls.

## 4.2.3 Returns

Returns are recognised as a reduction of revenue **in the period in which the return is
received**, not in the period of the original sale. The original sale is not restated.

For transactions from 1 January 2025 onward the return date is available directly. For
transactions before that date the legacy system did not record a return date and posted
the reversal against the original order. Historical returns are therefore, unavoidably,
recognised in the period of the original sale. This inconsistency is disclosed in the
FY2025 annual report, note 3, and no restatement is planned.

A return is valued at the **transaction price of the original line**, that is, the unit
price actually charged net of any discount granted. Returns are never valued at list
price and never at cost.

## 4.2.4 Value added tax

Revenue is stated **excluding value added tax**. The applicable statutory rates are:

| Country | Rate |
|---|---|
| Sweden | 25.0 % |
| Norway | 25.0 % |
| Finland | 25.5 % |
| Netherlands | 21.0 % |

The Finnish rate changed from 24.0 % to 25.5 % in September 2024. Transactions in the
data set carry the rate applied at the time and should not be recalculated.

Amounts including VAT are retained in the order line for reconciliation to the cash
ledger and to the payment provider settlement files. They are not a reporting measure.

## 4.2.5 Currency translation

Transactions denominated in NOK and EUR are translated to SEK using the **average
closing rate for the calendar month of the invoice date**. The daily rate table is the
source; the monthly average is computed from it.

Commercial reporting uses the **daily closing rate on the order date**. Where a figure
is presented to an audience that includes both functions, state the basis used. The
practical difference over a full year is under one per cent; over a single month in a
period of currency movement it has been as much as three.

Balance sheet items are translated at the closing rate on the reporting date. That is
outside the scope of the sales data set.

## 4.2.6 Leasing and benefit-bike arrangements

A benefit-bike (*förmånscykel*) or corporate lease is recorded in the order system as a
single order at the full contract value on the date of signature, with `ORD_TYP =
LEASING`. For statutory purposes the arrangement is an operating lease and revenue is
recognised **straight-line over the lease term**, normally thirty-six months.

The order system does not hold the lease term. Revenue recognition for leasing is
therefore maintained outside the order data, in the leasing sub-ledger, and **any
analysis of leasing revenue built directly on the order table will be wrong for
statutory purposes.** It remains valid for commercial purposes, where the full contract
value is credited to the signing period and the signing store.

On early termination, the unrecognised balance is released and the order system records
a full return of the original order in the month of termination. This can and does
produce a negative net sales figure for the store in that month. It is correct.

## 4.2.7 Subscription revenue

Nordvik Care subscription revenue is recognised monthly in arrears over the period of
service, for subscriptions in ACTIVE status only. Subscriptions in PAUSED status are not
billed and no revenue is recognised while the pause is in force. Subscription revenue is
presented separately from goods revenue in both statutory and management reporting and
is **not** included in net sales.

## 4.2.8 Responsibility

Group Business Control owns the definitions in this policy. Deviations require written
approval from the CFO. Where an analysis is produced for external use, the basis of
preparation must be stated on the face of the output.
