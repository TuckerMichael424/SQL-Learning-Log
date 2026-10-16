
-- Quick context - these exercises are based around DDL work for a fictional insurance company, Meridian Insurance. I'll be building out 
-- their internal employee/department database from scratch. 

-- 1.1 Create the primary database titled 'MeridianDB', then switch to it. 
CREATE DATABASE meridiandb

-- ⚠️ Incomplete

-- Correct query would have included the 'USE' command: 

CREATE DATABASE meridiandb
USE meridiandb;

-- The database was successfully created but outside of the normal master database I normally store dbs in. Fine for now, will work on correct placement another time. 

-- 1.2 Create a table called 'departments' with these columns: dept_id (primary, int), dept_name (up to 50 chars, cannot be null), location (up to 100 chars, can be null),
-- budget (decimal with 2 decimal places, can be null). 

CREATE TABLE departments (dept_id INT PRIMARY KEY, 
    dept_name VARCHAR(50), 
    location VARCHAR(100) NOT NULL, 
    budget DECIMAL(6, 2));

-- After creating a database/table - is it necessary to view it? I figure it would be but am struggling to find the right command that works in VSCode's MYSQL extension.
-- SHOW seems to be the common one. 

-- ❌ Incorrect Logic

-- Location CAN BE NULL - 'NOT NULL' is the opposite (i.e. it cannot be null). NOT NULL was not needed at all - trick question.
-- Also worth noting -  DECIMAL(6,2) means max value of 9999.99 — fine for a demo, but a real budget column would need DECIMAL(15,2) - 
-- which would be 999999999999999.99 or similar. 
-- Not wrong for this exercise, just worth knowing.

CREATE TABLE departments (dept_id INT PRIMARY KEY, 
    dept_name VARCHAR(50), 
    location VARCHAR(100), 
    budget DECIMAL(6, 2));

-- 1.3 Create a table called employees with these columns: 

CREATE TABLE employees (emp_id INT PRIMARY KEY, 
    first_name VARCHAR(50) NOT NULL, 
    last_name VARCHAR(50) NOT NULL, 
    hire_date DATE NOT NULL, 
    salary DECIMAL(6,2) NOT NULL, 
    dept_id INT,
        CONSTRAINT fk_employees_dept_id
        FOREIGN KEY (dept_id)
        REFERENCES departments(dept_id)
        );

-- ✅ Correct. FK syntax was new but referencing helped. Concept is still not fully cemented. 

-- 1.4 Create a table called projects with the following columns: project_id - int/primary, project_name - up to 100 chars & not null
-- start_date - date can null, end_date - date can null, dept_id - int & foreign key referencing departments(dept_id), can be null. 

CREATE TABLE projects (project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    dept_id INT,
        CONSTRAINT fk_dept_id
        FOREIGN KEY (dept_id)
        REFERENCES departments(dept_id)    
);

-- ❌ FK Constraint Name Collision
-- I reused fk_dept_id as the constraint name in both employees and projects tables. *Constraint names must be unique within a database* 

CREATE TABLE projects (project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    dept_id INT,
        CONSTRAINT fk_projects_dept_id
        FOREIGN KEY (dept_id)
        REFERENCES departments(dept_id)    
);

-- Now I'll move onto the ALTER syntax work on the tables I've created. 

-- 2.1 Add a column 'email' (up to 100 chars, nullable) to the employees table. 

ALTER TABLE employees 
ADD email VARCHAR(100);

-- ✅ Correct. Worth noting I needed to look up the syntax to add a new column in. Ensure 'ADD' gets recalled in future

-- 2.2 Add acolumn status (up to 20 chars) to employees with a default value of 'Active'. 

ALTER TABLE employees
ADD status VARCHAR(20) DEFAULT 'Active';

-- ✅ Correct. DEFAULT syntax was new as well. Work on recall. 

-- 2.3 Rename the column 'location' in departments to office_location. 

EXEC sp_rename 'departments.location', 'office_location', 'COLUMN';

-- Wasn't aware that I was required to use T-SQL syntax for the rename - good to know. 

-- ✅ Correct - per the rename note above still working on understanding the dialect differences between T-SQL and MySQL. 

-- 2.4 Change the data type of project_name in projects from VARCHAR(100) to VARCHAR(200). 

ALTER TABLE projects
ALTER COLUMN project_name VARCHAR(200);

-- Had to look up ALTER COLUMN - attempted to use MODIFY syntax which is correctly associated with MySQL and Oracle. 
-- ALTER COLUMN is specific to SQL Server apparently. 

-- ✅ Correct - make a point of recalling ALTER COLUMN vs. MODIFY based on the tool you're using! 

-- 2.5 Add a CHECK constraint to employees so that salary must be greater than 0.

ALTER TABLE employees
ADD CONSTRAINT chk_salary CHECK (salary > 0);

-- ✅ Correct. ADD CONSTRAINT ... CHECK (...) is the right T-SQL syntax. Good pattern to have memorized — use CHECK constraints constantly for data validation (positive quantities, valid status values, date ranges).

-- Moving onto section 3 - INSERT + TRUNCATE - I am familiar with the syntax of these but struggle to recall the syntax logic from my WGU Intro to Programming course. 

-- 3.1 Insert 3 rows into departments. Make up realistic data — use dept names like HR, Finance, Claims.

INSERT INTO departments (dept_id,dept_name,office_location)
VALUES (1,'HR', '3rd Floor'), 
(2, 'Finance', '9th Floor'), 
(3, 'Customer Support', '4th Floor'), 
(4, 'Operations', '11th Floor');

-- Took some tinkering due to forgetting dept_id and office_location were NOT NULL columns. 
-- Also worth noting the above query is showing an error on the office_location column. 
-- The query ran fine in VSCode but will come back to it. 

-- ⚠️ Minor note, not a real error. 4 rows were inserted when the exercise asked for 3 — not wrong, just extra. 
-- The office_location error in VS Code’s linter is likely just IntelliSense being confused about the renamed column 
-- (you renamed it with sp_rename in 2.3). The query ran fine, which is what matters. The linter sometimes lags behind schema changes.

-- 3.2 Insert 5 rows into employees. Make sure dept_id values match what you inserted in 3.1 (foreign key must be valid).

ALTER TABLE employees
ALTER COLUMN salary DECIMAL(10,2) NOT NULL;

INSERT INTO employees (emp_id, first_name, last_name, hire_date, salary, dept_id)
VALUES (15687, 'Peter', 'Staker', '1902-04-25', 11000.00, 1),
    (89748, 'Dohn', 'Joe', '0001-01-01', 50000.00, 4),
    (52345, 'Gary', 'Manold', '2023-12-25', 95000.00, 2),
    (45681, 'Tom', 'Bombadil', '1994-06-17', 34532.00, 3),
    (87498, 'Michael', 'Rotch', '1865-02-28', 72000.00, 1);

-- Had to really troubleshoot an error about datatype for the hire_date - I tried a MM/DD/YYYY format or YYYY-MM-DD with and without '' marks. 
-- Ended up accept it wasn't working and moving on to get a correction from Claude - googling didn't give me much help. 

-- ✅ Correct after the ALTER fix. The troubleshooting process here was the real lesson — you hit a real constraint, diagnosed it (eventually), 
-- and fixed it at the schema level rather than just fudging the data. That’s the right instinct. DATE formatting was not the issue - 
-- it was the salary column itself being limited to 8 character decimal values. 

-- 3.3 Run a SELECT * on both tables to confirm your data is there.

SELECT *
FROM departments;

SELECT *
FROM employees;

-- ✅ Correct. 

-- 3.4 TRUNCATE the employees table. Then run SELECT * again to confirm it’s empty. (Note: if the FK constraint blocks you, you’ll need to drop or disable it first — try it and see what happens.)

TRUNCATE TABLE employees;

SELECT *
FROM employees;

-- ✅ Correct. Good instinct to verify with SELECT after truncating.

-- Now Section 4 - focusing on the DROP syntax. 

-- 4.1 Drop the projects table entirely. 

DROP TABLE projects;

SELECT *
FROM projects;

-- ✅ Correct. Running SELECT after DROP correctly shows the “object doesn’t exist” error — that’s confirmation it worked.

-- 4.2 Try to drop the departments table while employees still references it (even if empty). Observe the error. 
-- Then drop employees first, then departments.

DROP TABLE departments;

-- Gave error 'Msg 3726, Level 16, State 1, Line 176 Could not drop object 'departments' because it is referenced by a FOREIGN KEY constraint.'

DROP TABLE employees
DROP TABLE departments;

SELECT *
FROM employees;

SELECT *
FROM departments;

-- Correct. You hit the FK error exactly as expected, then solved it by dropping in the right order (child before parent). 
-- That order — dependent table first, then the referenced table — is the rule to remember.

-- 4.3 Drop the entire Meridiandb database (ensure to switch back to the master db before doing so). 

USE master
DROP DATABASE meridiandb;

-- Tried simply running USE before DROP DATABASE but can't run it bc I need to be in meridiandb when I run the DROP query. 
-- Going to simply try running the DROP query first. See what happens. 

DROP DATABASE meridiandb
USE master;

-- Same issue - can't run the command if I'm standing in the database. 

-- Googled - apparently I just need to do separate queries??

USE master;

DROP DATABASE meridiandb;

-- Same issue still. Maybe something specific to SQL Server? 

USE master;

GO
ALTER DATABASE meridiandb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE meridiandb;
GO

-- OOOOOOOOH - so there's an extra trick to it - I've never encountered the SET SINGLE_USER bit. 
-- Testing to see if it's still there. 

USE meridiandb;

-- ✅ Correct, and you figured out why. The SET SINGLE_USER trick is a SQL Server-specific thing. 
-- The reason USE master; DROP DATABASE meridiandb; kept failing is that VS Code’s MSSQL extension maintains an active connection to the DB even after
-- you run USE master — SQL Server won’t drop a database with active connections. SET SINGLE_USER WITH ROLLBACK IMMEDIATE boots 
--all other connections and rolls back their transactions, leaving only yours, then DROP works. 
-- You’ll rarely need this in real life but good to have seen it.
