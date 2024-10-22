/*
* Creation of Table qa_tests
*
* Filename          : create_tbl_qa_chk.sql
* Created by        : Prathiba Ratnasabesan 
*
* Version   Date        Notes
* 0.01     21/10/2024   Initial Version 
*
*/

CREATE TABLE qa_tests (
    code VARCHAR2(50) PRIMARY KEY,
    description VARCHAR2(255),
    enabled VARCHAR2(1) CHECK (enabled IN ('Y', 'N')),
    parameter VARCHAR2(255),
    test_sql VARCHAR2(1000),
    exp_result VARCHAR2(255)
);

--Table where the results are stored.
CREATE TABLE qa_test_results (
code VARCHAR2(50),
    executed_sql varchar2(5000),
    result VARCHAR2(4000),
    status VARCHAR2(10),
    run_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
);

-- Supporting Table

-- Channel Transaction (Dev).

CREATE TABLE channel_transaction_dev (
    transaction_id    NUMBER,           
    channel_code      VARCHAR2(50) PRIMARY KEY ,     
    transaction_date  DATE, 
    transaction_amount NUMBER   
);

CREATE TABLE channel_transaction_test (
    transaction_id    NUMBER,           
    channel_code      VARCHAR2(50) PRIMARY KEY ,     
    transaction_date  DATE, 
    transaction_amount NUMBER    
);


-- Channel Table (Dev).
CREATE TABLE channel_table_dev (
    channel_id NUMBER,
    channel_code VARCHAR2(50) ,
    CONSTRAINT fk_channel_code_dev 
        FOREIGN KEY (channel_code) 
        REFERENCES channel_transaction_dev (channel_code)
);

-- Channel Table (test).
CREATE TABLE channel_table_test (
    channel_id NUMBER,
    channel_code VARCHAR2(50) ,
    CONSTRAINT fk_channel_code_test 
        FOREIGN KEY (channel_code) 
        REFERENCES channel_transaction_test (channel_code)
);

-- An audit table to log each test's execution results for later analysis.
CREATE TABLE qa_tests_audit (
    aud_id NUMBER,
    code VARCHAR2(50),   
    sql_executed VARCHAR2(4000),
    result VARCHAR2(4000),
    status VARCHAR2(10),
    run_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

