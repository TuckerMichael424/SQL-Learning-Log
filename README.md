# SQL Learning Log

This is **not a portfolio piece** — it's my working practice log, kept public and current on purpose so the people helping me track my progress (mentors, coaches) can see where I actually am, not a polished finished product.

For finished, written-up analysis projects, see my [Data Analysis Portfolio](https://github.com/TuckerMichael424/Data-Analysis-Portfolio) and [Golden Era of Video Games in SQL](https://github.com/TuckerMichael424/Golden_Era_of_Video_Games_in_SQL) instead.

## Where I'm at

**Solid:** `SELECT`/`WHERE`/`ORDER BY`, aggregates (`COUNT`/`SUM`/`AVG`/`MAX`), `GROUP BY`, `INNER`/`LEFT`/`RIGHT` JOINs, and the LEFT JOIN + `IS NULL` anti-join pattern (finding rows with no match in another table).

**Functional but inconsistent:** `HAVING` — I use it correctly most of the time (filtering an aggregated result), but I've also caught myself putting it on a plain column instead of `WHERE`, or instead of wrapping it in an aggregate. `CASE WHEN` and `COALESCE` are new as of this month. My first full CASE set (`practice/mock-hr-dataset/`) had real problems: range ordering (first match wins), conditional `SUM`/`AVG` with no `ELSE 0`, and a missing `GROUP BY`. I'm redoing the worst four drills before moving on.

**Just starting:** subqueries (through DataCamp's Associate Data Analyst in SQL track).

**Not started:** CTEs (`WITH`), window functions. I've literally left placeholder headers for these in practice files and skipped past them.

**Recurring mistakes worth knowing about, if you're reviewing my work:**
- Mixing JOIN types in a chain (e.g. `LEFT JOIN` then `INNER JOIN` further down) quietly drops rows the first JOIN was trying to preserve.
- Treating `CASE` like a filter instead of a new column, and wrapping the wrong thing in `AVG`/`SUM`/`COUNT` (conditional aggregation).
- Adding `GROUP BY` out of habit even when there's no aggregate function in the query (it's doing `DISTINCT`'s job, badly).
- Multi-table joins with more than 2-3 tables are still a struggle spot — I can usually get there but not on the first try.

## How I practice

I'm working through DataCamp's Associate Data Analyst in SQL track, and after each chapter I do unscaffolded practice in VS Code against SQL Server / MySQL, using four practice sources:
- **w3resources** exercises, against sample data an AI generated to match the schema they described
- A **Kaggle grocery-store dataset** (customers/products/orders), for translating plain-English business questions into queries from scratch
- A **synthetic No Man's Sky database** (galaxies/systems/planets/fauna/minerals), built specifically so I have a larger multi-table schema to practice real joins against
- A **mock HR dataset** (employees/departments, generated with Mockaroo) for CASE WHEN and conditional aggregation. The data has known problems, documented in `datasets/README.md`.

I review my own attempts and log what I got wrong — syntax slip vs. logic error vs. misunderstanding the question — rather than moving on once something "worked."

## Repo structure

```
practice/
  nms-dataset/              multi-table JOIN practice (galaxies → systems → planets → fauna/minerals)
  grocery-dataset/          business-question → SQL translation practice
  w3resources-dataset/      w3resources exercises
  mock-hr-dataset/          CASE WHEN drills plus the mentor session notes
datasets/
  mock-hr/                  the two mock HR CSVs (known data problems, see datasets/README)
  the other datasets are not uploaded yet (see datasets/README)
```

Some files include inline review notes (marked `-- Claude Input:` or similar) from sessions where I had a query reviewed. Those are left in place, mistakes and all — I'm not cleaning up the history to look more finished than it is.

## For coaches / mentors

I'm past the absolute-basics stage. If you're deciding where to start with me: JOINs and GROUP BY/HAVING are the area I most want pressure-tested (I'm functional but want to be fluent, not just correct-when-I'm-careful). Anything on subqueries, CTEs, or window functions would be genuinely new ground.
