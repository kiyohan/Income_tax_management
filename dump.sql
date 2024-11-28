-- MySQL dump 10.13  Distrib 8.0.40, for Linux (x86_64)
--
-- Host: localhost    Database: Taxation_System
-- ------------------------------------------------------
-- Server version	8.0.40-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Assessee`
--

DROP TABLE IF EXISTS `Assessee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Assessee` (
  `PAN` varchar(15) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Filing_Status` varchar(20) DEFAULT NULL,
  `Representative_PAN` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`PAN`),
  KEY `Representative_PAN` (`Representative_PAN`),
  CONSTRAINT `Assessee_ibfk_1` FOREIGN KEY (`Representative_PAN`) REFERENCES `Assessee` (`PAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assessee`
--

LOCK TABLES `Assessee` WRITE;
/*!40000 ALTER TABLE `Assessee` DISABLE KEYS */;
INSERT INTO `Assessee` VALUES ('ABCDE1234F','123 Main St, City','1234567890','Filed',NULL),('FGHIJ5678K','456 Side St, City','0987654321','Not Filed','ABCDE1234F'),('JKLMN9101P','789 Back St, City','1122334455','Filed',NULL),('NOPQR5678L','987 Market Rd, City','6677889900','Filed','JKLMN9101P');
/*!40000 ALTER TABLE `Assessee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Assessee_Bank_Details`
--

DROP TABLE IF EXISTS `Assessee_Bank_Details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Assessee_Bank_Details` (
  `Bank_Account_Number` varchar(20) NOT NULL,
  `PAN` varchar(15) DEFAULT NULL,
  `Account_Holder_Name` varchar(255) DEFAULT NULL,
  `Bank_Address` varchar(255) DEFAULT NULL,
  `IFSC` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`Bank_Account_Number`),
  KEY `PAN` (`PAN`),
  CONSTRAINT `Assessee_Bank_Details_ibfk_1` FOREIGN KEY (`PAN`) REFERENCES `Assessee` (`PAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Assessee_Bank_Details`
--

LOCK TABLES `Assessee_Bank_Details` WRITE;
/*!40000 ALTER TABLE `Assessee_Bank_Details` DISABLE KEYS */;
INSERT INTO `Assessee_Bank_Details` VALUES ('111122223333','ABCDE1234F','John Doe','123 Bank St, City','IFSC001'),('444455556666','FGHIJ5678K','Jane Smith','456 Bank St, City','IFSC002');
/*!40000 ALTER TABLE `Assessee_Bank_Details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bank_Transactions`
--

DROP TABLE IF EXISTS `Bank_Transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bank_Transactions` (
  `Transaction_ID` int NOT NULL,
  `Transaction_Type` varchar(50) DEFAULT NULL,
  `Sender_Account_Number` varchar(20) DEFAULT NULL,
  `Receiver_Account_Number` varchar(20) DEFAULT NULL,
  `Transaction_Amount` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bank_Transactions`
--

LOCK TABLES `Bank_Transactions` WRITE;
/*!40000 ALTER TABLE `Bank_Transactions` DISABLE KEYS */;
INSERT INTO `Bank_Transactions` VALUES (1,'Transfer','111122223333','777788889999',1000.00),(2,'Deposit',NULL,'444455556666',5000.00),(3,'Withdrawal','444455556666',NULL,2000.00),(5,'Transfer','ACC000001','ACC123456',5000.00),(6,'Transfer','ACC000002','ACC123456',3000.00),(7,'Transfer','ACC000003','ACC123456',4000.00);
/*!40000 ALTER TABLE `Bank_Transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Corporate_Assessee`
--

DROP TABLE IF EXISTS `Corporate_Assessee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Corporate_Assessee` (
  `PAN` varchar(15) NOT NULL,
  `Company_Name` varchar(255) DEFAULT NULL,
  `Registration_Number` varchar(50) DEFAULT NULL,
  `Date_of_Incorporation` date DEFAULT NULL,
  PRIMARY KEY (`PAN`),
  UNIQUE KEY `Registration_Number` (`Registration_Number`),
  CONSTRAINT `Corporate_Assessee_ibfk_1` FOREIGN KEY (`PAN`) REFERENCES `Assessee` (`PAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Corporate_Assessee`
--

LOCK TABLES `Corporate_Assessee` WRITE;
/*!40000 ALTER TABLE `Corporate_Assessee` DISABLE KEYS */;
INSERT INTO `Corporate_Assessee` VALUES ('JKLMN9101P','TechCorp Pvt Ltd','TC12345','2010-03-15'),('NOPQR5678L','Finance Solutions Ltd','FS98765','2015-08-20');
/*!40000 ALTER TABLE `Corporate_Assessee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Corresponding_Slabs`
--

DROP TABLE IF EXISTS `Corresponding_Slabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Corresponding_Slabs` (
  `Acknowledgement_Number` int NOT NULL,
  `Slab_ID` int NOT NULL,
  `Amount` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`Acknowledgement_Number`,`Slab_ID`),
  CONSTRAINT `Corresponding_Slabs_ibfk_1` FOREIGN KEY (`Acknowledgement_Number`) REFERENCES `ITR` (`Acknowledgement_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Corresponding_Slabs`
--

LOCK TABLES `Corresponding_Slabs` WRITE;
/*!40000 ALTER TABLE `Corresponding_Slabs` DISABLE KEYS */;
INSERT INTO `Corresponding_Slabs` VALUES (3001,3,NULL);
/*!40000 ALTER TABLE `Corresponding_Slabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Corresponding_year`
--

DROP TABLE IF EXISTS `Corresponding_year`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Corresponding_year` (
  `Start_Year` year NOT NULL,
  `End_Year` year DEFAULT NULL,
  PRIMARY KEY (`Start_Year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Corresponding_year`
--

LOCK TABLES `Corresponding_year` WRITE;
/*!40000 ALTER TABLE `Corresponding_year` DISABLE KEYS */;
INSERT INTO `Corresponding_year` VALUES (2022,2023),(2023,2024);
/*!40000 ALTER TABLE `Corresponding_year` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Deduction`
--

DROP TABLE IF EXISTS `Deduction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Deduction` (
  `Acknowledgement_Number` int NOT NULL,
  `Deduction_Type` varchar(50) NOT NULL,
  `Deduction_Amount` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`Acknowledgement_Number`,`Deduction_Type`),
  KEY `Deduction_Type` (`Deduction_Type`),
  CONSTRAINT `Deduction_ibfk_1` FOREIGN KEY (`Acknowledgement_Number`) REFERENCES `Deduction_period` (`Acknowledgement_Number`),
  CONSTRAINT `Deduction_ibfk_2` FOREIGN KEY (`Deduction_Type`) REFERENCES `Deduction_limit` (`Deduction_Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Deduction`
--

LOCK TABLES `Deduction` WRITE;
/*!40000 ALTER TABLE `Deduction` DISABLE KEYS */;
INSERT INTO `Deduction` VALUES (3001,'80C',100000.00),(3001,'80D',20000.00);
/*!40000 ALTER TABLE `Deduction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Deduction_limit`
--

DROP TABLE IF EXISTS `Deduction_limit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Deduction_limit` (
  `Deduction_Type` varchar(50) NOT NULL,
  `Max_allowable_limit` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`Deduction_Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Deduction_limit`
--

LOCK TABLES `Deduction_limit` WRITE;
/*!40000 ALTER TABLE `Deduction_limit` DISABLE KEYS */;
INSERT INTO `Deduction_limit` VALUES ('80C',150000.00),('80D',25000.00);
/*!40000 ALTER TABLE `Deduction_limit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Deduction_period`
--

DROP TABLE IF EXISTS `Deduction_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Deduction_period` (
  `Acknowledgement_Number` int NOT NULL,
  `PAN` varchar(15) DEFAULT NULL,
  `Start_Year` year DEFAULT NULL,
  PRIMARY KEY (`Acknowledgement_Number`),
  KEY `PAN` (`PAN`),
  KEY `Start_Year` (`Start_Year`),
  CONSTRAINT `Deduction_period_ibfk_1` FOREIGN KEY (`Acknowledgement_Number`) REFERENCES `ITR` (`Acknowledgement_Number`),
  CONSTRAINT `Deduction_period_ibfk_2` FOREIGN KEY (`PAN`) REFERENCES `Assessee` (`PAN`),
  CONSTRAINT `Deduction_period_ibfk_3` FOREIGN KEY (`Start_Year`) REFERENCES `Corresponding_year` (`Start_Year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Deduction_period`
--

LOCK TABLES `Deduction_period` WRITE;
/*!40000 ALTER TABLE `Deduction_period` DISABLE KEYS */;
INSERT INTO `Deduction_period` VALUES (3001,'ABCDE1234F',2022);
/*!40000 ALTER TABLE `Deduction_period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Goods`
--

DROP TABLE IF EXISTS `Goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Goods` (
  `TCS_Certificate_Number` int NOT NULL,
  `Goods_Type` varchar(50) NOT NULL,
  PRIMARY KEY (`TCS_Certificate_Number`,`Goods_Type`),
  CONSTRAINT `Goods_ibfk_1` FOREIGN KEY (`TCS_Certificate_Number`) REFERENCES `TCS` (`TCS_Certificate_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Goods`
--

LOCK TABLES `Goods` WRITE;
/*!40000 ALTER TABLE `Goods` DISABLE KEYS */;
INSERT INTO `Goods` VALUES (2001,'Electronics'),(2001,'Furniture');
/*!40000 ALTER TABLE `Goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ITR`
--

DROP TABLE IF EXISTS `ITR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ITR` (
  `Acknowledgement_Number` int NOT NULL,
  `PAN` varchar(15) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Tax_Payer_Category` varchar(50) DEFAULT NULL,
  `Submission_Date` date DEFAULT NULL,
  `Regime` varchar(50) DEFAULT NULL,
  `Due_Date` date DEFAULT NULL,
  `Start_Year` year DEFAULT NULL,
  `End_Year` year DEFAULT NULL,
  `Total_Taxable_Income` decimal(15,2) DEFAULT NULL,
  `Total_Tax_Paid` decimal(15,2) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Acknowledgement_Number`),
  KEY `PAN` (`PAN`),
  KEY `Start_Year` (`Start_Year`),
  CONSTRAINT `ITR_ibfk_1` FOREIGN KEY (`PAN`) REFERENCES `Assessee` (`PAN`),
  CONSTRAINT `ITR_ibfk_2` FOREIGN KEY (`Start_Year`) REFERENCES `Corresponding_year` (`Start_Year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ITR`
--

LOCK TABLES `ITR` WRITE;
/*!40000 ALTER TABLE `ITR` DISABLE KEYS */;
INSERT INTO `ITR` VALUES (3001,'ABCDE1234F',33,'Individual','2022-07-01','New','2023-07-31',2022,2023,1000000.00,105000.00,'Processed');
/*!40000 ALTER TABLE `ITR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Income_Details`
--

DROP TABLE IF EXISTS `Income_Details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Income_Details` (
  `Acknowledgement_Number` int NOT NULL,
  `PAN` varchar(15) DEFAULT NULL,
  `Start_Year` year DEFAULT NULL,
  `Salary_Income` decimal(15,2) DEFAULT NULL,
  `Business_Income` decimal(15,2) DEFAULT NULL,
  `Capital_Gain` decimal(15,2) DEFAULT NULL,
  `House_Property_Income` decimal(15,2) DEFAULT NULL,
  `Agriculture_Income` decimal(15,2) DEFAULT NULL,
  `Other_Income_Total` decimal(15,2) DEFAULT NULL,
  `Total_income` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`Acknowledgement_Number`),
  KEY `PAN` (`PAN`),
  KEY `Start_Year` (`Start_Year`),
  CONSTRAINT `Income_Details_ibfk_1` FOREIGN KEY (`Acknowledgement_Number`) REFERENCES `ITR` (`Acknowledgement_Number`),
  CONSTRAINT `Income_Details_ibfk_2` FOREIGN KEY (`PAN`) REFERENCES `Assessee` (`PAN`),
  CONSTRAINT `Income_Details_ibfk_3` FOREIGN KEY (`Start_Year`) REFERENCES `Corresponding_year` (`Start_Year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Income_Details`
--

LOCK TABLES `Income_Details` WRITE;
/*!40000 ALTER TABLE `Income_Details` DISABLE KEYS */;
/*!40000 ALTER TABLE `Income_Details` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`kiyohan`@`localhost`*/ /*!50003 TRIGGER `update_total_income_before_insert` BEFORE INSERT ON `Income_Details` FOR EACH ROW BEGIN
    
    SET NEW.Total_income = NEW.Salary_Income + NEW.Business_Income + NEW.Capital_Gain +
                           NEW.House_Property_Income + NEW.Agriculture_Income + NEW.Other_Income_Total;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`kiyohan`@`localhost`*/ /*!50003 TRIGGER `after_itr_insert` AFTER INSERT ON `Income_Details` FOR EACH ROW BEGIN
    
    CALL calculate_slabs_for_itr(NEW.Acknowledgement_Number);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Individual_Assessee`
--

DROP TABLE IF EXISTS `Individual_Assessee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Individual_Assessee` (
  `PAN` varchar(15) NOT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Middle_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `Residency_Status` varchar(20) DEFAULT NULL,
  `Aadhar_Number` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`PAN`),
  UNIQUE KEY `Aadhar_Number` (`Aadhar_Number`),
  CONSTRAINT `Individual_Assessee_ibfk_1` FOREIGN KEY (`PAN`) REFERENCES `Assessee` (`PAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Individual_Assessee`
--

LOCK TABLES `Individual_Assessee` WRITE;
/*!40000 ALTER TABLE `Individual_Assessee` DISABLE KEYS */;
INSERT INTO `Individual_Assessee` VALUES ('ABCDE1234F','John','Michael','Doe','1990-01-01','M','Resident','123456789012'),('FGHIJ5678K','Jane','Elizabeth','Smith','1985-05-10','F','Resident','234567890123');
/*!40000 ALTER TABLE `Individual_Assessee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Is_penaliser`
--

DROP TABLE IF EXISTS `Is_penaliser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Is_penaliser` (
  `Penalty` decimal(15,2) DEFAULT NULL,
  `PAN` varchar(15) NOT NULL,
  PRIMARY KEY (`PAN`),
  CONSTRAINT `Is_penaliser_ibfk_1` FOREIGN KEY (`PAN`) REFERENCES `ITR` (`PAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Is_penaliser`
--

LOCK TABLES `Is_penaliser` WRITE;
/*!40000 ALTER TABLE `Is_penaliser` DISABLE KEYS */;
INSERT INTO `Is_penaliser` VALUES (500.00,'ABCDE1234F');
/*!40000 ALTER TABLE `Is_penaliser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Non_Assessee_Bank_Details`
--

DROP TABLE IF EXISTS `Non_Assessee_Bank_Details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Non_Assessee_Bank_Details` (
  `Bank_Account_Number` varchar(20) NOT NULL,
  `PAN` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Bank_Account_Number`),
  KEY `PAN` (`PAN`),
  CONSTRAINT `Non_Assessee_Bank_Details_ibfk_1` FOREIGN KEY (`PAN`) REFERENCES `Non_Assessee_with_PAN` (`PAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Non_Assessee_Bank_Details`
--

LOCK TABLES `Non_Assessee_Bank_Details` WRITE;
/*!40000 ALTER TABLE `Non_Assessee_Bank_Details` DISABLE KEYS */;
INSERT INTO `Non_Assessee_Bank_Details` VALUES ('ACC123456','NONPAN1234'),('777788889999','NOPQR1234S');
/*!40000 ALTER TABLE `Non_Assessee_Bank_Details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Non_Assessee_with_PAN`
--

DROP TABLE IF EXISTS `Non_Assessee_with_PAN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Non_Assessee_with_PAN` (
  `PAN` varchar(15) NOT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Middle_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `DOB` date DEFAULT NULL,
  `Gender` char(1) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Contact_Number` varchar(15) DEFAULT NULL,
  `Residency_Status` varchar(20) DEFAULT NULL,
  `Aadhar_Number` varchar(12) DEFAULT NULL,
  `Is_tax_defaulter` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`PAN`),
  UNIQUE KEY `Aadhar_Number` (`Aadhar_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Non_Assessee_with_PAN`
--

LOCK TABLES `Non_Assessee_with_PAN` WRITE;
/*!40000 ALTER TABLE `Non_Assessee_with_PAN` DISABLE KEYS */;
INSERT INTO `Non_Assessee_with_PAN` VALUES ('NONPAN1234','John',NULL,'Doe',NULL,NULL,'123 Tax Lane','9876543210',NULL,NULL,1),('NOPQR1234S','David','Andrew','Brown','1980-12-20','M','789 Side Lane, City','6677889900','Resident','345678901234',0);
/*!40000 ALTER TABLE `Non_Assessee_with_PAN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Other_Income`
--

DROP TABLE IF EXISTS `Other_Income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Other_Income` (
  `Acknowledgement_Number` int NOT NULL,
  `Income_source` varchar(100) NOT NULL,
  PRIMARY KEY (`Acknowledgement_Number`,`Income_source`),
  CONSTRAINT `Other_Income_ibfk_1` FOREIGN KEY (`Acknowledgement_Number`) REFERENCES `Income_Details` (`Acknowledgement_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Other_Income`
--

LOCK TABLES `Other_Income` WRITE;
/*!40000 ALTER TABLE `Other_Income` DISABLE KEYS */;
/*!40000 ALTER TABLE `Other_Income` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Refund_details`
--

DROP TABLE IF EXISTS `Refund_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Refund_details` (
  `Acknowledgement_Number` int NOT NULL,
  `Refund_amount` decimal(15,2) DEFAULT NULL,
  `Refund_status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Acknowledgement_Number`),
  CONSTRAINT `Refund_details_ibfk_1` FOREIGN KEY (`Acknowledgement_Number`) REFERENCES `Tax_Verification` (`Acknowledgement_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Refund_details`
--

LOCK TABLES `Refund_details` WRITE;
/*!40000 ALTER TABLE `Refund_details` DISABLE KEYS */;
INSERT INTO `Refund_details` VALUES (3001,0.00,'No Refund');
/*!40000 ALTER TABLE `Refund_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sections`
--

DROP TABLE IF EXISTS `Sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Sections` (
  `Acknowledgement_Number` int NOT NULL,
  `Deduction_Type` varchar(50) NOT NULL,
  `Section_Code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Acknowledgement_Number`,`Deduction_Type`),
  KEY `Deduction_Type` (`Deduction_Type`),
  CONSTRAINT `Sections_ibfk_1` FOREIGN KEY (`Acknowledgement_Number`) REFERENCES `Deduction` (`Acknowledgement_Number`),
  CONSTRAINT `Sections_ibfk_2` FOREIGN KEY (`Deduction_Type`) REFERENCES `Deduction` (`Deduction_Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sections`
--

LOCK TABLES `Sections` WRITE;
/*!40000 ALTER TABLE `Sections` DISABLE KEYS */;
INSERT INTO `Sections` VALUES (3001,'80C','80C'),(3001,'80D','80D');
/*!40000 ALTER TABLE `Sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Slabs`
--

DROP TABLE IF EXISTS `Slabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Slabs` (
  `Slab_ID` int NOT NULL,
  `Minimum_Income` decimal(15,2) DEFAULT NULL,
  `Maximum_Income` decimal(15,2) DEFAULT NULL,
  `Tax_Rate` decimal(5,2) DEFAULT NULL,
  `CESS_Rate` decimal(5,2) DEFAULT NULL,
  `Effective_from` year DEFAULT NULL,
  `Effective_to` year DEFAULT NULL,
  PRIMARY KEY (`Slab_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Slabs`
--

LOCK TABLES `Slabs` WRITE;
/*!40000 ALTER TABLE `Slabs` DISABLE KEYS */;
INSERT INTO `Slabs` VALUES (1,0.00,250000.00,0.00,0.00,2022,2023),(2,250001.00,500000.00,5.00,4.00,2022,2023),(3,500001.00,1000000.00,10.00,4.00,2022,2023),(4,1000001.00,1500000.00,20.00,4.00,2022,2023);
/*!40000 ALTER TABLE `Slabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TCS`
--

DROP TABLE IF EXISTS `TCS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TCS` (
  `TCS_Certificate_Number` int NOT NULL,
  `PAN` varchar(15) DEFAULT NULL,
  `Seller_Name` varchar(255) DEFAULT NULL,
  `Seller_TAN` varchar(20) DEFAULT NULL,
  `TCS_Amount` decimal(15,2) DEFAULT NULL,
  `Date_of_Collection` date DEFAULT NULL,
  `Section_Code` varchar(10) DEFAULT NULL,
  `Start_Year` year DEFAULT NULL,
  `End_Year` year DEFAULT NULL,
  PRIMARY KEY (`TCS_Certificate_Number`),
  KEY `PAN` (`PAN`),
  CONSTRAINT `TCS_ibfk_1` FOREIGN KEY (`PAN`) REFERENCES `Assessee` (`PAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TCS`
--

LOCK TABLES `TCS` WRITE;
/*!40000 ALTER TABLE `TCS` DISABLE KEYS */;
INSERT INTO `TCS` VALUES (2001,'JKLMN9101P','Shop A','TAN002',200.00,'2022-06-20','206C',2022,2023);
/*!40000 ALTER TABLE `TCS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TDS`
--

DROP TABLE IF EXISTS `TDS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TDS` (
  `TDS_Certificate_Number` int NOT NULL,
  `PAN` varchar(15) DEFAULT NULL,
  `Deductor_Name` varchar(255) DEFAULT NULL,
  `Deductor_TAN` varchar(20) DEFAULT NULL,
  `Income_Type` varchar(50) DEFAULT NULL,
  `TDS_Amount` decimal(15,2) DEFAULT NULL,
  `Date_of_Deduction` date DEFAULT NULL,
  `Section_Code` varchar(10) DEFAULT NULL,
  `Start_Year` year DEFAULT NULL,
  `End_Year` year DEFAULT NULL,
  PRIMARY KEY (`TDS_Certificate_Number`),
  KEY `PAN` (`PAN`),
  CONSTRAINT `TDS_ibfk_1` FOREIGN KEY (`PAN`) REFERENCES `Assessee` (`PAN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TDS`
--

LOCK TABLES `TDS` WRITE;
/*!40000 ALTER TABLE `TDS` DISABLE KEYS */;
INSERT INTO `TDS` VALUES (1001,'ABCDE1234F','Corp A','TAN001','Salary',5000.00,'2022-06-15','192',2022,2023);
/*!40000 ALTER TABLE `TDS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tax_Verification`
--

DROP TABLE IF EXISTS `Tax_Verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Tax_Verification` (
  `Acknowledgement_Number` int NOT NULL,
  `Bank_Account_Number` varchar(20) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `Start_Year` year DEFAULT NULL,
  `Requested_Date` date DEFAULT NULL,
  `Processed_Date` date DEFAULT NULL,
  `Tax_Amount` decimal(15,2) DEFAULT NULL,
  `Tax_Paid` decimal(15,2) DEFAULT NULL,
  `IFSC_Code` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`Acknowledgement_Number`),
  KEY `Start_Year` (`Start_Year`),
  CONSTRAINT `Tax_Verification_ibfk_1` FOREIGN KEY (`Acknowledgement_Number`) REFERENCES `ITR` (`Acknowledgement_Number`),
  CONSTRAINT `Tax_Verification_ibfk_2` FOREIGN KEY (`Start_Year`) REFERENCES `Corresponding_year` (`Start_Year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tax_Verification`
--

LOCK TABLES `Tax_Verification` WRITE;
/*!40000 ALTER TABLE `Tax_Verification` DISABLE KEYS */;
INSERT INTO `Tax_Verification` VALUES (3001,'111122223333','Completed',2022,'2022-08-01','2022-08-05',105000.00,105000.00,'IFSC001');
/*!40000 ALTER TABLE `Tax_Verification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transactions_Involving_Assessee`
--

DROP TABLE IF EXISTS `Transactions_Involving_Assessee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transactions_Involving_Assessee` (
  `Transaction_Number` int NOT NULL,
  `Account_Number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Transaction_Number`),
  KEY `Account_Number` (`Account_Number`),
  CONSTRAINT `Transactions_Involving_Assessee_ibfk_1` FOREIGN KEY (`Transaction_Number`) REFERENCES `Bank_Transactions` (`Transaction_ID`),
  CONSTRAINT `Transactions_Involving_Assessee_ibfk_2` FOREIGN KEY (`Account_Number`) REFERENCES `Assessee_Bank_Details` (`Bank_Account_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transactions_Involving_Assessee`
--

LOCK TABLES `Transactions_Involving_Assessee` WRITE;
/*!40000 ALTER TABLE `Transactions_Involving_Assessee` DISABLE KEYS */;
INSERT INTO `Transactions_Involving_Assessee` VALUES (1,'111122223333'),(3,'444455556666');
/*!40000 ALTER TABLE `Transactions_Involving_Assessee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transactions_Involving_Non_Assessee`
--

DROP TABLE IF EXISTS `Transactions_Involving_Non_Assessee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transactions_Involving_Non_Assessee` (
  `Transaction_Number` int NOT NULL,
  `Bank_Account_Number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Transaction_Number`),
  KEY `Bank_Account_Number` (`Bank_Account_Number`),
  CONSTRAINT `Transactions_Involving_Non_Assessee_ibfk_1` FOREIGN KEY (`Transaction_Number`) REFERENCES `Bank_Transactions` (`Transaction_ID`),
  CONSTRAINT `Transactions_Involving_Non_Assessee_ibfk_2` FOREIGN KEY (`Bank_Account_Number`) REFERENCES `Non_Assessee_Bank_Details` (`Bank_Account_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transactions_Involving_Non_Assessee`
--

LOCK TABLES `Transactions_Involving_Non_Assessee` WRITE;
/*!40000 ALTER TABLE `Transactions_Involving_Non_Assessee` DISABLE KEYS */;
INSERT INTO `Transactions_Involving_Non_Assessee` VALUES (1,'777788889999'),(5,'ACC123456'),(6,'ACC123456'),(7,'ACC123456');
/*!40000 ALTER TABLE `Transactions_Involving_Non_Assessee` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`kiyohan`@`localhost`*/ /*!50003 TRIGGER `update_is_defaulter` AFTER INSERT ON `Transactions_Involving_Non_Assessee` FOR EACH ROW BEGIN
    
    DECLARE total_amount DECIMAL(15, 2);

    
    SELECT SUM(Bank_Transactions.Transaction_Amount) INTO total_amount
    FROM Bank_Transactions
    INNER JOIN Transactions_Involving_Non_Assessee
    ON Bank_Transactions.Transaction_ID = Transactions_Involving_Non_Assessee.Transaction_Number
    WHERE Transactions_Involving_Non_Assessee.Bank_Account_Number = NEW.Bank_Account_Number;

    
    IF total_amount > 10000 THEN
        
        UPDATE Non_Assessee_with_PAN
        SET Is_tax_defaulter = TRUE
        WHERE PAN = (SELECT PAN
                     FROM Non_Assessee_Bank_Details
                     WHERE Bank_Account_Number = NEW.Bank_Account_Number);
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-28 17:56:20
