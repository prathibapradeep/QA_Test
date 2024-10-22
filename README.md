# QA Test Automation in SQL

## Introduction

This project is aimed at automating quality assurance (QA) checks in a relational database management system (RDBMS). The code is designed to be modular to allow future improvements such as adding an audit table or extending test functionalities. The main goal of this MVP is to execute QA tests stored in a database, replace parameters in SQL queries at runtime, and output the test results in a GUI.

## Objectives

Key objectives of the project include:

Modular QA Checks: Develop a system that reads QA test configurations from a qa_tests table.
Parameterized Execution: Dynamically replace SQL query parameters with actual runtime values.
Automated Test Execution: Run the tests marked as enabled in the qa_tests table.
Test Results Output: Display the test results, including the executed SQL and the result, in a GUI.

**Programming Language:** Oracle PL/SQL

**Database:** LiveSQL

## QA Test Execution Logic

Below is an outline of the high-level process that runs the QA checks based on the information stored in the qa_tests table.

**Step 1: Table Creation** : Create all the tables that are essential to perform QA Checks.

**Step 2: Sample Data Generation** : Insert various datasets to thoroughly test the QA checks.

**Step 3: Define the Stored Procedure** : Create a Procedure to perform the QA check . Below are the explanation of the key parts.

1. Read the qa_tests table: Fetch all records from the qa_tests table (optionally filter by the enabled flag set to "Y").

2. Dynamic/Run Time Parameter: Replace environment (env) and date (date) placeholders in the test_sql with dynamic parameters (p_env and p_date) at runtime using the REPLACE function.

3. Dynamic SQL Execution: Use the EXECUTE IMMEDIATE statement to run the dynamic SQL after parameter substitution. Store the SQL execution result in a variable.

4. Error Handling: Capture any SQL errors (e.g., syntax or runtime issues) using SQLERRM, and log them into the qa_test_results table.

5. Storing Results for GUI: Save the fully executed SQL query, its results, and the execution time (run_time) into the qa_test_results table for later retrieval and GUI display.

**Step 4: Call/Execute the Stored Procedure** : Run the procedure with runtime parameters, which logs the results into the qa_test_results table.

**Step 5: Query the Results** : Fetch the results from the qa_test_results table to review the results of the test cases.

## Installation and Setup

**Prerequisites**
- Oracle Database (or any RDBMS that supports similar SQL syntax).

**Setup Instructions**

Run the following SQL scripts in sequence:

```
1. create_tbl_qa_chk.sql - Creates all required tables.
2. insert_tbl_qa_chk.sql - Inserts sample records into the tables.
3. run_qa_checks.sql -  Defines the procedure to perform QA checks.
4. exec_qa_checks.sql - Executes the QA checks based on runtime parameters.
5. Query the results using below sql

SELECT code, executed_sql, result, status
FROM qa_test_results
order by run_time desc
;


```

## Future Enhancement:

**Audit Table**: While an audit table is created, it currently does not log entries. Enhancing the code to track all test executions and results over time would allow for historical analysis of QA checks.

**Job Scheduling**: Integrate the program with automatic job schedulers like cron or other job scheduling tools.

**Performance Optimization**: Improve the program’s efficiency to better handle large datasets.
