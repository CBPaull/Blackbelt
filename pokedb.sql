-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: pokedb
-- ------------------------------------------------------
-- Server version	5.5.42

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
-- Table structure for table `pokes`
--

DROP TABLE IF EXISTS `pokes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pokes` (
  `target_id` int(11) NOT NULL,
  `poker_id` int(11) NOT NULL,
  `poker_name` varchar(45) DEFAULT NULL,
  KEY `fk_pokes_users_idx` (`target_id`),
  KEY `fk_pokes_users1_idx` (`poker_id`),
  CONSTRAINT `fk_pokes_users` FOREIGN KEY (`target_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokes_users1` FOREIGN KEY (`poker_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pokes`
--

LOCK TABLES `pokes` WRITE;
/*!40000 ALTER TABLE `pokes` DISABLE KEYS */;
INSERT INTO `pokes` VALUES (6,7,'Bug'),(7,7,'Bug'),(6,7,'Bug'),(7,7,'Bug'),(6,7,'Bug'),(7,7,'Bug'),(6,6,'test'),(6,6,'test'),(7,6,'test'),(7,6,'test'),(7,6,'test'),(6,6,'test'),(6,8,'Jimmy'),(7,8,'Jimmy'),(6,8,'Jimmy'),(8,8,'Jimmy'),(8,8,'Jimmy');
/*!40000 ALTER TABLE `pokes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `alias` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `pw_hash` varchar(500) DEFAULT NULL,
  `dateofbirth` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (6,'Test user','test','testbug@gmail.com','$2b$12$vFJsZhjr5UdkXediNVoEIeojRgk92wbL.CR7AU.wsObgC1Y3zM1EO','1997-09-09 00:00:00','2016-06-24 11:20:57','2016-06-24 11:20:57'),(7,'Test 2','Bug','email@email.com','$2b$12$N6MqHpyBB77ccMWwt6ZD9OmEPE4C9aqFtdhIxV5/EYMeEiJrNZBMq','1976-08-08 00:00:00','2016-06-24 11:21:46','2016-06-24 11:21:46'),(8,'Test 3','Jimmy','cbpaull@gmail.com','$2b$12$cl6VsAr5PtCg9mfNlPv2g.FrijK6HvrkrojT.UldQkSvqLucbS.nu','1987-07-07 00:00:00','2016-06-24 11:35:09','2016-06-24 11:35:09');
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

-- Dump completed on 2016-06-24 11:54:26
