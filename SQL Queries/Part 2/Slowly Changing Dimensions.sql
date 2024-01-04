CREATE TABLE Dim_Customer_SCD(
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
	start_date datetime,
	end_date datetime,
 CONSTRAINT [PK_Dim_Customer_SCD] PRIMARY KEY CLUSTERED 
(
	custSK ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
;

SELECT * FROM Dim_Customer_SCD;

SELECT * FROM Dim_Customer_SCD
WHERE custID = 'CUST006'

TRUNCATE TABLE Dim_Customer_SCD;