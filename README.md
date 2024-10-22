# QA_Checks

## Introduction

The purpose of this repository is to create a program that can perform QA Checks.

**Programming Language:** Oracle PL/SQL
**Database:** LiveSQL

Here's a high-level process that runs the QA checks based on the information stored in the qa_tests table. 

## Step 1: Creation of tables 

**File Name : create_tbl_qa_chk.sql**

Create all the tables that are essential to perform QA Checks.

## Step 2: Creation of Sample Data

**File Name : insert_tbl_qa_chk.sql**

Create various datasets to test the QA checks

## Step 3: Define the Stored Procedure

**File Name : run_qa_checks.sql**

Create a Procedure to perform the QA check . Below are the explanation of the key parts.

1. Dynamic/Run Time Parameter:
The env and date placeholders in the test_sql are passed dynamically as parameters (p_env and p_date). This is applied to the SQL using REPLACE function.

2. Dynamic SQL Execution:
The EXECUTE IMMEDIATE statement is used to run the dynamic SQL after the parameters are replaced. The result of the SQL execution is stored in a variable.

3. Error Handling:
If any SQL error occurs (like syntax errors or runtime errors), the error message is captured with SQLERRM and logged in the qa_test_results table.

4. GUI-Ready Results:
The fully executed SQL and its result are stored in the qa_test_results table, including the time of execution (run_time). This table can be queried to display the results in the GUI.

## Step 4: Call/Execute the Stored Procedure
**File Name : exec_qa_checks.sql**

## Step 5: Query the Results

Execute the below query to review various test case scenarios

```
SELECT code, executed_sql, result, status
FROM qa_test_results
order by run_time desc
;
```

**Query Execution :**

Below Queries are executed in order.

```
1. create_tbl_qa_chk.sql - Creation of all the tables 
2. insert_tbl_qa_chk.sql - Sample records of all the tables
3. run_qa_checks.sql - Procedure to perform the QA check 
4. exec_qa_checks.sql - Procedure to execute the QA checks based on the run time values.
```

## Future Enhancement:

- Audit Table is created but not really logged any entries. The code can be modified to log all test runs and their results over time, which would be helpful in historical analysis of QA checks.
- Based on more testing scenarios, exception handling can be improved.