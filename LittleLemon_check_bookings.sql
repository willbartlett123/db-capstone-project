-- Set up DB
USE LittleLemonDB;

-- Insert sample data to customer and staff tables for queries to work:
INSERT INTO Customers (CustomerID, FirstName, LastName, PhoneNumber, Email) VALUES
(1, 'John', 'Smith', '555-1010', 'john.smith@example.com'),
(2, 'Maria', 'Garcia', '555-1011', 'maria.garcia@example.com'),
(3, 'Wei', 'Chen', '555-1012', 'wei.chen@example.com');

INSERT INTO Staff (StaffID, FirstName, LastName, Role, Salary) VALUES
(1, 'Sofia', 'Rossi', 'Manager', 55000.00),
(2, 'Marco', 'Bianchi', 'Chef', 48000.00),
(3, 'Elena', 'Russo', 'Server', 32000.00);



-- Task 1: INSERT data into Bookings Table using example values for StaffID column
INSERT INTO Bookings (BookingID, Date, TableNo, CustomerID, StaffID) VALUES
(1, '2022-10-10', 5, 1, 1),
(2, '2022-11-12', 3, 3, 2),
(3, '2022-10-11', 2, 2, 3),
(4, '2022-10-13', 2, 1, 1);

-- Test query
SELECT * FROM Bookings;



-- Task 2: Create CheckBooking Stored Procedure
DELIMITER //
CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE booking_status VARCHAR(45);

    IF EXISTS (
        SELECT 1 FROM Bookings
        WHERE `Date` = booking_date AND TableNo = table_number
    ) THEN
        SET booking_status = CONCAT('Table ', table_number, ' is already booked');
    ELSE
        SET booking_status = CONCAT('Table ', table_number, ' is available for booking');
    END IF;

    SELECT booking_status AS BookingStatus;
END //
DELIMITER ;

-- Call Stored Procedure
CALL CheckBooking("2022-11-12", 3);



-- Task 3: Create Stored Procedure AddValidBooking
DELIMITER //
CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE existing_count INT;
    DECLARE next_id INT;

    START TRANSACTION;

    SELECT IFNULL(MAX(BookingID), 0) + 1 INTO next_id FROM Bookings;

    INSERT INTO Bookings (BookingID, `Date`, TableNo, CustomerID, StaffID)
    VALUES (next_id, booking_date, table_number, 1, 1);

    SELECT COUNT(*) INTO existing_count
    FROM Bookings
    WHERE `Date` = booking_date AND TableNo = table_number;

    IF existing_count > 1 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', table_number, ' is already booked - booking cancelled.') AS BookingStatus;
    ELSE
        COMMIT;
        SELECT 'Booking Confirmed!' AS BookingStatus;
    END IF;
END //
DELIMITER ;

-- Call Stored Procedure for new table and date
CALL AddValidBooking("2022-12-17", 6);
-- Call Stored Procedure for table and date already used 
CALL AddValidBooking('2022-10-10', 5);