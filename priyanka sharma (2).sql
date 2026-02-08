CREATE DATABASE  IF NOT EXISTS `management_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `management_system`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: management_system
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `Employee_ID` varchar(20) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Role` varchar(60) NOT NULL,
  `Department_ID` varchar(20) NOT NULL,
  `Atendance` varchar(10) DEFAULT 'absent',
  PRIMARY KEY (`Employee_ID`),
  UNIQUE KEY `Department_ID` (`Department_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES ('E001','James','Quality Analyst','D101','Present'),('E002','John','Production Manager','D102','Absent'),('E003','Preeti','HR Manager','D103','Present'),('E004','Komal','Sales Executive','D104','Present'),('E005','Payal','Quality Analyst','D105','Absent'),('E006','Mina','Marketing Specialist','D106','Present'),('E007','Tina','Accountant','D107','Present'),('E008','Mohan','Marketing Manager','D108','Absent'),('E009','Rohan','Sales Manager','D109','Absent');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Order_ID` int(11) NOT NULL,
  `Customer_ID` varchar(20) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL CHECK (`Quantity` > 50),
  `Dispatch_Date` date DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  UNIQUE KEY `Customer_ID` (`Customer_ID`),
  UNIQUE KEY `Product_ID` (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'C001',201,100,'2024-12-02'),(2,'C002',202,100,'2024-12-04'),(3,'C003',203,200,NULL),(4,'C004',204,250,'2024-12-07'),(5,'C005',205,350,NULL),(6,'C006',206,450,'2024-12-12'),(7,'C007',207,300,'2024-12-18'),(8,'C008',208,350,'2024-12-20');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger trg
after insert
on orders
for each row
begin
insert into queue_dispatch values(new.Order_id,NEW.Quantity,new.Dispatch_Date);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `pending_orders_view`
--

DROP TABLE IF EXISTS `pending_orders_view`;
/*!50001 DROP VIEW IF EXISTS `pending_orders_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `pending_orders_view` AS SELECT 
 1 AS `Order_ID`,
 1 AS `Customer_ID`,
 1 AS `Product_ID`,
 1 AS `Quantity`,
 1 AS `Dispatch_Date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `production_batches`
--

DROP TABLE IF EXISTS `production_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `production_batches` (
  `Batch_ID` int(11) NOT NULL,
  `Product_ID` int(11) NOT NULL,
  `Start_Date` date NOT NULL,
  `End_Date` date NOT NULL,
  `QA_Status` varchar(50) DEFAULT 'work in progress',
  PRIMARY KEY (`Batch_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_batches`
--

LOCK TABLES `production_batches` WRITE;
/*!40000 ALTER TABLE `production_batches` DISABLE KEYS */;
INSERT INTO `production_batches` VALUES (1001,201,'2024-12-07','2024-12-09','passed'),(1002,202,'2025-01-02','2025-01-04','failed'),(1003,203,'2025-01-24','2025-01-27','passed'),(1004,204,'2025-02-07','2025-02-10','passed'),(1005,205,'2025-02-09','2025-02-14','failed'),(1006,206,'2025-03-10','2025-03-23','in progress'),(1007,207,'2025-04-20','2025-04-24','passed'),(1008,208,'2025-05-07','2025-05-12','failed');
/*!40000 ALTER TABLE `production_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `production_view`
--

DROP TABLE IF EXISTS `production_view`;
/*!50001 DROP VIEW IF EXISTS `production_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `production_view` AS SELECT 
 1 AS `Batch_ID`,
 1 AS `Product_ID`,
 1 AS `Start_Date`,
 1 AS `End_Date`,
 1 AS `QA_Status`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `quality_tests`
--

DROP TABLE IF EXISTS `quality_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quality_tests` (
  `Test_ID` int(11) NOT NULL,
  `Batch_ID` int(11) NOT NULL,
  `Parameter` varchar(30) NOT NULL,
  `Result` varchar(10) NOT NULL,
  `Test_Date` date NOT NULL,
  PRIMARY KEY (`Test_ID`),
  UNIQUE KEY `Batch_ID` (`Batch_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quality_tests`
--

LOCK TABLES `quality_tests` WRITE;
/*!40000 ALTER TABLE `quality_tests` DISABLE KEYS */;
INSERT INTO `quality_tests` VALUES (1,1001,'potency','passed','2024-12-06'),(2,1002,'stability','failed','2024-12-07'),(3,1003,'microbial test','passed','2024-12-09'),(4,1004,'potency','passed','2024-12-12'),(5,1005,'stabilty','failed','2024-12-23');
/*!40000 ALTER TABLE `quality_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue_dispatch`
--

DROP TABLE IF EXISTS `queue_dispatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queue_dispatch` (
  `Order_id` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Dispatch_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue_dispatch`
--

LOCK TABLES `queue_dispatch` WRITE;
/*!40000 ALTER TABLE `queue_dispatch` DISABLE KEYS */;
INSERT INTO `queue_dispatch` VALUES (1,100,'2024-12-02'),(2,150,'2024-12-04'),(3,200,'0000-00-00'),(4,250,'2024-12-07'),(5,350,'0000-00-00'),(6,450,'2024-12-12'),(7,300,'2024-12-18'),(1,100,'2024-12-02'),(2,150,'2024-12-04'),(3,200,'0000-00-00'),(4,250,'2024-12-07'),(5,350,'0000-00-00'),(6,450,'2024-12-12'),(7,300,'2024-12-18'),(1,100,'2024-12-02'),(2,150,'2024-12-04'),(3,200,'0000-00-00'),(4,250,'2024-12-07'),(5,350,'0000-00-00'),(6,450,'2024-12-12'),(7,300,'2024-12-18'),(1,100,'2024-12-02'),(2,150,'2024-12-04'),(3,200,'2024-12-04'),(4,250,'2024-12-07'),(5,350,'2024-12-11'),(6,450,'2024-12-12'),(7,300,'2024-12-18'),(1,100,'2024-12-02'),(2,150,'2024-12-04'),(3,200,'2024-12-04'),(4,250,'2024-12-07'),(5,350,'2024-12-11'),(6,450,'2024-12-12'),(7,300,'2024-12-18'),(8,350,'2024-12-20');
/*!40000 ALTER TABLE `queue_dispatch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `raw_material`
--

DROP TABLE IF EXISTS `raw_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `raw_material` (
  `Material_ID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Supplier_ID` varchar(50) NOT NULL,
  PRIMARY KEY (`Material_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `raw_material`
--

LOCK TABLES `raw_material` WRITE;
/*!40000 ALTER TABLE `raw_material` DISABLE KEYS */;
INSERT INTO `raw_material` VALUES (1,'Paracetamol',500,'S101'),(2,'Ibuprofen',700,'S102'),(3,'Paracetamol',800,'S103'),(4,'Amoxicill in',600,'S104'),(5,'Paracetamol',500,'S105'),(6,'Amoxicill in',700,'S106'),(7,'Ibuprofen',900,'S107');
/*!40000 ALTER TABLE `raw_material` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger r_trg
before update
on raw_material
for each row
begin
if NEW.Quantity<500 then
signal SQLSTATE '45000' set MESSAGE_TEXT = 'Stock below minimum threshold';
end if ;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'management_system'
--
/*!50003 DROP PROCEDURE IF EXISTS `prc_m` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prc_m`()
begin
select Batch_ID from production_batches where QA_Status = 'failed';
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `pending_orders_view`
--

/*!50001 DROP VIEW IF EXISTS `pending_orders_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `pending_orders_view` AS select `orders`.`Order_ID` AS `Order_ID`,`orders`.`Customer_ID` AS `Customer_ID`,`orders`.`Product_ID` AS `Product_ID`,`orders`.`Quantity` AS `Quantity`,`orders`.`Dispatch_Date` AS `Dispatch_Date` from `orders` where `orders`.`Dispatch_Date` is null */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `production_view`
--

/*!50001 DROP VIEW IF EXISTS `production_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `production_view` AS select `production_batches`.`Batch_ID` AS `Batch_ID`,`production_batches`.`Product_ID` AS `Product_ID`,`production_batches`.`Start_Date` AS `Start_Date`,`production_batches`.`End_Date` AS `End_Date`,`production_batches`.`QA_Status` AS `QA_Status` from `production_batches` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-19 14:23:56
