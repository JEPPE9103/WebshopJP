-- 1. Vilka kunder har köpt svarta byxor i storlek 38 av märket Levis?
SELECT DISTINCT c.FirstName AS Förnamn, c.LastName AS Efternamn
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Color = 'Svart'
AND p.Size = '38'
AND p.Brand = 'Levis';

-- 2. Lista antalet produkter per kategori.
SELECT c.CategoryName AS Kategori, COUNT(p.ProductID) AS AntalProdukter
FROM ProductCategories pc
JOIN Categories c ON pc.CategoryID = c.CategoryID
JOIN Products p ON pc.ProductID = p.ProductID
GROUP BY c.CategoryName;

-- 3. Skapa en kundlista med den totala summan pengar som varje kund har handlat för.
SELECT c.FirstName AS Förnamn, c.LastName AS Efternamn, SUM(p.Price * od.Quantity) AS TotaltHandlat
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID;

-- 4. Lista det totala beställningsvärdet per ort där värdet är större än 1000 kr.
SELECT c.City AS Ort, SUM(p.Price * od.Quantity) AS TotaltBeställningsvärde
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.City
HAVING SUM(p.Price * od.Quantity) > 1000;

-- 5. Skapa en topp-5 lista av de mest sålda produkterna.
SELECT p.Name AS Produktnamn, SUM(od.Quantity) AS TotaltSålda
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID
ORDER BY TotaltSålda DESC
LIMIT 5;

-- 6. Vilken månad hade du den största försäljningen?
SELECT DATE_FORMAT(o.OrderDate, '%Y-%m') AS Månad, SUM(p.Price * od.Quantity) AS TotalaFörsäljningen
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY Månad
ORDER BY TotalaFörsäljningen DESC
LIMIT 1;
