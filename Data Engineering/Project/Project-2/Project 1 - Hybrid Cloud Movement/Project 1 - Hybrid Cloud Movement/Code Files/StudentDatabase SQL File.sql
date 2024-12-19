CREATE DATABASE SchoolDB;
USE SchoolDB;

-- Create the Student Table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Age INT,
    Grade NVARCHAR(10),
    DateOfBirth DATE NULL
);

CREATE TABLE Teachers (
    TeacherID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
);

CREATE TABLE Subject (
    SubjectID INT PRIMARY KEY,
    Name NVARCHAR(50),
    TeacherID INT
);

-- Insert Records into the Student Table
INSERT INTO Student (StudentID, FirstName, LastName, Age, Grade, DateOfBirth)
VALUES (1, 'Ram', 'Sharma', 14, '8th', '2010-06-15');

INSERT INTO Student (StudentID, FirstName, LastName, Age, Grade, DateOfBirth)
VALUES (2, 'Rohit', 'Singh', 13, '7th', '2011-04-21');

INSERT INTO Student (StudentID, FirstName, LastName, Age, Grade, DateOfBirth)
VALUES (3, 'Vikas', 'Garg', 15, '9th', '2009-01-30');

INSERT INTO Student (StudentID, FirstName, LastName, Age, Grade, DateOfBirth)
VALUES (4, 'Subrat', 'Shukla', 14, '8th', '2010-08-10');

INSERT INTO Student (StudentID, FirstName, LastName, Age, Grade, DateOfBirth)
VALUES (5, 'Vishal', 'Singh', 12, '6th', '2012-12-05');

INSERT INTO Student (StudentID, FirstName, LastName, Age, Grade, DateOfBirth)
VALUES (6, 'Harsh', 'Gupta', 16, '10th', '2008-09-17');


-- Updating Data in a Table
UPDATE Student
SET Grade = '9th'
WHERE StudentID = 3;

-- Deleting Data from a Table
DELETE FROM Student
WHERE StudentID = 5;

-- Retrieving Specific Attributes
SELECT FirstName, Grade FROM Student;

-- Retrieving Selected Rows
SELECT * FROM Student
WHERE Grade = '8th';

-- Filtering Data: WHERE Clauses
SELECT * FROM Student
WHERE Age > 13;


-- Filtering Data: IN, DISTINCT, AND, OR, BETWEEN, LIKE, Column & Table Aliases
-- IN
SELECT * FROM Student
WHERE Grade IN ('7th', '8th');

-- DISTINCT
SELECT DISTINCT Grade FROM Student;

-- AND/OR
SELECT * FROM Student
WHERE Grade = '8th' AND Age = 14;

-- BETWEEN
SELECT * FROM Student
WHERE Age BETWEEN 13 AND 15;

-- LIKE
SELECT * FROM Student
WHERE LastName LIKE 'M%';

-- Aliases
SELECT S.FirstName AS Name, S.Grade AS Class
FROM Student AS S;


-- Implementing Data Integrity
ALTER TABLE Student
ADD CONSTRAINT CK_Age CHECK (Age > 0);


-- Using Functions to Customize the Result Set

-- Using String Functions
SELECT FirstName, LEN(FirstName) AS NameLength
FROM Student;

-- Using Date Functions
SELECT FirstName, DateOfBirth, YEAR(GETDATE()) - YEAR(DateOfBirth) AS CurrentAge
FROM Student;

-- Using Mathematical Functions
SELECT FirstName, Age, Age + 1 AS AgeNextYear
FROM Student;

-- Using System Functions
SELECT SYSTEM_USER AS CurrentUser;


-- Summarizing and Grouping Data

-- Summarizing Data by Using Aggregate Functions
SELECT AVG(Age) AS AverageAge
FROM Student;

-- Grouping Data
SELECT Grade, COUNT(StudentID) AS StudentCount
FROM Student
GROUP BY Grade;


-- Hands-On Exercises

-- Filtering Data using SQL Queries
SELECT * FROM Student
WHERE Grade = '9th' AND Age > 14;

-- Total Aggregations using SQL Queries
SELECT COUNT(*) AS TotalStudents
FROM Student;

-- Group By Aggregations using SQL Queries
SELECT Grade, AVG(Age) AS AverageAge
FROM Student
GROUP BY Grade;



-------------------------------------------------------DAY3-----------------------------------------------------

-- Subtotal: Count of students per grade with a grand total
SELECT Grade, COUNT(StudentID) AS StudentCount FROM Student
GROUP BY ROLLUP(Grade);


--Calculating Average Age with Subtotals Using GROUP BY and ROLLUP
SELECT Grade, AVG(Age) AS AverageAge
FROM Student
GROUP BY ROLLUP(Grade);


--Creating a Stored Procedure for Adding New Students
CREATE PROCEDURE AddStudent
    @StudentID INT,
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Age INT,
    @Grade NVARCHAR(10),
    @DateOfBirth DATE
AS
BEGIN
    INSERT INTO Student (StudentID, FirstName, LastName, Age, Grade, DateOfBirth)
    VALUES (@StudentID, @FirstName, @LastName, @Age, @Grade, @DateOfBirth);
END;

EXEC AddStudent 7, 'Grace', 'Hopper', 13, '7th', '2011-12-09';

select*from Student;


--Creating a Stored Procedure to Retrieve Students by Grade
CREATE PROCEDURE GetStudentsByGrade
    @Grade NVARCHAR(10)
AS
BEGIN
    SELECT * FROM Student
    WHERE Grade = @Grade;
END;


EXEC GetStudentsByGrade '8th';


--Creating a Stored Procedure to Update Student Grades
CREATE PROCEDURE UpdateStudentGrade
    @StudentID INT,
    @NewGrade NVARCHAR(10)
AS
BEGIN
    UPDATE Student
    SET Grade = @NewGrade
    WHERE StudentID = @StudentID;
END;


EXEC UpdateStudentGrade 2, '8th';
select*from Student;


--Creating a Stored Procedure for Grouping and Total Aggregations
CREATE PROCEDURE GetStudentCountWithTotal
AS
BEGIN
    SELECT 
        Grade,
        COUNT(StudentID) AS StudentCount
    FROM Student
    GROUP BY ROLLUP(Grade);
END;

EXEC GetStudentCountWithTotal;


select*from Student;