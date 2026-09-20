-- Set up DB
USE LittleLemonDB;


-- Task 1: AddBooking Stored Procedure
DROP PROCEDURE IF EXISTS AddBooking;

DELIMITER //
CREATE PROCEDURE AddBooking(IN booking_id INT, IN customer_id INT, IN booking_date DATE, IN table_num INT)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, `Date`, TableNo, StaffID)
    VALUES (booking_id, customer_id, booking_date, table_num, 1); -- using placeholder for staffid
    
    SELECT 'New booking added' AS Confirmation;
END //
DELIMITER ;

CALL AddBooking(9, 3, '2022-12-20', 8); -- Call stored procedure



-- Task 2: Create UpdateBooking Stored Procedure
DROP PROCEDURE IF EXISTS UpdateBooking;

DELIMITER //
CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN booking_date DATE)
BEGIN
	UPDATE Bookings
    SET `Date` = booking_date
    WHERE BookingID = booking_id;
    
	SELECT CONCAT('Booking ', booking_id, ' updated') AS Confirmation;
END //
DELIMITER ; 

CALL UpdateBooking(9, '2022-12-17'); -- Call stored procedure



-- Task 3: Create CancelBooking Stored Procedure
DROP PROCEDURE IF EXISTS CancelBooking;

DELIMITER //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
	DELETE FROM Bookings
    WHERE BookingID = booking_id;
    
    SELECT CONCAT('Booking ', booking_id, ' cancelled') AS Confirmation;
END //
DELIMITER ;

CALL CancelBooking(9); -- Call stored procedure
