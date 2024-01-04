-- Create table employee
CREATE TABLE Employee (
    Id INT PRIMARY KEY,
    Employee_Name VARCHAR(50),
    Manager_id INT,
    FOREIGN KEY (Manager_id) REFERENCES Employee(Id)
);

-- Insert Data
INSERT INTO Employee VALUES (1, 'Silva', NULL);
INSERT INTO Employee VALUES (2, 'Perera', 1);
INSERT INTO Employee VALUES (3, 'Sandun', 1);
INSERT INTO Employee VALUES (4, 'Mathan', 2);
INSERT INTO Employee VALUES (5, 'Abdul', 2);
INSERT INTO Employee VALUES (6, 'Mihindu', 3);

-- Retrieve employee name and manager name
SELECT
    E.Employee_Name AS "Employee Name",
    M.Employee_Name AS "Manager Name"
FROM
    Employee E
JOIN
    Employee M ON E.Manager_id = M.Id;

