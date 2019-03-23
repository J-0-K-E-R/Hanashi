-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: hanashi
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.10.2

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
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followers` (
  `Username1` varchar(16) COLLATE utf8_bin NOT NULL,
  `Username2` varchar(16) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`Username1`,`Username2`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers`
--

LOCK TABLES `followers` WRITE;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` VALUES ('test','Admin'),('test2','Admin'),('test2','test'),('test2','test5');
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `threads`
--

DROP TABLE IF EXISTS `threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `threads` (
  `Thread_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(8000) NOT NULL,
  `Post` text NOT NULL,
  `Tags_List` varchar(8000) DEFAULT NULL,
  `Username` varchar(16) NOT NULL,
  `Votes` int(11) NOT NULL DEFAULT '0',
  `Timestamp_Created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Timestamp_Modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Thread_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `threads`
--

LOCK TABLES `threads` WRITE;
/*!40000 ALTER TABLE `threads` DISABLE KEYS */;
INSERT INTO `threads` VALUES (1,'Yes!!! You did it!! ','<p>The content doesn\'t matter either</p>','The,tags,don\'t,really,matter','test',0,'2019-03-23 08:46:08','2019-03-23 08:46:08');
/*!40000 ALTER TABLE `threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Username` varchar(16) COLLATE utf8_bin NOT NULL,
  `Password` varchar(64) COLLATE utf8_bin NOT NULL,
  `Email` varchar(50) COLLATE utf8_bin NOT NULL,
  `FollowersCount` int(10) NOT NULL DEFAULT '0',
  `FollowingCount` int(10) NOT NULL DEFAULT '0',
  `FollowingTagsCount` int(10) NOT NULL DEFAULT '0',
  `Points` int(10) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email_index` (`Email`),
  UNIQUE KEY `username_index` (`Username`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','fx7DIUfWYgKzLEsztpT7OUzGzZu8G25r4V6y0AijHr4=','hanashiteam@gmail.com',2,0,0,-1),(2,'test','n4bQgYhMfWWaL+qgxVrQFaO/TxsrC4Is0V1sFbDwCgg=','testemail',1,1,0,1),(3,'test2','YDA64iuZiGG847KPM+7BvnWKITyGyTwHbb6fVYwRx1I=','test2email',0,3,0,1),(4,'test3','/WGgOvT3fYcPwh4F5+gGeAlcktgIz7O1wnnuBMdKyhM=','test3email',0,0,0,1),(5,'test4','pOYk1obgPtJ2fAq9hcFEJrCxFX0s6B0nu0/k9vAdaIo=','test4email',0,0,0,1),(6,'test5','oUDAwe2i3vK4MDY7o2KqTX0lXCYpYFRIIfVW4WZhtv8=','test5email',1,0,0,1),(7,'test8','H5v+sV/uihDE0HEcfrDAg5YhI+GRjkYbalCOcUbBibI=','test8email@somo.com',0,0,0,1),(8,'test9','tEUQNNO2WQBgzpSEoouI3TMqgKIq6OOcnFy3NXqybJ8=','test9@something.com',0,0,0,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-23 14:18:16
