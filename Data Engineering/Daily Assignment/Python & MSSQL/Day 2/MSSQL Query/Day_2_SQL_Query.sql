use DE_1;


--1. Storing Data in a Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Position NVARCHAR(50),
    Salary DECIMAL(10, 2),
    Department NVARCHAR(50)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Position, Salary, Department)
VALUES 
    (1, 'Alice', 'Smith', 'Developer', 70000.00, 'IT'),
    (2, 'Bob', 'Johnson', 'Manager', 90000.00, 'IT'),
    (3, 'Charlie', 'Brown', 'Developer', 60000.00, 'IT'),
    (4, 'David', 'Wilson', 'Analyst', 50000.00, 'Finance'),
    (5, 'Emma', 'Davis', 'Developer', 75000.00, 'IT'),
    (6, 'Fiona', 'Martinez', 'Manager', 95000.00, 'Finance'),
    (7, 'George', 'Clark', 'Developer', 68000.00, 'IT'),
    (8, 'Hannah', 'Rodriguez', 'Analyst', 55000.00, 'Finance'),
    (9, 'Ian', 'Lewis', 'Support', 45000.00, 'Support'),
    (10, 'Jack', 'Walker', 'Support', 40000.00, 'Support');



--2. Updating Data in a Table
UPDATE Employees
SET Salary = 65000.00
WHERE EmployeeID = 1;

--3. Deleting Data from a Table
DELETE FROM Employees
WHERE EmployeeID = 1;

--4. Retrieving Specific Attributes
SELECT FirstName, LastName
FROM Employees;

--5. Retrieving Selected Rows
SELECT * 
FROM Employees 
WHERE Position = 'Developer';

--6. Filtering Data with WHERE Clauses
SELECT * 
FROM Employees 
WHERE Salary > 50000;

--7. Filtering Data with IN, DISTINCT, AND, OR, BETWEEN, LIKE, Column & Table Aliases
--IN:
SELECT * 
FROM Employees 
WHERE Position IN ('Developer', 'Manager');

--DISTINCT:
SELECT DISTINCT Position 
FROM Employees;

--AND/OR:
SELECT * 
FROM Employees 
WHERE Salary > 50000 AND Position = 'Developer';

--BETWEEN:
SELECT * 
FROM Employees 
WHERE Salary BETWEEN 50000 AND 70000;

--LIKE:
SELECT * FROM Employees WHERE FirstName LIKE 'J%';

--Column & Table Aliases:
SELECT E.FirstName AS First, E.LastName AS Last FROM Employees AS E;


--8. Implementing Data Integrity
ALTER TABLE Employees ADD CONSTRAINT CHK_Salary CHECK (Salary > 0);


--9. Using Functions to Customize the Result Set
--String Function:
SELECT UPPER(FirstName) AS FirstNameUpper FROM Employees;

--Date Function:
SELECT GETDATE() AS CurrentDate;

--Mathematical Function:
SELECT ROUND(Salary, 0) AS RoundedSalary FROM Employees;

--System Function:
SELECT SYSTEM_USER AS CurrentUser;


--10. Summarizing and Grouping Data
SELECT Position, COUNT(*) AS PositionCount FROM Employees GROUP BY Position;


--11. Using Aggregate Functions
SELECT AVG(Salary) AS AverageSalary FROM Employees;


--Hands-on Exercises
--1.Filtering Data using SQL Queries
SELECT * FROM Employees WHERE Position = 'Developer' AND Salary > 50000;

--2.Total Aggregations using SQL Queries
SELECT SUM(Salary) AS TotalSalary FROM Employees;

--3.Group By Aggregations using SQL Queries
SELECT Position, AVG(Salary) AS AvgSalary FROM Employees GROUP BY Position;

--4.Order of Execution of SQL Queries
SELECT Position, COUNT(*) AS PositionCount
FROM Employees WHERE Salary > 50000 GROUP BY Position ORDER BY PositionCount DESC;

--5.Rules and Restrictions to Group and Filter Data in SQL queries
SELECT Position, AVG(Salary) AS AvgSalary
FROM Employees WHERE Salary > 50000 GROUP BY Position HAVING AVG(Salary) > 55000;

--6.Filter Data based on Aggregated Results using Group By and Having
SELECT Position, COUNT(*) AS NumEmployees FROM Employees GROUP BY Position HAVING COUNT(*) > 1;











