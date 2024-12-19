create database employees;
use employees;

-- Create the Employee table
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    Position NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2),
    DateOfJoining DATE,
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(15),
    Address NVARCHAR(255)
);

-- Insert 10 records into the Employee table
INSERT INTO Employee (EmployeeID, FirstName, LastName, DateOfBirth, Position, Department, Salary, DateOfJoining, Email, PhoneNumber, Address)
VALUES
(1, 'Ravi', 'Kumar', '1990-05-15', 'Software Engineer', 'IT', 75000.00, '2015-06-01', 'ravi.kumar@example.com', '9876543210', '123 MG Road, Bangalore'),
(2, 'Priya', 'Sharma', '1988-07-10', 'Project Manager', 'IT', 95000.00, '2013-08-15', 'priya.sharma@example.com', '9876543211', '456 Andheri East, Mumbai'),
(3, 'Vikram', 'Patel', '1992-02-20', 'Data Analyst', 'Finance', 60000.00, '2017-03-20', 'vikram.patel@example.com', '9876543212', '789 Gariahat, Kolkata'),
(4, 'Meera', 'Nair', '1985-12-05', 'HR Manager', 'HR', 85000.00, '2012-01-10', 'meera.nair@example.com', '9876543213', '101 MG Road, Kochi'),
(5, 'Arjun', 'Reddy', '1995-09-25', 'DevOps Engineer', 'IT', 70000.00, '2019-07-30', 'arjun.reddy@example.com', '9876543214', '678 LB Nagar, Hyderabad'),
(6, 'Sneha', 'Verma', '1993-04-15', 'Business Analyst', 'Finance', 65000.00, '2018-04-25', 'sneha.verma@example.com', '9876543215', '234 South Extension, Delhi'),
(7, 'Karan', 'Singh', '1987-11-11', 'Technical Lead', 'IT', 90000.00, '2014-10-05', 'karan.singh@example.com', '9876543216', '789 Jayanagar, Bangalore'),
(8, 'Anita', 'Joshi', '1990-03-18', 'Quality Analyst', 'QA', 55000.00, '2016-12-12', 'anita.joshi@example.com', '9876543217', '456 Powai, Mumbai'),
(9, 'Ramesh', 'Gupta', '1986-08-08', 'Operations Manager', 'Operations', 85000.00, '2010-09-15', 'ramesh.gupta@example.com', '9876543218', '321 Salt Lake, Kolkata'),
(10, 'Neha', 'Kapoor', '1994-06-22', 'UI/UX Designer', 'Design', 60000.00, '2019-11-01', 'neha.kapoor@example.com', '9876543219', '111 Sector 18, Noida');

-- Retrieve all data from the Employee table
SELECT * FROM Employee;
