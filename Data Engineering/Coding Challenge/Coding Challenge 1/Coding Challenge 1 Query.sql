use DE_Coding_Challenge_1;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    City NVARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'Amit Sharma', 'Mumbai'),
(2, 'Priya Singh', 'Delhi'),
(3, 'Ravi Kumar', 'Bangalore'),
(4, 'Anita Desai', 'Chennai'),
(5, 'Sunil Verma', 'Hyderabad'),
(6, 'Pooja Patel', 'Pune'),
(7, 'Rakesh Mehta', 'Ahmedabad'),
(8, 'Sita Iyer', 'Kolkata'),
(9, 'Vikram Malhotra', 'Mumbai'),
(10, 'Kavita Rao', 'Jaipur');

Select * from Customers;


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(201, 1, '2024-01-05', 500.00),
(202, 2, '2024-01-10', 750.00),
(203, 3, '2024-02-15', 1200.00),
(204, 4, '2024-02-20', 600.00),
(205, 5, '2024-03-25', 450.00),
(206, 6, '2024-04-01', 800.00),
(207, 7, '2024-05-10', 1300.00),
(208, 8, '2024-06-15', 400.00),
(209, 9, '2024-07-20', 900.00),
(210, 10, '2024-08-25', 1100.00);

Select * from Orders;

CREATE TABLE Couriers (
    CourierID INT PRIMARY KEY,
    CourierName NVARCHAR(100),
    City NVARCHAR(50)
);

INSERT INTO Couriers (CourierID, CourierName, City) VALUES
(1, 'Rajesh Express', 'Mumbai'),
(2, 'QuickGo', 'Delhi'),
(3, 'Swift Couriers', 'Bangalore'),
(4, 'Speedy Deliveries', 'Chennai'),
(5, 'RapidMove', 'Hyderabad'),
(6, 'DeliverNow', 'Pune'),
(7, 'Express India', 'Ahmedabad'),
(8, 'FastTrack', 'Kolkata'),
(9, 'SafeHand', 'Mumbai'),
(10, 'OneDay Delivery', 'Jaipur');


Select * from Couriers;

CREATE TABLE Deliveries (
    DeliveryID INT PRIMARY KEY,
    OrderID INT,
    CourierID INT,
    DeliveryDate DATE,
    Status NVARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CourierID) REFERENCES Couriers(CourierID)
);

INSERT INTO Deliveries (DeliveryID, OrderID, CourierID, DeliveryDate, Status) VALUES
(301, 201, 1, '2024-01-06', 'Delivered'),
(302, 202, 2, '2024-01-11', 'In Transit'),
(303, 203, 3, '2024-02-16', 'Delivered'),
(304, 204, 4, '2024-02-21', 'Pending'),
(305, 205, 5, '2024-03-26', 'Delivered'),
(306, 206, 6, '2024-04-02', 'In Transit'),
(307, 207, 7, '2024-05-11', 'Delivered'),
(308, 208, 8, '2024-06-16', 'Pending'),
(309, 209, 9, '2024-07-21', 'Delivered'),
(310, 210, 10, '2024-08-26', 'In Transit');

Select * from Deliveries;

--1.Querying Data by Using Joins and Subqueries & subtotal

-- 1)Get Each Customer’s Latest Order and the Total Amount They Have Spent
SELECT C.CustomerID,
       C.CustomerName,
       (SELECT MAX(O.OrderDate) 
        FROM Orders O 
        WHERE O.CustomerID = C.CustomerID) AS LatestOrderDate,
       SUM(O.TotalAmount) AS TotalAmountSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName;


-- 2)Subquery with Aggregation - Find the maximum order amount for each city.
SELECT City, 
       (SELECT MAX(TotalAmount) FROM Orders O WHERE C.CustomerID = O.CustomerID) AS MaxOrderAmount
FROM Customers C;

-- 3)Subquery in FROM Clause - Get the count of orders per customer using a subquery.
SELECT CustomerID, COUNT(*) AS OrderCount
FROM (SELECT CustomerID, OrderID FROM Orders) AS SubOrders
GROUP BY CustomerID;

-- 2. Manipulate Data Using GROUP BY and HAVING

-- 1) Average Order Amount by Customer - Find the average order amount for each customer, 
--	  showing only those with an average order above $500.
SELECT CustomerID, AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY CustomerID
HAVING AVG(TotalAmount) > 500;

-- 2)Order Count by Delivery Status - Count orders based on their delivery status.
SELECT Status, COUNT(OrderID) AS OrderCount
FROM Deliveries GROUP BY Status;

-- 3)Customers with Large Orders - Show customers who have placed orders totaling more than $800.
SELECT CustomerID, SUM(TotalAmount) AS TotalAmount
FROM Orders GROUP BY CustomerID HAVING SUM(TotalAmount) > 800;


-- 4)Total Sales by Courier City - Calculate total order amount delivered by couriers in each city.
SELECT C.City, SUM(O.TotalAmount) AS TotalSales FROM Orders O 
JOIN Deliveries D ON O.OrderID = D.OrderID
JOIN Couriers C ON D.CourierID = C.CourierID GROUP BY C.City;

-- 5)Identify Cities with an Average Order Amount Above 600, and Show the Total Number of Customers per City Who Have Placed Orders
SELECT C.City,
       COUNT(DISTINCT O.CustomerID) AS TotalCustomers,
       AVG(O.TotalAmount) AS AvgOrderAmount
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.City
HAVING AVG(O.TotalAmount) > 600;

