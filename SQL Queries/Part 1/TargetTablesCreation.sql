USE Toy_Store_TargetDW;

----------- CUST DIM ---------------------
CREATE TABLE Dim_Customer(
	custSK int IDENTITY(1,1) NOT NULL,
	custID varchar(20),
	custFirstName varchar(20),
	custLastName varchar(20),
	custAddress varchar(100),
	custCity varchar(20),
	custDistrict varchar(20),
	custProvince varchar(20),
	custEmail varchar(50),
	custPhone nvarchar(20),
	custSegment varchar(20),
	custSegmentName varchar(50),
 CONSTRAINT [PK_Dim_Customer] PRIMARY KEY CLUSTERED 
(
	custSK ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
;

------ STORE DIMENSION -------------
CREATE TABLE Dim_Store(
	storeSK int IDENTITY(1,1) NOT NULL,
	storeID varchar(20),
	storeName varchar(50) NOT NUll,
	storeAddress varchar(100),
	storeCity varchar(20),
	storeDistrict varchar(20),
	storeProvince varchar(20),
	CONSTRAINT [PK_Dim_Store] PRIMARY KEY CLUSTERED 
(
	storeSK ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
;

------ PRODUCT DIMENSION -------------
CREATE TABLE Dim_Product(
	prodSK int IDENTITY(1,1) NOT NULL,
	prodID varchar(20),
	prodName varchar(20) NOT NUll,
	prodDesc varchar(200),
	prodCat varchar(20),
	prodType varchar(20),
	prodCatName varchar(20),
	prodCatDesc varchar(100),
	prodTypeName varchar(20),
	prodTypeDesc varchar(100),
	CONSTRAINT [PK_Dim_Product] PRIMARY KEY CLUSTERED 
(
	prodSK ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
;

---------- PROMOTION DIMENSION ----------------
CREATE TABLE Dim_Promotion(
	promSK int IDENTITY(1,1) NOT NULL,
	promotionID varchar(20),
	productSK varchar(20),
	start_date date,
	end_date date,
	CONSTRAINT PK_Dim_Promotion PRIMARY KEY CLUSTERED 
(
	promSK ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
;

----------------- DATE DIMENSION -------------------------
CREATE TABLE Dim_Date(
	date_key INT PRIMARY KEY,
	date date,
	day smallint,
	month nvarchar(20),
	year smallint,
	quarter smallint
);

---------- INSERTING DATA INTO DATE DIMENSION --------------------

-- Set the start and end years for your date range
DECLARE @StartYear INT = 2020;
DECLARE @EndYear INT = 2025;

-- Generate and insert date data
DECLARE @Date DATE = DATEFROMPARTS(@StartYear, 1, 1);

WHILE YEAR(@Date) <= @EndYear
BEGIN
    INSERT INTO Dim_Date (date_key, date, day, month, year, quarter)
    VALUES (
        CONVERT(INT, FORMAT(@Date, 'yyyyMMdd')),
        @Date,
        DAY(@Date),
        FORMAT(@Date, 'MMMM'),
        YEAR(@Date),
        DATEPART(QUARTER, @Date)
    );

    SET @Date = DATEADD(DAY, 1, @Date);
END;


---------- SALES FACT ----------
CREATE TABLE Fact_Sales(
	salesID int IDENTITY(1,1) NOT NULL,
	customerSK varchar(20),
	storeSK varchar(20),
	promotionSK varchar(20),
	productSK varchar(20),
	purchaseDate date,
	promotion_discount numeric(20,2),
	unit_price money,
	qty int,
	total numeric(20,2)
)ON [PRIMARY]
;