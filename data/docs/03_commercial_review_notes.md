# Commercial review — running notes

*Mattias' notebook. Weekly commercial review, Thursdays 09:00. Not minutes, not official.
Do not circulate outside the commercial team. I write these for myself.*

---

**2026-08-27**

Numbers pack came in 40 min before the meeting again. Need to fix that.

- Group net sales FY2026 landed just under 342 MSEK. Karin's version said 350-something
  and it took twenty minutes to work out why — she had the cancelled orders in. Again.
  Status 90 is not a sale. I have now said this in four consecutive reviews.
- Uppsala doing better than expected for a store that opened last September. Do NOT put
  it in the LFL table. Sofia had it in there last month and the LFL growth looked
  fantastic for about a day.
- Reminder to self: LFL = full-line stores only, trading the whole of both periods.
  Utrecht never goes in — it was a pop-up, it had pop-up pricing, it closed in March.
  Linköping is an outlet, also out.
- Someone asked for LFL including web. No. Web is not a store.

**2026-08-13**

- Marketing presented "customer growth" using their deduplicated count and commercial
  presented theirs off KUNDNR and the two numbers were 12% apart on the same slide deck.
  Nobody in the room could say which was right because both are. This needs a decision,
  and the decision is: say which one you are using, in the chart title, every time.
- Related: the guest checkout share is creeping up. Roughly one web order in eight has
  no customer number at all, and in store it is closer to one in five. So any "customers"
  number based on KUNDNR is missing a real chunk of the business. It does not affect
  revenue, because the orders are still there — but every time someone builds a customer
  view with an inner join to the customer table they quietly lose about a tenth of the
  top line and do not notice. That has happened three times that I know of.
- Ask Karin before quoting churn to anyone outside the team. She has opinions and she is
  usually right.

**2026-07-02**

- Budget question again. Peter wanted Malmö vs budget. There is no store budget. Budget
  is country and category and month. I explained this. He asked if we could "just split
  it by store size". We could. It would be a number I made up. We are not doing that.
- FY2027 planning round starts in September, same grain as always.

**2026-04-09**

- The March returns spike. Finally understood: it is the Fjell 500, the battery mount
  bracket. Units sold from about November came back through March, nearly all under
  reason code 02. Product has a supplier claim in. Roughly 70 units. It is not a data
  error and it is not a demand signal, and it should be called out separately in any
  March or Q1 commentary rather than left in the returns line where it looks like
  customers going off us.
- Support had been seeing it in tickets well before it showed up in the returns numbers.
  Worth remembering — the tickets led the data by about six weeks. If we had been reading
  them we would have known in February.

**2026-03-05**

- Malmö is going to show negative net sales for February. The Vattenhall lease cancelled
  and the whole order reverses in the month of cancellation. 25 bikes. Do not "correct"
  it, do not exclude it, just put a footnote on the slide. Ludvig tried to filter it out
  last time something like this happened and then the store total did not tie to the
  country total and we spent an afternoon on it.
- Leasing generally: the whole contract value hits the signing month and the signing
  store. Commercially that is what we want. It does mean a single deal can make a small
  store look like a big one for a month.

**2026-01-15**

- Reminder that FY2026 ends 30 April. When the Dutch team says "last year" they mean
  calendar. When Gothenburg says it they mean fiscal. Half the confusion in this company
  is this one thing.

**2025-11-20**

- Dashboard rebuild kicked off. Things I want fixed and keep having to explain:
  - BELOPP_1 is excluding VAT. BELOPP_2 is including. The names tell you nothing.
  - The country field is free text. SE, se, Sverige, Sweden. Same for the other three.
  - Product categories are the same story. Elcykel and E-bikes are the same thing.
  - BUTIK_ID is 'WEB' on web orders. It is not a store and it will not join to the
    store table. Every new analyst discovers this the hard way.
- Also: 26 articles got reclassified from service parts into accessories on 1 July.
  The product table only shows where they are now. If you report last year's category
  split using today's category you will move about a million kronor between two
  categories and wonder why the history changed. There is a history table. Use it.

**2025-09-04**

- Coffee machine on floor 2 is broken again.
- MRR: Emil's number was high because he counted paused subscriptions. Paused is not
  cancelled but it is also not billing. Active only.
- Subscription amounts are in local currency, same as everything else, and he had summed
  them raw across four countries. Two errors in one number.

**2025-05-22**

- New FY. Note for whoever builds the comparison: FY2026 is May 2025 to April 2026.
  FY2025 is May 2024 to April 2025.
- Gothenburg Outlet closed in December, so it is out of LFL for FY2026 as well.
