-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 30, 2019 at 03:27 AM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `autoclave`
--

CREATE TABLE `autoclave` (
  `id` int(11) NOT NULL,
  `autoc_quantity` int(11) DEFAULT NULL,
  `autoc_heattime` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `autoclave`
--

INSERT INTO `autoclave` (`id`, `autoc_quantity`, `autoc_heattime`) VALUES
(1, 1, 10),
(2, 2, 11),
(3, 3, 12);

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id` int(11) NOT NULL,
  `doc_lname` varchar(45) DEFAULT NULL,
  `doc_fname` varchar(45) DEFAULT NULL,
  `doc_licen` varchar(45) DEFAULT NULL,
  `doc_hosp` varchar(45) DEFAULT NULL,
  `doc_addr` varchar(45) DEFAULT NULL,
  `doc_email` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id`, `doc_lname`, `doc_fname`, `doc_licen`, `doc_hosp`, `doc_addr`, `doc_email`) VALUES
(1, 'Antonio', 'Adrian John', 'Yes', 'Westech Hospital', '1037 Benito St. San Fernando, Pampanga', 'ajantonio01@gmail.com'),
(2, 'Kamado', 'Tanjiro', 'Yes', 'Chinese General Hospital', '21 Maimpis Blk 3 Sampaloc, Manila', 'kamabokogonpachiro@yahoo.com');

-- --------------------------------------------------------

--
-- Table structure for table `doctor_recieves_materials`
--

CREATE TABLE `doctor_recieves_materials` (
  `doctor_id` int(11) NOT NULL,
  `materials_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hospital_staff`
--

CREATE TABLE `hospital_staff` (
  `id` int(11) NOT NULL,
  `hospsta_fname` varchar(45) DEFAULT NULL,
  `hospsta_lname` varchar(45) DEFAULT NULL,
  `hospsta_age` int(11) DEFAULT NULL,
  `hospsta_sex` varchar(45) DEFAULT NULL,
  `hospsta_add` varchar(45) DEFAULT NULL,
  `hospsta_licen` varchar(45) DEFAULT NULL,
  `autoclave_autoc_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hospital_staff`
--

INSERT INTO `hospital_staff` (`id`, `hospsta_fname`, `hospsta_lname`, `hospsta_age`, `hospsta_sex`, `hospsta_add`, `hospsta_licen`, `autoclave_autoc_id`) VALUES
(1, 'Adrian John', 'Antonio', 19, 'M', '21 Humabon st. Sampaloc, Manila', NULL, 0),
(1, 'Rose', 'Magallanes', 29, 'F', '1037 Don Benits st. Metro Manila, Makati', 'Yes', 1),
(2, 'Peter', 'Ocampo', 22, 'M', '32 Amazon st. San Fernando Pampanga', 'Yes', 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `manytomany`
-- (See below for the actual view)
--
CREATE TABLE `manytomany` (
`doctor_id` int(11)
,`materials_id` int(11)
,`doc_fname` varchar(45)
,`doc_lname` varchar(45)
,`mater_name` varchar(45)
,`mater_quantity` int(11)
,`mater_price` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE `materials` (
  `id` int(11) NOT NULL,
  `mater_name` varchar(45) DEFAULT NULL,
  `mater_quantity` int(11) DEFAULT NULL,
  `mater_price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`id`, `mater_name`, `mater_quantity`, `mater_price`) VALUES
(1, 'Bone Cement', 1, 4999),
(2, 'Plates', 2, 5999);

-- --------------------------------------------------------

--
-- Stand-in structure for view `virtualtable`
-- (See below for the actual view)
--
CREATE TABLE `virtualtable` (
`id` int(11)
,`hospsta_fname` varchar(45)
,`hospsta_lname` varchar(45)
);

-- --------------------------------------------------------

--
-- Structure for view `manytomany`
--
DROP TABLE IF EXISTS `manytomany`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `manytomany`  AS  select `doctor_recieves_materials`.`doctor_id` AS `doctor_id`,`doctor_recieves_materials`.`materials_id` AS `materials_id`,`doctor`.`doc_fname` AS `doc_fname`,`doctor`.`doc_lname` AS `doc_lname`,`materials`.`mater_name` AS `mater_name`,`materials`.`mater_quantity` AS `mater_quantity`,`materials`.`mater_price` AS `mater_price` from ((`doctor_recieves_materials` join `doctor` on((`doctor_recieves_materials`.`doctor_id` = `doctor`.`id`))) join `materials` on((`doctor_recieves_materials`.`materials_id` = `materials`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `virtualtable`
--
DROP TABLE IF EXISTS `virtualtable`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `virtualtable`  AS  select `autoclave`.`id` AS `id`,`hospital_staff`.`hospsta_fname` AS `hospsta_fname`,`hospital_staff`.`hospsta_lname` AS `hospsta_lname` from (`autoclave` join `hospital_staff` on((`autoclave`.`id` = `hospital_staff`.`hospsta_fname`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `autoclave`
--
ALTER TABLE `autoclave`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doctor_recieves_materials`
--
ALTER TABLE `doctor_recieves_materials`
  ADD PRIMARY KEY (`doctor_id`,`materials_id`),
  ADD KEY `fk_doctor_recieves_materials_materials1_idx` (`materials_id`),
  ADD KEY `fk_doctor_recieves_materials_doctor_idx` (`doctor_id`);

--
-- Indexes for table `hospital_staff`
--
ALTER TABLE `hospital_staff`
  ADD PRIMARY KEY (`id`,`autoclave_autoc_id`),
  ADD KEY `fk_HOSPITAL_STAFF_AUTOCLAVE1_idx` (`autoclave_autoc_id`);

--
-- Indexes for table `materials`
--
ALTER TABLE `materials`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `materials`
--
ALTER TABLE `materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctor_recieves_materials`
--
ALTER TABLE `doctor_recieves_materials`
  ADD CONSTRAINT `fk_doctor_recieves_materials_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_doctor_recieves_materials_materials1` FOREIGN KEY (`materials_id`) REFERENCES `materials` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `hospital_staff`
--
ALTER TABLE `hospital_staff`
  ADD CONSTRAINT `fk_HOSPITAL_STAFF_AUTOCLAVE1` FOREIGN KEY (`id`) REFERENCES `autoclave` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
