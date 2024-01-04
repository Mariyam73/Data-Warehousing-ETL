CREATE TABLE MONTHLY_SALES_SUMMARY_TABLE(
	summary_key INT IDENTITY(1,1) NOT NULL,
	year int,
	month nvarchar(20),
	monthly_sales_qty numeric(18,2),
	monthly_sales_amount numeric(18,2)
);

SELECT * FROM MONTHLY_SALES_SUMMARY_TABLE;

----------------- MARKET BASKET ----------------------
CREATE TABLE FACT_MARKET_BASKET(
	Date_key date,
	Product_A varchar(20),
	Product_B varchar(20),
	Store varchar(20),
	Product_A_qty INT,
	Product_B_qty INT,
	Product_A_SalesAmnt NUMERIC(18,2),
	Product_B_SalesAmnt NUMERIC(18,2),
);

SELECT * FROM FACT_MARKET_BASKET;

---------------- SALES PRODUCT AND LOCATION ----
CREATE TABLE SALES_PROD_LOC(
	Product varchar(20),
	Location varchar(20),
	total_sales_qty numeric(18,2),
	total_sales_amount numeric(18,2),
);

SELECT * FROM SALES_PROD_LOC;