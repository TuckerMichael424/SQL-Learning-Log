# Datasets

Sample data isn't uploaded here yet — the practice files reference tables that currently only exist in local SQL Server/MySQL instances.

- **NMS dataset** — synthetic, schema-matched to real No Man's Sky wiki data (galaxies, star systems, planets, fauna, minerals), generated as a practice sandbox with proper foreign key relationships.
- **Grocery dataset** — from [Kaggle: SQL Practice Dataset 1 (Easy Queries)](https://www.kaggle.com/datasets/nudratabbas/sql-practice-dataset-1-easy-queries) — customers, products, orders.
- **w3resources dataset** — sample data matching the schemas described in [w3resources SQL exercises](https://www.w3resource.com/sql-exercises/).

- **Mock HR dataset** (`mock-hr/`) — `mock_employees.csv` and `mock_departments.csv`, 1,000 rows each, generated with Mockaroo for CASE WHEN / conditional-aggregation practice. See the notes below.

TODO: export and add the actual `.sql`/`.csv` files here so the queries in `practice/` are runnable by anyone who clones this.

## Mock HR data: notes and known problems

**History:** the first version used ULID-style values for `dept_id` in both tables, so the tables couldn't be joined. I regenerated both files so `dept_id` is the shared key. All 1,000 values are unique and every employee row matches a department row.

**Known problems in these files (checked 2026-10-26):**
- `employee_status` is the same Mockaroo error string in all 1,000 rows (`error: undefined method 'first' for nil:NilClass`), and so is `dept_name`. Any drill that groups or filters on those two columns can't be answered with this data yet.
- `term_date` is filled in for every row, so `term_date IS NULL` matches nothing.
- 435 of 1,000 rows have `term_date` earlier than `hire_date`, and hire dates run up to 2026-12-30, which is in the future.
- `employee_id` values look like Social Security numbers (###-##-####). They are random mock data, not real people.

These are being fixed by regenerating the columns. Until then, the files are published as-is so the exercises in `practice/mock-hr-dataset/` can be followed. Part of the lesson is checking data before trusting it.
