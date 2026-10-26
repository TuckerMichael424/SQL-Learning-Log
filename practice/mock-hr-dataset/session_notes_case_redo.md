# CASE drills: first attempt and redo plan

Context pasted from my SQL mentor chat after finishing `mock_hr_case_practice_1.sql` (8 CASE WHEN drills). The attempt is saved as-is, errors and all. Several drills were finished with help ("PEEKED" notes in the file), so don't read it as unaided work.

## Schema

`dbo.mock_employees` and `dbo.mock_departments`, SQL Server (T-SQL), 1,000 rows each.

- employees: employee_id, first_name, last_name, hire_date, term_date, salary, employee_status, dept_id
- departments: dept_id, dept_name, office_location, budget
- dept_id is meant to be the shared key between the two tables. See `datasets/README.md` for how it got fixed and what is still wrong with the data.

## Session rules

- Max 3 drills per session
- Each query starts with `-- grain: one row per ___` and `-- prediction: [number or named error]`
- After each run: do the bucket counts sum to the table total, and are the magnitudes right?
- The 🔮 steps are mandatory before moving to the next drill
- Hint ladder only: nudge, then bigger hint, then full answer. No rewrites.
- Give the exact error message (Msg number) before diagnosing any error

## Redo list and exact issues

| Drill | Issue |
|---|---|
| 1 | First-match-wins range ordering is wrong. `ELSE 'Exec'` catches everyone above 50k. |
| 5 (col 6) | `SUM(CASE ... THEN 1)` returns headcount instead of dollars. |
| 6 | Missing `GROUP BY employee_status`, missing `ELSE 0`, so every share comes back as 1. |
| 8 | Small tier typo (25M instead of 2.5B). `IN` used instead of `LIKE` for address suffix matching. |

## Mistake patterns across the file

- Treating CASE as something that filters, rather than something that adds a column (WHERE filters because it runs before SELECT).
- Syntax slips: missing commas, `SELECT *` alongside other expressions, CASE wrapped in the wrong place.
- Comparing dates and numbers loosely: `2010-01-01` unquoted is arithmetic (it evaluates to 2008), not a date.
- Checking only that a query runs, not that the buckets add up to the table total.
