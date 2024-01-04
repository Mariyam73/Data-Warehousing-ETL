----- RANGE ------
CREATE TABLE sales_data_range_partition ( 
    sale_id INT PRIMARY KEY, 
    product_id INT, 
    year INT, 
    sale_amount DECIMAL(10, 2), 
    location VARCHAR(50) 
) 
PARTITION BY RANGE (year) ( 
    PARTITION p2016 VALUES LESS THAN (2017), 
    PARTITION p2017 VALUES LESS THAN (2018), 
    PARTITION p2018 VALUES LESS THAN (2019), 
    PARTITION p2019 VALUES LESS THAN (2020), 
    PARTITION p2020 VALUES LESS THAN (2021), 
    PARTITION p2021 VALUES LESS THAN (2022), 
    PARTITION p2022 VALUES LESS THAN (2023), 
    PARTITION p2023 VALUES LESS THAN (MAXVALUE) 
);

INSERT INTO sales_data_range_partition VALUES (1, 101, 2017, 500.00, 'Colombo');
INSERT INTO sales_data_range_partition VALUES (2, 102, 2018, 700.50, 'Gampaha');
INSERT INTO sales_data_range_partition VALUES (3, 101, 2019, 450.25, 'Kandy');
INSERT INTO sales_data_range_partition VALUES (4, 103, 2020, 900.75, 'Colombo');
INSERT INTO sales_data_range_partition VALUES (5, 104, 2021, 400.00, 'Anuradhapura');
INSERT INTO sales_data_range_partition VALUES (6, 105, 2022, 350.85, 'Galle');
INSERT INTO sales_data_range_partition VALUES (7, 106, 2023, 1000.00, 'Kandy');


SELECT  
    TABLE_NAME,  
    PARTITION_NAME,  
    HIGH_VALUE 
FROM  
    USER_TAB_PARTITIONS 
WHERE  
    TABLE_NAME = 'SALES_DATA_RANGE_PARTITION';


------------ LIST --------------------
CREATE TABLE sales_data_list_partition ( 
    sale_id INT PRIMARY KEY, 
    product_id INT, 
    year INT, 
    sale_amount DECIMAL(10, 2), 
    location VARCHAR(50) 
)  
PARTITION BY LIST (location) ( 
    PARTITION p_colombo VALUES ('Colombo'), 
    PARTITION p_kandy VALUES ('Kandy'), 
    PARTITION p_matara VALUES ('Matara'), 
    PARTITION p_galle VALUES ('Galle'), 
    PARTITION p_other VALUES (DEFAULT) 
);


INSERT INTO sales_data_list_partition VALUES (1, 101, 2020, 500.00, 'Colombo');
INSERT INTO sales_data_list_partition VALUES (2, 102, 2020, 700.50, 'Kandy');
INSERT INTO sales_data_list_partition VALUES (3, 201, 2021, 450.25, 'Matara');
INSERT INTO sales_data_list_partition VALUES (4, 301, 2021, 900.75, 'Galle');

SELECT  
    TABLE_NAME,  
    PARTITION_NAME,  
    HIGH_VALUE 
FROM  
    USER_TAB_PARTITIONS 
WHERE  
    TABLE_NAME = 'SALES_DATA_LIST_PARTITION';


	--------- HASH ----------
CREATE TABLE sales_data_hash_partition ( 
    sale_id INT PRIMARY KEY, 
    product_id INT, 
    year INT, 
    sale_amount DECIMAL(10, 2), 
    location VARCHAR(50) 
)  
PARTITION BY HASH (product_id) 
PARTITIONS 4;

INSERT INTO sales_data_hash_partition VALUES (1, 101, 2020, 500.00, 'Colombo');
INSERT INTO sales_data_hash_partition VALUES (2, 102, 2020, 700.50, 'Kandy');
INSERT INTO sales_data_hash_partition VALUES (3, 201, 2021, 450.25, 'Matara');
INSERT INTO sales_data_hash_partition VALUES (4, 301, 2021, 900.75, 'Galle');

SELECT  
    TABLE_NAME,  
    PARTITION_NAME,  
    HIGH_VALUE 
FROM  
    USER_TAB_PARTITIONS 
WHERE  
    TABLE_NAME = 'SALES_DATA_HASH_PARTITION';

DROP TABLE SALES_DATA;

------------------------------
CREATE TABLE sales_data ( 
    sale_id INT PRIMARY KEY, 
    product_id INT, 
    year INT, 
    sale_amount DECIMAL(10, 2), 
    location VARCHAR(50) 
);

INSERT INTO sales_data VALUES (1, 101, 2020, 500.00, 'Colombo');
INSERT INTO sales_data VALUES (2, 102, 2020, 700.50, 'Kandy');
INSERT INTO sales_data VALUES (3, 201, 2021, 450.25, 'Matara');
INSERT INTO sales_data VALUES (4, 301, 2021, 900.75, 'Galle');

ALTER TABLE SALES_DATA MODIFY 
    PARTITION BY RANGE (year) ( 
    PARTITION p2016 VALUES LESS THAN (2017), 
    PARTITION p2017 VALUES LESS THAN (2018), 
    PARTITION p2018 VALUES LESS THAN (2019), 
    PARTITION p2019 VALUES LESS THAN (2020), 
    PARTITION p2020 VALUES LESS THAN (2021), 
    PARTITION p2021 VALUES LESS THAN (2022), 
    PARTITION p2022 VALUES LESS THAN (2023), 
    PARTITION p2023 VALUES LESS THAN (MAXVALUE) 
);

SELECT  
    TABLE_NAME,  
    PARTITION_NAME,  
    HIGH_VALUE 
FROM  
    USER_TAB_PARTITIONS 
WHERE  
    TABLE_NAME = 'SALES_DATA';

