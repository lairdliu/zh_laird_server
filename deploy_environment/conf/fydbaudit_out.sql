-- MySQL dump 10.13  Distrib 5.6.16, for Linux (x86_64)
--
-- Host: localhost    Database: fydbaudit
-- ------------------------------------------------------
-- Server version	5.6.16

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
-- Table structure for table `tftpfilelog`
--

DROP TABLE IF EXISTS `tftpfilelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tftpfilelog` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `channelname` varchar(32) NOT NULL,
  `srcip` varchar(20) NOT NULL,
  `destip` varchar(20) NOT NULL,
  `starttime` varchar(20) NOT NULL,
  `endtime` varchar(20) NOT NULL,
  `filename` varchar(600) NOT NULL,
  `filesize` bigint(20) NOT NULL,
  `result` varchar(500) NOT NULL,
  `rescode` varchar(20) NOT NULL,
  PRIMARY KEY (`logid`),
  KEY `channel` (`channelname`,`srcip`,`destip`,`starttime`,`endtime`,`rescode`) USING BTREE,
  KEY `file` (`filename`(500)) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=11783096 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tftpfilelog`
--

LOCK TABLES `tftpfilelog` WRITE;
/*!40000 ALTER TABLE `tftpfilelog` DISABLE KEYS */;
/*!40000 ALTER TABLE `tftpfilelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `toperationlog`
--

DROP TABLE IF EXISTS `toperationlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `toperationlog` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `logname` varchar(20) NOT NULL,
  `eventtype` varchar(20) NOT NULL,
  `content` varchar(100) NOT NULL,
  `result` varchar(20) NOT NULL,
  `logtime` varchar(20) NOT NULL,
  PRIMARY KEY (`logid`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `toperationlog`
--

LOCK TABLES `toperationlog` WRITE;
/*!40000 ALTER TABLE `toperationlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `toperationlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `twarninglog`
--

DROP TABLE IF EXISTS `twarninglog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twarninglog` (
  `logid` int(11) NOT NULL AUTO_INCREMENT,
  `eventtype` varchar(32) NOT NULL,
  `content` varchar(200) NOT NULL,
  `logtime` varchar(20) NOT NULL,
  PRIMARY KEY (`logid`)
) ENGINE=MyISAM AUTO_INCREMENT=163324 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `twarninglog`
--

LOCK TABLES `twarninglog` WRITE;
/*!40000 ALTER TABLE `twarninglog` DISABLE KEYS */;
/*!40000 ALTER TABLE `twarninglog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-14 12:36:12
