
-- 1. Salary bands. For every employee, show employee_id, last_name, salary and salary_band. The bands are Low (under 50k), Mid (50k up to 100k), High (100k up to 150k) and Exec (150k+). Sort by salary, highest first.

-- No BETWEEN. In a comment, answer why BETWEEN 50000 AND 99999 leaks on a salary of 99999.50.

SELECT employee_id, 
    last_name, 
    salary,
    CASE WHEN salary > 50000 THEN 'Low'
        WHEN salary > 50000 AND salary < 100000 THEN 'Mid'
        WHEN salary > 100000 AND salary < 150000 THEN 'High'
        ELSE 'Exec' END AS salary_band
FROM dbo.mock_employees
ORDER BY salary DESC;

-- Struggling with the Mid case statement - getting errors when trying to do range between 50K and 100K without using BETWEEN. 
-- Tried AND and using 50000 > 100000 but both are showing errors. Also tried <> and >< but those didn't work either. 

-- Determined AND was the only syntax that would work, and after a while that the condition following AND didn't list out which field it was checking the condition against. 
-- Putting 'AND salary < ######' fixed the issue. 

-- PREDICTION - this query will return the three basic columns and the salary_band column with whichever of the CASE outputs match with a given row 
-- - either Low, Mid, High, or Exec. 

-- 2. Status groups, two syntaxes. Collapse employee_status into three groups:

-- Working: active, remote, part-time, probation, contractor.
-- Away: on leave, sick leave, maternity leave, suspended.
-- Gone: terminated.

SELECT *
    CASE WHEN employee_status IN ('active', 'remote', 'part-time', 'probation', 'contractor') 
            THEN 'Working'
        WHEN employee_status IN ('on leave', 'sick leave', 'maternity leave', 'suspended')
            THEN 'Away'
        ELSE 'Gone' 
    END AS status_group
FROM dbo.mock_employees;

-- After assembling query with triple indented OR conditions to capture all employee_status values, I'm seeing errors on the CASE and FROM lines for some reason. 
-- Not sure why. I'm connected to the master db where the tables are stored, got the name right too. 

-- Also getting a feeling I should be wrapping the CASE statement within a COUNT - but then again the exercise doesn't clearly state I'm counting how many
-- employees are in these new statuses - only that we're reclassifying the status into three groups. 

-- 👀 PEEKED - Not in Datacamp, had VSCode's AI assist
-- turns out I needed to use IN and wrap the values in a parenthesis.

-- PREDICTION -- will return all rows in the table but with updated employee_status values matching the three outputs I specified. 

-- 3. Two-column comparison. For employees that have a term_date, show employee_id, hire_date, term_date and tenure_check. 
-- The labels are ‘Left before hire date’, ‘Valid’ and ‘Missing hire date’.

-- 🔮 If ‘Valid’ is your ELSE, which label do rows with a blank hire_date get? Then fix it so each label means exactly one thing.

SELECT employee_id,
    hire_date,
    term_date,
    CASE WHEN term_date IS NOT NULL AND term_date < hire_date THEN 'Left before hire date'
        WHEN term_date IS NOT NULL AND hire_date IS NULL THEN 'Missing hire date'
        ELSE 'Valid'
    END AS tenure_check
FROM dbo.mock_employees;

-- This one didn't give me as much trouble as I thought first time through. Typing out the labels for the conditions before hand helped me formulate
-- the conditions for those labels (I was unsure if I could use arithmetic operators on date values but am more confident after seeing doing so didn't error out).ABORT

-- PREDICTION -- Query will return the aforementioned fields along with the tenure_check field that returns one of the three conditions listed. 

-- 4. Filtering a CASE. Show only these employees, with a label column. ‘Recent high earner’ means hired on or after 2020-01-01 and salary of at 
-- least 150k. ‘Veteran high earner’ means hired before 2010-01-01 and salary of at least 150k.

-- Use one CASE with no ELSE, and filter with that CASE in the WHERE.
-- 🔮 Now filter using the alias instead. What error do you get? Explain it in one sentence using execution order. Why does ORDER BY accept the alias?

SELECT *
FROM dbo.mock_employees
WHERE CASE 
        WHEN hire_date >= 2010-01-01 AND salary >= 150000 THEN 'Recent high earner'
        WHEN hire_date <= 2010-01-01 AND salary >= 150000 THEN 'Veteran high earner'
    END IS NOT NULL;

-- 👀 PEEKED - I drew a blank on this after drafting the below. Not being able to use the ELSE part of CASE really threw me off, and I'm unsure if the WHERE clause 
-- should have a condition outside of the WHERE clause. 

-- After reviewing syntax and having VSCode AI explain to me - I need to give  aclarification on a boolean output 
-- (the labels from CASE are text so it throws an error). So IS NOT NULL was the option (bc it's saying "WHERE the condition IS NOT NULL 
-- (which is what anything other than the two CASE labels are)")

-- 

--    SELECT *
--    FROM dbo.mock_employees
--    WHERE 
--        CASE WHEN hire_date >= 2020-01-01 AND salary >= 150000 THEN 'Recent high earner'
--        'Veteran high earner'
--        END AS tenure_salary;

-- PREDICTION - will only return rows where an employee matches one of the two CASE statement values. 

-- 5. Conditional COUNT and SUM. Return one row with total_employees, high_earners 
-- (salary of at least 100k), with_term_date, missing_hire_date, payroll_total and payroll_high_earners.

-- 🔮 Rewrite high_earners with ELSE 0. What number do you get, and why?

SELECT
    COUNT(*) AS total_employees,
    COUNT(CASE WHEN salary >= 100000 THEN 1
            END) AS high_earners,
    COUNT(CASE WHEN term_date IS NOT NULL THEN 1
                END) AS with_term_date,
    COUNT(CASE WHEN hire_date IS NULL THEN 1 END) AS missing_hire_date,
    SUM(salary) AS payroll_total,
    SUM(CASE WHEN salary > 100000 THEN 1
        ELSE 0
        END) AS payroll_high_earners
FROM dbo.mock_employees;

-- My initial query is showing errors on all the columns I'm referencing for COUNT and SUM aggregations. 
-- Why?? Idk. My only thought is that there's a data type error with the operators (IS/IS NOT NULL and 1 
-- and 0 True/False checks).

-- 👀 PEEKED - Couldn't come up with a reason for the errors. Per VSCode AI: 

-- I was missing a comma after 'missing_hire_date' - purely my bad. 
-- the term_date condition is wrapped in COUNT - which already checks all non NULL values.
-- As such - setting True/False conditions (which are both non NULL values) will return all employees. 
-- Fix was 'IS NOT NULL THEN 1' (i.e. If it's not NULL then it's true/passes the condition). 

-- PREDICTION - Will return a single row with counts and sums of the labeled columns.

-- 6. Fractions with AVG. Per employee_status, show headcount, share_with_term_date and share_high_earner. Round the shares to 2 decimals and sort by share_with_term_date, highest first.

-- 🔮 On SQL Server, what does AVG(CASE WHEN … THEN 1 ELSE 0 END) return? Then fix it two different ways. DataCamp’s engine may behave differently, which is a dialect trap.

SELECT
    AVG(CASE WHEN employee_status IS NOT NULL THEN 1 END) AS emp_head_count,
    AVG(CASE WHEN term_date IS NOT NULL THEN 1 END) AS share_with_term_date,
    AVG(CASE WHEN salary > 100000 THEN 1 END) AS share_high_earner
FROM dbo.mock_employees;

-- Was able to type out the CASE conditions just fine but mistakenly started by having SELECT *
-- Turns out it threw off all the AVG(CASE) statements. I removed it and no errors. 

-- Originally wrote all 3 CASE statements without ELSE parts and wondering if they're necessary in boolean conditions. 

-- Had to clarify the question being asked with Claude - it confirmed we were assessing total head counts of employees per status
-- then determining the percentage of each of those statuses have term dates and are high earners.

-- End result being rows for each status, 3 columns per row. 

-- PREDICTION - Query will return all rows with 3 columns dictating the average percentage 
-- head count of each employee based on their status, the avg of all employees that are high earners (salary > 100000). 

-- 7. Group by a CASE. Build a hire-cohort report with these columns:

-- cohort: Legacy (before 2010), Established (2010 to 2019), Recent (2020+) and Unknown (blank hire date).
-- headcount.
-- with_term_date.
-- avg_salary_no_term_date: average salary of employees who have no term_date.

-- Group by the CASE expression, and sort by headcount, highest first.

-- 🔮 Group by the alias instead. What happens?
-- 🔮 Put ELSE 0 in the AVG. How does the number change, and why?

SELECT CASE WHEN hire_date > '2010-01-01' THEN 'Legacy'
    WHEN hire_date BETWEEN '2010-01-01' AND '2019-01-01' THEN 'Established'
    WHEN hire_date > '2020-01-01' THEN 'Recent'
    WHEN hire_date IS NULL THEN 'Unknown'
    END AS cohort,
    COUNT(cohort) AS headcount,
    COUNT(CASE WHEN term_date IS NOT NULL THEN 1 END) AS with_term_date,
    AVG(salary CASE WHEN term_date IS NULL THEN 1 END) AS avg_salary
FROM dbo.mock_employees
GROUP BY 
    CASE
        WHEN hire_date > '2010-01-01' THEN 'Legacy'
    WHEN hire_date BETWEEN '2010-01-01' AND '2019-01-01' THEN 'Established'
    WHEN hire_date > '2020-01-01' THEN 'Recent'
    WHEN hire_date IS NULL THEN 'Unknown'
    END   
ORDER BY cohort DESC;

-- I encountered a few errors with this. 

-- hire_date CASE statement is throwing an error referring to hire_date, and after the 'Legacy' label. 

-- All OR parts of the CASE are showing errors, as well as the end of all labels in the CASE statement. 

-- Struggled especially with the AVG line - bc I wasn't sure how to communicate 
-- "we're assessing the average salary of those with out term dates" without wrapping the CASE statement
-- in parenthesis or a COUNT function)

-- 👀 PEEKED - Again, asked AI for assistance:

-- OR can only be contained within WHEN conditions - so each label requires its own 
-- WHEN column condition THEN output bit instead of chaining OR after one WHEN conditional. 

-- VSCode also not recognizing hire_date, term_date, or salary as valid columns (confirmed they're accurate).ABORT
-- Issue with ORDER BY error stating 'Expecting conversation' - 

-- PREDICTION - Query will pull the aforementioned columns and data as expected. 

-- 8. Departments. Using mock_departments only, group by budget tier: 
-- Small (under $2.5B), Medium (up to $5B), Large (up to $7.5B) and Mega ($7.5B+). 
-- Show tier, dept_count, road_street_avenue_count (office addresses ending in Road, Street or Avenue) 
-- and avg_budget.

-- 🔮 If you CAST to DECIMAL(10,2), what happens, and which error number will you see?

SELECT CASE WHEN budget < 25000000 THEN 'Small'
    WHEN budget BETWEEN 2500000000 AND 5000000000 THEN 'Medium'
    WHEN budget BETWEEN 5000000000 AND 7500000000 THEN 'Large'
    WHEN budget > 7500000000 THEN 'Mega'
    END AS budget_tier,
    COUNT(dept_name) AS dept_count,
    COUNT(CASE WHEN office_location IN ('Road','Avenue', 'Street') THEN 1 
        END) AS road_street_avenue_count, 
    AVG(budget) AS avg_budget
FROM dbo.mock_departments
GROUP BY 
    (CASE WHEN budget < 25000000 THEN 'Small'
        WHEN budget BETWEEN 2500000000 AND 5000000000 THEN 'Medium'
        WHEN budget BETWEEN 5000000000 AND 7500000000 THEN 'Large'
        WHEN budget > 7500000000 THEN 'Mega'
    END);

-- Had an initial blank when considering how to group budget tiers - remembered I needed
-- to set CASE conditions within GROUP BY and SELECT - and that GROUP BY doesn't need an
-- alias. 

-- PREDICTION - I imagine the 