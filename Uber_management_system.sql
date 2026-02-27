-- ==========================================
-- UBER INDIA MANAGEMENT SYSTEM - COMPLETE DATASET
-- ==========================================

CREATE DATABASE IF NOT EXISTS uber_management_system;
USE uber_management_system;

-- ---------------------------------------------------------
-- 1. TABLE STRUCTURES (DDL)
-- ---------------------------------------------------------

-- Users (Passengers)
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15) UNIQUE,
    wallet_balance DECIMAL(10,2) DEFAULT 0.00,
    city ENUM('Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Pune', 'Kolkata', 'Chennai'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Emergency Contacts (Safety)
CREATE TABLE Emergency_Contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    contact_name VARCHAR(100),
    contact_phone VARCHAR(15),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Drivers
CREATE TABLE Drivers (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    aadhar_no VARCHAR(20) UNIQUE,
    license_no VARCHAR(20) UNIQUE,
    rating DECIMAL(3,2) DEFAULT 4.0,
    is_active BOOLEAN DEFAULT TRUE,
    joined_at DATE
);

-- Vehicles (Indian Models)
CREATE TABLE Vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_id INT UNIQUE,
    model_name VARCHAR(50), 
    plate_no VARCHAR(20) UNIQUE, 
    category ENUM('UberGo', 'UberPremier', 'UberAuto', 'UberXL') DEFAULT 'UberGo',
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id) ON DELETE CASCADE
);

-- Trips
CREATE TABLE Trips (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    driver_id INT,
    pickup_loc VARCHAR(255),
    dropoff_loc VARCHAR(255),
    distance_km DECIMAL(5,2),
    fare_amount DECIMAL(10,2),
    status ENUM('Completed', 'Cancelled') DEFAULT 'Completed',
    booking_time DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id)
);

-- Payments (UPI, PayTM etc)
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT UNIQUE,
    payment_method ENUM('UPI', 'Cash', 'PayTM', 'AmazonPay', 'Credit_Card'),
    transaction_status ENUM('Success', 'Failed') DEFAULT 'Success',
    transaction_id VARCHAR(50) UNIQUE,
    amount_paid DECIMAL(10,2),
    FOREIGN KEY (trip_id) REFERENCES Trips(trip_id)
);

-- Reviews
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT UNIQUE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    feedback TEXT,
    FOREIGN KEY (trip_id) REFERENCES Trips(trip_id)
);

-- ---------------------------------------------------------
-- 2. DATA POPULATION PROCEDURE (200 Records Each)
-- ---------------------------------------------------------

DELIMITER $$

CREATE PROCEDURE PopulateIndianUberData()
BEGIN
    DECLARE i INT DEFAULT 1;
    -- Diverse Indian Names & Localities
    DECLARE f_names TEXT DEFAULT 'Aarav,Priyanka,Rahul,Sneha,Amit,Ananya,Vikram,Kavita,Rajesh,Deepika,Arjun,Pooja,Sanjay,Ishani,Aditya,Riya,Nitin,Sunita,Kunal,Megha';
    DECLARE l_names TEXT DEFAULT 'Sharma,Iyer,Patel,Reddy,Deshmukh,Chatterjee,Nair,Gupta,Kulkarni,Singh,Verma,Joshi,Mehta,Malhotra,Gill,Pillai,Bose,Yadav,Dutta,Chauhan';
    DECLARE streets TEXT DEFAULT 'Indiranagar,Powai,Cyber City,Banjara Hills,Hinjewadi,Park Street,T-Nagar,Connaught Place,Viman Nagar,Salt Lake';

    -- Clear tables for a fresh start
    SET FOREIGN_KEY_CHECKS = 0;
    TRUNCATE TABLE Reviews; TRUNCATE TABLE Payments; TRUNCATE TABLE Trips; 
    TRUNCATE TABLE Vehicles; TRUNCATE TABLE Drivers; TRUNCATE TABLE Emergency_Contacts; TRUNCATE TABLE Users;
    SET FOREIGN_KEY_CHECKS = 1;

    -- 1. Insert 200 Users & Emergency Contacts
    WHILE i <= 200 DO
        SET @fn = SUBSTRING_INDEX(SUBSTRING_INDEX(f_names, ',', FLOOR(1 + RAND() * 20)), ',', -1);
        SET @ln = SUBSTRING_INDEX(SUBSTRING_INDEX(l_names, ',', FLOOR(1 + RAND() * 20)), ',', -1);
        
        INSERT INTO Users (full_name, email, phone, wallet_balance, city)
        VALUES (CONCAT(@fn, ' ', @ln), LOWER(CONCAT(@fn, i, '@uberindia.in')), CONCAT('+91-', FLOOR(7000+RAND()*2999), '-', FLOOR(10000+RAND()*89999)), ROUND(RAND()*1500, 2), ELT(FLOOR(1+RAND()*7), 'Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Pune', 'Kolkata', 'Chennai'));
        
        INSERT INTO Emergency_Contacts (user_id, contact_name, contact_phone)
        VALUES (i, CONCAT('Family of ', @fn), CONCAT('+91-9', FLOOR(100000000 + RAND() * 899999999)));
        SET i = i + 1;
    END WHILE;

    -- 2. Insert 200 Drivers & Vehicles
    SET i = 1;
    WHILE i <= 200 DO
        SET @fn = SUBSTRING_INDEX(SUBSTRING_INDEX(f_names, ',', FLOOR(1 + RAND() * 20)), ',', -1);
        SET @ln = SUBSTRING_INDEX(SUBSTRING_INDEX(l_names, ',', FLOOR(1 + RAND() * 20)), ',', -1);
        
        INSERT INTO Drivers (full_name, aadhar_no, license_no, rating, joined_at)
        VALUES (CONCAT(@fn, ' ', @ln), CONCAT(FLOOR(2000+RAND()*7000), '-', FLOOR(1000+RAND()*8000), '-', FLOOR(1000+RAND()*8000)), CONCAT('DL-', i, '-IND'), ROUND(3.8 + RAND()*1.2, 1), DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*500) DAY));
        
        INSERT INTO Vehicles (driver_id, model_name, plate_no, category)
        VALUES (i, ELT(FLOOR(1+RAND()*5), 'Maruti Dzire', 'Hyundai Aura', 'Tata Nexon', 'Toyota Innova', 'Maruti Suzuki Alto'), 
        CONCAT(ELT(FLOOR(1+RAND()*5), 'MH', 'KA', 'DL', 'TS', 'WB'), '-', FLOOR(10+RAND()*89), '-', CHAR(65+RAND()*25), CHAR(65+RAND()*25), '-', FLOOR(1000+RAND()*8999)),
        ELT(FLOOR(1+RAND()*4), 'UberGo', 'UberPremier', 'UberAuto', 'UberXL'));
        SET i = i + 1;
    END WHILE;

    -- 3. Insert 200 Trips, Payments, and Reviews
    SET i = 1;
    WHILE i <= 200 DO
        SET @dist = ROUND(3 + RAND()*30, 2);
        SET @fare = ROUND(@dist * 15.5, 2);
        
        INSERT INTO Trips (user_id, driver_id, pickup_loc, dropoff_loc, distance_km, fare_amount, booking_time)
        VALUES (FLOOR(1+RAND()*200), FLOOR(1+RAND()*200), CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(streets, ',', FLOOR(1+RAND()*10)), ',', -1), ', Plot ', FLOOR(RAND()*50)), CONCAT(SUBSTRING_INDEX(SUBSTRING_INDEX(streets, ',', FLOOR(1+RAND()*10)), ',', -1), ', Sector ', FLOOR(RAND()*15)), @dist, @fare, DATE_SUB(NOW(), INTERVAL FLOOR(RAND()*5000) MINUTE));
        
        INSERT INTO Payments (trip_id, payment_method, amount_paid, transaction_id)
        VALUES (i, ELT(FLOOR(1+RAND()*5), 'UPI', 'Cash', 'PayTM', 'AmazonPay', 'Credit_Card'), @fare, CONCAT('TXN-', i, '-', FLOOR(RAND()*100000)));
        
        INSERT INTO Reviews (trip_id, rating, feedback)
        VALUES (i, FLOOR(3+RAND()*3), ELT(FLOOR(1+RAND()*4), 'Professional driver', 'Clean car interior', 'Helpful with luggage', 'Quick response'));
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;

-- Run the generator
CALL PopulateIndianUberData();

-- Clean up the procedure
DROP PROCEDURE IF EXISTS PopulateIndianUberData;

-- Final Verification Query
SELECT 'SETUP COMPLETE' as Status, (SELECT COUNT(*) FROM Users) as Total_Users, (SELECT COUNT(*) FROM Trips) as Total_Trips;