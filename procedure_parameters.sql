USE classicmodels;

-- =========================================================
-- 1. THAM SỐ LOẠI IN (Tham số truyền vào)
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS getCusById //

CREATE PROCEDURE getCusById (
    IN cusNum INT
)
BEGIN
    SELECT * FROM customers WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi thủ tục loại IN
CALL getCusById(175);


-- =========================================================
-- 2. THAM SỐ LOẠI OUT (Tham số trả ra)
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS GetCustomersCountByCity //

CREATE PROCEDURE GetCustomersCountByCity (
    IN in_city VARCHAR(50),
    OUT total INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi thủ tục loại OUT và xem kết quả
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total AS TotalCustomersInLyon;


-- =========================================================
-- 3. THAM SỐ LOẠI INOUT (Tham số kết hợp vừa truyền vào vừa trả ra)
-- =========================================================
DELIMITER //

DROP PROCEDURE IF EXISTS SetCounter //

CREATE PROCEDURE SetCounter (
    INOUT counter INT,
    IN inc INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Gọi thủ tục loại INOUT nhiều lần để tăng giá trị biến @counter
SET @counter = 1;

CALL SetCounter(@counter, 1); -- @counter trở thành 2
CALL SetCounter(@counter, 1); -- @counter trở thành 3
CALL SetCounter(@counter, 5); -- @counter trở thành 8

-- Hiển thị kết quả cuối cùng
SELECT @counter AS FinalCounterValue;