DROP DATABASE IF EXISTS WebshopJP;

CREATE DATABASE WebshopJP;
USE WebshopJP;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(100),
    City VARCHAR(50),
    Email VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Size VARCHAR(10),
    Color VARCHAR(20),
    Price DECIMAL(10, 2),
    Brand VARCHAR(50),
    Stock INT
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

CREATE TABLE ProductCategories (
    ProductID INT,
    CategoryID INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);


INSERT INTO Customers (FirstName, LastName, Address, City, Email) VALUES
('Erik', 'Svensson', '123 Eken St', 'Göteborg', 'erik.svensson@example.com'),
('Anna', 'Johansson', '456 Ek St', 'Stockholm', 'anna.johansson@example.com'),
('Karin', 'Andersson', '789 Tall St', 'Malmö', 'karin.andersson@example.com'),
('Oskar', 'Karlsson', '101 Björk St', 'Uppsala', 'oskar.karlsson@example.com'),
('Elsa', 'Nilsson', '202 Almn St', 'Linköping', 'elsa.nilsson@example.com');

INSERT INTO Products (Name, Size, Color, Price, Brand, Stock) VALUES
('Svarta Byxor', '38', 'Svart', 299.99, 'Sweetpants', 50),
('Röd Skjorta', 'M', 'Röd', 199.99, 'Tommy Hilfiger', 75),
('Blå Jeans', '32', 'Blå', 399.99, 'Wrangler', 60),
('Grön Hatt', 'OneSize', 'Grön', 149.99, 'Gucci', 30),
('Vita Strumpor', 'OneSize', 'Vit', 49.99, 'Adidas', 100),
('Gul Jacka', 'L', 'Gul', 499.99, 'The North Face', 20),
('Grå Halsduk', 'OneSize', 'Grå', 79.99, 'Burberry', 40),
('Lila Klänning', 'S', 'Lila', 599.99, 'Zara', 10);

INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2024-08-01'),
(2, '2024-08-02'),
(3, '2024-08-03'),
(4, '2024-08-04'),
(5, '2024-08-05'),
(1, '2024-08-06');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 3),
(3, 4, 1),
(4, 5, 5),
(5, 6, 1),
(6, 7, 1),
(6, 8, 1);

INSERT INTO Categories (CategoryName) VALUES
('Klänningar'),
('Skjortor'),
('Byxor'),
('Accessoarer'),
('Ytterkläder');

INSERT INTO ProductCategories (ProductID, CategoryID) VALUES
(1, 3),
(2, 2),
(3, 3),
(4, 4),
(5, 4),
(6, 5),
(7, 4),
(8, 1);
