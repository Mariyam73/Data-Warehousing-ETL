USE Toy_Store_SourceDB;

------ STORE TABLE --------
CREATE TABLE Store(
storeID varchar(20) PRIMARY KEY,
storeName varchar(50) NOT NUll,
storeAddress varchar(100),
storeCity varchar(20),
storeDistrict varchar(20),
storeProvince varchar(20),
);

SELECT * FROM Store;

INSERT INTO STORE VALUES('ST001','Colombo Branch 1','475, Union Place','Colombo','Colombo','Western');
INSERT INTO STORE VALUES('ST002','Kandy Branch 1','12, D.S Senanayake Rd','Kandy','Kandy','Central');
INSERT INTO STORE VALUES('ST003','Kandy Branch 2','22/A, Peradeniya Rd','Peradeniya','Kandy','Central');
INSERT INTO STORE VALUES('ST004','Colombo Branch 2','151, Ebenezer Place','Dehiwela','Colombo','Western');
INSERT INTO STORE VALUES('ST005','Matale Branch','B22, Watuwatta','Matale','Matale','Central');
INSERT INTO STORE VALUES('ST006','Kurunegala Branch','25, Labbala','Kurunegala','Kurunegala','Western');
INSERT INTO STORE VALUES('ST007','Hambantota Branch','76, Chithragala','Ambalantota','Hambanthota','Southern');
INSERT INTO STORE VALUES('ST008','Galle Branch','321, Talduwa','Ahangama','Galle','Southern');
INSERT INTO STORE VALUES('ST009','Gampaha Branch','101, Kiribathgoda','Gampaha','Gampaha','Western');

------------ CUSTOMER SEGMENT TABLE -----------------
CREATE TABLE Customer_Segment(
custSegmentID varchar(20) PRIMARY KEY,
custSegmentName varchar(50) NOT NUll,
);

INSERT INTO Customer_Segment VALUES('SEG001','Regular Customer');
INSERT INTO Customer_Segment VALUES('SEG002','Direct Customer');
INSERT INTO Customer_Segment VALUES('SEG003','Online Customer');
INSERT INTO Customer_Segment VALUES('SEG004','Inactive Customer');
INSERT INTO Customer_Segment VALUES('SEG005','Dealer Customer');


----------- CUSTOMER TABLE -----------------
CREATE TABLE Customer(
custID varchar(20) PRIMARY KEY,
custFirstName varchar(20),
custLastName varchar(20),
custAddress varchar(100),
custCity varchar(20),
custDistrict varchar(20),
custProvince varchar(20),
custEmail varchar(50),
custPhone nvarchar(20),
custSegmentFK varchar(20),
FOREIGN KEY (custSegmentFK) REFERENCES Customer_Segment(custSegmentID),
);
INSERT INTO Customer VALUES('CUST001','Malithi','Perera','132, Calvert Terrace', 'Dehiwela', 'Colombo', 
'Western', 'malithi.perera@gamil.com', '0773462834', 'SEG001');
INSERT INTO Customer VALUES('CUST002','Shehani','Gunatilake','29/A, Teldeniya Rd', 'Madawala', 'Kandy', 
'Central', 'gshehani.gtk@gamil.com', '0775612345', 'SEG004');
INSERT INTO Customer VALUES('CUST003','Ruwan','Perera','53, Ebenezer Place', 'Dehiwela', 'Colombo', 
'Western', 'ruwan.perera@gamil.com', '0763888911', 'SEG003');
INSERT INTO Customer VALUES('CUST004','Mihirangi','Kumari','76, Kirbathgoda', 'Gampaha', 'Gampaha', 
'Western', 'migirangi.kumari@gamil.com', '0729873872', 'SEG001');
INSERT INTO Customer VALUES('CUST005','Anirudh','Ravichandar','10, Peradeniya rd', 'Peradeniya', 'Kandy', 
'Central', 'ani.ravi@gamil.com', '0777861448', 'SEG005');
INSERT INTO Customer VALUES('CUST006','Mahesh','Peiris','8, Page Lane', 'Wellawatte', 'Colombo', 
'Western', 'mahesh.peiris@gamil.com', '0773462834', 'SEG002');

--------------- ORDER HEADER TABLE -------
CREATE TABLE Order_Header(
orderHeaderID varchar(20) PRIMARY KEY,
custID varchar(20),
storeID varchar(20),
purchaseDate date,
FOREIGN KEY (custID) REFERENCES Customer(custID),
FOREIGN KEY (storeID) REFERENCES Store(StoreID)
);

INSERT INTO Order_Header VALUES('ORH001', 'CUST001', 'ST003', '2023-01-09');
INSERT INTO Order_Header VALUES('ORH002', 'CUST002', 'ST001', '2023-11-01');
INSERT INTO Order_Header VALUES('ORH003', 'CUST006', 'ST004', '2021-12-12');
INSERT INTO Order_Header VALUES('ORH004', 'CUST005', 'ST002', '2022-12-29');
INSERT INTO Order_Header VALUES('ORH005', 'CUST003', 'ST005', '2023-05-11');

-------- PRODUCT TYPE ------------
CREATE TABLE Product_Type(
prodTypeID varchar(20) PRIMARY KEY,
prodTypeName varchar(20),
prodTypeDesc varchar(100)
);

INSERT INTO Product_Type VALUES('PRTY001','General','Products developed based on general orders');
INSERT INTO Product_Type VALUES('PRTY002','Import','Products imported');
INSERT INTO Product_Type VALUES('PRTY003','EXport','Products exported');

----------- PRODUCT CATEGORY -------------------
CREATE TABLE Product_Category(
prodCatID varchar(20) PRIMARY KEY,
prodCatName varchar(20),
prodCatDesc varchar(100),
prodType varchar(20),
FOREIGN KEY (prodType) REFERENCES Product_Type(prodTypeID)
);

INSERT INTO Product_Category VALUES('PRCAT001','Doll','Barbie Doll','PRTY002');
INSERT INTO Product_Category VALUES('PRCAT002','Kitchen ware','Kitchen Cooker and Plate Set','PRTY001');
INSERT INTO Product_Category VALUES('PRCAT003','Animal','Toy animal set','PRTY001');

---- PRODUCT TABLE ----

CREATE TABLE Product(
prodID varchar(20) PRIMARY KEY,
prodName varchar(20) NOT NUll,
prodDesc varchar(200),
unitPrice money NOT NULL,
qty int,
prodCat varchar(20),
FOREIGN KEY (prodCat) REFERENCES Product_Category(ProdCatID)
);

INSERT INTO Product VALUES('PROD001','Doll', 'Pink Barbie Doll', 500, 300, 'PRCAT001');
INSERT INTO Product VALUES('PROD002','Toy Car', 'Merc Red', 200, 250, 'PRCAT003');
INSERT INTO Product VALUES('PROD003','Minie', 'Toy Minnie Mouse', 350, 100, 'PRCAT003');
INSERT INTO Product VALUES('PROD004','Cookoware', 'Kitchen cookware set', 300, 80, 'PRCAT002');
INSERT INTO Product VALUES('PROD005','KitchenUp', 'Kitchen Setup Toy', 800, 100, 'PRCAT002');
INSERT INTO Product VALUES('PROD006','Bisque Doll', 'Blue Barbie Doll', 450, 300, 'PRCAT001');

------------ PROMOTION TABLE ----------------------
CREATE TABLE Promotion(
promotionID varchar(20) PRIMARY KEY,
productID varchar(20),
discount numeric(20,2),
start_date date,
end_date date,
FOREIGN KEY (productID) REFERENCES Product(prodID));

INSERT INTO Promotion VALUES('DIS001','PROD006',0.20,'2023-11-06','2023-12-31');
INSERT INTO Promotion VALUES('DIS002','PROD001',0.10,'2023-10-23','2023-11-01');
INSERT INTO Promotion VALUES('DIS003','PROD004',0.15,'2023-11-06','2023-12-31');
INSERT INTO Promotion VALUES('DIS004','PROD005',0.50,'2023-10-10','2023-11-30');

------- ORDER DETAILS TABLE --------------
CREATE TABLE Order_Detail(
orderID varchar(20) PRIMARY KEY,
product varchar(20),
orderHeader varchar(20),
qty int
FOREIGN KEY (product) REFERENCES Product(prodID),
FOREIGN KEY (orderHeader) REFERENCES Order_Header(orderHeaderID)
);

INSERT INTO Order_Detail VALUES('ORD001','PROD001','ORH002',2);
INSERT INTO Order_Detail VALUES('ORD002','PROD005','ORH003',1);
INSERT INTO Order_Detail VALUES('ORD003','PROD002','ORH004',5);
INSERT INTO Order_Detail VALUES('ORD004','PROD006','ORH001',10);