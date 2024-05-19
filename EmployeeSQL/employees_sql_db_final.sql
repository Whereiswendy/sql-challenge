-- ---------------------------------------------------------------------------------------------
-- STEP 1: Create Tables in Order - Starting with Metadata Tables
-- ---------------------------------------------------------------------------------------------

-- Departments table
CREATE TABLE departments (
    dept_no VARCHAR(4) PRIMARY KEY,
    dept_name VARCHAR(40) UNIQUE NOT NULL
);

-- Titles table
CREATE TABLE titles (
    title_id VARCHAR(5) PRIMARY KEY,
    title VARCHAR(30)
);

-- Employees table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(5),
    birth_date DATE,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    sex VARCHAR(1),
    hire_date DATE,
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

-- Dept_Emp table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no VARCHAR(4),
    PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

-- Dept_Manager table
CREATE TABLE dept_manager (
    dept_no VARCHAR(10),
    emp_no INT,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- Salaries table
CREATE TABLE salaries (
    emp_no INT,
    salary INT,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- ---------------------------------------------------------------------------------------------
-- STEP 2: Managing Import Bugs and Altering Tables
-- ---------------------------------------------------------------------------------------------

-- Adjusting dept_manager table to have a composite primary key and modifying dept_no length
ALTER TABLE dept_manager ALTER COLUMN dept_no TYPE VARCHAR(10);

-- Dropping the existing primary key and column if they exist
ALTER TABLE dept_manager DROP CONSTRAINT IF EXISTS dept_manager_pkey;
ALTER TABLE dept_manager DROP COLUMN IF EXISTS dept_manager_index;

-- Adding composite primary key
ALTER TABLE dept_manager ADD PRIMARY KEY (dept_no, emp_no);

-- Ensuring salaries table has a single primary key
ALTER TABLE salaries DROP CONSTRAINT IF EXISTS salaries_pkey;
ALTER TABLE salaries ADD CONSTRAINT salaries_pkey PRIMARY KEY (emp_no);

-- ---------------------------------------------------------------------------------------------
-- STEP 3: Import CSV Data, One Table at a Time
-- ---------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------
-- In Windows Command Prompt:
-- ---------------------------------------------------------------------------------------------
-- C:\Program Files\PostgreSQL\16\bin>psql -U postgres -d employeesql
-- Password for user postgres:
-- ---------------------------------------------------------------------------------------------
-- This is returned:
-- ---------------------------------------------------------------------------------------------
-- psql (16.3)
-- WARNING: Console code page (437) differs from Windows code page (1252)
--          8-bit characters might not work correctly. See psql reference
--          page "Notes for Windows users" for details.
-- Type "help" for help.
-- ---------------------------------------------------------------------------------------------
-- employeesql=# \du
-- ---------------------------------------------------------------------------------------------
-- This is returned:
-- ---------------------------------------------------------------------------------------------
--                              List of roles
--  Role name |                         Attributes
-- -----------+------------------------------------------------------------
--  postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS

-- employeesql=# SHOW data_directory;
--            data_directory
-- -------------------------------------
--  C:/Program Files/PostgreSQL/16/data
-- (1 row)
-- ---------------------------------------------------------------------------------------------
-- employeesql=#
-- -----------+------------------------------------------------------------

-- Import departments' data (in cmd prompt)
-- \copy departments(dept_no, dept_name) FROM 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Resources/departments.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM departments;

-- Import titles' data (in cmd prompt)
-- \copy titles(title_id, title) FROM 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Resources/titles.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM titles;

-- Import employees' data (in cmd prompt)
-- \copy employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date) FROM 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Resources/employees.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM employees;

-- Import dept_emp data (in cmd prompt)
-- \copy dept_emp(emp_no, dept_no) FROM 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Resources/dept_emp.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM dept_emp;

-- Import dept_manager data (in cmd prompt)
-- \copy dept_manager(dept_no, emp_no) FROM 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Resources/dept_manager.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM dept_manager;

-- Import salaries data (in cmd prompt)
-- \copy salaries(emp_no, salary) FROM 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Resources/salaries.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM salaries;

-- ---------------------------------------------------------------------------------------------
-- STEP 4: Data Analysis Section
-- ---------------------------------------------------------------------------------------------

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
CREATE VIEW employee_details_with_salary AS
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

SELECT * FROM public.employee_details_with_salary LIMIT 10;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
CREATE VIEW employees_hired_in_1986 AS
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

SELECT * FROM public.employees_hired_in_1986 LIMIT 10;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
CREATE VIEW department_managers AS
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments d
JOIN dept_manager dm ON d.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no;

SELECT * FROM public.department_managers LIMIT 10;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
CREATE VIEW employee_department_details AS
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

SELECT * FROM public.employee_department_details LIMIT 10;

-- 5. List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
CREATE VIEW hercules_b_employees AS
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

SELECT * FROM public.hercules_b_employees LIMIT 10;

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
CREATE VIEW sales_department_employees AS
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

SELECT * FROM public.sales_department_employees LIMIT 10;

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
CREATE VIEW sales_and_dev_department_employees AS
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

SELECT * FROM public.sales_and_dev_department_employees LIMIT 10;

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
CREATE VIEW last_name_frequency AS
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

SELECT * FROM public.last_name_frequency LIMIT 10;

-- ---------------------------------------------------------------------------------------------
-- STEP 5: Export Generated Views to CSV, One Table at a Time
-- ---------------------------------------------------------------------------------------------

-- \COPY (SELECT * FROM employee_details_with_salary) TO 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Outputs/employee_details_with_salary.csv' WITH CSV HEADER;
-- \COPY (SELECT * FROM employees_hired_in_1986) TO 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Outputs/employees_hired_in_1986.csv' WITH CSV HEADER;
-- \COPY (SELECT * FROM department_managers) TO 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Outputs/department_managers.csv' WITH CSV HEADER;
-- \COPY (SELECT * FROM employee_department_details) TO 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Outputs/employee_department_details.csv' WITH CSV HEADER;
-- \COPY (SELECT * FROM hercules_b_employees) TO 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Outputs/hercules_b_employees.csv' WITH CSV HEADER;
-- \COPY (SELECT * FROM sales_department_employees) TO 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Outputs/sales_department_employees.csv' WITH CSV HEADER;
-- \COPY (SELECT * FROM sales_and_dev_department_employees) TO 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Outputs/sales_and_dev_department_employees.csv' WITH CSV HEADER;
-- \COPY (SELECT * FROM last_name_frequency) TO 'C:/Users/wware/Desktop/UWA Bootcamp/Challenges/sql-challenge/EmployeeSQL/Outputs/last_name_frequency.csv' WITH CSV HEADER;
