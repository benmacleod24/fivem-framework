-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.6.8-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for vex-fivem
CREATE DATABASE IF NOT EXISTS `vex-fivem` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `vex-fivem`;

-- Dumping structure for table vex-fivem.config_inventory_items
CREATE TABLE IF NOT EXISTS `config_inventory_items` (
  `id` varchar(64) NOT NULL,
  `name` varchar(128) NOT NULL,
  `weight` decimal(8,2) NOT NULL DEFAULT 0.00,
  `durability` int(11) NOT NULL,
  `max` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `event` varchar(128) DEFAULT NULL,
  `aliases` longtext NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vex-fivem.config_inventory_items: ~1 rows (approximately)
/*!40000 ALTER TABLE `config_inventory_items` DISABLE KEYS */;
INSERT INTO `config_inventory_items` (`id`, `name`, `weight`, `durability`, `max`, `price`, `event`, `aliases`) VALUES
	('cactus', 'Cactus', 6.00, 240, 12, 16, 'vx-inventory:useables:cactus', '["cacti","cactuses"]'),
	('lemon', 'Lemon', 1.80, 60, 4, 3, 'vx-inventory:usables:consume', '["lemming","lemons"]');
/*!40000 ALTER TABLE `config_inventory_items` ENABLE KEYS */;

-- Dumping structure for table vex-fivem.config_inventory_types
CREATE TABLE IF NOT EXISTS `config_inventory_types` (
  `id` varchar(32) NOT NULL,
  `name` varchar(128) NOT NULL,
  `slots` int(11) NOT NULL DEFAULT 0,
  `max_weight` decimal(8,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vex-fivem.config_inventory_types: ~6 rows (approximately)
/*!40000 ALTER TABLE `config_inventory_types` DISABLE KEYS */;
INSERT INTO `config_inventory_types` (`id`, `name`, `slots`, `max_weight`) VALUES
	('glovebox', 'Glove Box', 5, 100.00),
	('player', 'Player', 40, 400.00),
	('trailer', 'Trailer', 400, 4000.00),
	('trunk_car', 'Trunk', 40, 1000.00),
	('trunk_pickup', 'Trunk', 60, 2000.00),
	('trunk_van', 'Trunk', 100, 2000.00);
/*!40000 ALTER TABLE `config_inventory_types` ENABLE KEYS */;

-- Dumping structure for table vex-fivem.fivem_inventories
CREATE TABLE IF NOT EXISTS `fivem_inventories` (
  `id` varchar(128) NOT NULL,
  `owner` int(11) DEFAULT NULL,
  `slots` int(11) NOT NULL DEFAULT 0,
  `type` varchar(32) NOT NULL DEFAULT 'default',
  `max_weight` decimal(8,2) NOT NULL DEFAULT 0.00,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) NOT NULL DEFAULT 0,
  `data` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vex-fivem.fivem_inventories: ~0 rows (approximately)
/*!40000 ALTER TABLE `fivem_inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `fivem_inventories` ENABLE KEYS */;

-- Dumping structure for table vex-fivem.fivem_inventories_items
CREATE TABLE IF NOT EXISTS `fivem_inventories_items` (
  `id` varchar(36) NOT NULL,
  `item` varchar(32) NOT NULL,
  `inventory_id` varchar(128) NOT NULL,
  `slot` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  `weight` decimal(8,2) NOT NULL,
  `created` datetime NOT NULL,
  `data` longtext NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table vex-fivem.fivem_inventories_items: ~0 rows (approximately)
/*!40000 ALTER TABLE `fivem_inventories_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `fivem_inventories_items` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
