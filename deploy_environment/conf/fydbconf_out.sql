-- MySQL dump 10.13  Distrib 5.6.16, for Linux (x86_64)
--
-- Host: localhost    Database: fydbconf
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
-- Table structure for table `t_channel_correlation`
--

DROP TABLE IF EXISTS `t_channel_correlation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_channel_correlation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `syncdirect` int(11) DEFAULT NULL,
  `proxyname` varchar(100) DEFAULT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_channel_correlation`
--

LOCK TABLES `t_channel_correlation` WRITE;
/*!40000 ALTER TABLE `t_channel_correlation` DISABLE KEYS */;
INSERT INTO `t_channel_correlation` VALUES ('11', '1', null, '10.255.255.225', '6000');
INSERT INTO `t_channel_correlation` VALUES ('16', '2', null, '10.255.255.234', '6000');
/*!40000 ALTER TABLE `t_channel_correlation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tchannelinfo`
--

DROP TABLE IF EXISTS `tchannelinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tchannelinfo` (
  `channelid` int(11) NOT NULL AUTO_INCREMENT,
  `channelname` varchar(32) NOT NULL,
  `outprotocoltype` int(11) NOT NULL,
  `inprotocoltype` int(11) NOT NULL,
  `outsideip` varchar(20) NOT NULL,
  `outsideport` int(11) NOT NULL,
  `outusername` varchar(32) NOT NULL,
  `outpasswd` varchar(48) NOT NULL,
  `outsidedir` varchar(100) NOT NULL,
  `nlowLimit` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `insideip` varchar(20) NOT NULL,
  `insidePort` int(11) NOT NULL,
  `inusername` varchar(32) NOT NULL,
  `inpasswd` varchar(48) NOT NULL,
  `insidedir` varchar(100) NOT NULL,
  `channelstatus` int(11) NOT NULL,
  `subdir` int(11) NOT NULL,
  `srcopertype` int(11) NOT NULL,
  `destopertype` int(11) NOT NULL,
  `postway` int(11) NOT NULL,
  `suffix` varchar(20) NOT NULL,
  `viruscheck` int(11) NOT NULL,
  `fileformat` int(11) NOT NULL,
  `allowformat` varchar(100) DEFAULT NULL,
  `forbitformat` varchar(100) DEFAULT NULL,
  `logtime` varchar(20) NOT NULL,
  `indirector` varchar(100) DEFAULT NULL,
  `syncdirect` int(11) DEFAULT NULL,
  `keywordfilter` int(11) DEFAULT NULL,
  `filetercontent` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`channelid`)
) ENGINE=MyISAM AUTO_INCREMENT=201 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tchannelinfo`
--

LOCK TABLES `tchannelinfo` WRITE;
/*!40000 ALTER TABLE `tchannelinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tchannelinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcsconfig`
--

DROP TABLE IF EXISTS `tcsconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tcsconfig` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channelname` varchar(32) NOT NULL,
  `listerip` varchar(20) NOT NULL,
  `listerport` int(11) NOT NULL,
  `ip` varchar(20) NOT NULL,
  `port` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `passwd` varchar(48) NOT NULL,
  `dir` varchar(640) NOT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=147 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcsconfig`
--

LOCK TABLES `tcsconfig` WRITE;
/*!40000 ALTER TABLE `tcsconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `tcsconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tfilecopyinfo`
--

DROP TABLE IF EXISTS `tfilecopyinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tfilecopyinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channelname` varchar(32) NOT NULL,
  `filename` varchar(400) NOT NULL,
  `filesize` bigint(20) NOT NULL,
  `filetime` varchar(20) NOT NULL,
  `type` char(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1161093 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tfilecopyinfo`
--

LOCK TABLES `tfilecopyinfo` WRITE;
/*!40000 ALTER TABLE `tfilecopyinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfilecopyinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tfiletransuser`
--

DROP TABLE IF EXISTS `tfiletransuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tfiletransuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(48) NOT NULL,
  `transtype` char(10) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tfiletransuser`
--

LOCK TABLES `tfiletransuser` WRITE;
/*!40000 ALTER TABLE `tfiletransuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfiletransuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tfiletypemag`
--

DROP TABLE IF EXISTS `tfiletypemag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tfiletypemag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `name` varchar(400) NOT NULL,
  `uuid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wai_tfiletypepaper` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tfiletypemag`
--

LOCK TABLES `tfiletypemag` WRITE;
/*!40000 ALTER TABLE `tfiletypemag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfiletypemag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tfiletypepaper`
--

DROP TABLE IF EXISTS `tfiletypepaper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tfiletypepaper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tfiletypepaper`
--

LOCK TABLES `tfiletypepaper` WRITE;
/*!40000 ALTER TABLE `tfiletypepaper` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfiletypepaper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tfileupload`
--

DROP TABLE IF EXISTS `tfileupload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tfileupload` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` varchar(400) DEFAULT NULL,
  `src` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tfileupload`
--

LOCK TABLES `tfileupload` WRITE;
/*!40000 ALTER TABLE `tfileupload` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfileupload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tsysconfig`
--

DROP TABLE IF EXISTS `tsysconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tsysconfig` (
  `systype` varchar(50) NOT NULL,
  `sysname` varchar(50) NOT NULL,
  `sysvalue` varchar(50) DEFAULT NULL,
  `sysdesc` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`systype`,`sysname`)
) ENGINE=MyISAM DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tsysconfig`
--

LOCK TABLES `tsysconfig` WRITE;
/*!40000 ALTER TABLE `tsysconfig` DISABLE KEYS */;
INSERT INTO `tsysconfig` VALUES ('fychmanager','port','6001','调度主进程监听端口'),('fyftpmanager','port','6002','FTP业务管理主进程监听端口'),('fyflowcontrol','port','6003','流控进程监听端口'),('ferryway','ip','127.0.0.1','本机监听IP'),('fiber','ip','10.10.13.223','光纤目标端IP'),('device','device_flag','1','1-外端机，2-内端机'),('device','device_name','sender','外端机'),('flowcontrol','flowlimit','100','流控大小'),('flowcontrol','unit','2','流控单位1-Kb，2-Mb，3-Gb'),('senderclient','ip','192.168.0.189','服务发送端IP'),('senderclient','port','6001','服务发送端port'),('thread','number','1','工作线程数'),('fystreamanager','port','6004','stream业务管理主进程监听端口'),('fyftpserver','port','21','ftpserver监听端口'),('managerip','ip','192.168.50.99','管理口IP'),('businessip','ip','192.168.50.99','业务口IP'),('channelip','ip','127.0.0.1','通道IP'),('fycustproto','port','6005','自定义协议通道管理主进程监听端口'),('islongorshortconnect','flag','2','1-长连接；2-短连接'),('ferryway','ethname','eth7','单向网卡名称'),('ferryway','maxtasknum','15','最大通道数'),('ferryway','maxtime','120','超时时间，单位秒'),('fyflowcontrol','toport','6000','数据交换端口'),('ferryway','runmode','1','1-单向；2-双向'),('fysmbmanager','port','6006','smb进程监听端口'),('fynfsmanager','port','6007','nfs进程监听端口'),('ftpconnect','number','1000','ftp连接数'),('ftpclientsendtimeout','timeout','120','ftpclient发送数据超时（秒）'),('fyflowcontrol','sendtoport','6000','数据交换端口'),('datarestore','flag','0','1-yes;0-no'),('needsyncing','flag','0','1-yes;0-no'),('hoststand','ishostflag','0','1-on;0-off'),('hoststand','masterflag','1','1-master;2-slave'),('hoststand','ip','127.0.0.1','ip'),('hoststand','port','6008','port'),('filecheck','flag','0','1-on;0-off'),('diskLog','setPercent','90','日志磁盘使用告警阈值(%)'),('fysftpmanager','port','6010','fysftpmanager port'),('writetolocal','flag','0','1-yes;0-no');
/*!40000 ALTER TABLE `tsysconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ttaskprocinfo`
--

DROP TABLE IF EXISTS `ttaskprocinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ttaskprocinfo` (
  `channelname` varchar(32) NOT NULL,
  `procname` varchar(20) NOT NULL,
  `username` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ttaskprocinfo`
--

LOCK TABLES `ttaskprocinfo` WRITE;
/*!40000 ALTER TABLE `ttaskprocinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ttaskprocinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tearwaring`
--

DROP TABLE IF EXISTS `tearwaring`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tearwaring` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isOnFlag` char(10) DEFAULT NULL,
  `DtimeInter` char(10) DEFAULT NULL,
  `Fmail` varchar(30) DEFAULT NULL,
  `Pass` varchar(30) DEFAULT NULL,
  `Emaiserver` varchar(64) DEFAULT NULL,
  `TEmail` varchar(30) DEFAULT NULL,
  `warvalue` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tearwaring`
--

LOCK TABLES `tearwaring` WRITE;
/*!40000 ALTER TABLE `tearwaring` DISABLE KEYS */;
/*!40000 ALTER TABLE `tearwaring` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `tsshkeys`
--

DROP TABLE IF EXISTS `tsshkeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tsshkeys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) DEFAULT NULL,
  `pubkeys` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tsshkeys`
--

LOCK TABLES `tsshkeys` WRITE;
/*!40000 ALTER TABLE `tsshkeys` DISABLE KEYS */;
/*!40000 ALTER TABLE `tsshkeys` ENABLE KEYS */;
UNLOCK TABLES;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-16 11:41:02
