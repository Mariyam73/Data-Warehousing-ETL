-- Customer Table
CREATE TABLE CUSTOMER(
	Customer_ID INT IDENTITY(1,1) NOT NULL,
	Customer_name varchar(20)
);

-- Create a table to capture the correct spellings
CREATE TABLE CORRECT_NAMES (
    Correct_ID INT IDENTITY(1,1) NOT NULL,
    Incorrect_name VARCHAR(20),
    Correct_name VARCHAR(20)
);

-- Insert values to the correction table
INSERT INTO CORRECT_NAMES VALUES ('John Doh', 'John Doe');
INSERT INTO CORRECT_NAMES VALUES ('Sahidiya', 'Sahdiya');
INSERT INTO CORRECT_NAMES VALUES ('Shadiya', 'Sahdiya');
INSERT INTO CORRECT_NAMES VALUES ('Jananie', 'Janani');
INSERT INTO CORRECT_NAMES VALUES ('Jananee', 'Janani');
INSERT INTO CORRECT_NAMES VALUES ('Janany', 'Janani');
INSERT INTO CORRECT_NAMES VALUES ('Maheshie', 'Maheshi');
INSERT INTO CORRECT_NAMES VALUES ('Maheshee', 'Maheshi');
INSERT INTO CORRECT_NAMES VALUES ('Maheshy', 'Maheshi');

-- Create a trigger to ensure correct names are inserted or updated in CUSTOMER
CREATE TRIGGER trigger_EnforceCorrectNames
ON CUSTOMER
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Update incorrect names to their correct forms
    UPDATE c
    SET Customer_name = cn.Correct_name
    FROM CUSTOMER c
    JOIN inserted i ON c.Customer_ID = i.Customer_ID
    JOIN CORRECT_NAMES cn ON c.Customer_name = cn.Incorrect_name;

    -- Insert only correct names
    INSERT INTO CUSTOMER (Customer_name)
    SELECT cn.Correct_name
    FROM inserted i
    JOIN CORRECT_NAMES cn ON i.Customer_name = cn.Incorrect_name
    WHERE NOT EXISTS (
        SELECT 1
        FROM CUSTOMER c
        WHERE c.Customer_ID = i.Customer_ID
    );
END;

-- Test by inserting a record with wrong name
INSERT INTO CUSTOMER VALUES ('Shadiya');
SELECT * FROM CUSTOMER;

INSERT INTO CUSTOMER VALUES ('Shahidiya');
SELECT * FROM CUSTOMER;
