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
/*!40000 ALTER TABLE `t_channel_correlation` DISABLE KEYS */;
INSERT INTO `t_channel_correlation` VALUES ('11', '1', null, '10.255.255.225', '6000');
INSERT INTO `t_channel_correlation` VALUES ('16', '2', null, '10.255.255.234', '6000');
/*!40000 ALTER TABLE `t_channel_correlation` ENABLE KEYS */;

--
-- Table structure for table `tchannelinfo`
--
/*!40000 ALTER TABLE `tchannelinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tchannelinfo` ENABLE KEYS */;

--
-- Table structure for table `tcsconfig`
--
/*!40000 ALTER TABLE `tcsconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `tcsconfig` ENABLE KEYS */;

--
-- Table structure for table `tfilecopyinfo`
--
/*!40000 ALTER TABLE `tfilecopyinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfilecopyinfo` ENABLE KEYS */;

--
-- Table structure for table `tfiletransuser`
--
/*!40000 ALTER TABLE `tfiletransuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfiletransuser` ENABLE KEYS */;

--
-- Table structure for table `tfiletypemag`
--
/*!40000 ALTER TABLE `tfiletypemag` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfiletypemag` ENABLE KEYS */;

--
-- Table structure for table `tfiletypepaper`
--
/*!40000 ALTER TABLE `tfiletypepaper` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfiletypepaper` ENABLE KEYS */;

--
-- Table structure for table `tfileupload`
--
/*!40000 ALTER TABLE `tfileupload` DISABLE KEYS */;
/*!40000 ALTER TABLE `tfileupload` ENABLE KEYS */;

--
-- Table structure for table `tsysconfig`
--
/*!40000 ALTER TABLE `tsysconfig` DISABLE KEYS */;
INSERT INTO `tsysconfig` VALUES ('fychmanager','port','6001','调度主进程监听端口'),('fyftpmanager','port','6002','FTP业务管理主进程监听端口'),('fyflowcontrol','port','6003','流控进程监听端口'),('ferryway','ip','127.0.0.1','本机监听IP'),('fiber','ip','10.10.13.223','光纤目标端IP'),('device','device_flag','1','1-外端机，2-内端机'),('device','device_name','sender','外端机'),('flowcontrol','flowlimit','100','流控大小'),('flowcontrol','unit','2','流控单位1-Kb，2-Mb，3-Gb'),('senderclient','ip','192.168.0.189','服务发送端IP'),('senderclient','port','6001','服务发送端port'),('thread','number','1','工作线程数'),('fystreamanager','port','6004','stream业务管理主进程监听端口'),('fyftpserver','port','21','ftpserver监听端口'),('managerip','ip','192.168.50.99','管理口IP'),('businessip','ip','192.168.50.99','业务口IP'),('channelip','ip','127.0.0.1','通道IP'),('fycustproto','port','6005','自定义协议通道管理主进程监听端口'),('islongorshortconnect','flag','1','1-长连接；2-短连接'),('ferryway','ethname','eth7','单向网卡名称'),('ferryway','maxtasknum','15','最大通道数'),('ferryway','maxtime','120','超时时间，单位秒'),('fyflowcontrol','toport','6000','数据交换端口'),('ferryway','runmode','1','1-单向；2-双向'),('fysmbmanager','port','6006','smb进程监听端口'),('fynfsmanager','port','6007','nfs进程监听端口'),('ftpconnect','number','1000','ftp连接数'),('ftpclientsendtimeout','timeout','120','ftpclient发送数据超时（秒）'),('fyflowcontrol','sendtoport','6000','数据交换端口'),('datarestore','flag','0','1-yes;0-no'),('needsyncing','flag','0','1-yes;0-no'),('hoststand','ishostflag','0','1-on;0-off'),('hoststand','masterflag','1','1-master;2-slave'),('hoststand','ip','127.0.0.1','ip'),('hoststand','port','6008','port'),('filecheck','flag','0','1-on;0-off'),('diskLog','setPercent','90','日志磁盘使用告警阈值(%)'),('fysftpmanager','port','6010','fysftpmanager port'),('writetolocal','flag','0','1-yes;0-no');
/*!40000 ALTER TABLE `tsysconfig` ENABLE KEYS */;

--
-- Table structure for table `ttaskprocinfo`
--
/*!40000 ALTER TABLE `ttaskprocinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ttaskprocinfo` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-16 11:41:02
