-- MySQL dump 10.14  Distrib 5.5.44-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: audit
-- ------------------------------------------------------
-- Server version	5.5.44-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accessory`
--

DROP TABLE IF EXISTS `accessory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accessory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `svr_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accessory`
--

LOCK TABLES `accessory` WRITE;
/*!40000 ALTER TABLE `accessory` DISABLE KEYS */;
/*!40000 ALTER TABLE `accessory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `clientip` varchar(255) DEFAULT NULL,
  `eventtype` int(11) DEFAULT NULL,
  `eventcontent` varchar(255) DEFAULT NULL,
  `eventresult` int(11) DEFAULT NULL,
  `generator` int(11) DEFAULT NULL,
  `eventdate` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2225 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `desc` varchar(255) DEFAULT NULL,
  `director` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan`
--

DROP TABLE IF EXISTS `plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_num` varchar(255) DEFAULT NULL,
  `plan_title` varchar(255) DEFAULT NULL,
  `project_name` varchar(255) DEFAULT NULL,
  `plan_desc` varchar(255) DEFAULT NULL,
  `plan_analy` varchar(255) DEFAULT NULL,
  `plan_category` int(11) DEFAULT NULL,
  `plan_level` int(11) DEFAULT NULL,
  `plan_state` int(11) DEFAULT NULL,
  `expect_dt` varchar(255) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `create_dt` date DEFAULT NULL,
  `regenerator` int(11) DEFAULT NULL,
  `update_dt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan`
--

LOCK TABLES `plan` WRITE;
/*!40000 ALTER TABLE `plan` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_deal`
--

DROP TABLE IF EXISTS `plan_deal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_deal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) DEFAULT NULL,
  `deal_style` int(11) DEFAULT NULL,
  `executant` int(11) DEFAULT NULL,
  `deal_dt` date DEFAULT NULL,
  `deal_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7D4ABBC2D7BF34B2` (`plan_id`),
  KEY `FK_rcpuvy6ldy058o5rn6sa8wnak` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_deal`
--

LOCK TABLES `plan_deal` WRITE;
/*!40000 ALTER TABLE `plan_deal` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_deal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `popedom`
--

DROP TABLE IF EXISTS `popedom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `popedom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `popedom`
--

LOCK TABLES `popedom` WRITE;
/*!40000 ALTER TABLE `popedom` DISABLE KEYS */;
/*!40000 ALTER TABLE `popedom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_num` varchar(255) DEFAULT NULL,
  `task_title` varchar(255) DEFAULT NULL,
  `plan_id` int(11) DEFAULT NULL,
  `executant` int(11) DEFAULT NULL,
  `task_desc` varchar(255) DEFAULT NULL,
  `task_level` int(11) DEFAULT NULL,
  `task_state` int(11) DEFAULT NULL,
  `expect_dt` varchar(255) DEFAULT NULL,
  `intend_hour` int(11) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `create_dt` datetime DEFAULT NULL,
  `regenerator` int(11) DEFAULT NULL,
  `update_dt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task_deal`
--

DROP TABLE IF EXISTS `task_deal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task_deal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) DEFAULT NULL,
  `executant` int(11) DEFAULT NULL,
  `deal_dt` datetime DEFAULT NULL,
  `deal_style` int(11) DEFAULT NULL,
  `deal_desc` varchar(255) DEFAULT NULL,
  `fact_hour` int(11) DEFAULT NULL,
  `auditing_score` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKAC12AE69990C732` (`task_id`),
  KEY `FK_obd1ysa6irklqqnp74ho7l8us` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task_deal`
--

LOCK TABLES `task_deal` WRITE;
/*!40000 ALTER TABLE `task_deal` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_deal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `creator` int(11) DEFAULT NULL,
  `created_dt` varchar(255) DEFAULT NULL,
  `regenerator` int(11) DEFAULT NULL,
  `updated_dt` varchar(255) DEFAULT NULL,
  `department` int(11) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK36EBCBF44F743C` (`department`),
  KEY `FK36EBCB584119E8` (`status`),
  KEY `FK_su93soui1ledea731cucockr8` (`status`),
  KEY `FK_aht1eu3cyg114yvueeegg0gy4` (`department`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-05 16:58:13
