-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 15 Décembre 2016 à 11:56
-- Version du serveur :  10.1.16-MariaDB
-- Version de PHP :  5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `refarc`
--

-- --------------------------------------------------------

--
-- Structure de la table `applications`
--

CREATE TABLE `applications` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ecolience` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `irt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `trigramme` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `criticite_stamp` enum('Non prioritaire','Secondaire','Critique','Vitale') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Non prioritaire',
  `sensible_groupe` tinyint(1) NOT NULL,
  `demande_client` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `statu` enum('Draft','Final') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Draft',
  `niv_sensible_fraude` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `active_edit` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `applications`
--

TRUNCATE TABLE `applications`;
--
-- Contenu de la table `applications`
--

INSERT INTO `applications` (`id`, `name`, `ecolience`, `irt`, `trigramme`, `criticite_stamp`, `sensible_groupe`, `demande_client`, `version`, `statu`, `niv_sensible_fraude`, `user_id`, `project_id`, `template_id`, `active_edit`, `created_at`, `updated_at`) VALUES
(1, 'App SECTION', 'HJGHJG21454', 'AN394', 'FDO', 'Critique', 1, 'Créattion suite CVTI du 12/01/2016\r\nCode project ITIM 15342\r\nCode projet GTS : N°MFU 606825', '1.25', 'Draft', '1', 1, 2, 1, NULL, '2016-10-18 22:00:00', '2016-10-26 11:29:52'),
(10, 'Test1', 'yyyyyyyyyyyyyyy', 'qsdqsd', 'qsdqsdqsdqs', 'Non prioritaire', 0, 'dqsdqsdqdsqsd', '2.30', 'Draft', 'qsdqs', 1, 16, 0, NULL, '2016-10-31 14:40:24', '2016-10-31 14:45:08'),
(11, 'App1', 'WXDE365', '1456987', 'DZDZDZD', 'Secondaire', 0, 'TEST', '', 'Draft', '100', 1, 17, 0, NULL, '2016-11-02 09:07:44', '2016-11-04 14:35:38'),
(12, 'App 2', 'XDES', 'FR365', 'TRE', 'Non prioritaire', 1, 'test demande', '3.3', 'Draft', '1', 1, 1, 0, NULL, '2016-11-04 12:14:03', '2016-12-14 16:41:24'),
(13, 'APP test', 'ASE24', '236AZE', 'ZTY', 'Non prioritaire', 1, 'test demande', '', 'Draft', '1', 1, 18, 0, NULL, '2016-11-04 12:24:21', '2016-11-04 12:25:04'),
(14, 'Dsfdsf', 'dsfsdf', 'sdfdsf', 'dsfsdfs', 'Non prioritaire', 0, 'sdfdsfsdf', '', 'Draft', 'fsdfhhhh', 1, 15, 0, NULL, '2016-11-04 14:42:07', '2016-11-04 14:42:43'),
(15, 'App 1', '362DSF', '123', 'TRF', 'Non prioritaire', 1, 'Test', '', 'Draft', '0', 1, 19, 0, NULL, '2016-11-04 16:00:18', '2016-11-04 16:01:49');

--
-- Déclencheurs `applications`
--
DELIMITER $$
CREATE TRIGGER `update_apps` AFTER UPDATE ON `applications` FOR EACH ROW BEGIN
    IF (NEW.name != OLD.name) THEN
        INSERT INTO histo_applications 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("name", OLD.name, NEW.name, NOW(), @actifUser, NEW.id);
    END IF;
    IF (NEW.ecolience != OLD.ecolience) THEN
        INSERT INTO histo_applications 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("ecolience", OLD.ecolience, NEW.ecolience, NOW(), @actifUser, NEW.id);
    END IF;
    IF (NEW.irt != OLD.irt) THEN
        INSERT INTO histo_applications 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("irt", OLD.irt, NEW.irt, NOW(), @actifUser, NEW.id);
    END IF;
	IF (NEW.trigramme != OLD.trigramme) THEN
        INSERT INTO histo_applications 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("trigramme", OLD.trigramme, NEW.trigramme, NOW(), @actifUser, NEW.id);
    END IF;
	IF (NEW.criticite_stamp != OLD.criticite_stamp) THEN
        INSERT INTO histo_applications 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("criticite_stamp", OLD.criticite_stamp, NEW.criticite_stamp, NOW(), @actifUser, NEW.id);
    END IF;
	IF (NEW.sensible_groupe != OLD.sensible_groupe) THEN
        INSERT INTO histo_applications 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("sensible_groupe", OLD.sensible_groupe, NEW.sensible_groupe, NOW(), @actifUser, NEW.id);
    END IF;
	IF (NEW.demande_client != OLD.demande_client) THEN
        INSERT INTO histo_applications 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("demande_client", OLD.demande_client, NEW.demande_client, NOW(), @actifUser, NEW.id);
    END IF;
	IF (NEW.niv_sensible_fraude != OLD.niv_sensible_fraude) THEN
        INSERT INTO histo_applications 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("niv_sensible_fraude", OLD.niv_sensible_fraude, NEW.niv_sensible_fraude, NOW(), @actifUser, NEW.id);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `applications_content`
--

CREATE TABLE `applications_content` (
  `id` int(11) NOT NULL,
  `id_app` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `id_template` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `text_stat` longtext NOT NULL,
  `num_parag` varchar(45) NOT NULL,
  `parent` int(11) NOT NULL,
  `niv` int(11) NOT NULL,
  `ordre` int(11) NOT NULL,
  `modified` tinyint(1) NOT NULL DEFAULT '0',
  `aide` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Vider la table avant d'insérer `applications_content`
--

TRUNCATE TABLE `applications_content`;
--
-- Contenu de la table `applications_content`
--

INSERT INTO `applications_content` (`id`, `id_app`, `user_id`, `id_template`, `text`, `text_stat`, `num_parag`, `parent`, `niv`, `ordre`, `modified`, `aide`, `created_at`, `updated_at`) VALUES
(1, 12, 1, 1, 'SYNTHESE', '<p><img src="/refarc/public/source/applications/work.jpg" alt="" width="480" height="329" />sdffdsfds</p>', '1', 0, 0, 1, 1, NULL, '2016-12-14 16:13:36', '2016-12-14 16:27:40'),
(2, 12, 1, 1, 'NIVEAU DE SERVICES DES COMPOSANTS AU SOCLE GTS', '<p>qsdqsdqsdqsd</p>', '2', 0, 0, 9, 1, NULL, '2016-12-14 16:13:36', '2016-12-14 16:38:22'),
(3, 12, 1, 1, 'SECURITE ET RISQUES OPERATIONNELS', '<p>frrrrrrrrrrrrrrrrrrrr<img src="/refarc/public/source/applications/work.jpg" alt="" width="480" height="329" /></p>', '3', 0, 0, 12, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(4, 12, 1, 1, 'ARCHITECTURE RESEAU', '', '4', 0, 0, 19, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(5, 12, 1, 1, 'ARCHITECTURE D’HEBERGEMENT APPLICATIF', '', '5', 0, 0, 22, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(6, 12, 1, 1, 'EXERCICES (PREUVE) / ECOSYSTEMES D’HEBERGEMENT', '', '6', 0, 0, 27, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(7, 12, 1, 1, 'ORIENTATIONS POUR LA PRODUCTION', '', '7', 0, 0, 37, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(8, 12, 1, 1, 'ANNEXE', '', '8', 0, 0, 42, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(9, 12, 1, 1, 'Contexte du projet', '<p>sdxfsfsdfdsfsdf</p>', '1.1', 1, 1, 43, 1, NULL, '2016-12-14 16:13:36', '2016-12-14 16:37:45'),
(10, 12, 1, 1, 'test 2', '', '2.1', 2, 1, 44, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(11, 12, 1, 1, 'test 3', '', '3.1', 3, 1, 45, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(12, 12, 1, 1, 'test 4', '', '4.1', 4, 1, 46, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(13, 12, 1, 1, 'test 5', '', '5.1', 5, 1, 47, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(14, 12, 1, 1, 'test 6', '', '6.1', 6, 1, 48, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(15, 12, 1, 1, 'test 7', '', '7.1', 7, 1, 49, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(16, 12, 1, 1, 'test 8', '', '8.1', 8, 1, 50, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:37'),
(17, 12, 1, 1, 'Vision synthétique de l’Architecture', '<p>qsdqsdqsdqdsqsdqdsddddddddddddddddddddddddddddddddddddddddddd</p>', '1.2', 1, 1, 51, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(18, 12, 1, 1, 'Principes d’architecture SI appliqués par GTS/RET', '<p>ggggggggggggggggggggggggggggggggggggggggggggg</p>', '1.2.1', 17, 2, 52, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:37'),
(19, 12, 1, 1, 'Caractéristiques de l’architecture', '', '1.2.2', 17, 2, 53, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:37'),
(20, 12, 1, 1, 'Résumé technique de l’architecture', '', '1.2.3', 17, 2, 54, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:37'),
(21, 12, 1, 1, 'dqsffdsfsdf', '', '8.2', 8, 1, 60, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:37'),
(22, 12, 1, 1, 'vcbxvxcv', '', '8.3', 8, 1, 61, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:37'),
(23, 12, 1, 1, 'qsdqsdqds', '<p>dtttttttttttttttttttttttttttttttttttttt</p>', '1.3', 1, 1, 62, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:36'),
(24, 12, 1, 1, 'yyyyyyyyyyyyyyyyyyy', '<p><span style="background-color: #ffff00;"><strong>ywaj</strong></span>di</p>', '1.3.1', 23, 2, 63, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:37'),
(25, 12, 1, 1, 'xcvxcvxcvxcv', '<p><img src="/refarc/public/source/applications/enjezok.jpg" alt="" width="719" height="502" /></p>', '2.2', 2, 1, 65, 0, NULL, '2016-12-14 16:13:36', '2016-12-14 16:13:37');

-- --------------------------------------------------------

--
-- Structure de la table `blogs`
--

CREATE TABLE `blogs` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `views_location` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `blogs`
--

TRUNCATE TABLE `blogs`;
--
-- Contenu de la table `blogs`
--

INSERT INTO `blogs` (`id`, `name`, `views_location`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'testffff', 0, 4, '2016-10-10 12:55:37', '2016-10-11 07:53:27'),
(2, 'qsdqsdqdsqsdqsdqsd', 1, 1, '2016-10-17 06:52:08', '2016-10-17 06:52:09');

-- --------------------------------------------------------

--
-- Structure de la table `blog_role`
--

CREATE TABLE `blog_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `blog_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `blog_role`
--

TRUNCATE TABLE `blog_role`;
-- --------------------------------------------------------

--
-- Structure de la table `diffusion`
--

CREATE TABLE `diffusion` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `entite` varchar(50) NOT NULL,
  `objet` varchar(50) NOT NULL,
  `id_app` int(10) NOT NULL,
  `id_user` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Vider la table avant d'insérer `diffusion`
--

TRUNCATE TABLE `diffusion`;
--
-- Contenu de la table `diffusion`
--

INSERT INTO `diffusion` (`id`, `nom`, `entite`, `objet`, `id_app`, `id_user`, `created_at`, `updated_at`) VALUES
(1, 'houllier julien', 'RESG/APS/RET', 'diffusion', 1, 1, '2016-11-28 16:32:46', '0000-00-00 00:00:00'),
(2, 'hammami wajdi', 'RESG/APS/API', 'validation', 1, 1, '2016-11-28 16:32:46', '0000-00-00 00:00:00'),
(3, 'francois level', 'RESG/GTS/RET', 'validation', 11, 1, '2016-11-28 15:48:06', '2016-11-28 15:48:06'),
(4, 'houllier julien', 'RESG/APS/RET', 'diffusion', 11, 1, '2016-11-30 09:05:18', '2016-11-30 09:05:18');

-- --------------------------------------------------------

--
-- Structure de la table `documents`
--

CREATE TABLE `documents` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direct_download` tinyint(1) NOT NULL,
  `disabled` tinyint(1) NOT NULL,
  `authorization_required` tinyint(1) NOT NULL,
  `download_timer` int(11) NOT NULL,
  `downloads` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `documents`
--

TRUNCATE TABLE `documents`;
--
-- Contenu de la table `documents`
--

INSERT INTO `documents` (`id`, `user_id`, `name`, `slug`, `password`, `direct_download`, `disabled`, `authorization_required`, `download_timer`, `downloads`, `created_at`, `updated_at`) VALUES
(1, 1, 'image5.jpeg', '2177059297', 'eyJpdiI6IkF2OTMxR1JEUXhPclZqd3p5NXdpZGc9PSIsInZhbHVlIjoidHVLOWVvOGRNaXhmalh2SlwvZVpYZ1E9PSIsIm1hYyI6Ijk5ZjAyOTM4Njg1ZGYyNjBjMzM4Mzk4Y2Q4MWYwMjM0MzRmNWQ4ODgwMGU2MzBmYTNhZTVjMzgwZjQ4NjUyMTgifQ==', 1, 0, 0, 6, 0, '2016-11-25 09:00:34', '2016-11-25 09:00:34');

-- --------------------------------------------------------

--
-- Structure de la table `histo_applications`
--

CREATE TABLE `histo_applications` (
  `id` int(10) UNSIGNED NOT NULL,
  `namefield` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `old_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `new_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `id_original` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `histo_applications`
--

TRUNCATE TABLE `histo_applications`;
--
-- Contenu de la table `histo_applications`
--

INSERT INTO `histo_applications` (`id`, `namefield`, `old_value`, `new_value`, `user_id`, `id_original`, `updated_at`) VALUES
(11, 'name', 'App Julienn', 'App Julienn test', 1, 2, '2016-10-27 10:12:03'),
(12, 'ecolience', 'WAJ1215', 'WAJ1215 test', 1, 2, '2016-10-27 10:12:03'),
(13, 'irt', 'WA9999', 'WA9999 test', 1, 2, '2016-10-27 10:12:03'),
(14, 'trigramme', 'JHO', 'JHO test', 1, 2, '2016-10-27 10:12:03'),
(15, 'criticite_stamp', 'Secondaire', 'Non prioritaire', 1, 2, '2016-10-27 10:12:03'),
(16, 'sensible_groupe', '10', '100', 1, 2, '2016-10-27 10:12:03'),
(17, 'demande_client', 'Premiere modificavvvvvvvvvvvvv', 'Premiere modification', 1, 2, '2016-10-27 10:12:03'),
(18, 'niv_sensible_fraude', '8', '80', 1, 2, '2016-10-27 10:12:03'),
(19, 'name', 'App Julienn test', 'test 2', 1, 2, '2016-10-27 12:20:36'),
(20, 'niv_sensible_fraude', '80', '800', 1, 2, '2016-10-30 12:31:18'),
(21, 'ecolience', 'qsdqsdqsd', 'yyyyyyyyyyyyyyy', 1, 10, '2016-10-31 15:45:08'),
(22, 'name', 'APP', 'APP test', 1, 13, '2016-11-04 13:25:04'),
(23, 'niv_sensible_fraude', '10', '100', 1, 11, '2016-11-04 15:35:38'),
(24, 'niv_sensible_fraude', 'fsdf', 'fsdfhhhh', 1, 14, '2016-11-04 15:42:43'),
(25, 'irt', '123456', '123', 1, 15, '2016-11-04 17:01:49');

-- --------------------------------------------------------

--
-- Structure de la table `histo_projects`
--

CREATE TABLE `histo_projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `namefield` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `old_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `new_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `id_original` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `histo_projects`
--

TRUNCATE TABLE `histo_projects`;
--
-- Contenu de la table `histo_projects`
--

INSERT INTO `histo_projects` (`id`, `namefield`, `old_value`, `new_value`, `user_id`, `id_original`, `updated_at`) VALUES
(13, 'name', 'wajdi', 'julien', 1, 3, '2016-10-18 14:32:52'),
(14, 'description', 'histodfff\r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    ', 'histodfff\r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n  ', 1, 3, '2016-10-18 14:32:52'),
(15, 'name', 'Test3', 'Test3vv', 1, 4, '2016-10-18 14:35:08'),
(16, 'description', 'wajdi\r\nfs\r\nfs\r\ndfsdffdsfsfsfsf\r\n                    ', 'vv', 1, 4, '2016-10-18 14:35:08'),
(17, 'statu', '1', '0', 1, 4, '2016-10-18 14:35:08'),
(18, 'name', 'julien', 'Julientest', 1, 3, '2016-10-18 14:53:41'),
(19, 'description', 'fffffffffffffffffffffffffffffffffff', 'jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj', 1, 7, '2016-10-18 15:55:17'),
(20, 'name', 'Ffffffffffffffffffffffffffffffffffffffffffffff', 'Ffffff', 1, 8, '2016-10-18 16:17:58'),
(21, 'name', 'Fiduceo CDN', 'Fiduceo CDN*', 4, 1, '2016-10-18 16:31:58'),
(22, 'statu', '1', '0', 4, 1, '2016-10-18 16:31:58'),
(23, 'statu', '0', '1', 1, 8, '2016-10-18 16:36:32'),
(24, 'name', 'Fiduceo CDN*', 'Fiduceo CDN', 1, 1, '2016-10-18 16:42:11'),
(25, 'statu', '0', '1', 1, 1, '2016-10-18 16:42:11'),
(26, 'description', 'jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj', 'pj2', 1, 7, '2016-10-18 16:42:53'),
(27, 'statu', '0', '1', 1, 7, '2016-10-18 16:42:53'),
(28, 'description', 'test', 'testwajdi', 1, 5, '2016-10-19 08:32:10'),
(29, 'statu', '0', '1', 1, 5, '2016-10-19 08:32:10'),
(30, 'name', 'Fiduceo CDN', 'Fiduceo CDN First', 1, 1, '2016-10-20 10:55:14'),
(31, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\nFiduceo CDN', 'Fiduceo CDN\r\nFiduceo CDN\r\nFiduceo CDN\r\ntest julien', 1, 1, '2016-10-20 10:55:14'),
(32, 'statu', '0', '1', 1, 3, '2016-10-20 12:44:15'),
(33, 'name', 'dsfsqdfsdfsdf', 'hjy', 1, 10, '2016-10-23 17:04:49'),
(34, 'description', 'fsdfsdfsdfsdf', 'frt', 1, 10, '2016-10-23 17:04:49'),
(35, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\nFiduceo CDN\r\ntest julien', 'Fiduceo CDN\r\nFiduceo CDN\r\nFiduceo CDN\r\n', 1, 1, '2016-10-23 17:05:43'),
(36, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\nFiduceo CDN\r\n', 'Fiduceo CDN\r\nFiduceo CDN\r\n', 1, 1, '2016-10-23 17:07:07'),
(37, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\n', 'Fiduceo CDN\r\nFiduceo CDN\r\nffffffffffffffffffffff', 1, 1, '2016-10-24 09:50:09'),
(38, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\nffffffffffffffffffffff', 'Fiduceo CDN\r\nFiduceo CDN\r\n', 1, 1, '2016-10-24 09:56:19'),
(39, 'statu', '1', '0', 1, 1, '2016-10-24 09:56:19'),
(40, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\n', 'Fiduceo CDN\r\nFiduceo CDN\r\ndghdfgdfgf', 1, 1, '2016-10-24 10:14:54'),
(41, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\ndghdfgdfgf', 'Fiduceo CDN\r\nFiduceo CDN\r\ndghdfgdfgffghdfgdfgdfgdfg', 1, 1, '2016-10-24 10:22:40'),
(42, 'description', 'wcwxcwxcwc', 'ffffffffffffff', 1, 8, '2016-10-24 10:48:30'),
(43, 'description', 'pj2', 'pj2qsdqsdqsdqd', 1, 7, '2016-10-24 10:55:57'),
(44, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\ndghdfgdfgffghdfgdfgdfgdfg', 'Fiduceo CDN\r\nFiduceo CDN\r\n', 1, 1, '2016-10-24 11:12:13'),
(45, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\n', 'Fiduceo CDN\r\nFiduceo CDN\r\nsqdqsdqsd', 1, 1, '2016-10-24 11:41:38'),
(46, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\nsqdqsdqsd', 'Fiduceo CDN\r\nFiduceo CDN\r\n', 1, 1, '2016-10-24 11:42:33'),
(47, 'description', 'vvvv', 'bbbbbbbbbbbbbbb', 1, 12, '2016-10-24 15:48:42'),
(48, 'statu', '0', '1', 1, 12, '2016-10-24 15:48:42'),
(49, 'description', 'ffffffffffffff', 'vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv', 1, 8, '2016-10-24 15:51:45'),
(50, 'statu', '1', '0', 1, 8, '2016-10-24 15:51:45'),
(51, 'description', 'vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv', 'yyyyyy', 1, 8, '2016-10-24 15:54:37'),
(52, 'description', 'yyyyyy', 'nnnnn', 1, 8, '2016-10-24 15:55:18'),
(53, 'description', 'nnnnn', 'jjjj', 1, 8, '2016-10-24 16:00:01'),
(54, 'description', 'jjjj', 'kkkkkkkkkkkkkkkkkkkk', 1, 8, '2016-10-24 16:01:16'),
(55, 'description', 'kkkkkkkkkkkkkkkkkkkk', 'bbbbbbbbbbbbbb', 1, 8, '2016-10-24 16:02:23'),
(56, 'description', 'bbbbbbbbbbbbbb', 'bn', 1, 8, '2016-10-24 16:14:33'),
(57, 'description', 'bn', 'cccccccccccc', 1, 8, '2016-10-24 16:15:34'),
(58, 'description', 'cccccccccccc', 'vvvvvvvvvvv', 1, 8, '2016-10-24 16:27:31'),
(59, 'description', 'vvvvvvvvvvv', 'ffff', 1, 8, '2016-10-25 09:25:18'),
(60, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\n', 'Fiduceo CDN\r\nFiduceo CDN\r\nqsdqsdqsdqds\r\n', 1, 1, '2016-10-25 09:25:53'),
(61, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\nqsdqsdqsdqds\r\n', 'Fiduceo CDN\r\nFiduceo CDN\r\n\r\n', 1, 1, '2016-10-25 09:48:31'),
(62, 'name', 'Gfhgfhgfhgfhhhhhhhhhhhhhhhhhhhhhhhhhh', 'Gfhg', 1, 13, '2016-10-25 10:06:47'),
(63, 'description', 'D.A.H', 'D.A.Hfffffffffffffffffffffffffffffffffcccccccccccccdddddddddddddd', 1, 14, '2016-10-29 11:50:58'),
(64, 'description', 'D.A.Hfffffffffffffffffffffffffffffffffcccccccccccccdddddddddddddd', 'D.A.H', 1, 14, '2016-10-29 11:53:01'),
(65, 'name', 'D.A.H', 'D.A.Hfffff', 1, 14, '2016-10-29 11:56:52'),
(66, 'name', 'D.A.Hfffff', 'D.A.Httt', 1, 14, '2016-10-29 11:58:39'),
(67, 'description', 'D.A.H', 'D.A.Hggg', 1, 14, '2016-10-29 11:58:39'),
(68, 'description', 'D.A.Hggg', 'D.A.H', 1, 14, '2016-10-29 12:00:17'),
(69, 'description', 'D.A.H', 'D.A.Hccccccccccccccccc', 1, 14, '2016-10-29 12:02:41'),
(70, 'description', 'D.A.Hccccccccccccccccc', 'D.A.Hcccccccccccccccccfffffffffffffffffffff', 1, 14, '2016-10-29 12:03:54'),
(71, 'description', 'D.A.Hcccccccccccccccccfffffffffffffffffffff', 'D.A.Hcccccccccccccccccgggggg', 1, 14, '2016-10-29 12:13:08'),
(72, 'name', 'D.A.Httt', 'D.A.H', 1, 14, '2016-10-30 12:22:49'),
(73, 'description', 'D.A.Hcccccccccccccccccgggggg', 'D.A.H', 1, 14, '2016-10-30 12:22:49'),
(74, 'name', 'D.A.H', 'D.A.Hccccccccccccc', 1, 14, '2016-10-30 12:26:08'),
(75, 'name', 'D.A.Hccccccccccccc', 'D.A.H', 1, 14, '2016-10-30 12:28:03'),
(76, 'name', 'D.A.H', 'D.A.Hffff', 1, 14, '2016-10-30 12:28:52'),
(77, 'description', 'Fiduceo CDN\r\nFiduceo CDN\r\n\r\n', 'Fiduceo CDNddFiduceo CDN', 1, 1, '2016-10-30 12:31:57'),
(78, 'description', 'Fiduceo CDNddFiduceo CDN', 'Fiduceo CDNFiduceo CDN', 1, 1, '2016-10-30 12:33:42'),
(79, 'description', 'Fiduceo CDNFiduceo CDN', 'Fiduceo CDNFiduceo CDN55', 1, 1, '2016-10-30 12:34:17'),
(80, 'name', 'Fiduceo CDN First', 'Fiduceo CDN First 4', 1, 1, '2016-10-30 12:39:50'),
(81, 'description', 'Fiduceo CDNFiduceo CDN55', 'Fiduceo CDNFiduceo CDN', 1, 1, '2016-10-30 12:39:50'),
(82, 'name', 'Fiduceo CDN First 4', 'Fiduceo CDN First', 1, 1, '2016-10-30 12:40:56'),
(83, 'description', 'Fiduceo CDNFiduceo CDN', 'Fiduceo CDNFiduceo CDNFiduceo CDNFiduceo CDN', 1, 1, '2016-10-30 12:40:56'),
(84, 'name', 'Fiduceo CDN First', 'Fiduceo CDN First ggg', 1, 1, '2016-10-30 12:41:18'),
(85, 'description', 'The Last DAH', 'The Last DAHThe Last DAHThe Last DAHThe Last DAHThe Last DAHThe Last DAHThe Last DAH', 1, 16, '2016-10-31 11:51:21'),
(86, 'name', 'Fiduceo CDN First ggg', 'Fiduceo CDN First', 1, 1, '2016-10-31 11:54:52'),
(87, 'description', 'Fiduceo CDNFiduceo CDNFiduceo CDNFiduceo CDN', 'Fiduceo CDNFiduceo', 1, 1, '2016-10-31 11:54:52'),
(88, 'name', 'Fiduceo CDN First', 'Fiduceo CDN First gggggggggggggg', 1, 1, '2016-10-31 11:56:29'),
(89, 'description', 'Fiduceo CDNFiduceo', 'Fiduceo CDNFiduceo gggggggggggggg', 1, 1, '2016-10-31 11:56:29'),
(90, 'name', 'Fiduceo CDN First gggggggggggggg', 'Fiduceo CDN First', 1, 1, '2016-10-31 11:59:25'),
(91, 'description', 'Fiduceo CDNFiduceo gggggggggggggg', 'Fiduceo CDNFiduceo', 1, 1, '2016-10-31 11:59:25'),
(92, 'description', 'The Last DAHThe Last DAHThe Last DAHThe Last DAHThe Last DAHThe Last DAHThe Last DAH', 'The Last DAH', 1, 16, '2016-10-31 13:35:59'),
(93, 'name', 'The Last DAH', 'The Last DAHgggggggggggggggggggggggggggggggggggggg', 1, 16, '2016-10-31 14:10:25'),
(94, 'name', 'The Last DAHgggggggggggggggggggggggggggggggggggggg', 'The Last DAH', 1, 16, '2016-10-31 14:10:52'),
(95, 'description', 'DAH test', 'DAH testDAH test', 1, 17, '2016-11-02 10:06:56'),
(96, 'description', 'Fiduceo CDNFiduceo', 'Fiduceo CDN', 1, 1, '2016-11-04 08:56:45'),
(97, 'description', 'Fiduceo CDN', 'Fiduceo CDN test', 1, 1, '2016-11-04 08:59:16'),
(98, 'description', 'Fiduceo CDN test', 'Fiduceo CDN', 1, 1, '2016-11-04 13:12:45'),
(99, 'description', 'DAH testDAH test', 'DAH test', 1, 17, '2016-11-04 15:38:11'),
(100, 'description', 'DAH test', 'DAH testqsdqsdq', 1, 17, '2016-11-04 15:38:38'),
(101, 'description', 'projet demo', 'projet demo toto', 1, 19, '2016-11-04 17:00:53'),
(102, 'name', 'Fiduceo CDN First', 'Fiduceo CDN First bbbb', 1, 1, '2016-11-07 13:03:32'),
(103, 'name', 'Fiduceo CDN First bbbb', 'Fiduceo CDN First', 1, 1, '2016-11-22 13:02:27');

-- --------------------------------------------------------

--
-- Structure de la table `intervenants`
--

CREATE TABLE `intervenants` (
  `id` int(10) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `resp_domain` varchar(50) NOT NULL,
  `entite` varchar(50) NOT NULL,
  `id_app` int(10) NOT NULL,
  `id_user` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Vider la table avant d'insérer `intervenants`
--

TRUNCATE TABLE `intervenants`;
--
-- Contenu de la table `intervenants`
--

INSERT INTO `intervenants` (`id`, `nom`, `email`, `resp_domain`, `entite`, `id_app`, `id_user`, `created_at`, `updated_at`) VALUES
(1, 'houllier julien', 'houllier.julien@gmail.com', 'Dev', 'RESG/RET/APS', 11, 2, '2016-11-28 15:58:03', '0000-00-00 00:00:00'),
(2, 'hammami wajdi', 'hammami.wajdi@gmail.com', 'Dev', 'RESG/GTS/API', 11, 3, '2016-11-28 15:58:06', '0000-00-00 00:00:00'),
(5, 'hammami julien', 'houllier.julien@gmail.com', 'Dev', 'RESG/RET/APS', 11, 34, '2016-11-28 15:58:08', '0000-00-00 00:00:00'),
(23, 'houllier julien', 'houllier.julien@gmail.com', 'Dev', 'RESG/RET/APS', 1, 1, '2016-12-02 18:53:34', '2016-12-02 18:53:34'),
(21, 'houllier julien', 'houllier.julien@gmail.com', 'Dev', 'RESG/RET/APS', 11, 1, '2016-11-28 15:58:10', '2016-11-28 14:46:54'),
(22, 'F. LEVEL DE CURNIEU', 'f.level@gmail.com', 'Manager', 'RESG/APS/RET', 1, 1, '2016-11-28 15:03:22', '2016-11-28 15:03:22');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `migrations`
--

TRUNCATE TABLE `migrations`;
--
-- Contenu de la table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1),
('2016_02_10_150019_Create_Roles_Table', 1),
('2016_02_10_150205_Create_Role_User', 1),
('2016_02_10_150405_Create_Users_Settings', 1),
('2016_02_10_152932_Create_Permissions', 1),
('2016_02_10_153414_Create_Permission_Role', 1),
('2016_05_15_115823_Create_Blogs', 1),
('2016_05_15_115828_Create_Posts', 1),
('2016_05_15_122433_Create_Views', 1),
('2016_06_11_160205_create_settings', 1),
('2016_06_20_201138_create_blog_role', 1),
('2016_06_24_162123_create_post_comments', 1),
('2016_07_05_175919_create_documents', 1),
('2016_09_12_161028_create_social_table', 1),
('2016_10_10_150222_create_projects_table', 2),
('2016_10_19_092006_create_applications_table', 3);

-- --------------------------------------------------------

--
-- Structure de la table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `password_resets`
--

TRUNCATE TABLE `password_resets`;
-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `assignable` tinyint(1) NOT NULL,
  `su` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `permissions`
--

TRUNCATE TABLE `permissions`;
--
-- Contenu de la table `permissions`
--

INSERT INTO `permissions` (`id`, `slug`, `assignable`, `su`, `created_at`, `updated_at`) VALUES
(1, 'refarc.access', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(2, 'refarc.users.access', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(3, 'refarc.users.create', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(4, 'refarc.users.edit', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(5, 'refarc.users.roles', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(6, 'refarc.users.delete', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(7, 'refarc.users.settings', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(8, 'refarc.roles.access', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(9, 'refarc.roles.create', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(10, 'refarc.roles.edit', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(11, 'refarc.roles.permissions', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(12, 'refarc.roles.delete', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(13, 'refarc.permissions.access', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(14, 'refarc.permissions.create', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(15, 'refarc.permissions.edit', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(29, 'refarc.files.access', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(30, 'refarc.files.upload', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(31, 'refarc.files.download', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(32, 'refarc.files.delete', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(33, 'refarc.documents.create', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(34, 'refarc.documents.edit', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(35, 'refarc.documents.delete', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(36, 'refarc.settings.access', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(37, 'refarc.settings.edit', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(38, 'refarc.CRUD.access', 1, 1, '2016-10-10 12:32:01', '2016-10-10 12:32:01'),
(39, 'refarc.projects.access', 1, 1, '2016-10-09 22:00:00', '2016-10-10 13:27:07'),
(40, 'refarc.projects.edit', 1, 1, '2016-10-09 22:00:00', '2016-10-09 22:00:00'),
(41, 'refarc.projects.create', 1, 1, '2016-10-09 22:00:00', '2016-10-09 22:00:00'),
(43, 'refarc.applications.access', 1, 1, '2016-10-24 22:00:00', '2016-10-24 22:00:00'),
(44, 'refarc.applications.create', 1, 1, NULL, NULL),
(45, 'refarc.applications.edit', 1, 1, '2016-10-24 22:00:00', '2016-10-24 22:00:00'),
(46, 'refarc.templates.access', 1, 1, '2016-11-03 23:00:00', NULL),
(47, 'refarc.templates.edit', 1, 1, NULL, NULL),
(48, 'refarc.templates.create', 1, 1, '2016-11-03 23:00:00', NULL),
(49, 'refarc.templates.delete', 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `permission_role`
--

CREATE TABLE `permission_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `permission_role`
--

TRUNCATE TABLE `permission_role`;
--
-- Contenu de la table `permission_role`
--

INSERT INTO `permission_role` (`id`, `permission_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 1, NULL, NULL),
(3, 3, 1, NULL, NULL),
(4, 4, 1, NULL, NULL),
(5, 5, 1, NULL, NULL),
(6, 6, 1, NULL, NULL),
(7, 7, 1, NULL, NULL),
(8, 8, 1, NULL, NULL),
(9, 9, 1, NULL, NULL),
(10, 10, 1, NULL, NULL),
(11, 11, 1, NULL, NULL),
(12, 12, 1, NULL, NULL),
(13, 13, 1, NULL, NULL),
(14, 14, 1, NULL, NULL),
(15, 15, 1, NULL, NULL),
(16, 16, 1, NULL, NULL),
(29, 29, 1, NULL, NULL),
(30, 30, 1, NULL, NULL),
(31, 31, 1, NULL, NULL),
(32, 32, 1, NULL, NULL),
(33, 33, 1, NULL, NULL),
(34, 34, 1, NULL, NULL),
(35, 35, 1, NULL, NULL),
(36, 36, 1, NULL, NULL),
(37, 37, 1, NULL, NULL),
(38, 38, 1, NULL, NULL),
(62, 39, 1, NULL, NULL),
(63, 40, 1, NULL, NULL),
(64, 41, 1, NULL, NULL),
(65, 42, 1, NULL, NULL),
(69, 43, 1, NULL, NULL),
(70, 44, 1, NULL, NULL),
(71, 45, 1, NULL, NULL),
(73, 39, 3, NULL, NULL),
(75, 2, 2, NULL, NULL),
(93, 39, 2, NULL, NULL),
(94, 40, 2, NULL, NULL),
(95, 41, 2, NULL, NULL),
(101, 43, 2, NULL, NULL),
(103, 45, 2, NULL, NULL),
(105, 44, 2, NULL, NULL),
(106, 46, 2, NULL, NULL),
(111, 46, 1, NULL, NULL),
(112, 47, 1, NULL, NULL),
(113, 48, 1, NULL, NULL),
(114, 49, 1, NULL, NULL),
(115, 46, 3, NULL, NULL),
(125, 1, 3, NULL, NULL),
(127, 43, 3, NULL, NULL),
(128, 1, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `pictures`
--

CREATE TABLE `pictures` (
  `id` int(11) NOT NULL,
  `id_app` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `user_id` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Vider la table avant d'insérer `pictures`
--

TRUNCATE TABLE `pictures`;
--
-- Contenu de la table `pictures`
--

INSERT INTO `pictures` (`id`, `id_app`, `nom`, `user_id`, `updated_at`, `created_at`) VALUES
(11, 0, 'T01_1_tplsModif.PNG', 1, '2016-11-30 14:53:36', '2016-11-30 14:53:36'),
(12, 0, 'T01_2_appHist.PNG', 1, '2016-11-30 14:55:21', '2016-11-30 14:55:21'),
(13, 0, 'T01_3_roles.PNG', 1, '2016-11-30 15:04:11', '2016-11-30 15:04:11'),
(14, 0, 'T01_4_tpls.PNG', 1, '2016-11-30 15:04:37', '2016-11-30 15:04:37'),
(15, 0, 'T01_5_appsProfil.PNG', 1, '2016-11-30 15:20:26', '2016-11-30 15:20:26'),
(16, 0, 'T01_6_cnx.PNG', 1, '2016-11-30 15:40:07', '2016-11-30 15:40:07');

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `logged_in_comments` tinyint(1) NOT NULL,
  `anonymous_comments` tinyint(1) NOT NULL,
  `limit_views_per_ip` tinyint(1) NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `blog_id` int(11) NOT NULL,
  `edited_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `posts`
--

TRUNCATE TABLE `posts`;
--
-- Contenu de la table `posts`
--

INSERT INTO `posts` (`id`, `image`, `title`, `description`, `logged_in_comments`, `anonymous_comments`, `limit_views_per_ip`, `body`, `user_id`, `blog_id`, `edited_by`, `created_at`, `updated_at`) VALUES
(1, '', 'sdfsdfsdfsf', 'sdfsdfsdfsdf\r\nsdfsd\r\nfsd\r\nfs\r\nfsdf\r\nsffds', 0, 0, 0, '<p>sdfsdfsdffsf</p>\r\n', 4, 1, NULL, '2016-10-10 12:56:16', '2016-10-10 12:56:16');

-- --------------------------------------------------------

--
-- Structure de la table `post_comments`
--

CREATE TABLE `post_comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `post_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `post_comments`
--

TRUNCATE TABLE `post_comments`;
-- --------------------------------------------------------

--
-- Structure de la table `post_views`
--

CREATE TABLE `post_views` (
  `id` int(10) UNSIGNED NOT NULL,
  `post_id` int(11) NOT NULL,
  `ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ref` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `post_views`
--

TRUNCATE TABLE `post_views`;
-- --------------------------------------------------------

--
-- Structure de la table `projects`
--

CREATE TABLE `projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `nb_apps` int(11) NOT NULL,
  `statu` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `projects`
--

TRUNCATE TABLE `projects`;
--
-- Contenu de la table `projects`
--

INSERT INTO `projects` (`id`, `name`, `description`, `nb_apps`, `statu`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Fiduceo CDN First', 'Fiduceo CDN', 1, 0, 1, '2016-10-10 22:00:00', '2016-11-22 12:02:27'),
(3, 'Julientest', 'histodfff\r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    \r\n                    ', 0, 1, 1, '2016-10-07 22:00:00', '2016-10-20 10:44:15'),
(5, 'Wajtest', 'testwajdi', 0, 1, 4, '2016-10-07 22:00:00', '2016-10-19 06:32:10'),
(7, 'FLA (DAH)', 'pj2qsdqsdqsdqd', 0, 1, 1, '2016-10-18 13:54:25', '2016-10-24 08:55:57'),
(15, 'DAH2', 'DAH2', 1, 0, 1, '2016-10-28 13:24:52', '2016-10-28 13:24:52'),
(16, 'The Last DAH', 'The Last DAH', 1, 0, 1, '2016-10-31 10:45:34', '2016-10-31 13:10:52'),
(17, 'DAH test', 'DAH testqsdqsdq', 1, 0, 1, '2016-11-02 09:06:05', '2016-11-04 14:38:38'),
(18, 'NEW DAH', 'nouveau DAH test', 1, 0, 1, '2016-11-04 12:22:57', '2016-11-04 12:22:57'),
(19, 'DAH Demo', 'projet demo toto', 1, 0, 1, '2016-11-04 15:55:30', '2016-11-04 16:00:53');

--
-- Déclencheurs `projects`
--
DELIMITER $$
CREATE TRIGGER `update_data` AFTER UPDATE ON `projects` FOR EACH ROW BEGIN
    IF (NEW.name != OLD.name) THEN
        INSERT INTO histo_projects 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("name", OLD.name, NEW.name, NOW(), @actifUser, NEW.id);
    END IF;
    IF (NEW.description != OLD.description) THEN
        INSERT INTO histo_projects 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("description", OLD.description, NEW.description, NOW(), @actifUser, NEW.id);
    END IF;
    IF (NEW.statu != OLD.statu) THEN
        INSERT INTO histo_projects 
            (`namefield` , `old_value` , `new_value` , `updated_at`, `user_id`,  `id_original`) 
        VALUES 
            ("statu", OLD.statu, NEW.statu, NOW(), @actifUser, NEW.id);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `assignable` tinyint(1) NOT NULL,
  `allow_editing` tinyint(1) NOT NULL,
  `su` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `roles`
--

TRUNCATE TABLE `roles`;
--
-- Contenu de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `color`, `assignable`, `allow_editing`, `su`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'red', 0, 0, 1, '2016-10-10 12:32:00', '2016-10-10 12:38:12'),
(2, 'ARCHITECT', 'red', 0, 0, 0, '2016-10-10 12:39:21', '2016-10-10 12:39:21'),
(3, 'Observateur', 'yellow', 0, 0, 0, '2016-11-02 09:46:18', '2016-11-02 09:46:18');

-- --------------------------------------------------------

--
-- Structure de la table `role_user`
--

CREATE TABLE `role_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `role_user`
--

TRUNCATE TABLE `role_user`;
--
-- Contenu de la table `role_user`
--

INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2016-10-10 12:32:00', '2016-10-10 12:32:00'),
(5, 2, 4, '2016-10-10 12:39:42', '2016-10-10 12:39:42'),
(6, 3, 5, '2016-10-12 06:44:16', '2016-10-12 06:44:16'),
(10, 3, 4, '2016-11-02 14:10:27', '2016-11-02 14:10:27'),
(12, 3, 13, '2016-11-02 14:12:08', '2016-11-02 14:12:08'),
(13, 2, 14, '2016-11-04 08:01:16', '2016-11-04 08:01:16'),
(14, 2, 15, '2016-11-04 09:21:16', '2016-11-04 09:21:16'),
(15, 2, 16, '2016-11-04 11:46:53', '2016-11-04 11:46:53'),
(16, 3, 16, '2016-11-04 11:46:54', '2016-11-04 11:46:54'),
(17, 1, 17, '2016-11-21 13:32:13', '2016-11-21 13:32:13'),
(18, 3, 18, '2016-11-21 13:36:23', '2016-11-21 13:36:23');

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `laralum_version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `website_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `logo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `button_color` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `header_color` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pie_chart_source` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `bar_chart_source` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `line_chart_source` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `geo_chart_source` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `settings`
--

TRUNCATE TABLE `settings`;
--
-- Contenu de la table `settings`
--

INSERT INTO `settings` (`id`, `laralum_version`, `website_title`, `logo`, `button_color`, `header_color`, `pie_chart_source`, `bar_chart_source`, `line_chart_source`, `geo_chart_source`, `created_at`, `updated_at`) VALUES
(1, '2.1.3', 'REF''ARC', '', 'black', '#DB2828', 'highcharts', 'highcharts', 'highcharts', 'highcharts', '2016-10-10 12:32:03', '2016-10-31 09:05:25');

-- --------------------------------------------------------

--
-- Structure de la table `socials`
--

CREATE TABLE `socials` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `social_id` int(11) NOT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `socials`
--

TRUNCATE TABLE `socials`;
-- --------------------------------------------------------

--
-- Structure de la table `templates`
--

CREATE TABLE `templates` (
  `id` int(11) NOT NULL,
  `id_template` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `text_stat` longtext NOT NULL,
  `type` enum('1','2','3','4') NOT NULL,
  `content` varchar(45) NOT NULL,
  `num_parag` varchar(45) NOT NULL,
  `parent` int(11) NOT NULL,
  `niv` int(11) NOT NULL,
  `ordre` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Vider la table avant d'insérer `templates`
--

TRUNCATE TABLE `templates`;
--
-- Contenu de la table `templates`
--

INSERT INTO `templates` (`id`, `id_template`, `text`, `text_stat`, `type`, `content`, `num_parag`, `parent`, `niv`, `ordre`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'SYNTHESE', '<p><img src="/refarc/public/source/applications/work.jpg" alt="" width="480" height="329" /></p>', '1', '', '1', 0, 0, 1, 1, '2016-12-13 20:28:09', '2016-12-13 19:28:09'),
(16, 1, 'NIVEAU DE SERVICES DES COMPOSANTS AU SOCLE GTS', '', '1', '', '2', 0, 0, 9, 1, '2016-12-01 11:05:34', '2016-11-28 10:16:02'),
(19, 1, 'SECURITE ET RISQUES OPERATIONNELS', '<p>frrrrrrrrrrrrrrrrrrrr<img src="/refarc/public/source/applications/work.jpg" alt="" width="480" height="329" /></p>', '1', '', '3', 0, 0, 12, 1, '2016-12-13 17:58:03', '2016-12-13 16:58:03'),
(40, 1, 'ARCHITECTURE RESEAU', '', '1', '', '4', 0, 0, 19, 1, '2016-11-10 12:08:32', '2016-11-10 11:08:32'),
(43, 1, 'ARCHITECTURE D’HEBERGEMENT APPLICATIF', '', '1', '', '5', 0, 0, 22, 1, '2016-11-07 09:26:33', '2016-11-07 09:26:33'),
(48, 1, 'EXERCICES (PREUVE) / ECOSYSTEMES D’HEBERGEMENT', '', '1', '', '6', 0, 0, 27, 1, '2016-11-07 09:26:33', '2016-11-07 09:26:33'),
(123, 1, 'ORIENTATIONS POUR LA PRODUCTION', '', '1', '', '7', 0, 0, 37, 1, '2016-11-28 10:50:57', '2016-11-25 15:04:00'),
(128, 1, 'ANNEXE', '', '1', '', '8', 0, 0, 42, 1, '2016-11-07 09:36:28', '2016-11-07 09:36:28'),
(302, 1, 'Contexte du projet', '', '1', '', '1.1', 1, 1, 43, 1, '2016-12-09 10:03:19', '2016-11-28 10:07:26'),
(303, 1, 'test 2', '', '1', '', '2.1', 16, 1, 44, 1, '2016-11-23 09:30:50', '2016-11-23 09:30:50'),
(304, 1, 'test 3', '', '1', '', '3.1', 19, 1, 45, 1, '2016-11-23 09:31:03', '2016-11-23 09:31:03'),
(305, 1, 'test 4', '', '1', '', '4.1', 40, 1, 46, 1, '2016-11-23 09:31:11', '2016-11-23 09:31:11'),
(306, 1, 'test 5', '', '1', '', '5.1', 43, 1, 47, 1, '2016-11-23 09:31:19', '2016-11-23 09:31:19'),
(307, 1, 'test 6', '', '1', '', '6.1', 48, 1, 48, 1, '2016-11-23 09:31:26', '2016-11-23 09:31:26'),
(308, 1, 'test 7', '', '1', '', '7.1', 123, 1, 49, 1, '2016-11-23 09:31:34', '2016-11-23 09:31:34'),
(309, 1, 'test 8', '', '1', '', '8.1', 128, 1, 50, 1, '2016-11-23 09:31:41', '2016-11-23 09:31:41'),
(310, 1, 'Vision synthétique de l’Architecture', '<p>qsdqsdqsdqdsqsdqdsddddddddddddddddddddddddddddddddddddddddddd</p>', '1', '', '1.2', 1, 1, 51, 1, '2016-12-13 20:38:13', '2016-12-13 19:38:13'),
(311, 1, 'Principes d’architecture SI appliqués par GTS/RET', '<p>ggggggggggggggggggggggggggggggggggggggggggggg</p>', '1', '', '1.2.1', 310, 2, 52, 1, '2016-12-13 20:42:46', '2016-12-13 19:42:46'),
(312, 1, 'Caractéristiques de l’architecture', '', '1', '', '1.2.2', 310, 2, 53, 1, '2016-12-09 10:03:33', '2016-11-28 09:57:03'),
(313, 1, 'Résumé technique de l’architecture', '', '1', '', '1.2.3', 310, 2, 54, 1, '2016-12-09 10:03:51', '2016-11-28 09:59:49'),
(314, 10, 'sqdqsdqsd', '<p>qsdqsdqsdqsd</p><table class="table table-bordered"><tbody><tr><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td></tr><tr><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td></tr></tbody></table><p><br></p>', '1', '', '1', 0, 0, 1, 1, '2016-12-05 14:47:31', '2016-12-05 14:47:31'),
(315, 10, 'qsdqsdqsd', '<p>dqsdqsdqdqd<br></p>', '1', '', '1.1', 314, 1, 2, 1, '2016-12-05 14:47:45', '2016-12-05 14:47:45'),
(316, 10, 'fdffdgdfgdf', '<p>gsqdqsdqsdqdsqsd<br></p>', '1', '', '2', 0, 0, 3, 1, '2016-12-05 14:47:55', '2016-12-05 14:47:55'),
(336, 1, 'dqsffdsfsdf', '', '1', '', '8.2', 128, 1, 60, 1, '2016-12-13 19:49:19', '2016-12-13 19:49:19'),
(337, 1, 'vcbxvxcv', '', '1', '', '8.3', 128, 1, 61, 1, '2016-12-13 19:58:36', '2016-12-13 19:58:36'),
(339, 1, 'qsdqsdqds', '<p>dtttttttttttttttttttttttttttttttttttttt</p>', '1', '', '1.3', 1, 1, 62, 1, '2016-12-14 08:51:23', '2016-12-14 08:51:23'),
(340, 1, 'yyyyyyyyyyyyyyyyyyy', '<p><span style="background-color: #ffff00;"><strong>ywaj</strong></span>di</p>', '1', '', '1.3.1', 339, 2, 63, 1, '2016-12-14 08:51:51', '2016-12-14 08:51:51'),
(342, 1, 'xcvxcvxcvxcv', '<p><img src="/refarc/public/source/applications/enjezok.jpg" alt="" width="719" height="502" /></p>', '1', '', '2.2', 16, 1, 65, 1, '2016-12-14 09:42:31', '2016-12-14 09:42:31');

-- --------------------------------------------------------

--
-- Structure de la table `templates_dump`
--

CREATE TABLE `templates_dump` (
  `id` int(11) NOT NULL,
  `id_template` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `text_stat` longtext NOT NULL,
  `type` enum('1','2','3','4') NOT NULL,
  `content` varchar(45) NOT NULL,
  `num_parag` varchar(45) NOT NULL,
  `parent` int(11) NOT NULL,
  `niv` int(11) NOT NULL,
  `ordre` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Vider la table avant d'insérer `templates_dump`
--

TRUNCATE TABLE `templates_dump`;
--
-- Contenu de la table `templates_dump`
--

INSERT INTO `templates_dump` (`id`, `id_template`, `text`, `text_stat`, `type`, `content`, `num_parag`, `parent`, `niv`, `ordre`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'SYNTHESE', 'qsdqsdqsdqsdqsdqsdqds', '1', '', '1', 0, 0, 1, 1, '2016-11-14 10:30:41', '2016-11-14 09:30:41'),
(2, 1, 'CONTEXTE DU PROJET', '', '1', '', '1.1', 1, 1, 2, 1, '2016-11-10 12:57:38', '2016-11-10 11:57:38'),
(8, 1, 'VISION SYNTHETIQUE DE L’ARCHITECTURE', '', '1', '', '1.2', 1, 1, 3, 1, '2016-11-10 12:21:34', '2016-11-10 11:21:34'),
(9, 1, 'Principes d’architecture SI appliqués par GTS/RET', '', '1', '', '1.2.1', 8, 2, 4, 1, '2016-11-10 12:57:53', '2016-11-10 11:57:53'),
(12, 1, 'Caractéristiques de l’architecture', '', '1', '', '1.2.2', 8, 2, 5, 1, '2016-11-09 14:47:32', '2016-11-09 12:22:13'),
(13, 1, 'Résumé technique de l’architecture', '', '1', '', '1.2.3', 8, 2, 6, 1, '2016-11-08 13:19:38', '0000-00-00 00:00:00'),
(14, 1, 'Etat d’avancement de l’étude', '', '1', '', '1.2.4', 8, 2, 7, 1, '2016-11-08 13:19:52', '2016-11-07 09:13:32'),
(15, 1, 'Lotissement de l’architecture', '', '1', '', '1.2.5', 8, 2, 8, 1, '2016-11-08 13:20:06', '2016-11-07 09:14:25'),
(16, 1, 'NIVEAU DE SERVICES DES COMPOSANTS AU SOCLE GTS', '', '1', '', '2', 0, 0, 9, 1, '2016-11-10 12:08:45', '2016-11-10 11:08:45'),
(17, 1, 'NIVEAUX DE SERVICE (SLA) DEMANDES PAR LE PROJET', '', '1', '', '2.1', 16, 1, 10, 1, '2016-11-08 10:29:28', '2016-11-07 09:15:17'),
(18, 1, 'REPONSES GTS', '', '1', '', '2.2', 16, 1, 11, 1, '2016-11-09 14:47:43', '2016-11-09 11:23:15'),
(19, 1, 'SECURITE ET RISQUES OPERATIONNELS', '', '1', '', '3', 0, 0, 12, 1, '2016-11-07 09:17:30', '2016-11-07 09:17:30'),
(20, 1, 'AVIS SECURITE', '', '1', '', '3.1', 19, 1, 13, 1, '2016-11-08 13:21:10', '2016-11-07 09:17:53'),
(21, 1, 'Exigences demandées', '', '1', '', '3.2.1', 23, 2, 15, 1, '2016-11-08 13:32:50', '2016-11-07 09:18:07'),
(22, 1, 'Services fournies et réserves', '', '1', '', '3.3.1', 19, 2, 18, 1, '2016-11-08 13:33:08', '2016-11-07 09:18:47'),
(23, 1, 'OS (DURCISSEMENT)', '', '1', '', '3.2', 19, 1, 14, 1, '2016-11-08 13:23:45', '2016-11-07 09:18:47'),
(24, 1, 'COLLECTE DES LOGS ET CORRELATION', '', '1', '', '3.3', 19, 1, 17, 1, '2016-11-08 13:34:13', '2016-11-07 09:18:47'),
(25, 1, 'Services fournies et réserves', '', '1', '', '3.2.2', 23, 2, 16, 1, '2016-11-08 13:32:57', '2016-11-07 09:18:47'),
(40, 1, 'ARCHITECTURE RESEAU', '', '1', '', '4', 0, 0, 19, 1, '2016-11-10 12:08:32', '2016-11-10 11:08:32'),
(41, 1, 'SCHEMA DU RESEAU', '', '1', '', '4.1', 40, 1, 20, 1, '2016-11-08 09:31:27', '2016-11-07 09:26:33'),
(42, 1, 'Topologie, flux, protocole, port, matrice des flux', 'qsdqsdqdqdqdssqdqd', '1', '', '4.1.1', 41, 2, 21, 1, '2016-11-09 12:29:28', '2016-11-09 11:29:28'),
(43, 1, 'ARCHITECTURE D’HEBERGEMENT APPLICATIF', '', '1', '', '5', 0, 0, 22, 1, '2016-11-07 09:26:33', '2016-11-07 09:26:33'),
(44, 1, 'DESCRIPTION DE L’ARCHITECTURE PAR ENVIRONNEMENT ET DIMENSIONNEMENT', '', '1', '', '5.1', 43, 1, 23, 1, '2016-11-08 09:31:55', '2016-11-07 09:26:33'),
(45, 1, 'Les Environnements', '', '1', '', '5.1.1', 44, 2, 24, 1, '2016-11-08 09:32:12', '2016-11-07 09:26:33'),
(46, 1, 'Composants', '', '1', '', '5.1.2', 44, 2, 25, 1, '2016-11-08 09:32:25', '2016-11-07 09:26:33'),
(47, 1, 'Environnement de [production et secours | homol | etc.]', '', '1', '', '5.1.3', 44, 2, 26, 1, '2016-11-08 09:32:39', '2016-11-07 09:26:33'),
(48, 1, 'EXERCICES (PREUVE) / ECOSYSTEMES D’HEBERGEMENT', '', '1', '', '6', 0, 0, 27, 1, '2016-11-07 09:26:33', '2016-11-07 09:26:33'),
(49, 1, 'ANALYSE DE L’ECOSYSTEME DE FLUX (PREMIER NIVEAU)', '', '1', '', '6.1', 48, 1, 28, 1, '2016-11-08 09:33:02', '2016-11-07 09:26:33'),
(50, 1, 'ANALYSE DE L’ECOSYSTEME DE DONNEES (PREMIER NIVEAU)', '', '1', '', '6.2', 48, 1, 29, 1, '2016-11-08 09:33:35', '2016-11-07 09:26:33'),
(51, 1, 'ECOSYSTEME D’HEBERGEMENT [ECOSYSTEME ]', '', '1', '', '6.3', 48, 1, 30, 1, '2016-11-08 09:33:48', '2016-11-07 09:26:33'),
(52, 1, 'Définition', '', '1', '', '6.3.1', 51, 2, 31, 1, '2016-11-08 09:34:10', '2016-11-07 09:26:33'),
(53, 1, 'Eléments à prendre en compte pour la procédure de démarrage', '', '1', '', '6.3.2', 51, 2, 32, 1, '2016-11-08 09:34:30', '2016-11-07 09:26:33'),
(119, 1, 'DEFINITION DE L’ECOLIENCE', '', '1', '', '6.4', 48, 1, 33, 1, '2016-11-08 09:34:43', '2016-11-07 09:36:28'),
(120, 1, 'NIVEAU DE PREUVE ATTEINT', '', '1', '', '6.5', 48, 1, 34, 1, '2016-11-08 09:34:57', '2016-11-07 09:36:28'),
(121, 1, 'ECOSYSTEME DE FLUX (NIVEAU 1)', '', '1', '', '6.6', 48, 1, 35, 1, '2016-11-08 09:35:09', '2016-11-07 09:36:28'),
(122, 1, 'Standard (conforme à la prestation catalogue)', '', '1', '', '6.6.1', 121, 2, 36, 1, '2016-11-08 09:35:30', '2016-11-07 09:36:28'),
(123, 1, 'ORIENTATIONS POUR LA PRODUCTION', '', '1', '', '7', 0, 0, 37, 1, '2016-11-10 12:08:56', '2016-11-10 11:08:56'),
(124, 1, 'PLAN DE MIGRATION', '', '1', '', '7.1', 123, 1, 38, 1, '2016-11-08 09:35:44', '2016-11-07 09:36:28'),
(125, 1, 'MAINTENANCE', '', '1', '', '7.2', 123, 1, 39, 1, '2016-11-08 09:35:58', '2016-11-07 09:36:28'),
(126, 1, 'ADMINISTRATION ET SUPERVISION', '', '1', '', '7.3', 123, 1, 40, 1, '2016-11-08 09:36:12', '2016-11-07 09:36:28'),
(127, 1, 'PLAN DE SECOURS', '', '1', '', '7.4', 123, 1, 41, 1, '2016-11-08 09:36:31', '2016-11-07 09:36:28'),
(128, 1, 'ANNEXE', '', '1', '', '8', 0, 0, 42, 1, '2016-11-07 09:36:28', '2016-11-07 09:36:28'),
(129, 1, 'CHECKLIST DAH (EBQ)', '', '1', '', '8.1', 128, 1, 43, 1, '2016-11-08 09:36:43', '2016-11-07 09:36:28'),
(130, 1, 'CONCLUSION DU POC TECHNIQUE (SI CELUI-CI A ETE FAIT)', '', '1', '', '8.2', 128, 1, 44, 1, '2016-11-08 09:36:58', '2016-11-07 09:36:28'),
(131, 1, 'CONCLUSION DU BENCHMARK (SI CEUX-CI SONT REALISES)', '', '1', '', '8.3', 128, 1, 45, 1, '2016-11-08 09:37:11', '2016-11-07 09:36:28'),
(132, 1, 'DOCUMENT FOURNISSEUR / INTEGRATEUR/ EDITEUR', '', '1', '', '8.4', 128, 1, 46, 1, '2016-11-08 09:37:22', '2016-11-07 09:42:37'),
(133, 1, 'GLOSSAIRE', '', '1', '', '8.5', 128, 1, 47, 1, '2016-11-08 09:37:36', '2016-11-07 09:42:37'),
(134, 1, 'DOCUMENTS CONNEXES', '', '1', '', '8.6', 128, 1, 48, 1, '2016-11-08 09:37:50', '2016-11-07 09:42:37'),
(135, 1, 'LISTE DES OPTIONS FACTURABLES', '', '1', '', '8.7', 128, 1, 49, 1, '2016-11-08 09:38:02', '2016-11-07 09:42:37'),
(136, 1, 'STRATEGIE DE POSITIONNEMENT DU SI DANS LES DATACENTERS', '', '1', '', '8.8', 128, 1, 50, 1, '2016-11-08 09:38:12', '2016-11-07 09:42:37'),
(137, 1, 'DEMARCHE POUR LES EXERCICES DISTANTS (DANS UN DISPOSITIF DE SECOURS ET/OU DE ROBUSTESSE)', '', '1', '', '8.9', 128, 1, 51, 1, '2016-11-08 09:38:23', '2016-11-07 09:42:37'),
(138, 1, 'DEMARCHE POUR LES EXERCICES LOCAUX DANS UN DISPOSITIF DE ROBUSTESSE', '', '1', '', '8.10', 128, 1, 52, 1, '2016-11-08 09:38:33', '2016-11-07 09:42:37'),
(139, 1, 'TAUX DE DISPONIBILITE MATERIEL (VISION CONSTRUCTEUR)', '', '1', '', '8.11', 128, 1, 53, 1, '2016-11-08 09:38:48', '2016-11-07 09:42:37'),
(140, 1, 'CATALOGUES SERVEURS X86', '', '1', '', '8.12', 128, 1, 54, 1, '2016-11-08 09:38:59', '2016-11-07 09:42:37'),
(189, 1, 'sqdqdsqsd', '', '1', '', '1.11.1', 187, 2, 64, 1, '2016-11-17 15:30:37', '2016-11-17 15:30:37'),
(193, 1, '3', '', '1', '', '1.3', 1, 1, 65, 1, '2016-11-18 08:42:13', '2016-11-18 08:42:13'),
(194, 1, '4', '', '1', '', '1.4', 1, 1, 66, 1, '2016-11-18 08:42:24', '2016-11-18 08:42:24'),
(195, 1, '5', '', '1', '', '1.5', 1, 1, 67, 1, '2016-11-18 08:42:31', '2016-11-18 08:42:31'),
(196, 1, '6', '', '1', '', '1.6', 1, 1, 68, 1, '2016-11-18 08:42:40', '2016-11-18 08:42:40'),
(197, 1, '7', '', '1', '', '1.7', 1, 1, 69, 1, '2016-11-18 08:42:53', '2016-11-18 08:42:53'),
(198, 1, '8', '', '1', '', '1.8', 1, 1, 70, 1, '2016-11-18 08:43:00', '2016-11-18 08:43:00'),
(199, 1, '9', '', '1', '', '1.9', 1, 1, 71, 1, '2016-11-18 08:43:09', '2016-11-18 08:43:09'),
(200, 1, '10', '', '1', '', '1.10', 1, 1, 72, 1, '2016-11-18 08:43:22', '2016-11-18 08:43:22'),
(201, 1, '11', '', '1', '', '1.11', 1, 1, 73, 1, '2016-11-18 08:44:13', '2016-11-18 08:44:13'),
(202, 1, 'test', '<p><br></p><table class="table table-bordered"><tbody><tr><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td></tr><tr><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td><td><br></td></tr></tbody></table><p><br></p>', '1', '', '1.11.1', 201, 2, 74, 1, '2016-11-18 09:44:51', '2016-11-18 08:44:51'),
(203, 1, 'ghfhfghfgh', '', '1', '', '1.12', 1, 1, 75, 1, '2016-11-18 10:16:50', '2016-11-18 10:16:50'),
(204, 1, 'sdfsdfsf', '', '1', '', '1.12.1', 203, 2, 76, 1, '2016-11-18 10:17:03', '2016-11-18 10:17:03'),
(205, 1, 'test delete', '', '1', '', '9', 0, 0, 77, 1, '2016-11-18 10:32:11', '2016-11-18 10:32:11'),
(211, 1, 'qsdqsdqds', '', '1', '', '10', 0, 0, 78, 1, '2016-11-18 12:20:35', '2016-11-18 12:20:35'),
(212, 1, 'qsdqsdqsdqdsqd', '', '1', '', '11', 0, 0, 79, 1, '2016-11-18 12:20:43', '2016-11-18 12:20:43'),
(213, 1, 'qsdqsdqsdqsd', '', '1', '', '12', 0, 0, 80, 1, '2016-11-18 12:20:54', '2016-11-18 12:20:54'),
(214, 1, 'qsdqsdqsd', '', '1', '', '11.1', 212, 1, 81, 1, '2016-11-18 12:35:02', '2016-11-18 12:35:02');

-- --------------------------------------------------------

--
-- Structure de la table `templates_params`
--

CREATE TABLE `templates_params` (
  `id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `nbapps` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Vider la table avant d'insérer `templates_params`
--

TRUNCATE TABLE `templates_params`;
--
-- Contenu de la table `templates_params`
--

INSERT INTO `templates_params` (`id`, `version`, `comment`, `user_id`, `type`, `nbapps`, `created_at`, `updated_at`) VALUES
(1, 1, 'vers1', 1, 1, 1, '2016-12-14 17:13:36', '2016-12-14 16:13:36'),
(2, 1, 'vers2', 1, 2, 0, '2016-12-14 15:01:20', '2016-12-14 15:01:20'),
(3, 1, 'vers2', 1, 3, 0, '2016-12-14 15:02:01', '2016-12-14 15:02:01'),
(4, 2, 'vers2', 1, 3, 2, '2016-12-14 16:25:35', '2016-12-14 15:02:23'),
(5, 2, 'vers3', 1, 1, 0, '2016-12-14 15:05:05', '2016-12-14 15:05:05'),
(6, 1, 'vers3', 1, 4, 1, '2016-12-14 16:25:17', '2016-12-14 15:19:41');

-- --------------------------------------------------------

--
-- Structure de la table `typetpl`
--

CREATE TABLE `typetpl` (
  `id` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Vider la table avant d'insérer `typetpl`
--

TRUNCATE TABLE `typetpl`;
--
-- Contenu de la table `typetpl`
--

INSERT INTO `typetpl` (`id`, `type`, `created_at`, `updated_at`) VALUES
(1, 'DAH', '2016-12-14 15:00:51', '2016-12-14 15:00:51'),
(2, 'DAU', '2016-12-14 15:01:15', '2016-12-14 15:01:15'),
(3, 'DAZ', '2016-12-14 15:01:58', '2016-12-14 15:01:58'),
(4, 'DAT', '2016-12-14 15:19:38', '2016-12-14 15:19:38');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL,
  `banned` tinyint(1) NOT NULL,
  `register_ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `country_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `activation_key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `su` tinyint(1) NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `users`
--

TRUNCATE TABLE `users`;
--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `active`, `banned`, `register_ip`, `country_code`, `locale`, `activation_key`, `su`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Wajdi', 'hammami.ouajdi@gmail.com', '$2y$10$p1iNnPAuuHljzo9zk1zroOu25y.HkmQNlPAJcmn4XvS3JoLRYhz/C', 1, 0, '', 'FR', 'en', 'A772sNxQfXSTOX0gEDPzhceEd', 1, 'HiezcGIcZ8QJxStbsdcnLszWJoevfazT5vKdZ9yIwWRkRUel0qzcStfXJB8s', '2016-10-10 12:31:59', '2016-12-14 16:02:12'),
(4, 'Julien Houllier', 'ouajdi10@yahoo.fr', '$2y$10$3AHxfCcJoDFVsIWmCn8nROUfkEV67HE.mDs8KKah1JIpz8DlVXXEO', 1, 0, '::1', 'GT', '', 'nHNQbWhmDFVbw7JjYDBM9lvqQ', 0, '5TpmUVLtucVNU7GHMLbcQ6DnlYBtHjUcajyTekUG4ak7H5iEUBcuGk5rB4ax', '2016-10-10 12:36:16', '2016-10-18 08:55:50'),
(5, 'Julien', 'houllier.julien@gmail.com', '$2y$10$wdtgJ1j7vC2AGUyi40Z8qOKnYMnaW/R0zWi8fz5RqpdOTuWrQ0Evi', 1, 0, '::1', 'FF', '', 'CjGgzRzCqdcMhbXOrSYzc02Gb', 0, NULL, '2016-10-12 06:44:16', '2016-10-12 06:46:59'),
(13, 'Julien Hammami', '1hammami.ouajdi@gmail.com', '$2y$10$tGRa4W/YvgW1oLhQZwthje9/l.D6jEpt6Nb5.nHC11k6EjrZ.Q5Oa', 1, 0, '::1', 'FR', '', 'gkfTKIVHRRvQWFeExssSpEJes', 0, 'p8SOco9nBgHhRWN7hpmWu98JE7kDNvCrDUfuKbYpvHSx9h86rk7FIFnpImni', '2016-11-02 14:12:08', '2016-12-14 16:00:40'),
(14, 'User1', 'admin@admin.com', '$2y$10$4IJn.ZkfKsRhcL7j.smuiO/YRJtZ4S.aRrCR1zLctr8c8GNG/HLkW', 1, 0, '::1', 'FR', '', 'bUsvbvOshanUQgsXW2upg2YdG', 0, NULL, '2016-11-04 08:01:15', '2016-11-04 08:01:16'),
(15, 'User2', '12hammami.ouajdi@gmail.com', '$2y$10$lNIOaROhGsud5Fmg5ltrAO6wBrd35YsP.RygA3svVoumLnz3upz4S', 1, 0, '::1', 'FR', '', 'UM4kB55bjEnQAxBtOWGT1IyvP', 0, NULL, '2016-11-04 09:21:16', '2016-11-04 09:21:16'),
(16, 'Julien Hammami', 'admin10@admin.com', '$2y$10$ls4ZjnlRTMn5KMO6uPEsOuzNxbR1rbXYwajESz9RHWPg96WWsAU4y', 1, 0, '::1', 'FR', '', 'ANgv5hPc6ke8OYOtKwpDJHxBY', 0, NULL, '2016-11-04 11:46:53', '2016-11-04 11:46:53'),
(17, 'Qqsdqsd', '11hammami.ouajdi@gmail.com', '$2y$10$pafdw5F.PNuJkg.kn882UOHJc5.cSwMsmTlrkJZwsFkw39pnIWLfi', 1, 0, '::1', '', '', 'irbTOPEatrsAYs8EzwPf9GeIr', 0, NULL, '2016-11-21 13:32:12', '2016-11-21 13:32:12'),
(18, 'Qqsdqsd Dsfsfsdf', 'ouajdi100@yahoo.fr', '$2y$10$lJN0OAbrv/fspC//rbWuKe99BHNPvYx8yz/sD7zEo4otV4U2jnzKW', 1, 0, '::1', '', '', '6qS0XRJc1NlBxZX3kozizkw13', 0, 'WRn70H353WgwBtquWsxGPQFGFfBjS0xbtMAwC9ribNStrfwoHRRnzVFVIoht', '2016-11-21 13:36:23', '2016-11-21 13:37:14');

-- --------------------------------------------------------

--
-- Structure de la table `users_settings`
--

CREATE TABLE `users_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `default_role` int(11) NOT NULL,
  `location` tinyint(1) NOT NULL COMMENT '0: off, 1: on',
  `register_enabled` tinyint(1) NOT NULL COMMENT '0: off, 1: on',
  `default_active` int(11) NOT NULL COMMENT '0: off, 1: email, 2: on',
  `welcome_email` tinyint(1) NOT NULL COMMENT '0: off, 1: on'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Vider la table avant d'insérer `users_settings`
--

TRUNCATE TABLE `users_settings`;
--
-- Contenu de la table `users_settings`
--

INSERT INTO `users_settings` (`id`, `default_role`, `location`, `register_enabled`, `default_active`, `welcome_email`) VALUES
(1, 1, 0, 1, 2, 0);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `applications_content`
--
ALTER TABLE `applications_content`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `blog_role`
--
ALTER TABLE `blog_role`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `diffusion`
--
ALTER TABLE `diffusion`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `documents_name_unique` (`name`),
  ADD UNIQUE KEY `documents_slug_unique` (`slug`);

--
-- Index pour la table `histo_applications`
--
ALTER TABLE `histo_applications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `histo_projects`
--
ALTER TABLE `histo_projects`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `intervenants`
--
ALTER TABLE `intervenants`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`),
  ADD KEY `password_resets_token_index` (`token`);

--
-- Index pour la table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_slug_unique` (`slug`);

--
-- Index pour la table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pictures`
--
ALTER TABLE `pictures`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `post_comments`
--
ALTER TABLE `post_comments`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `post_views`
--
ALTER TABLE `post_views`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Index pour la table `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `socials`
--
ALTER TABLE `socials`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `templates_dump`
--
ALTER TABLE `templates_dump`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `templates_params`
--
ALTER TABLE `templates_params`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `typetpl`
--
ALTER TABLE `typetpl`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Index pour la table `users_settings`
--
ALTER TABLE `users_settings`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT pour la table `applications_content`
--
ALTER TABLE `applications_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT pour la table `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `blog_role`
--
ALTER TABLE `blog_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `diffusion`
--
ALTER TABLE `diffusion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `histo_applications`
--
ALTER TABLE `histo_applications`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT pour la table `histo_projects`
--
ALTER TABLE `histo_projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;
--
-- AUTO_INCREMENT pour la table `intervenants`
--
ALTER TABLE `intervenants`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT pour la table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;
--
-- AUTO_INCREMENT pour la table `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;
--
-- AUTO_INCREMENT pour la table `pictures`
--
ALTER TABLE `pictures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT pour la table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `post_comments`
--
ALTER TABLE `post_comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `post_views`
--
ALTER TABLE `post_views`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT pour la table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `socials`
--
ALTER TABLE `socials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `templates`
--
ALTER TABLE `templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=346;
--
-- AUTO_INCREMENT pour la table `templates_dump`
--
ALTER TABLE `templates_dump`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;
--
-- AUTO_INCREMENT pour la table `templates_params`
--
ALTER TABLE `templates_params`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `typetpl`
--
ALTER TABLE `typetpl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT pour la table `users_settings`
--
ALTER TABLE `users_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
