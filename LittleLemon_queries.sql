-- Set up db
USE LittleLemonDB;

-- Task 1: Create OrdersView
CREATE VIEW OrdersView AS
SELECT 
	OrderID,
    Quantity,
    TotalCost
FROM Orders
WHERE Quantity > 2;

-- Test OrdersView
SELECT * FROM OrdersView;


-- Task 2: JOIN Query
SELECT 
	c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName,
    o.OrderID,
    o.TotalCost,
    m.Name AS ItemName,
    m.Course AS CourseName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Menu m   ON o.ItemID = m.ItemID
WHERE o.TotalCost > 150
ORDER BY o.TotalCost ASC;


-- Task 3: Subquery
SELECT Name AS MenuName
FROM Menu 
WHERE ItemID = ANY (
    SELECT ItemID
    FROM Orders
    WHERE Quantity > 2
);