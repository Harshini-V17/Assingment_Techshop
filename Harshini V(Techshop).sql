CREATE DATABASE TechShop;
USE TechShop;

--task 1

CREATE TABLE Customers (
    CustomerID INT IDENTITY PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);
CREATE TABLE Products (
    ProductID INT IDENTITY PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL
);
CREATE TABLE Orders (
    OrderID INT IDENTITY PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Inventory (
    InventoryID INT IDENTITY PRIMARY KEY,
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Maple Ave'),
('Alice', 'Johnson', 'alice.johnson@example.com', '5555555555', '789 Oak St'),
('Bob', 'Brown', 'bob.brown@example.com', '6666666666', '101 Pine St'),
('Charlie', 'Davis', 'charlie.davis@example.com', '7777777777', '102 Cedar Ave'),
('Emily', 'Clark', 'emily.clark@example.com', '8888888888', '202 Birch Blvd'),
('David', 'Garcia', 'david.garcia@example.com', '9999999999', '303 Spruce Lane'),
('Sophia', 'Martinez', 'sophia.martinez@example.com', '2222222222', '404 Walnut Way'),
('Liam', 'Miller', 'liam.miller@example.com', '3333333333', '505 Elm Dr'),
('Mia', 'Wilson', 'mia.wilson@example.com', '4444444444', '606 Cherry Ct');

INSERT INTO Products VALUES
('Laptop', 'High-end gaming laptop', 1500.00),
('Smartphone', 'Latest model smartphone', 800.00),
('Tablet', '10-inch tablet', 400.00),
('Smartwatch', 'Fitness tracking smartwatch', 200.00),
('Headphones', 'Noise-cancelling headphones', 150.00),
('Keyboard', 'Mechanical keyboard', 100.00),
('Monitor', '27-inch 4K monitor', 300.00),
('Mouse', 'Wireless gaming mouse', 50.00),
('Printer', 'Laser printer', 250.00),
('Camera', 'Digital SLR camera', 1200.00);

INSERT INTO Orders VALUES
(1, '2024-09-10', 2300.00),
(2, '2024-09-11', 950.00),
(3, '2024-09-12', 600.00),
(4, '2024-09-13', 200.00),
(5, '2024-09-14', 1550.00),
(6, '2024-09-15', 450.00),
(7, '2024-09-16', 500.00),
(8, '2024-09-17', 1200.00),
(9, '2024-09-18', 3000.00),
(10, '2024-09-19', 1350.00);

INSERT INTO OrderDetails VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 4, 1),
(4, 5, 1),
(5, 6, 2),
(6, 7, 1),
(7, 8, 3),
(8, 9, 1),
(9, 10, 1);

INSERT INTO Inventory VALUES
(1, 50, '2024-09-01'),
(2, 100, '2024-09-01'),
(3, 200, '2024-09-01'),
(4, 150, '2024-09-01'),
(5, 75, '2024-09-01'),
(6, 80, '2024-09-01'),
(7, 120, '2024-09-01'),
(8, 60, '2024-09-01'),
(9, 30, '2024-09-01'),
(10, 40, '2024-09-01');

--task 2

SELECT FirstName, LastName, Email
FROM Customers;

SELECT Orders.OrderID, Orders.OrderDate, Customers.FirstName, Customers.LastName
FROM Orders, Customers
where Orders.CustomerID = Customers.CustomerID;

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Michael', 'Scott', 'michael.scott@example.com', '9876543210', '1725 Slough Ave');
select * from Customers;

UPDATE Products
SET Price = Price * 1.10;
select * from Products;

declare @OrderID int = 3
DELETE FROM OrderDetails WHERE OrderID = @OrderID;
DELETE FROM Orders WHERE OrderID = @OrderID;

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (3, '2024-09-20', 350.00);

declare @NewAddress varchar(20) = '555 Great Avenue' 
declare @NewEmail varchar(20) = 'johnn@example.com'
declare @CustomerID int = 1
UPDATE Customers
SET Email = @NewEmail, Address = @NewAddress
WHERE CustomerID = @CustomerID;

UPDATE Orders
SET TotalAmount = (
    SELECT SUM(OD.Quantity * P.Price)
    FROM OrderDetails OD , Products P 
    WHERE OD.ProductID = P.ProductID and OD.OrderID = Orders.OrderID
);

declare @Customer int = 1
DELETE FROM OrderDetails
WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = @Customer);
DELETE FROM Orders
WHERE CustomerID = @Customer;

INSERT INTO Products (ProductName, Description, Price)
VALUES ('Wireless Charger', 'Fast wireless charging device', 50.00);

select * from Orders;
ALTER TABLE Orders ADD Status VARCHAR(20);
UPDATE Orders
SET Status = CASE
    WHEN TotalAmount IS NULL THEN 'Pending'
    WHEN TotalAmount > 0 THEN 'Shipped'
    ELSE 'Pending'
END;
declare @NewStatus varchar(20)='Shipped'
declare @Order int = 11
UPDATE Orders
SET Status = @NewStatus
WHERE OrderID = @Order;


ALTER TABLE Customers ADD NumberOfOrders INT;
UPDATE Customers
SET NumberOfOrders = (
    SELECT COUNT(*)
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
);

--task 3

SELECT O.OrderID, O.OrderDate, C.FirstName, C.LastName, C.Email, C.Phone
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
ORDER BY O.OrderID;

SELECT P.ProductName, SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName;

SELECT C.FirstName, C.LastName, C.Email, C.Phone
FROM Customers C
WHERE C.NumberOfOrders >0;

SELECT P.ProductName, SUM(OD.Quantity) AS TotalQuantityOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalQuantityOrdered DESC
Offset 0 rows fetch first 1 rows only;

SELECT ProductName, Description as Category
FROM Products;

SELECT C.FirstName, C.LastName, AVG(O.TotalAmount) AS AverageOrderValue
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.FirstName, C.LastName;

SELECT O.OrderID, C.FirstName, C.LastName, C.Email, O.TotalAmount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
ORDER BY O.TotalAmount DESC
offset 0 rows fetch first 1 rows only;

SELECT P.ProductName, COUNT(OD.OrderDetailID) AS TimesOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TimesOrdered DESC;

declare @ProductName varchar(20) = 'Mouse'
SELECT C.FirstName, C.LastName, C.Email
FROM Customers C
WHERE C.CustomerID IN (
    SELECT O.CustomerID
    FROM Orders O
    JOIN OrderDetails OD ON O.OrderID = OD.OrderID
    JOIN Products P ON OD.ProductID = P.ProductID
    WHERE P.ProductName = @ProductName
);

DECLARE @StartDate DATE = '2024-01-01';
DECLARE @EndDate DATE = '2024-12-31';
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN @StartDate AND @EndDate;

--task 4

SELECT FirstName, LastName, Email
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

SELECT COUNT(ProductID) AS TotalProducts
FROM Products;

SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders;

ALTER TABLE Products
ALTER COLUMN Description NVARCHAR(100);
DECLARE @CategoryName NVARCHAR(100) = 'Laser printer';
SELECT AVG(OD.Quantity) AS AverageQuantity
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
WHERE P.Description = @CategoryName;

DECLARE @Custom INT = 8;
SELECT SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE CustomerID = @Custom;

SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName
ORDER BY NumberOfOrders DESC;

SELECT P.Description, SUM(OD.Quantity) AS TotalQuantityOrdered
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.Description
ORDER BY TotalQuantityOrdered DESC
offset 0 rows fetch first 1 rows only;

SELECT C.FirstName, C.LastName, SUM(OD.Quantity * P.Price) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY C.FirstName, C.LastName
ORDER BY TotalSpent DESC
offset 0 rows fetch first 1 rows only;

SELECT AVG(TotalAmount) AS AverageOrderValue
FROM Orders;

SELECT C.FirstName, C.LastName, 
       SUM(O.TotalAmount) / COUNT(O.OrderID) AS AverageOrderValue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName;

SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName, C.LastName
ORDER BY NumberOfOrders DESC;
