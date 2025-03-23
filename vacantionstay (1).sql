-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 07, 2025 at 03:58 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vacantionstay`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddBooking` (IN `p_PropertyID` INT, IN `p_GuestID` INT, IN `p_CheckInDate` DATE, IN `p_CheckOutDate` DATE, IN `p_Confirm` VARCHAR(10))   BEGIN
    INSERT INTO booking (PropertyID, GuestID, CheckInDate, CheckOutDate, Confirm)
    VALUES (p_PropertyID, p_GuestID, p_CheckInDate, p_CheckOutDate, p_Confirm);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AddGuest` (IN `FirstName` VARCHAR(255), IN `LastName` VARCHAR(255), IN `Email` VARCHAR(50), IN `Phone` VARCHAR(20))   BEGIN
    INSERT INTO guest (FirstName, LastName, Email, Phone)
    VALUES (FirstName, LastName, Email, Phone);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteGuestByID` (IN `p_GuestID` INT)   BEGIN
    -- Delete the guest by GuestID
    DELETE FROM guest
    WHERE GuestID = p_GuestID;
    
    -- I check if any rows were deleted before or not exist
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = ' Error No guest found with the given: ID';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPropertyByID` (IN `p_PropertyID` INT)   BEGIN
    SELECT 
        PropertyID, 
        Property_Name, 
        Address, 
        property_type
    FROM property
    WHERE PropertyID = p_PropertyID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStaffByFilters` (IN `p_StaffID` INT, IN `p_Role` VARCHAR(255), IN `p_FirstName` VARCHAR(255), IN `p_LastName` VARCHAR(255))   BEGIN
    SELECT 
        Staff_ID, 
        firstName, 
        lastName, 
        Role, 
        Email
    FROM staff
    WHERE 
        (p_StaffID IS NULL OR Staff_ID = p_StaffID) AND
        (p_Role IS NULL OR Role = p_Role) AND
        (p_FirstName IS NULL OR firstName LIKE CONCAT('%', p_FirstName, '%')) AND
        (p_LastName IS NULL OR lastName LIKE CONCAT('%', p_LastName, '%'));
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetStaffByID` (IN `p_StaffID` INT)   BEGIN
    SELECT        -- Get staff by ID
        Staff_ID, 
        firstName, 
        lastName, 
        Role, 
        Email
    FROM staff
    WHERE Staff_ID = p_StaffID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGuestDetails` (IN `p_GuestID` INT, IN `p_FirstName` VARCHAR(255), IN `p_LastName` VARCHAR(255), IN `p_Email` VARCHAR(255), IN `p_Phone` VARCHAR(20))   BEGIN
    UPDATE guest
    SET 
        FirstName = p_FirstName,
        LastName = p_LastName,
        Email = p_Email,
        Phone = p_Phone
    WHERE GuestID = p_GuestID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateRoomPrice` (IN `p_RoomID` INT, IN `p_NewPrice` DECIMAL(10,2))   BEGIN
    UPDATE rooms
    SET Price = p_NewPrice
    WHERE RoomID = p_RoomID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `BookingID` int(11) NOT NULL,
  `PropertyID` int(11) DEFAULT NULL,
  `GuestID` int(11) DEFAULT NULL,
  `CheckInDate` date DEFAULT NULL,
  `CheckOutDate` date DEFAULT NULL,
  `Confirm` enum('Yes','No') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`BookingID`, `PropertyID`, `GuestID`, `CheckInDate`, `CheckOutDate`, `Confirm`) VALUES
(6, 3, 1, '2024-12-03', '2024-12-04', 'Yes'),
(7, 4, 2, '2024-12-13', '2024-12-14', 'Yes'),
(8, 5, 3, '2024-10-03', '2024-10-04', 'Yes'),
(9, 6, 4, '2024-08-22', '2024-08-23', 'Yes'),
(10, 7, 5, '2024-05-02', '2024-05-03', 'Yes'),
(11, 8, 6, '2025-01-03', '2025-01-04', 'Yes'),
(12, 9, 7, '2025-01-18', '2025-01-18', 'Yes'),
(13, 10, 8, '2025-01-25', '2025-01-26', 'Yes'),
(14, 11, 9, '2025-02-03', '2025-02-04', 'Yes'),
(15, 12, 10, '2025-02-04', '2025-02-05', 'Yes'),
(17, 5, 8, '2025-02-05', '2025-02-06', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `guest`
--

CREATE TABLE `guest` (
  `GuestID` int(11) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guest`
--

INSERT INTO `guest` (`GuestID`, `FirstName`, `LastName`, `Email`, `Phone`) VALUES
(1, 'Franco', 'Odelli', 'franco44@yahoo.com', '0786453678'),
(2, 'Mark', 'Anderson', 'mark@gmail.uk', '0747483699'),
(3, 'Franco', 'Martelli', 'franco.M@gmail.com', '07440785033'),
(4, 'Michael', 'Johnson', 'jack@yahoo.uk', '0754678403'),
(5, 'Daniel', 'Harris', 'harris5@yahoo.com', '0747483644'),
(6, 'Sophia', 'Lee', 'LeeSof@gmail.com', '0754634538'),
(7, 'Benjamin', 'Walker', 'walker@yahoo.com', '0766538898'),
(8, 'Ava', 'Martinez', 'avaM@yahoo.com', '0786865432'),
(9, 'William', 'Turner', 'turnetW4@yahoo.com', '0767454783'),
(10, 'Mia', 'Robinson', 'MiaR@yahoo.com', '0745363573'),
(12, 'Franco', 'Odelli', 'franco44@yahoo.com', '0745675394'),
(13, 'Ana', 'Brown', 'anaBw@yahoo.com', '07556754393'),
(14, 'John', 'Doe', 'johndoe@gmail.com', '0734567890'),
(15, 'Vlad', 'Tepes', 'valad@yahoo.com', '0745456789'),
(16, 'Nanen', 'Marius', 'manAn@yahoo.com', '0758564375');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `PaymentID` int(11) NOT NULL,
  `BookingID` int(11) DEFAULT NULL,
  `PaymentDate` date DEFAULT NULL,
  `AmountPaid` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`PaymentID`, `BookingID`, `PaymentDate`, `AmountPaid`) VALUES
(1, 6, '2024-12-03', 45.00),
(2, 7, '2024-12-13', 75.00),
(3, 8, '2024-12-03', 78.70),
(4, 9, '2024-10-03', 56.20),
(5, 10, '2024-08-22', 100.00),
(6, 11, '2025-05-02', 87.00),
(7, 12, '2025-01-03', 200.00),
(8, 13, '2025-01-18', 134.00),
(9, 14, '2025-01-25', 45.00),
(10, 15, '2025-02-04', 109.00);

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `PropertyID` int(11) NOT NULL,
  `Property_Name` varchar(100) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `property_type` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`PropertyID`, `Property_Name`, `Address`, `property_type`) VALUES
(3, 'The Ritz-Carlton', '9 New Street Birmingham', 'Hotel'),
(4, 'Four Seasons Hotel', '276 Tutubury, Buton on trent', 'Hotel'),
(5, 'The Peninsula', '220 Tutubury Road, Buton on trent', 'Villa'),
(6, 'Marriott Marquis', '567 New Street, London', 'Hotel'),
(7, 'Shangri-La Hotel ', '2 Hight Street, London', 'Hotel'),
(8, 'Mandarin Oriental', '48b Blackpool Street, Derby', 'Hotel'),
(9, 'The St. Regis', '5 The Queen Street, Mancester ', 'Villa'),
(10, 'InterContinental Hotel', ' 33 Avenue Street, Northampton', 'Hotel'),
(11, 'WB Villa', '42 Northcote Stree, Nottingham ', 'Villa'),
(12, 'Hilton Worldwide', '16 Anglesey Road, Leicester', 'Hotel');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `RoomID` int(11) NOT NULL,
  `PropertyID` int(11) DEFAULT NULL,
  `Room_type` enum('Single','Double','Suite','Queen De Luxe') DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`RoomID`, `PropertyID`, `Room_type`, `Price`) VALUES
(3, 3, 'Single', 50.00),
(4, 4, 'Double', 75.00),
(5, 5, 'Double', 78.70),
(6, 6, 'Single', 56.20),
(7, 7, 'Suite', 100.00),
(8, 8, 'Double', 87.00),
(9, 9, 'Queen De Luxe', 200.00),
(10, 10, 'Suite', 134.00),
(11, 11, 'Single', 45.00),
(12, 12, 'Double', 109.00);

-- --------------------------------------------------------

--
-- Table structure for table `special_requests`
--

CREATE TABLE `special_requests` (
  `Request_id` int(11) NOT NULL,
  `BookingID` int(11) DEFAULT NULL,
  `Request_description` text DEFAULT NULL,
  `status` enum('Pending','Approved','Denied') DEFAULT 'Pending',
  `Approved_by_staff_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `special_requests`
--

INSERT INTO `special_requests` (`Request_id`, `BookingID`, `Request_description`, `status`, `Approved_by_staff_id`) VALUES
(1, 7, 'Bottle of Champhagne', 'Approved', 1),
(10, 8, 'Order a pizza', 'Pending', 3),
(11, 7, 'Extra pilow', 'Approved', 5),
(12, 9, 'Extra bed', 'Pending', 3),
(13, 10, 'Breakfast', 'Pending', 1);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `Staff_ID` int(11) NOT NULL,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `Role` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`Staff_ID`, `firstName`, `lastName`, `Role`, `Email`) VALUES
(1, 'Giovanny', 'Barto', 'Manager', 'giovannyB@gmail.co.uk'),
(2, 'Emma', 'Carter', 'Operativ', 'emmaC@gmail.com'),
(3, 'Lauzra', 'Onely', 'staff', 'laurao@gmail.com'),
(4, 'John', 'Onion', 'staff ', 'Oninomo@gmail.com'),
(5, 'Cristian', 'Anorld', 'step Manager', 'CristMo@gmail.com'),
(6, 'Claraa', 'Monoli', 'staff ', 'Monlio@gmail.com'),
(7, 'Aron', 'Cruz', 'staff', 'arono@gmail.com'),
(8, 'Bogdan', 'Danescu', 'staff', 'laurao@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`BookingID`),
  ADD KEY `PropertyID` (`PropertyID`),
  ADD KEY `GuestID` (`GuestID`);

--
-- Indexes for table `guest`
--
ALTER TABLE `guest`
  ADD PRIMARY KEY (`GuestID`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`PaymentID`),
  ADD KEY `BookingID` (`BookingID`);

--
-- Indexes for table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`PropertyID`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`RoomID`),
  ADD KEY `PropertyID` (`PropertyID`);

--
-- Indexes for table `special_requests`
--
ALTER TABLE `special_requests`
  ADD PRIMARY KEY (`Request_id`),
  ADD KEY `BookingID` (`BookingID`),
  ADD KEY `Approved_by_staff_id` (`Approved_by_staff_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`Staff_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `BookingID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `guest`
--
ALTER TABLE `guest`
  MODIFY `GuestID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `PropertyID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `RoomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `special_requests`
--
ALTER TABLE `special_requests`
  MODIFY `Request_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `Staff_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`PropertyID`) REFERENCES `property` (`PropertyID`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`GuestID`) REFERENCES `guest` (`GuestID`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`);

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`PropertyID`) REFERENCES `property` (`PropertyID`);

--
-- Constraints for table `special_requests`
--
ALTER TABLE `special_requests`
  ADD CONSTRAINT `special_requests_ibfk_1` FOREIGN KEY (`BookingID`) REFERENCES `booking` (`BookingID`),
  ADD CONSTRAINT `special_requests_ibfk_2` FOREIGN KEY (`Approved_by_staff_id`) REFERENCES `staff` (`Staff_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
