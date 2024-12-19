use DE_Day_3;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(50),
    ContactName NVARCHAR(50),
    Address NVARCHAR(100),
    City NVARCHAR(30),
    PostalCode NVARCHAR(10)
);

INSERT INTO Customers (CustomerID, CustomerName, ContactName, Address, City, PostalCode) 
VALUES 
    (1, 'Alfreds Futterkiste', 'Maria Anders', 'Obere Str. 57', 'Berlin', '12209'),
    (2, 'Ana Trujillo Emparedados y Helados', 'Ana Trujillo', 'Avda. de la Constituci�n 22', 'M�xico D.F.', '05021'),
    (3, 'Antonio Moreno Taquer�a', 'Antonio Moreno', 'Mataderos 2312', 'M�xico D.F.', '05023'),
    (4, 'Around the Horn', 'Thomas Hardy', '120 Hanover Sq.', 'London', 'WA1 1DP'),
    (5, 'Berglunds snabbk�p', 'Christina Berglund', 'Berguvsv�gen 8', 'Lule�', 'S-958 22'),
    (6, 'Blauer See Delikatessen', 'Hanna Moos', 'Forsterstr. 57', 'Mannheim', '68306'),
    (7, 'Blondel p�re et fils', 'Fr�d�rique Citeaux', '24, place Kl�ber', 'Strasbourg', '67000'),
    (8, 'B�lido Comidas preparadas', 'Mart�n Sommer', 'C/ Araquil, 67', 'Madrid', '28023'),
    (9, 'Bon app''', 'Laurence Lebihan', '12, rue des Bouchers', 'Marseille', '13008'),
    (10, 'Bottom-Dollar Marketse', 'Elizabeth Lincoln', '23 Tsawassen Blvd.', 'Tsawassen', 'T2F 8M4');


--Create a Stored Procedure

CREATE PROCEDURE SelectAllCustomers AS SELECT * FROM Customers;
GO


--Execute the Stored Procedure
EXEC SelectAllCustomers;



