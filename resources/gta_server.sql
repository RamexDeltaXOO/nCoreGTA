-- --------------------------------------------------------
-- Hôte :                        127.0.0.1
-- Version du serveur:           10.4.13-MariaDB - mariadb.org binary distribution
-- SE du serveur:                Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Listage de la structure de la base pour gta_serveur
DROP DATABASE IF EXISTS `gta_serveur`;
CREATE DATABASE IF NOT EXISTS `gta_serveur` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */;
USE `gta_serveur`;

-- Listage de la structure de la table gta_serveur. gta_joueurs
DROP TABLE IF EXISTS `gta_joueurs`;
CREATE TABLE IF NOT EXISTS `gta_joueurs` (
  `license` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `argent_propre` int(11) DEFAULT NULL,
  `argent_sale` int(11) DEFAULT NULL,
  `banque` int(11) DEFAULT NULL,
  `job` varchar(255) COLLATE utf8mb4_bin DEFAULT 'Chomeur',
  `isFirstConnection` tinyint(1) NOT NULL DEFAULT 1,
  `nom` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT 'Sans Nom',
  `prenom` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT 'Sans Prenom',
  `taille` int(10) unsigned NOT NULL DEFAULT 0,
  `age` int(120) NOT NULL DEFAULT 0,
  `origine` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `faim` double DEFAULT 100,
  `soif` double DEFAULT 100,
  `serverid` int(11) NOT NULL DEFAULT 0,
  `isAdmin` tinyint(1) DEFAULT 0,
  `enService` tinyint(1) NOT NULL DEFAULT 0,
  `lastpos` varchar(255) COLLATE utf8mb4_bin DEFAULT '{-887.48388671875, -2311.68872070313,  -3.50776553153992}',
  `grade` varchar(255) COLLATE utf8mb4_bin DEFAULT 'Aucun',
  PRIMARY KEY (`license`),
  KEY `faim_soif` (`faim`,`soif`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table gta_serveur.gta_joueurs : ~0 rows (environ)
/*!40000 ALTER TABLE `gta_joueurs` DISABLE KEYS */;
/*!40000 ALTER TABLE `gta_joueurs` ENABLE KEYS */;

-- Listage de la structure de la table gta_serveur. gta_joueurs_banni
DROP TABLE IF EXISTS `gta_joueurs_banni`;
CREATE TABLE IF NOT EXISTS `gta_joueurs_banni` (
  `license` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `nom` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `prenom` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `isBanned` tinyint(1) DEFAULT 0,
  `raison` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table gta_serveur.gta_joueurs_banni : ~0 rows (environ)
/*!40000 ALTER TABLE `gta_joueurs_banni` DISABLE KEYS */;
/*!40000 ALTER TABLE `gta_joueurs_banni` ENABLE KEYS */;

-- Listage de la structure de la table gta_serveur. gta_joueurs_humain
DROP TABLE IF EXISTS `gta_joueurs_humain`;
CREATE TABLE IF NOT EXISTS `gta_joueurs_humain` (
  `license` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `sex` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT 'mp_m_freemode_01',
  `visage` int(11) DEFAULT 0,
  `couleurPeau` int(11) DEFAULT 0,
  `cheveux` int(11) DEFAULT 0,
  `couleurCheveux` int(11) DEFAULT 0,
  PRIMARY KEY (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table gta_serveur.gta_joueurs_humain : ~0 rows (environ)
/*!40000 ALTER TABLE `gta_joueurs_humain` DISABLE KEYS */;
/*!40000 ALTER TABLE `gta_joueurs_humain` ENABLE KEYS */;

-- Listage de la structure de la table gta_serveur. gta_joueurs_vetement
DROP TABLE IF EXISTS `gta_joueurs_vetement`;
CREATE TABLE IF NOT EXISTS `gta_joueurs_vetement` (
  `license` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `topsID` int(125) DEFAULT 0,
  `topsDraw` int(125) DEFAULT 0,
  `topsCouleur` int(125) DEFAULT 0,
  `undershirtsID` int(125) DEFAULT 0,
  `undershirtsDraw` int(125) DEFAULT 0,
  `undershirtsCouleur` int(125) DEFAULT 0,
  `shoesID` int(125) DEFAULT 0,
  `shoesDraw` int(125) DEFAULT 0,
  `shoesCouleur` int(125) DEFAULT 0,
  `legsID` int(125) DEFAULT 0,
  `legsDraw` int(125) DEFAULT 0,
  `legsCouleur` int(125) DEFAULT 0,
  `torsosID` int(125) DEFAULT 0,
  `torsosDraw` int(125) DEFAULT 0,
  `AccessoiresID` int(125) DEFAULT 0,
  `AccessoiresDraw` int(125) DEFAULT 0,
  `AccessoiresCouleur` int(125) DEFAULT 0,
  `HatsID` int(125) DEFAULT 0,
  `HatsDraw` int(125) DEFAULT 0,
  `HatsCouleurs` int(125) DEFAULT 0,
  PRIMARY KEY (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Listage des données de la table gta_serveur.gta_joueurs_vetement : ~0 rows (environ)
/*!40000 ALTER TABLE `gta_joueurs_vetement` DISABLE KEYS */;
/*!40000 ALTER TABLE `gta_joueurs_vetement` ENABLE KEYS */;

-- Listage de la structure de la table gta_serveur. gta_metiers
DROP TABLE IF EXISTS `gta_metiers`;
CREATE TABLE IF NOT EXISTS `gta_metiers` (
  `metiers` varchar(50) NOT NULL DEFAULT '0',
  `salaire` int(11) NOT NULL DEFAULT 500,
  `emploi` varchar(50) DEFAULT 'public'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Listage des données de la table gta_serveur.gta_metiers : ~3 rows (environ)
/*!40000 ALTER TABLE `gta_metiers` DISABLE KEYS */;
INSERT INTO `gta_metiers` (`metiers`, `salaire`, `emploi`) VALUES
	('Chomeur', 150, 'public'),
	('Police', 500, 'priver'),
	('Medic', 500, 'priver');
/*!40000 ALTER TABLE `gta_metiers` ENABLE KEYS */;

-- Listage de la structure de la table gta_serveur. items
DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `libelle` varchar(255) DEFAULT NULL,
  `isUsable` tinyint(1) DEFAULT 1,
  `type` tinyint(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Listage des données de la table gta_serveur.items : ~14 rows (environ)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`libelle`, `isUsable`, `type`) VALUES
	('Pistolet', 1, 3),
	('Munition 9mm', 1, 3),
	('Marteau', 1, 3),
	('Batte de baseball', 1, 3),
	('Pied-de-biche', 1, 3),
	('Couteau', 1, 3),
	('Menotte', 1, 3),
	('Hache', 1, 3),
	('Machette', 1, 3),
	('Poing américain', 1, 3),
	('Tazer', 1, 3),
	('Matraque', 1, 3),
	('Seringue d\'adrenaline', 1, 4),
	('Soda', 1, 1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Listage de la structure de la table gta_serveur. user_inventory
DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `item_name` varchar(255) DEFAULT NULL,
  `quantity` bigint(20) unsigned NOT NULL DEFAULT 0,
  `license` varchar(50) NOT NULL DEFAULT '0',
  UNIQUE KEY `item_id_license` (`item_name`,`license`) USING BTREE,
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Listage des données de la table gta_serveur.user_inventory : ~0 rows (environ)
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
