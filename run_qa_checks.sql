/*
* Procedure to run the QA checks
* The test_sql is executed based on the parameter passed during runtime
*
* Filename          : run_qa_checks.sql
* Created by        : Prathiba Ratnasabesan 
*
* Version   Date        Notes
* 0.01     21/10/2024   Initial Version 
*
*/

CREATE OR REPLACE PROCEDURE run_qa_checks (
    p_env IN VARCHAR2,
    p_date IN VARCHAR2
) AS
    v_sql VARCHAR2(5000);
    v_test_result VARCHAR2(4000);
    v_status VARCHAR2(10);
    v_expected_result VARCHAR2(4000);
    v_def_env VARCHAR2(10) := 'test';
	s_date VARCHAR2(50);
BEGIN
    -- Loop over all enabled tests from qa_tests

    FOR test_rec IN (
        SELECT code, parameter, test_sql, exp_result
        FROM qa_tests        
    ) LOOP
        v_sql := test_rec.test_sql;  -- Start with the test_sql from the table
        
        -- Replace parameters dynamically
        IF INSTR(test_rec.parameter, 'env') > 0 THEN
            v_sql := REPLACE(v_sql, 'env', p_env);  
        ELSE        
            v_sql := REPLACE(v_sql, 'env', v_def_env);   -- Use the default env variable        
        END IF;
        
        IF INSTR(test_rec.parameter, 'date') > 0 THEN                 
            s_date:=''''||p_date||'''';
            v_sql := REPLACE(v_sql, ':date',s_date);
        ELSE
            v_sql := REPLACE(v_sql, ':date', TRUNC(SYSDATE));  -- Use the default date    
        END IF;            
          
        -- Execute the SQL dynamically and capture the result
        BEGIN
            EXECUTE IMMEDIATE v_sql INTO v_test_result;       
            v_expected_result := test_rec.exp_result;  -- Compare the result with the expected result

            IF v_test_result = v_expected_result THEN
                v_status := 'PASS';
            ELSE
                v_status := 'FAIL';
            END IF;
           
        EXCEPTION
            WHEN OTHERS THEN
                -- Capture any error that occurs during execution
                v_test_result := SQLERRM;
                v_status := 'ERROR';                
        END;  
    -- Insert the result into the qa_test_results table for GUI display
            INSERT INTO qa_test_results (code, executed_sql, result, status, run_time)
            VALUES (test_rec.code, v_sql, v_test_result, v_status, SYSTIMESTAMP);           
        
    END LOOP;
    COMMIT;
    
END run_qa_checks;