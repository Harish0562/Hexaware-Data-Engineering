use DE_Day_3;

CREATE TABLE SalesList (
    SalesMonth NVARCHAR(20),
    SalesQuarter VARCHAR(5),
    SalesYear SMALLINT,
    SalesTotal MONEY
);

INSERT INTO SalesList (SalesMonth, SalesQuarter, SalesYear, SalesTotal) VALUES 
(N'March', 'Q1', 2019, 60),
(N'March', 'Q1', 2020, 50),
(N'May', 'Q2', 2019, 30),
(N'July', 'Q3', 2020, 10),
(N'November', 'Q4', 2019, 120),
(N'October', 'Q4', 2019, 150),
(N'November', 'Q4', 2019, 180),
(N'November', 'Q4', 2020, 120),
(N'July', 'Q3', 2019, 160),
(N'March', 'Q1', 2020, 170);

--1. Using ROLLUP to Calculate Subtotals and Grand Totals
SELECT SalesYear,SalesQuarter, SUM(SalesTotal) AS SalesTotal FROM SalesList
GROUP BY ROLLUP (SalesYear, SalesQuarter);


--2.Replacing NULL Values with Labels for Subtotals and Grand Totals
SELECT CASE WHEN GROUPING(SalesYear) = 1 AND GROUPING(SalesQuarter) = 1 THEN 'Grand Total'
WHEN GROUPING(SalesQuarter) = 1 THEN 'Subtotal'
        ELSE CAST(SalesYear AS NVARCHAR(10))
    END AS SalesYear,SalesQuarter,SUM(SalesTotal) AS SalesTotal FROM SalesList
GROUP BY ROLLUP(SalesYear, SalesQuarter);


--3. Using GROUPING SETS for Custom Subtotals
SELECT SalesQuarter,SalesMonth, SUM(SalesTotal) AS SalesTotal FROM SalesList
GROUP BY GROUPING SETS ((SalesQuarter), (SalesMonth), ());
