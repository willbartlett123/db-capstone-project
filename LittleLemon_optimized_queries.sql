-- Set up DB
USE LittleLemonDB;



-- Task 1: Create Stored Procedure GetMaxQuantity
DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN
	SELECT MAX(Quantity) AS "Max Quantity in Order" FROM Orders; 
END //
DELIMITER ;

-- Call Stored Procedure
CALL GetMaxQuantity();



-- Task 2: Create Prepared Statement GetOrderDetail
PREPARE GetOrderDetail FROM
	'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ?';
    
-- Execute Prepared Statement
SET @id = 1;
EXECUTE GetOrderDetail USING @id;



-- Task 3: Create Stored Procedure CancelOrder
DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id INT) 
BEGIN
	DELETE FROM Orders WHERE OrderID = order_id;
    SELECT CONCAT('Order ', order_id, ' is cancelled') AS Confirmation;
END //
DELIMITER ;

-- Call CamcelOrder
CALL CancelOrder(5);