-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: shoe_store_db
-- ------------------------------------------------------
-- Server version	8.0.46

CREATE DATABASE IF NOT EXISTS shoe_store_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shoe_store_db;
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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (2,'Ботинки'),(4,'Кеды'),(1,'Кроссовки'),(5,'Сандалии'),(3,'Туфли');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers`
--

DROP TABLE IF EXISTS `manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
INSERT INTO `manufacturers` VALUES (4,'Adidas'),(7,'Ecco'),(1,'Nike'),(5,'Puma'),(6,'Rieker'),(2,'Timberland'),(3,'Zenden');
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Новый',
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2026-06-19 22:45:27','В обработке',1),(2,'2026-06-19 22:45:27','Завершен',2),(3,'2026-06-19 22:45:27','Новый',1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `article` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int NOT NULL,
  `manufacturer_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` decimal(10,2) NOT NULL,
  `unit_of_measurement` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'пар',
  `stock_quantity` int NOT NULL DEFAULT '0',
  `discount_percent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article` (`article`),
  KEY `category_id` (`category_id`),
  KEY `manufacturer_id` (`manufacturer_id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_3` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `products_chk_1` CHECK ((`price` >= 0.00)),
  CONSTRAINT `products_chk_2` CHECK ((`stock_quantity` >= 0)),
  CONSTRAINT `products_chk_3` CHECK ((`discount_percent` between 0.00 and 100.00))
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'SH-001','Кроссовки Nike Air Max',1,1,1,'Спортивные кроссовки с воздушной амортизацией.',12000.00,'пар',15,20.00,'sh-001.jpg'),(2,'SH-002','Ботинки Timberland Classic',2,2,2,'ЖЕСТЬ',20000.00,'пар',0,5.00,'img/622c8336-118f-45a6-a5c5-b5db35b50e52.png'),(3,'SH-003','Туфли кожаные Zenden',3,3,3,'Классические мужские туфли из натуральной кожи.',5000.00,'пар',8,0.00,'sh-003.jpg'),(4,'SH-004','Кеды Adidas Superstar',4,4,1,'Легендарные городские кеды с резиновым мыском.',9500.00,'пар',25,18.00,'sh-004.jpg'),(5,'SH-005','Кроссовки Puma RS-X',1,5,2,'Массивные футуристичные кроссовки для бега.',11000.00,'пар',12,10.00,'sh-005.jpg'),(6,'SH-006','Ботинки Rieker Антистресс',2,6,4,'Легкие и гибкие осенние ботинки повышенной комфортности.',7500.00,'пар',0,0.00,'img/sh-006.jpg'),(7,'SH-007','Туфли Ecco Летние',3,7,5,'Женские перфорированные туфли из мягкой кожи.',8900.00,'пар',14,25.00,NULL),(8,'SH-008','Кеды Nike Blazer Low',4,1,3,'Низкие винтажные кеды из белой кожи.',8000.00,'пар',19,12.00,NULL),(9,'SH-009','Сандалии Adidas Terrex',5,4,1,'Спортивные туристические сандалии для бездорожья.',6500.00,'пар',30,0.00,'img/sh-009.jpg'),(10,'SH-010','Ботинки Зимние Zenden',2,3,3,'Мужские ботинки на натуральном меху.',6200.00,'пар',5,30.00,'img/sh-010.jpg'),(11,'SH-011','Кроссовки Nike Pegasus',1,1,2,'Профессиональные беговые кроссовки.',13500.00,'пар',7,16.00,NULL),(12,'SH-012','Кеды Puma Suede',4,5,5,'Классические замшевые кеды в стиле ретро.',7800.00,'пар',0,0.00,NULL),(13,'SH-013','Туфли Rieker Классика',3,6,4,'Строгие мужские туфли для офиса.',6900.00,'пар',22,5.00,NULL),(14,'SH-014','Ботинки Спортивные Ecco',2,7,3,'Треккинговые демисезонные ботинки с мембраной.',16000.00,'пар',3,15.00,NULL),(15,'SH-015','Сандалии Rieker Кожаные',5,6,2,'Легкие повседневные мужские сандалии.',5400.00,'пар',11,8.00,NULL),(16,'SH-016','Кроссовки Adidas Ultraboost',1,4,1,'Премиальные трикотажные кроссовки для бега.',18000.00,'пар',9,22.00,NULL),(17,'SH-017','Кеды Zenden Холщовые',4,3,5,'Легкие текстильные кеды на лето.',2500.00,'пар',45,0.00,NULL),(18,'SH-018','Туфли Праздничные Zenden',3,3,3,'Женские туфли-лодочки на высоком каблуке.',4800.00,'пар',0,40.00,NULL),(19,'SH-019','Ботинки Puma Desierto',2,5,4,'Утепленные высокие ботинки-кроссовки.',10500.00,'пар',6,12.00,NULL),(20,'SH-020','Сандалии Ecco Удобные',5,7,1,'Анатомические женские сандалии для ходьбы.',9200.00,'пар',17,0.00,NULL);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productsorders`
--

DROP TABLE IF EXISTS `productsorders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productsorders` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price_at_purchase` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `productsorders_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `productsorders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT,
  CONSTRAINT `productsorders_chk_1` CHECK ((`quantity` > 0)),
  CONSTRAINT `productsorders_chk_2` CHECK ((`price_at_purchase` >= 0.00))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productsorders`
--

LOCK TABLES `productsorders` WRITE;
/*!40000 ALTER TABLE `productsorders` DISABLE KEYS */;
INSERT INTO `productsorders` VALUES (1,1,1,12000.00),(2,3,2,5000.00),(2,4,1,9500.00),(3,10,1,6200.00);
/*!40000 ALTER TABLE `productsorders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (4,'Администратор'),(1,'Гость'),(2,'Клиент'),(3,'Менеджер');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES (4,'ГлавПоставка'),(2,'ИП ОптОбувь'),(5,'Обувь-Опт'),(1,'ООО ОбувьТорг'),(3,'Склад-Центр');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `login` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `login` (`login`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Иванов Иван Иванович','ivanov@mail.ru','client','password123',2),(2,'Смирнова Анна Алексеевна','smirnova@yandex.ru','client2','password123',2),(3,'Петрова Ольга Сергеевна','petrova@shoe.ru','manager','securemgr',3),(4,'Сидоров Александр Петрович','admin@shoe.ru','admin','superadmin',4);
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

-- Dump completed on 2026-06-20  8:04:09
