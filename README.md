# SQL Learning Log

This is **not a portfolio piece** — it's my working practice log, kept public and current on purpose so the people helping me track my progress (mentors, coaches) can see where I actually am, not a polished finished product.

For finished, written-up analysis projects, see my [Data Analysis Portfolio](https://github.com/TuckerMichael424/Data-Analysis-Portfolio) and [Golden Era of Video Games in SQL](https://github.com/TuckerMichael424/Golden_Era_of_Video_Games_in_SQL) instead.

## Where I'm at

**Solid:** `SELECT`/`WHERE`/`ORDER BY`, aggregates (`COUNT`/`SUM`/`AVG`/`MAX`), `GROUP BY`, `INNER`/`LEFT`/`RIGHT` JOINs, and the LEFT JOIN + `IS NULL` anti-join pattern (finding rows with no match in another table).

**Functional but inconsistent:** `HAVING` — I use it correctly most of the time (filtering an aggregated result), but I've also caught myself putting it on a plain column instead of `WHERE`, or instead of wrapping it in an aggregate. `CASE WHEN` and `COALESCE` are new as of this month — early results are decent but not battle-tested yet.

**Not started:** subqueries, CTEs (`WITH`), window functions. I've literally left placeholder headers for these in practice files and skipped past them.

**Recurring mistakes worth knowing about, if you're reviewing my work:**
- Mixing JOIN types in a chain (e.g. `LEFT JOIN` then `INNER JOIN` further down) quietly drops rows the first JOIN was trying to preserve.
- Adding `GROUP BY` out of habit even when there's no aggregate function in the query (it's doing `DISTINCT`'s job, badly).
- Multi-table joins with more than 2-3 tables are still a struggle spot — I can usually get there but not on the first try.

## How I practice

Working in VS Code against SQL Server / MySQL, using three practice sources:
- **w3resources** exercises, against sample data an AI generated to match the schema they described
- A **Kaggle grocery-store dataset** (customers/products/orders), for translating plain-English business questions into queries from scratch
- A **synthetic No Man's Sky database** (galaxies/systems/planets/fauna/minerals), built specifically so I have a larger multi-table schema to practice real joins against

I review my own attempts and log what I got wrong — syntax slip vs. logic error vs. misunderstanding the question — rather than moving on once something "worked."

## Repo structure

```
practice/
  nms-dataset/              multi-table JOIN practice (galaxies → systems → planets → fauna/minerals)
  grocery-dataset/          business-question → SQL translation practice
  w3resources-dataset/      w3resources exercises
datasets/
  sample data referenced by the queries above (not yet uploaded — see datasets/README)
```

Some files include inline review notes (marked `-- Claude Input:` or similar) from sessions where I had a query reviewed. Those are left in place, mistakes and all — I'm not cleaning up the history to look more finished than it is.

## For coaches / mentors

I'm past the absolute-basics stage. If you're deciding where to start with me: JOINs and GROUP BY/HAVING are the area I most want pressure-tested (I'm functional but want to be fluent, not just correct-when-I'm-careful). Anything on subqueries, CTEs, or window functions would be genuinely new ground.
