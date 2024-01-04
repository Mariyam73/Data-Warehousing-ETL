---- Poroduct Sales Table ----
CREATE TABLE PRODUCT_SALES( 
    PRODUCT VARCHAR(20), 
	YEAR INT, 
	SALE NUMBER(20,2) 
);

--- Insert Data ---------
INSERT INTO PRODUCT_SALES VALUES('Prod1',2020,45000);
INSERT INTO PRODUCT_SALES VALUES('Prod1',2021,999999);
INSERT INTO PRODUCT_SALES VALUES('Prod1',2022,155000);
INSERT INTO PRODUCT_SALES VALUES('Prod2',2020,9999);
INSERT INTO PRODUCT_SALES VALUES('Prod2',2021,50000);
INSERT INTO PRODUCT_SALES VALUES('Prod2',2022,100000);
INSERT INTO PRODUCT_SALES VALUES('Prod3',2020,99999);
INSERT INTO PRODUCT_SALES VALUES('Prod3',2021,175000);
INSERT INTO PRODUCT_SALES VALUES('Prod3',2022,480000);

--- Create Table to store years ---
CREATE TABLE YEAR_TAB( 
    YEARS clob 
);

-- Materiaized View ---

DECLARE 
    dynamic_years CLOB; 
    sql_query CLOB; 
BEGIN 
    -- Clear existing data in YEAR_TAB 
    DELETE FROM YEAR_TAB; 
 
    -- Insert unique years from PRODUCT_SALES into YEAR_TAB 
    INSERT INTO YEAR_TAB (YEARS) 
    SELECT DISTINCT TO_CHAR(YEAR) FROM PRODUCT_SALES; 
 
    -- Get the dynamic years from YEAR_TAB 
    SELECT LISTAGG(YEARS, ',') WITHIN GROUP (ORDER BY YEARS DESC)  
    INTO dynamic_years 
    FROM ( 
        SELECT TO_CHAR(YEARS) AS YEARS 
        FROM YEAR_TAB 
        ORDER BY YEARS DESC 
    ); 
 
	EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW MV_VIEW1'; 
 
    -- Build the dynamic SQL query 
    sql_query := 'CREATE MATERIALIZED VIEW mv_view1 
                 BUILD IMMEDIATE 
                 REFRESH FORCE 
        		 ON DEMAND 
        		 ENABLE QUERY REWRITE 
                 AS 
                 SELECT * FROM ( 
                     SELECT ps.PRODUCT, 
                            TO_CHAR(ps.YEAR) AS YEAR, 
                            COALESCE(ps.SALE, 0) AS SALE 
                     FROM YEAR_TAB yt 
                     LEFT JOIN PRODUCT_SALES ps ON TO_CHAR(yt.YEARS) = TO_CHAR(ps.YEAR) 
                 )  
                 PIVOT ( 
                     MAX(SALE) FOR YEAR IN (' || dynamic_years || ') 
                 ) 
                 ORDER BY PRODUCT'; 
 
    -- Execute the dynamic SQL query 
    EXECUTE IMMEDIATE sql_query; 
     
    -- Refresh the materialized view 
    DBMS_MVIEW.REFRESH('MV_VIEW1'); 
END;
/

SELECT * FROM MV_VIEW1;
INSERT INTO PRODUCT_SALES VALUES('Prod3',2019,480000);
EXECUTE DBMS_MVIEW.REFRESH('MV_VIEW1');
SELECT * FROM MV_VIEW1;



