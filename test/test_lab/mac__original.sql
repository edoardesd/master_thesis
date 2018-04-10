-- MySQL dump 10.13  Distrib 5.7.18, for macos10.12 (x86_64)
--
-- Host: localhost    Database: lab_dataset
-- ------------------------------------------------------
-- Server version	5.7.18

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
-- Table structure for table `bluetooth_dataset_lab_pos1`
--

DROP TABLE IF EXISTS `bluetooth_dataset_lab_pos1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bluetooth_dataset_lab_pos1` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bluetooth_dataset_lab_pos1`
--

LOCK TABLES `bluetooth_dataset_lab_pos1` WRITE;
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos1` DISABLE KEYS */;
INSERT INTO `bluetooth_dataset_lab_pos1` VALUES (-9.3253,-14.4062,-11.0769,-14.5714,-13.78,-12.7451,'88:C9:D0:1F:3E:48',1,'lg'),(0.120321,-7.96743,-4.72973,-13.6592,-6.61812,-9.52903,'C8:14:79:31:3C:29',1,'s3'),(-3.53165,-9.68639,0,-14.8051,-7.10239,-4.58242,'D8:90:E8:29:AD:3E',1,'sams'),(-0.90566,-3.52601,-5.2291,-12.8412,-5.39819,-6.16327,'DC:A9:04:4F:D9:36',1,'ipad');
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bluetooth_dataset_lab_pos10`
--

DROP TABLE IF EXISTS `bluetooth_dataset_lab_pos10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bluetooth_dataset_lab_pos10` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bluetooth_dataset_lab_pos10`
--

LOCK TABLES `bluetooth_dataset_lab_pos10` WRITE;
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos10` DISABLE KEYS */;
INSERT INTO `bluetooth_dataset_lab_pos10` VALUES (-6.71429,-10.8272,-9.51575,-8.07812,-4.79325,-2.67442,'D8:90:E8:29:AD:3E',10,'sams');
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos10` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bluetooth_dataset_lab_pos11`
--

DROP TABLE IF EXISTS `bluetooth_dataset_lab_pos11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bluetooth_dataset_lab_pos11` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bluetooth_dataset_lab_pos11`
--

LOCK TABLES `bluetooth_dataset_lab_pos11` WRITE;
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos11` DISABLE KEYS */;
INSERT INTO `bluetooth_dataset_lab_pos11` VALUES (-10.2328,-10.9957,2.00377,-14.7671,-10.75,-16.3661,'D8:90:E8:29:AD:3E',11,'sams');
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos11` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bluetooth_dataset_lab_pos2`
--

DROP TABLE IF EXISTS `bluetooth_dataset_lab_pos2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bluetooth_dataset_lab_pos2` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bluetooth_dataset_lab_pos2`
--

LOCK TABLES `bluetooth_dataset_lab_pos2` WRITE;
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos2` DISABLE KEYS */;
INSERT INTO `bluetooth_dataset_lab_pos2` VALUES (-12.1553,-5.41126,-2.35484,-0.212389,-9.96667,-5.59091,'C8:14:79:31:3C:29',2,'s3'),(-16.0145,-13.5588,-9.70588,-8.84163,-0.158163,-3.52558,'D8:90:E8:29:AD:3E',2,'sams'),(0.729614,-3.9777,-5.48227,-7.13924,-3.21495,-2.808,'DC:A9:04:4F:D9:36',2,'ipad');
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bluetooth_dataset_lab_pos3`
--

DROP TABLE IF EXISTS `bluetooth_dataset_lab_pos3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bluetooth_dataset_lab_pos3` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bluetooth_dataset_lab_pos3`
--

LOCK TABLES `bluetooth_dataset_lab_pos3` WRITE;
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos3` DISABLE KEYS */;
INSERT INTO `bluetooth_dataset_lab_pos3` VALUES (-6.24752,-10.0864,-4.3125,-0.624413,-8.45122,-9.22564,'C8:14:79:31:3C:29',3,'s3'),(-4.62712,0.0436508,-16.7258,-7.83696,-15.0884,-15.6777,'D8:90:E8:29:AD:3E',3,'sams'),(-0.754545,-10.6242,-8.38378,-11.4217,-10.8817,-10.5398,'DC:A9:04:4F:D9:36',3,'ipad');
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bluetooth_dataset_lab_pos4`
--

DROP TABLE IF EXISTS `bluetooth_dataset_lab_pos4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bluetooth_dataset_lab_pos4` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bluetooth_dataset_lab_pos4`
--

LOCK TABLES `bluetooth_dataset_lab_pos4` WRITE;
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos4` DISABLE KEYS */;
INSERT INTO `bluetooth_dataset_lab_pos4` VALUES (1.14655,-12.5097,-2.22,-9.28922,-11.109,-8.28,'C8:14:79:31:3C:29',4,'s3'),(-8.38579,-9.37766,-7.07955,-12.1875,-1.57576,-0.0892857,'D8:90:E8:29:AD:3E',4,'sams'),(-0.0308642,-8.64141,-5.47368,-7.57368,-5.3949,-2.19412,'DC:A9:04:4F:D9:36',4,'ipad');
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bluetooth_dataset_lab_pos5`
--

DROP TABLE IF EXISTS `bluetooth_dataset_lab_pos5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bluetooth_dataset_lab_pos5` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bluetooth_dataset_lab_pos5`
--

LOCK TABLES `bluetooth_dataset_lab_pos5` WRITE;
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos5` DISABLE KEYS */;
INSERT INTO `bluetooth_dataset_lab_pos5` VALUES (0,-22.7391,-11.5075,-19.4154,-15.4615,-10.875,'88:C9:D0:1F:3E:48',5,'lg'),(1.71429,-17.1895,-5.25316,-11.9697,-10.9231,-10.3021,'C8:14:79:31:3C:29',5,'s3'),(-13.8688,-14.7143,2.94191,-13.6818,-6.76142,-17.3758,'D8:90:E8:29:AD:3E',5,'sams'),(0.0857143,-5.1588,-5.58537,-10.4542,-10.6847,-7.27004,'DC:A9:04:4F:D9:36',5,'ipad');
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bluetooth_dataset_lab_pos9`
--

DROP TABLE IF EXISTS `bluetooth_dataset_lab_pos9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bluetooth_dataset_lab_pos9` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bluetooth_dataset_lab_pos9`
--

LOCK TABLES `bluetooth_dataset_lab_pos9` WRITE;
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos9` DISABLE KEYS */;
INSERT INTO `bluetooth_dataset_lab_pos9` VALUES (-7.03704,0,-10.8842,-4.99692,-12.1675,-18.7933,'D8:90:E8:29:AD:3E',9,'sams'),(-11.9543,-9.04486,-8.91138,-11.8352,-17.5919,-20.6146,'E0:AC:CB:70:B1:21',9,'elisabetta');
/*!40000 ALTER TABLE `bluetooth_dataset_lab_pos9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_lab_pos1`
--

DROP TABLE IF EXISTS `dataset_lab_pos1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_lab_pos1` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_lab_pos1`
--

LOCK TABLES `dataset_lab_pos1` WRITE;
/*!40000 ALTER TABLE `dataset_lab_pos1` DISABLE KEYS */;
INSERT INTO `dataset_lab_pos1` VALUES (-62.7429,-58.6346,-45.8778,-65.381,-46.315,-52.2093,'14:2D:27:E9:D7:67',1,NULL),(-66.5769,-66.9808,-76.7143,-78.35,-75,-80.6,'28:56:5A:A0:47:E9',1,NULL),(-53.8276,-53.9615,-53,-45.7049,-59.8,-58.5,'30:10:B3:3F:E3:7D',1,NULL),(-51.7563,-42.2796,-46.6454,-53.9889,-55.1295,-55.7576,'34:23:87:03:78:B9',1,NULL),(-60.5408,-44.2746,-61.4531,-63.55,-70.7578,-67,'40:40:A7:AE:DE:17',1,NULL),(-61.2115,-56.3772,-60.2846,-56.9534,-52.8749,-47.8223,'54:26:96:DB:9C:25',1,NULL),(-47.8961,-51.2121,-49.4412,-60.1252,-60.5218,-61.9048,'68:76:4F:FC:28:68',1,NULL),(-56.5687,-58.7401,-66.2685,-71.6954,-71.3506,-69.25,'6E:8C:01:39:FD:3F',1,NULL),(-41.2396,-55.4836,-53.4628,-66.5161,-66.9948,-68.2755,'98:01:A7:B6:B2:BD',1,NULL),(-55.75,-40.5398,-60.9802,-62.1901,-62.4403,-69.1967,'9C:B6:D0:D6:7F:81',1,NULL),(-68.6429,-61,-60.6145,-62.5039,-64.886,-57.938,'A0:8D:16:33:54:DE',1,NULL),(-60.0333,-59.044,-53.0722,-62.1373,-48.1684,-50.4595,'A8:BB:CF:01:C6:0C',1,NULL),(-57.4038,-48.9897,-46.5313,-51.6485,-47.5863,-57.9223,'A8:C8:3A:07:88:9F',1,NULL),(-49.9623,-50.6661,-47.3765,-64.7623,-62.9795,-61.3909,'AC:72:89:1C:16:F0',1,NULL),(-72,-63.6667,-69.72,-66.7547,-64.08,-62.6571,'BC:F5:AC:F8:73:69',1,NULL),(-58.3445,-59.5366,-68.75,-67.027,-59.6122,-61.9459,'C4:43:8F:B3:0A:F7',1,'lg'),(-47.2104,-55.9865,-46.1392,-57.8692,-57.427,-58.6145,'D8:90:E8:29:AD:3F',1,'sams'),(-59.087,-50.412,-56.8406,-60.6776,-67.3787,-68.7355,'F0:25:B7:D0:2E:97',1,NULL),(-40.3274,-44.952,-48.2355,-53.6089,-62.1615,-52.3333,'F4:E3:FB:85:66:D8',1,'huawei');
/*!40000 ALTER TABLE `dataset_lab_pos1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_lab_pos10`
--

DROP TABLE IF EXISTS `dataset_lab_pos10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_lab_pos10` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_lab_pos10`
--

LOCK TABLES `dataset_lab_pos10` WRITE;
/*!40000 ALTER TABLE `dataset_lab_pos10` DISABLE KEYS */;
INSERT INTO `dataset_lab_pos10` VALUES (-56.0298,-48.2803,-54.7752,-55.8322,-59.3276,-49.2286,'34:23:87:03:78:B9',10,NULL),(-69.5768,-46.051,-62.9737,-59.227,-68.3837,-63.6984,'40:40:A7:AE:DE:17',10,NULL),(-67.7927,-58.3481,-61.4686,-62.1321,-55.4024,-51.9312,'4C:8D:79:E3:51:6C',10,NULL),(-73.0944,-55.5296,-59.8376,-53.0828,-61.5267,-51.75,'54:26:96:DB:9C:25',10,NULL),(-64.4493,-51.2294,-55.141,-54.9318,-49.9568,-57.6226,'60:67:20:C9:93:28',10,NULL),(-60.5451,-51.1605,-54.6822,-60.1597,-64.0523,-57.5476,'68:76:4F:FC:28:68',10,NULL),(-60.3155,-57.5267,-65.1599,-68.0537,-72.259,-65.75,'6E:8C:01:39:FD:3F',10,NULL),(-69.7904,-64.4435,-52.6302,-63.7212,-53.7532,-64.6452,'74:DF:BF:30:AC:49',10,NULL),(-44.4412,-55.1536,-57.7271,-58.7593,-63.3937,-62.4207,'98:01:A7:B6:B2:BD',10,NULL),(-68.5385,-55.6667,-62.1053,-59.3158,-57.8182,-47.4902,'A0:8D:16:33:54:DE',10,NULL),(-63.9924,-62.8654,-49.033,-55.9273,-45.9319,-63.4583,'A8:C8:3A:07:88:9F',10,NULL),(-49.0843,-53.7533,-48.6138,-60.8614,-55.5261,-59.8182,'AC:72:89:1C:16:F0',10,NULL),(-69.037,-62.4348,-67,-62.375,-72.2857,-77,'D0:13:FD:64:B7:2F',10,NULL),(-58.2035,-55.6772,-56.9581,-57.4491,-54.7916,-53.8082,'D8:90:E8:29:AD:3F',10,'sams');
/*!40000 ALTER TABLE `dataset_lab_pos10` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_lab_pos11`
--

DROP TABLE IF EXISTS `dataset_lab_pos11`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_lab_pos11` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_lab_pos11`
--

LOCK TABLES `dataset_lab_pos11` WRITE;
/*!40000 ALTER TABLE `dataset_lab_pos11` DISABLE KEYS */;
INSERT INTO `dataset_lab_pos11` VALUES (-74.4286,-63.8571,-72.2778,-74.1429,-76.2778,-84.5556,'28:56:5A:A0:47:E9',11,NULL),(-55.4889,-48.088,-51.269,-51.0682,-56.2069,-56.3548,'34:23:87:03:78:B9',11,NULL),(-63.0807,-37.2388,-61.063,-60.1689,-62.5223,-55.7857,'40:40:A7:AE:DE:17',11,NULL),(-74.2294,-65.902,-60.4924,-66.1709,-55.443,-64.56,'4C:8D:79:E3:51:6C',11,NULL),(-69.7059,-55.6949,-59.6612,-53.8954,-57.4354,-43.5536,'54:26:96:DB:9C:25',11,NULL),(-65.8939,-52.898,-56.5833,-56.5258,-49.7708,-53.6923,'60:67:20:C9:93:28',11,NULL),(-62.4068,-52.6552,-56.619,-60.8378,-63.0526,-51.2222,'68:76:4F:FC:28:68',11,NULL),(-62.3958,-57.2572,-66.5,-68.1667,-71.3678,-68.5682,'6E:8C:01:39:FD:3F',11,NULL),(-44.5935,-53.8174,-57.214,-59.0893,-61.6542,-60.9792,'98:01:A7:B6:B2:BD',11,NULL),(-71.5,-64.5,-70,-78,-64.8333,-49.25,'A0:8D:16:33:54:DE',11,NULL),(-60.8072,-63.75,-50.9681,-53.011,-44.0417,-69.4,'A8:C8:3A:07:88:9F',11,NULL),(-54.7789,-49.3404,-49.6706,-58.7632,-54.1875,-61.1111,'AC:72:89:1C:16:F0',11,NULL),(-57.8433,-49.831,-54.2153,-57.4809,-62.22,-59.2778,'D2:15:7F:1C:13:7E',11,NULL),(-57.0058,-55.2062,-33.3453,-60.869,-62.3456,-62.85,'D8:90:E8:29:AD:3F',11,'sams'),(-67.2209,-64.1487,-66.2874,-63.5077,-61.26,-54,'DE:65:B8:F4:54:82',11,NULL),(-71,-50,-72.6667,-52.9,-69.45,-65.2308,'F0:25:B7:D0:2E:97',11,NULL);
/*!40000 ALTER TABLE `dataset_lab_pos11` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_lab_pos2`
--

DROP TABLE IF EXISTS `dataset_lab_pos2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_lab_pos2` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_lab_pos2`
--

LOCK TABLES `dataset_lab_pos2` WRITE;
/*!40000 ALTER TABLE `dataset_lab_pos2` DISABLE KEYS */;
INSERT INTO `dataset_lab_pos2` VALUES (-60.25,-62.6557,-45.4444,-66.0092,-47.6069,-54.1667,'14:2D:27:E9:D7:67',2,NULL),(-49.7088,-43.5301,-42.6876,-58.2065,-58.8819,-59.4206,'34:23:87:03:78:B9',2,NULL),(-62.6163,-46.6,-62.8195,-58.3067,-64.1656,-64.8113,'40:40:A7:AE:DE:17',2,NULL),(-65.2564,-57.3786,-58.8675,-51.2993,-55.7426,-50.1716,'54:26:96:DB:9C:25',2,NULL),(-57.8207,-59.2523,-65.565,-70.4867,-71.8623,-69.5,'6E:8C:01:39:FD:3F',2,NULL),(-42.9183,-54.6554,-52.5923,-66.6673,-65.0275,-64.8117,'98:01:A7:B6:B2:BD',2,NULL),(-59.45,-63.9579,-58.2473,-61.6936,-59.8689,-54.931,'A0:8D:16:33:54:DE',2,NULL),(-58.7062,-57.1571,-55.854,-58.7699,-47.3946,-52.2419,'A8:BB:CF:01:C6:0C',2,NULL),(-61.907,-50.0823,-45.5777,-55.337,-45.548,-57.9313,'A8:C8:3A:07:88:9F',2,NULL),(-54.7034,-53.6004,-48.5436,-58.8207,-61.55,-65.4571,'AC:72:89:1C:16:F0',2,NULL),(-58.2265,-51.076,-52.0491,-66.6863,-65.0403,-67.0938,'F0:25:B7:D0:2E:97',2,NULL),(-48.6302,-48.4263,-44.1642,-49.6014,-48.55,-48.069,'F4:E3:FB:85:66:D8',2,'huawei');
/*!40000 ALTER TABLE `dataset_lab_pos2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_lab_pos3`
--

DROP TABLE IF EXISTS `dataset_lab_pos3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_lab_pos3` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_lab_pos3`
--

LOCK TABLES `dataset_lab_pos3` WRITE;
/*!40000 ALTER TABLE `dataset_lab_pos3` DISABLE KEYS */;
INSERT INTO `dataset_lab_pos3` VALUES (-60.4528,-59.7746,-47.3488,-63.9915,-48.7563,-51.2143,'14:2D:27:E9:D7:67',3,NULL),(-52.6963,-44.5121,-43.6004,-56.4362,-62.9121,-60.0822,'34:23:87:03:78:B9',3,NULL),(-61.7718,-36.749,-59.6369,-54.7104,-63.081,-63.5,'40:40:A7:AE:DE:17',3,NULL),(-62.5442,-55.6562,-57.9616,-64.0662,-47.1835,-55.6563,'4C:8D:79:E3:51:6C',3,NULL),(-57.6866,-58.1543,-65.3036,-71.5369,-72.5448,-66.5,'6E:8C:01:39:FD:3F',3,NULL),(-39.529,-54.5476,-54.6111,-68.4878,-68.8426,-65.2091,'98:01:A7:B6:B2:BD',3,NULL),(-60.6098,-53.6857,-60.575,-57.9277,-51.3061,-57.102,'A0:8D:16:33:54:DE',3,NULL),(-59.7022,-57.835,-60.7368,-66.3012,-50.2409,-58.3478,'A4:02:B9:24:34:C5',3,NULL),(-55.1104,-61.354,-60.7347,-56.1407,-48.0588,-53.0508,'A8:BB:CF:01:C6:0C',3,NULL),(-58.8701,-55.0169,-46.1233,-56.8669,-45.9068,-56.7255,'A8:C8:3A:07:88:9F',3,NULL),(-59.4863,-57,-48.1988,-59.8599,-61.9782,-68.1,'AC:72:89:1C:16:F0',3,NULL),(-62.3333,-59.8148,-35.8018,-60.4844,-66.0645,-66.0476,'C4:43:8F:B3:0A:F7',3,'lg'),(-55.78,-56.6714,-53.325,-62.6147,-68.2716,-77,'F0:25:B7:D0:2E:97',3,NULL),(-54.4918,-48.3958,-50.2688,-58.1441,-50.4929,-42.9241,'F4:E3:FB:85:66:D8',3,'huawei');
/*!40000 ALTER TABLE `dataset_lab_pos3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_lab_pos4`
--

DROP TABLE IF EXISTS `dataset_lab_pos4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_lab_pos4` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_lab_pos4`
--

LOCK TABLES `dataset_lab_pos4` WRITE;
/*!40000 ALTER TABLE `dataset_lab_pos4` DISABLE KEYS */;
INSERT INTO `dataset_lab_pos4` VALUES (-62.1603,-58.4612,-45.3841,-64.9742,-48.8669,-52.125,'14:2D:27:E9:D7:67',4,NULL),(-53.625,-41.0885,-60.2683,-60.2661,-64.9932,-67.4923,'40:40:A7:AE:DE:17',4,NULL),(-58.6154,-57.805,-54.2152,-65.164,-46.7853,-56.681,'4C:8D:79:E3:51:6C',4,NULL),(-49.9118,-62.08,-48.7949,-58,-54.75,-71,'68:76:4F:FC:28:68',4,NULL),(-43.2057,-53.8698,-55.8774,-66.8605,-67.1202,-64.2877,'98:01:A7:B6:B2:BD',4,NULL),(-60.1325,-56.5392,-56.3385,-66.8795,-52.377,-57.4239,'A4:02:B9:24:34:C5',4,NULL),(-57.6492,-58.5283,-47.215,-55.8184,-43.5983,-60.957,'A8:C8:3A:07:88:9F',4,NULL),(-49.8667,-56.4931,-48.8169,-60.5973,-61.8514,-67.1818,'AC:72:89:1C:16:F0',4,NULL),(-37.8454,-62.7692,-60.4242,-71.2381,-70.8,-81.7273,'C4:43:8F:B3:0A:F7',4,'lg'),(-17.54,-50.5918,-45.4423,-60.5184,-62.7815,-27.5,'F4:E3:FB:85:66:D8',4,'huawei');
/*!40000 ALTER TABLE `dataset_lab_pos4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_lab_pos5`
--

DROP TABLE IF EXISTS `dataset_lab_pos5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_lab_pos5` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_lab_pos5`
--

LOCK TABLES `dataset_lab_pos5` WRITE;
/*!40000 ALTER TABLE `dataset_lab_pos5` DISABLE KEYS */;
INSERT INTO `dataset_lab_pos5` VALUES (-60.7269,-59.8819,-57.1931,-67.3254,-48.9811,-57.1314,'4C:8D:79:E3:51:6C€',5,NULL),(-50.6848,-55.5789,-49.37,-57.7778,-58.5588,-49.8,'68:76:4F:FC:28:68€',5,NULL),(-39.939,-54.5476,-52.5775,-66.1721,-68.47,-63.3333,'98:01:A7:B6:B2:BD€',5,NULL),(-65,-61,-65.8333,-59,-62.8333,-53.4878,'A0:8D:16:33:54:DE€',5,NULL),(-60.8471,-57.124,-56.8756,-66.6889,-52.6914,-59.1739,'A4:02:B9:24:34:C5€',5,NULL),(-56.8333,-59.76,-57.1739,-57.5278,-55.0769,-55.125,'A8:BB:CF:01:C6:0C€',5,NULL),(-61.9014,-59.1429,-51.8333,-55.3077,-43.9,-61.7143,'A8:C8:3A:07:88:9F€',5,NULL),(-57.3266,-50.3978,-47.788,-62.6742,-63.913,-63.6024,'AC:72:89:1C:16:F0€',5,NULL),(-27.9626,-58.8049,-53.4257,-69.2203,-67.6129,-73.7273,'C4:43:8F:B3:0A:F7€',5,NULL),(-19.0169,-54.0235,-42.6125,-65.0702,-56.0874,-62.2,'F4:E3:FB:85:66:D8€',5,NULL);
/*!40000 ALTER TABLE `dataset_lab_pos5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dataset_lab_pos9`
--

DROP TABLE IF EXISTS `dataset_lab_pos9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_lab_pos9` (
  `rasp1` float DEFAULT NULL,
  `rasp2` float DEFAULT NULL,
  `rasp3` float DEFAULT NULL,
  `rasp4` float DEFAULT NULL,
  `rasp5` float DEFAULT NULL,
  `rasp6` float DEFAULT NULL,
  `mac_address` varchar(30) DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `dev` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dataset_lab_pos9`
--

LOCK TABLES `dataset_lab_pos9` WRITE;
/*!40000 ALTER TABLE `dataset_lab_pos9` DISABLE KEYS */;
INSERT INTO `dataset_lab_pos9` VALUES (-65.0769,-40.687,-62.9868,-58.5744,-69.1783,-59.7526,'40:40:A7:AE:DE:17',9,NULL),(-68.0746,-60.9663,-62.2213,-62.1916,-49.9335,-62.4167,'4C:8D:79:E3:51:6C',9,NULL),(-65,-49.031,-56.2646,-53.7907,-50.0652,-56.0672,'60:67:20:C9:93:28',9,NULL),(-52.2857,-52.25,-55.1974,-57.484,-61.9667,-62.2,'68:76:4F:FC:28:68',9,NULL),(-45.9091,-52.4137,-53.96,-61.8572,-65.7683,-73.5253,'98:01:A7:B6:B2:BD',9,NULL),(-67.0643,-60.5736,-68.3635,-61.195,-59.5878,-53.5281,'A0:8D:16:33:54:DE',9,NULL),(-63.4706,-63.6414,-50.7185,-55.2586,-52.2699,-69.2286,'A8:C8:3A:07:88:9F',9,NULL),(-49.75,-53.7329,-50.0379,-57.0525,-60.3551,-69.4,'AC:72:89:1C:16:F0',9,NULL);
/*!40000 ALTER TABLE `dataset_lab_pos9` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-04 11:30:36
