/*
* Insertion of records into the table qa_tests
*
* Filename          : insert_tbl_qa_chk.sql
* Created by        : Prathiba Ratnasabesan 
*
* Version   Date        Notes
* 0.01     21/10/2024   Initial Version 
*
*/

INSERT INTO qa_tests (code, description, enabled, parameter, test_sql, exp_result)
VALUES (
    'qa_ch_01', 
    'Runs the SQL against the Channel table to count duplicates. Duplicates count must be 0', 
    'Y', 
    'env', 
    'SELECT COUNT(*) FROM (SELECT channel_code, COUNT(*) AS duplicate_count FROM channel_table_env GROUP BY channel_code HAVING COUNT(*) > 1)', 
    '0'
);

INSERT INTO qa_tests (code, description, enabled, parameter, test_sql, exp_result)
VALUES (
    'qa_ch_02', 
    'Check the FK between channel_code and its child table channel_transaction to identify orphans at a given date', 
    'Y', 
    'env, date', 
    'SELECT COUNT(*) FROM channel_transaction_env A LEFT JOIN channel_table_env B ON A.channel_code = B.channel_code WHERE B.channel_code IS NULL AND A.transaction_date = :date', 
    '0'
);

INSERT INTO qa_tests (code, description, enabled, parameter, test_sql, exp_result)
VALUES (
    'qa_ch_03', 
    'Counts the records in channel_transaction_env table at a given date that have amount NULL', 
    'N', 
    'date', 
    'SELECT COUNT(*) FROM channel_transaction_env WHERE transaction_date = :date AND transaction_amount IS NULL', 
    '0'
);

INSERT INTO channel_transaction_dev (transaction_id, channel_code, transaction_date, transaction_amount)
VALUES (1001, 'CHN001', TO_DATE('2024-01-12', 'YYYY-MM-DD'), 1500);

INSERT INTO channel_transaction_dev (transaction_id, channel_code, transaction_date, transaction_amount)
VALUES (1002, 'CHN002', TO_DATE('2024-09-20', 'YYYY-MM-DD'), 3335);

INSERT INTO channel_transaction_test (transaction_id, channel_code, transaction_date, transaction_amount)
VALUES (1001, 'CHN001', TO_DATE('2023-10-21', 'YYYY-MM-DD'), 500);

INSERT INTO channel_transaction_test (transaction_id, channel_code, transaction_date, transaction_amount)
VALUES (1001, 'CHN004', TO_DATE('2024-06-11', 'YYYY-MM-DD'), 780);

-- Transaction Amount Null
INSERT INTO channel_transaction_test (transaction_id, channel_code, transaction_date)
VALUES (1003, 'CHN003', TO_DATE('2024-05-21', 'YYYY-MM-DD'));

INSERT INTO channel_table_dev (channel_id, channel_code)
VALUES (1, 'CHN001');

INSERT INTO channel_table_dev (channel_id, channel_code)
VALUES (2, 'CHN002');

INSERT INTO channel_table_test (channel_id, channel_code)
VALUES (1, 'CHN001');

-- Duplicate entry
INSERT INTO channel_table_test (channel_id, channel_code)
VALUES (1, 'CHN001');

INSERT INTO channel_table_test (channel_id, channel_code)
VALUES (3, 'CHN003');

--  Missing Channel
INSERT INTO channel_table_test (channel_id)
VALUES (4 );

COMMIT;
