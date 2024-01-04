USE Toy_Store_TargetDW;

--- Changing permissions since the role does not allow enabling of CDC on Database--
EXEC sp_changedbowner 'sa';

--- Enable CDC on the DB ---
EXEC sys.sp_cdc_enable_db;

-- Verifying the CDC ----
SELECT name, is_cdc_enabled 
FROM sys.databases
WHERE name='Toy_Store_TargetDW';

-- Enable CDC on the table --
EXEC sys.sp_cdc_enable_table
    @source_schema = N'dbo',
    @source_name = N'DIM_CUSTOMER',
    @role_name = NULL,
    @supports_net_changes = 1;

--- Verifying if CDC is enabled on table --
select name,type,type_desc,is_tracked_by_cdc
from sys.tables
where name = 'DIM_CUSTOMER';

--- Inserting data and checking if the changes are captured ---
SELECT * FROM dbo.DIM_CUSTOMER;

INSERT INTO dbo.DIM_CUSTOMER VALUES('CUST001','Malithi','Perera','132, Calvert Terrace', 'Dehiwela', 'Colombo', 
'Western', 'malithi.perera@gamil.com', '0773462834', 'SEG001', 'Regular Customer');

UPDATE Dim_Customer
SET custCity='Colombo 06'
WHERE custID='CUST001';

DELETE FROM Dim_Customer
WHERE custID='CUST001';

SELECT * FROM [cdc].[dbo_DIM_CUSTOMER_CT];


