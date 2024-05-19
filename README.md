# sql-challenge
UWA Data Analytics Bootcamp Module 9 Challenge in SQL - The Basics

# EmployeeSQL

## Overview

This project is part of the UWA Bootcamp and involves creating and managing a PostgreSQL database to handle employee data. The challenge includes creating database tables, importing data from CSV files, performing data analysis through SQL queries, and exporting the results.

## Repository Structure

EmployeeSQL

│

├── **Outputs**

│ ├── department_managers.csv

│ ├── employee_department_details.csv

│ ├── employee_details_with_salary.csv

│ ├── employees_hired_in_1986.csv

│ ├── hercules_b_employees.csv

│ ├── last_name_frequency.csv

│ ├── sales_and_dev_department_employees.csv

│ ├── sales_department_employees.csv

│ ├── QuickDBD-UWABootcamp_EmployeeSQL.png

│ ├── QuickDBD-UWABootcamp_EmployeeSQL.sql

│

├── **Resources** - `Provided`

│ ├── departments.csv

│ ├── dept_emp.csv

│ ├── dept_manager.csv

│ ├── employees.csv

│ ├── salaries.csv

│ ├── titles.csv

│

├── employees_sql_db_final.sql - `Final Scripts - schemata and queries`

├── employees_sql_db.sql

├── .gitignore

└── README.md `You are here`


## Challenge Instructions

1. **Create Database Schema**:
    - Define and create tables for `departments`, `titles`, `employees`, `dept_emp`, `dept_manager`, and `salaries`.
    - Manage foreign keys and primary keys appropriately.
    - Adjust table structures as necessary to fix import bugs.

2. **Import Data from CSV Files**:
    - Import data into each table from the corresponding CSV files located in the `Resources` directory.

3. **Perform Data Analysis**:
    - Create SQL views to perform the following analyses:
        1. List the employee number, last name, first name, sex, and salary of each employee.
        2. List the first name, last name, and hire date for the employees who were hired in 1986.
        3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
        4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
        5. List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
        6. List each employee in the Sales department, including their employee number, last name, and first name.
        7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
        8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

4. **Export Data Analysis Results**:
    - Export the results of the SQL views to CSV files located in the `Outputs` directory.

## Steps Undertaken

### Step 1: Create Tables

Created the following tables:
- `departments`
- `titles`
- `employees`
- `dept_emp`
- `dept_manager`
- `salaries`

Ensured the primary and foreign keys were set correctly and adjusted the table structure to fix import bugs.

### Step 2: Import Data

Imported data from CSV files into the corresponding tables using the `\COPY` command in `psql`.

### Step 3: Data Analysis

Created SQL views to perform the required data analyses:
- `employee_details_with_salary`
- `employees_hired_in_1986`
- `department_managers`
- `employee_department_details`
- `hercules_b_employees`
- `sales_department_employees`
- `sales_and_dev_department_employees`
- `last_name_frequency`

### Step 4: Export Data Analysis Results

Exported the results of the views to CSV files in the `Outputs` directory using the `\COPY` command in `psql`.

## How to Use

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/yourusername/EmployeeSQL.git
    cd EmployeeSQL
    ```

2. **Set Up the Database**:
    - Ensure PostgreSQL is installed and running.
    - Run the `employees_sql_db_final.sql` script to create the tables and import the data.

    ```sh
    psql -U your_username -d your_database -f employees_sql_db_final.sql
    ```

3. **View the Analysis Results**:
    - The CSV files containing the analysis results are located in the `Outputs` directory.

## Notes

- Ensure the file paths in the `\COPY` commands match your system's directory structure.
- The `employees_sql_db_final.sql` script includes all necessary SQL commands for creating tables, importing data, and performing data analysis.


