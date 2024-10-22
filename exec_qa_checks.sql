/*
* Procedure to run the QA checks
* The test_sql is executed based on the parameter passed during runtime
*
* Filename          : exec_qa_checks.sql
* Created by        : Prathiba Ratnasabesan 
*
* Version   Date        Notes
* 0.01     21/10/2024   Initial Version 
*
*/

BEGIN
    run_qa_checks('dev', TO_DATE('2024-09-20', 'YYYY-MM-DD')); 
    run_qa_checks('test', TO_DATE('2024-05-21', 'YYYY-MM-DD')); -- To test the Transaction Amount Null
    run_qa_checks('test', TO_DATE('2024-01-12', 'YYYY-MM-DD')); -- To test the Duplicate entry
    run_qa_checks('test', TO_DATE('2024-06-11', 'YYYY-MM-DD')); -- To test the missing channel

END;