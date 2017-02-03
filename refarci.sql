-- phpMyAdmin SQL Dump
-- version 4.4.4
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1:3306
-- Généré le :  Ven 03 Février 2017 à 17:02
-- Version du serveur :  5.7.10
-- Version de PHP :  5.6.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `refarci`
--

-- --------------------------------------------------------

--
-- Structure de la table `applications_content`
--

CREATE TABLE IF NOT EXISTS `applications_content` (
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

-- --------------------------------------------------------

--
-- Structure de la table `applications_params`
--

CREATE TABLE IF NOT EXISTS `applications_params` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ecolience` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `irt` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `trigramme` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `criticite_stamp` enum('Non prioritaire','Secondaire','Critique','Vitale') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Non prioritaire',
  `sensible_groupe` tinyint(1) NOT NULL,
  `demande_client` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `statu` enum('Draft','Validé','Pré-validé','Attente Visa Sécurité') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Draft',
  `niv_sensible_fraude` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `template_id` int(11) NOT NULL,
  `active_edit` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déclencheurs `applications_params`
--
DELIMITER $$
CREATE TRIGGER `update_apps` AFTER UPDATE ON `applications_params`
 FOR EACH ROW BEGIN
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
-- Structure de la table `applications_planning`
--

CREATE TABLE IF NOT EXISTS `applications_planning` (
  `id` int(11) NOT NULL,
  `id_app` int(11) NOT NULL,
  `jalon` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `commentaires` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `applications_version_history`
--

CREATE TABLE IF NOT EXISTS `applications_version_history` (
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
  `version` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `diffusion`
--

CREATE TABLE IF NOT EXISTS `diffusion` (
  `id` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `entite` varchar(50) NOT NULL,
  `objet` varchar(50) NOT NULL,
  `id_app` int(10) NOT NULL,
  `id_user` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `documents`
--

CREATE TABLE IF NOT EXISTS `documents` (
  `id` int(10) unsigned NOT NULL,
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

-- --------------------------------------------------------

--
-- Structure de la table `experiences`
--

CREATE TABLE IF NOT EXISTS `experiences` (
  `id` int(11) NOT NULL,
  `page` varchar(255) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `type` enum('bug','evolution') NOT NULL,
  `criticite` enum('basse','moyenne','haute') NOT NULL,
  `id_user` int(11) NOT NULL,
  `wished_at` date NOT NULL DEFAULT '2017-02-01',
  `planned_at` varchar(20) NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `experiences`
--

INSERT INTO `experiences` (`id`, `page`, `comment`, `status`, `type`, `criticite`, `id_user`, `wished_at`, `planned_at`, `created_at`, `updated_at`) VALUES
(2, 'Tableau de bord', 'Home button erreur', 'Traité', 'bug', 'basse', 3, 0x323031372d30322d3031, '2017-01-24', 0x323031372d30312d3139, 0x323031372d30312d32342031343a30323a3338),
(22, 'Administration utilisateur', 'Pouvoir utiliser l''ID Sesame pour la connexion', 'A Analyser', 'evolution', 'moyenne', 2, 0x323031372d30322d3031, '2017-01-27', 0x323031372d30312d3236, 0x323031372d30312d32362031353a31323a3238),
(5, 'Administration utilisateur', 'Les projets et le progression des projects peux etre presenter en forme liste', 'StandBy', 'bug', 'basse', 3, 0x323031372d30322d3031, '2017-02-01', 0x323031372d30312d3139, 0x323031372d30312d32362031353a31333a3239),
(11, 'Liste des templates', 'Il serait intéressant que l''admin puisse modifier/supprimer un type de template.', 'Traité', 'bug', 'basse', 2, 0x323031372d30322d3031, '2017-01-25', 0x323031372d30312d3230, 0x323031372d30312d32352031353a34373a3132),
(7, 'Tableau de bord', 'Role création par l''admin provoque un erreur', 'Traité', 'bug', 'basse', 3, 0x323031372d30322d3031, '2017-01-31', 0x323031372d30312d3139, 0x323031372d30312d33312031353a34313a3133),
(8, 'Liste des utilisateurs', 'La liste des utilisateurs créés avant le 19/01/17 ne présente pas les icônes de modification/suppression.\nLorsqu''on créé un utilisateur à partir du 19/01, les icônes apparaissent.\nDepuis ce matin, toutes les icônes ont disparu :(', 'Traité', 'bug', 'haute', 2, 0x323031372d30322d3031, '2017-01-30', 0x323031372d30312d3139, 0x323031372d30312d33302031333a34363a3432),
(9, 'Tableau de bord', 'Pour le "Retour d''Expérience" :\r\n- Classifier : Amélioration, bug\r\n- Niveau d''urgence', 'Traité', 'bug', 'basse', 2, 0x323031372d30322d3031, '2017-01-24', 0x323031372d30312d3139, 0x323031372d30312d32342031343a32333a3530),
(10, 'Création d''un template', 'Les titres ou sous titres ne sont pas visible quand on descends. On est perdu pour savoir ou on est dans le DAH', 'A Analyser', 'bug', 'basse', 3, 0x323031372d30322d3031, '2017-02-01', 0x323031372d30312d3139, 0x323031372d30312d32362031343a31343a3136),
(13, 'Liste des templates', 'Peut-on importer un template à partir du fichier existant (format doc ou xml) ?\n--> Ne passer de temps sur ce sujet QUE si cela peut servir de base à l''import d''anciens DAH', 'StandBy', 'evolution', 'basse', 2, 0x323031372d30322d3031, '2017-02-01', 0x323031372d30312d3233, 0x323031372d30312d32362031353a31353a3132),
(21, 'Administration utilisateur', 'Pas de possibilité de modifier le mot de passe', 'Traité', 'bug', 'moyenne', 2, 0x323031372d30322d3031, '2017-01-26', 0x323031372d30312d3236, 0x323031372d30312d32362031353a31333a3130),
(18, 'Tableau de bord', 'Supprimer l''icône Notifications tant qu''elle n''est pas opérationnelles', 'Traité', 'bug', 'basse', 2, 0x323031372d30322d3031, '2017-01-24', 0x323031372d30312d3233, 0x323031372d30312d32342031363a31313a3330);

-- --------------------------------------------------------

--
-- Structure de la table `histo_applications`
--

CREATE TABLE IF NOT EXISTS `histo_applications` (
  `id` int(10) unsigned NOT NULL,
  `namefield` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `old_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `new_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `id_original` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `histo_projects`
--

CREATE TABLE IF NOT EXISTS `histo_projects` (
  `id` int(10) unsigned NOT NULL,
  `namefield` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `old_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `new_value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `id_original` int(11) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `intervenants`
--

CREATE TABLE IF NOT EXISTS `intervenants` (
  `id` int(10) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `resp_domain` varchar(50) NOT NULL,
  `entite` varchar(50) NOT NULL,
  `id_app` int(10) NOT NULL,
  `id_user` int(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `intervenants`
--

INSERT INTO `intervenants` (`id`, `nom`, `email`, `resp_domain`, `entite`, `id_app`, `id_user`, `created_at`, `updated_at`) VALUES
(1, 'houllier julien', 'houllier.julien@gmail.com', 'Dev', 'RESG/RET/APS', 11, 2, 0x323031362d31312d32382031353a35383a3033, 0x303030302d30302d30302030303a30303a3030),
(2, 'hammami wajdi', 'hammami.wajdi@gmail.com', 'Dev', 'RESG/GTS/API', 11, 3, 0x323031362d31312d32382031353a35383a3036, 0x303030302d30302d30302030303a30303a3030),
(5, 'hammami julien', 'houllier.julien@gmail.com', 'Dev', 'RESG/RET/APS', 11, 34, 0x323031362d31312d32382031353a35383a3038, 0x303030302d30302d30302030303a30303a3030),
(23, 'houllier julien', 'houllier.julien@gmail.com', 'Dev', 'RESG/RET/APS', 1, 1, 0x323031362d31322d30322031383a35333a3334, 0x323031362d31322d30322031383a35333a3334),
(21, 'houllier julien', 'houllier.julien@gmail.com', 'Dev', 'RESG/RET/APS', 11, 1, 0x323031362d31312d32382031353a35383a3130, 0x323031362d31312d32382031343a34363a3534),
(22, 'F. LEVEL DE CURNIEU', 'f.level@gmail.com', 'Manager', 'RESG/APS/RET', 1, 1, 0x323031362d31312d32382031353a30333a3232, 0x323031362d31312d32382031353a30333a3232),
(24, 'houllier julien', 'houllier.julien@gmail.com', 'Dev', 'RESG/RET/APS', 12, 1, 0x323031362d31322d31352031323a33373a3232, 0x323031362d31322d31352031323a33373a3232);

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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

CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `assignable` tinyint(1) NOT NULL,
  `su` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `permissions`
--

INSERT INTO `permissions` (`id`, `slug`, `assignable`, `su`, `created_at`, `updated_at`) VALUES
(1, 'refarc.access', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(2, 'refarc.users.access', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(3, 'refarc.users.create', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(4, 'refarc.users.edit', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(5, 'refarc.users.roles', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(6, 'refarc.users.delete', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(7, 'refarc.users.settings', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(8, 'refarc.roles.access', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(9, 'refarc.roles.create', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(10, 'refarc.roles.edit', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(11, 'refarc.roles.permissions', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(12, 'refarc.roles.delete', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(13, 'refarc.permissions.access', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(14, 'refarc.permissions.create', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(15, 'refarc.permissions.edit', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(29, 'refarc.files.access', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(30, 'refarc.files.upload', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(31, 'refarc.files.download', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(32, 'refarc.files.delete', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(36, 'refarc.settings.access', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(37, 'refarc.settings.edit', 1, 1, 0x323031362d31302d31302031323a33323a3031, 0x323031362d31302d31302031323a33323a3031),
(39, 'refarc.projects.access', 1, 1, 0x323031362d31302d30392032323a30303a3030, 0x323031362d31302d31302031333a32373a3037),
(40, 'refarc.projects.edit', 1, 1, 0x323031362d31302d30392032323a30303a3030, 0x323031362d31302d30392032323a30303a3030),
(41, 'refarc.projects.create', 1, 1, 0x323031362d31302d30392032323a30303a3030, 0x323031362d31302d30392032323a30303a3030),
(43, 'refarc.applications.access', 1, 1, 0x323031362d31302d32342032323a30303a3030, 0x323031362d31302d32342032323a30303a3030),
(44, 'refarc.applications.create', 1, 1, NULL, NULL),
(45, 'refarc.applications.edit', 1, 1, 0x323031362d31302d32342032323a30303a3030, 0x323031362d31302d32342032323a30303a3030),
(46, 'refarc.templates.access', 1, 1, 0x323031362d31312d30332032333a30303a3030, NULL),
(47, 'refarc.templates.edit', 1, 1, NULL, NULL),
(48, 'refarc.templates.create', 1, 1, 0x323031362d31312d30332032333a30303a3030, NULL),
(49, 'refarc.templates.delete', 1, 1, NULL, NULL),
(50, 'refarc.applications.final', 1, 1, NULL, NULL),
(52, 'refarc.projects.archive', 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `permission_role`
--

CREATE TABLE IF NOT EXISTS `permission_role` (
  `id` int(10) unsigned NOT NULL,
  `permission_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(36, 36, 1, NULL, NULL),
(37, 37, 1, NULL, NULL),
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
(127, 43, 3, NULL, NULL),
(128, 1, 2, NULL, NULL),
(129, 45, 1, NULL, NULL),
(130, 50, 1, NULL, NULL),
(132, 52, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `pictures`
--

CREATE TABLE IF NOT EXISTS `pictures` (
  `id` int(11) NOT NULL,
  `id_app` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `user_id` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `pictures`
--

INSERT INTO `pictures` (`id`, `id_app`, `nom`, `user_id`, `updated_at`, `created_at`) VALUES
(11, 0, 'T01_1_tplsModif.PNG', 1, 0x323031362d31312d33302031343a35333a3336, 0x323031362d31312d33302031343a35333a3336),
(12, 0, 'T01_2_appHist.PNG', 1, 0x323031362d31312d33302031343a35353a3231, 0x323031362d31312d33302031343a35353a3231),
(13, 0, 'T01_3_roles.PNG', 1, 0x323031362d31312d33302031353a30343a3131, 0x323031362d31312d33302031353a30343a3131),
(14, 0, 'T01_4_tpls.PNG', 1, 0x323031362d31312d33302031353a30343a3337, 0x323031362d31312d33302031353a30343a3337),
(15, 0, 'T01_5_appsProfil.PNG', 1, 0x323031362d31312d33302031353a32303a3236, 0x323031362d31312d33302031353a32303a3236),
(16, 0, 'T01_6_cnx.PNG', 1, 0x323031362d31312d33302031353a34303a3037, 0x323031362d31312d33302031353a34303a3037);

-- --------------------------------------------------------

--
-- Structure de la table `projects`
--

CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `nb_apps` int(11) NOT NULL,
  `statu` tinyint(1) NOT NULL DEFAULT '0',
  `archived` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déclencheurs `projects`
--
DELIMITER $$
CREATE TRIGGER `update_data` AFTER UPDATE ON `projects`
 FOR EACH ROW BEGIN
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

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `assignable` tinyint(1) NOT NULL,
  `allow_editing` tinyint(1) NOT NULL,
  `su` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `color`, `assignable`, `allow_editing`, `su`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'red', 0, 0, 1, 0x323031362d31302d31302031323a33323a3030, 0x323031362d31302d31302031323a33383a3132),
(2, 'ARCHITECT', 'red', 0, 0, 0, 0x323031362d31302d31302031323a33393a3231, 0x323031362d31302d31302031323a33393a3231),
(3, 'Observateurs', 'red', 0, 0, 0, 0x323031362d31312d30322030393a34363a3138, 0x323031372d30312d30332031333a30373a3139),
(4, 'Securite', 'red', 0, 0, 0, 0x323031372d30312d30332031333a31303a3337, 0x323031372d30312d30332031333a31303a3337),
(6, 'Rôle test', 'red', 0, 0, 0, 0x323031372d30312d32332031353a32373a3431, 0x323031372d30312d32332031353a32373a3431),
(8, 'Role 1', 'red', 0, 0, 0, 0x323031372d30312d32362031343a31353a3438, 0x323031372d30312d32362031343a31353a3438);

-- --------------------------------------------------------

--
-- Structure de la table `role_user`
--

CREATE TABLE IF NOT EXISTS `role_user` (
  `id` int(10) unsigned NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `role_user`
--

INSERT INTO `role_user` (`id`, `role_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0x323031362d31302d31302031323a33323a3030, 0x323031362d31302d31302031323a33323a3030),
(2, 1, 2, NULL, NULL),
(7, 2, 10, 0x323031372d30312d32342031343a31333a3434, 0x323031372d30312d32342031343a31333a3434),
(22, 2, 3, 0x323031372d30312d32362031343a31373a3430, 0x323031372d30312d32362031343a31373a3430);

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(10) unsigned NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `settings`
--

INSERT INTO `settings` (`id`, `laralum_version`, `website_title`, `logo`, `button_color`, `header_color`, `pie_chart_source`, `bar_chart_source`, `line_chart_source`, `geo_chart_source`, `created_at`, `updated_at`) VALUES
(1, '2.1.3', 'REF''ARC', '', 'black', '#DB2828', 'highcharts', 'highcharts', 'highcharts', 'highcharts', 0x323031362d31302d31302031323a33323a3033, 0x323031362d31302d33312030393a30353a3235);

-- --------------------------------------------------------

--
-- Structure de la table `templates`
--

CREATE TABLE IF NOT EXISTS `templates` (
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
) ENGINE=InnoDB AUTO_INCREMENT=463 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `templates`
--

INSERT INTO `templates` (`id`, `id_template`, `text`, `text_stat`, `type`, `content`, `num_parag`, `parent`, `niv`, `ordre`, `user_id`, `created_at`, `updated_at`) VALUES
(349, 1, 'Synthèse', '<p>Fiche Synth&egrave;se du document</p>\n<table>\n<tbody>\n<tr>\n<td>IRT/ Trigramme</td>\n<td>AAAA / XYZ</td>\n</tr>\n<tr>\n<td>Applications</td>\n<td>Nom Application XXXX</td>\n</tr>\n<tr>\n<td>Code Ecolience</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Progiciel(s)</td>\n<td>Nom(s) + release utilisee pour l''application</td>\n</tr>\n<tr>\n<td>Typologie Architecture</td>\n<td>\n<p>Web Transactionnel C1 ou non standard</p>\n<p>Web D&eacute;cisionnel D1, D2 ou non standard</p>\n</td>\n</tr>\n<tr>\n<td>Preconisations de GTS non retenues par la ME</td>\n<td>\n<p>Statut : R&eacute;diger la vision synthetique de l''architecte</p>\n<p>Lister les preconisations non retenues de maniere synthetique :</p>\n<ul>\n<li>DDD</li>\n<li>AAA</li>\n</ul>\n<p>Les point sont detailles dans le prg 1.2 "vision de l''architecture"</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>Description de l''architecture de production</p>\n<table style="height:2732px;" width="1531">\n<tbody>\n<tr>\n<td style="width:298px;">Site primaire d''hebergement</td>\n<td style="width:1233px;">Tigery / Marcoussis DC02 / Seclin2 / Seclin1 / Valmy</td>\n</tr>\n<tr>\n<td style="width:298px;">Site secondaire</td>\n<td style="width:1233px;">Seclin2 / Marcoussis DC02</td>\n</tr>\n<tr>\n<td style="width:298px;">Modele d''architecture de resilience</td>\n<td style="width:1233px;">\n<ul>\n<li>1+0:A</li>\n<li>1+0:HA</li>\n<li>1+1:A+A</li>\n<li>1+1:A + Hot Standby</li>\n<li>1+1:A + Hot Standby croise</li>\n<li>1+1:A + Cold Standby</li>\n<li>1+1:HA + Cold Standby</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Mod&egrave;le de solution de resilience de l''ecolience</td>\n<td style="width:1233px;">\n<p>Bronze,Argent,Or,Saphir,Rubis,Emeraude</p>\n<p>Objectif de delai de retablissement GTS(panne) : 0h,4h,8h,24h</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Niveau d''exercices entre deuxi sites distans atteignables</td>\n<td style="width:1233px;">\n<ul>\n<li>Exercice unitaire hors charge (validation technique)</li>\n<li>Exercice hors charge de l''ecolience</li>\n<li>Exercice pleine charge de l''ecolience</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Couches m&eacute;tiers</td>\n<td style="width:1233px;">\n<p>Pour les couches/services ci-dessous, pr&eacute;ciser en gras les composants techniques associes a des fonctions applicatives vitales/critiques (par opposition aux fonctions non prioritaires ou secondaires) -&gt; impact direct sur le processus de prise en charge des incidents</p>\n<p>Ex: fournie en boite noire (realise autour du progiciel zz)</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Services d''echanges</td>\n<td style="width:1233px;">\n<ul>\n<li>WMQ R.m</li>\n<li>Connect: eXpress R.m</li>\n<li>SMTP</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Services d''application</td>\n<td style="width:1233px;">\n<ul>\n<li>Weblogic xxgRxx et dsk &amp;.5</li>\n<li>Informatica</li>\n<li>Tomcat</li>\n</ul>\n<p>&nbsp;La matrice de comptabilite impose une version &lt; &agrave; ...</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Services donnees</td>\n<td style="width:1233px;">\n<ul>\n<li>Oracle ww.x.y.z</li>\n<li>IBM DB2 w.x</li>\n<li>Microsoft SQL Server xxxx</li>\n</ul>\n<p>La matrice de comptabilite impose une version &lt; a ...</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">zone ordennancement</td>\n<td style="width:1233px;">\n<p>Control M</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Zones Cellules Securite Reseau</td>\n<td style="width:1233px;">\n<p>CITSv2 , L3 BSC Mutualise , PCMS , CAZA , TNU , GMS , PGN , PEPSY , MAIA</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Systemes d''exploitation</td>\n<td style="width:1233px;">\n<ul>\n<li>Linux Red Hat 6.6</li>\n<li>Windows 2012 SPxx</li>\n<li>AIX 6.1 TL3</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Classe de resilience du stockage</td>\n<td style="width:1233px;">SAN : M0,M1,L0,L1 + id du groupe de coh&eacute;rence</td>\n</tr>\n<tr>\n<td style="width:298px;">Conformit&eacute; standard et politique</td>\n<td style="width:1233px;">\n<p><span style="text-decoration:underline;">Durcissement OS</span></p>\n<p>Advanced / Premium / Premium +</p>\n<p>Plusieurs choix possibles en fonction de la sensibilit&eacute; de l''application (voir QES ou ASA) (le niveau de durcissement par serveur est formalise dans les paragraphes 4 par environnement)</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Features hors socle &agrave; installer</td>\n<td style="width:1233px;">\n<p>Features a installer hors socle ou ce qui est obligatoire (le detail prg 2)</p>\n<p>JVM Oracle dans la couche DB,OpenSSH</p>\n<p>Autres regles de durcissement Ex: JVM Oracle dans la douche DB,OpenSSH</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Ressources Techniques</td>\n<td style="width:1233px;">\n<p>3 choix possibles :</p>\n<ul>\n<li>Indiquer les paragraphes correspondants par environnement ex 4.1.2</li>\n<li>Mettre ici le tableau recapitulatif tout environnement</li>\n<li>ou en litteraire (ex: ci-dessous)</li>\n</ul>\n<p>[Environnement]<br />" fonction" (N/R/M): PxxxLX01 &agrave; 04: 4 standards x86, cluster VCS, xxx Go SAN ou NAS (ou DAS)</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Offres GTS</td>\n<td style="width:1233px;">\n<p>RET : OMLX, SQM,OMDG<br />TFO : SIPO [Exotique], etc<br />EUS : @PAC,...</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Servitudes</td>\n<td style="width:1233px;">\n<p>Sauvegarde standard TSM ou Lan Free Backup ou specifique (ex: networker sur valmy)<br />Supervision standard patrol</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Ressources reseaux</td>\n<td style="width:1233px;">\n<p>x lien 100 Mb | 1Gb | 10Gb</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Poste de travail</td>\n<td style="width:1233px;">Client lourd ou client web NDG ARPEGE IE8<br />International oui/non</td>\n</tr>\n<tr>\n<td style="width:298px;">Services d''acces</td>\n<td style="width:1233px;">CITRIX , PAX , TRAP , I2BD , GAIA , VPN , LS</td>\n</tr>\n<tr>\n<td style="width:298px;">Processus de livraison des packages applicatifs en production</td>\n<td style="width:1233px;">\n<p>Earth CDI<br />Non standard (scp,client lourd, etc)</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>Ecarts :</p>\n<table>\n<tbody>\n<tr>\n<td rowspan="7">Pricipaux ecarts par rapport a la strategie ou aux exigences GTS</td>\n<td>Domaine</td>\n<td>Ecart ?<br />Oui/non</td>\n</tr>\n<tr>\n<td>Securite</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Virtualisation comme 1er choix de hosting</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Capacite a realiser des exercices en pleine charge / ecosysteme de donnees et de flux definis et valides</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>RedCat</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Strategie DataCenter</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Processus de livraison standard</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Principaux ecarts par rapport aux besoins exprimes</td>\n<td colspan="2">Synthese : xxxxx<br />Lister les ecarts de maniere synthetique<br />\n<ul>\n<li>Ecart 1 : domaine / description synthetique</li>\n<li>ex SLA de disponibilite</li>\n<li>ex : couverture de risques</li>\n<li>...<br /><br />Les points sont detailles dans le paragraphe 1.2.2 "Vision Architecture"</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td>Synthese de l''avis securite</td>\n<td colspan="2">Rappeler le niveau d''ISR indique en cartouche (page de garde)<br />Les points sont detailles dans le paragraphe 3.1 "Avis Securite Detaille"</td>\n</tr>\n</tbody>\n</table>\n<p>Dans le paragraphe 1.2.2, le recapitulatif des besoins declines par offre et par environnement et par site</p>', '1', '', '1', 0, 0, 1, 1, 0x323031372d30312d33302031303a34393a3539, 0x323031372d30312d33302030393a34393a3539),
(350, 1, 'Contexte du projet', '<p>Cette version de DAH (version x.y) decrit les impacts suite a ces demandes.<br /><br />Le scenario de migration retenu est decrit dans le paragraphe 4.1.3</p>', '1', '', '1.1', 349, 1, 2, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031323a34353a3535),
(351, 1, 'Vision synthetique de l''architecture', '', '1', '', '1.2', 349, 1, 3, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031323a34363a3337),
(352, 1, 'Principes d''architecture SI appliques par GTS/RET', '<p>&nbsp;</p>\n<table>\n<tbody>\n<tr>\n<td>N&deg;</td>\n<td>Formulation simplifiee du principe, le document de reference reste le "livre blanc resilience GTS"</td>\n</tr>\n<tr>\n<td>1</td>\n<td>Les applications vitales et critiques sont regroupees en ecolience pour permettre la realisation d''exercices de robustesse ou de secours</td>\n</tr>\n<tr>\n<td>2</td>\n<td>GTS assure la resilience d''une ecolience soit par un dispositif de robustesse sur le meme site ou sur deux sites interregionnaux, eventuellement complete par un disposotif de secours a froid hors region (fonction de l''EBCA, Expression de Besoins de Continuite d''Activite exprimee par les Metiers Bancaires)<br />Les donnes d''une ecolience sont localisees sur un seul site si la coherence des donnees secourues est assuree par GTS<br /><br />Les 3 cas de risque d''indisponibilite couverts sont : panne de composant, perte de site et choc regional<br /><br />La couverture de perte de salle adresse en priorite les besoins de RBDF.</td>\n</tr>\n<tr>\n<td>3</td>\n<td>Le dispositif de robustesse ou de secours peut etre con&ccedil;u pour limiter l''impact d''une panne applicative ou materielle &agrave; tout ou partie des utilisateurs finaux<br /><br />La declinaison de ce principe est fonction des SLA exprimes et du budget.</td>\n</tr>\n<tr>\n<td>4</td>\n<td>Les applications de Reseaux France, exploitees par GTS/RET, sont localisees preferentiellement a TIGERY<br />Les applications Directions Centrales et GTPS, exploitees par GTS/RET, sont localises preferentiellement &agrave; Marcoussis DC02<br />Les applications de pilotage de GTS sont localises preferentiellement a Seclin2</td>\n</tr>\n<tr>\n<td>5</td>\n<td>En standard, le dispositif de secours est a froid, non robuste et non secouru<br />En standard, GTS ne couvre pas le cas de double-panne (panne du composant nominal et panne du dispositif assurant la resilience du composant)</td>\n</tr>\n<tr>\n<td>6</td>\n<td>Les environnements non production sont localises preferentiellement a Seclin2 (sauf le systeme zOs)</td>\n</tr>\n<tr>\n<td>7</td>\n<td>La DSI est responsable de l''integrite de la transaction fonctionnelle sur le site nominal.</td>\n</tr>\n<tr>\n<td>8</td>\n<td>Si le principe 2 (donnees) n''est pas respecte, le perimetre 8 n''est pas applicable, la DSI est responsable de l''integrite de la transaction sur les dispositifs distants (robustesse ou secours), notamment sur la coherence des copies de donnees<br /><br />a) En cas de sinistre d''une baie de stockage, GTS garantit la reprise applicative en se basant sur le dernier bloc de donnees ecrit sur le disque<br /><br />b) Toutes les donnees applicatives devant rester coherentes entre elles au sein d''une transaction, doivent suivre la meme strategie de replication GTS, et donc etre localisees sur le meme sute et dans le meme ilot de replication de donnees<br /><br />c) En cas de panne, si la solution GTS ne peut pas synchroniser / repliquer les donnees d''au moins une des applications de l''ilot de replication alors la synchronisation / replication de l''ensemble des applications de l''ilot est stoppee pour garantir la coherence des donnees</td>\n</tr>\n<tr>\n<td>9</td>\n<td>Pas d''engagement sur le delai de restauration des sauvegarde (best efforts)</td>\n</tr>\n</tbody>\n</table>', '1', '', '1.2.1', 351, 2, 4, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a30333a3131),
(353, 1, 'Caracteristiques de l''architecture', '<p>Essayer de faire tenir cette vision synthetique en 1/2 pages max : principaux messages a retenir et des principaux ecarts sur les dimensions suivantes (liste non exhaustive). Si pas de message/ecart, mettre RAS.<br /><br />A) Niveau de criticite de l''application vu par le metier<br /><br />Indiquer si non redige par le metier (ou non fourni par les RO).<br />Vision DSI : indiquez systematiquement si l''application a ete classe "sensible" par la DSI.<br /><br />B) Securite et couverture des risques operationnels (dont DICP)<br />La securite et la couverture de risques operationnels sont detailles dans la partie 3<br /><br />Preciser<br />DICP : etre vigilant que la Maitrise d''oeuvre a fourni un DICP base sur le l''echelle groupe (de 0 a 3) et n''a pas repris un DICP correspondant a l''ancienne nomenclature.<br />Ex : Preciser les motifs si non eligibilite a Schengen ou cas d''exclusion a LogColCor.</p>\n<p>C) Niveau de service attendu et atteint</p>\n<p>D) Identification des SPOFs applications ou physiques</p>\n<p>E) Ecarts identifies (obligatoire s''il existe un ecart identifie par rapport aux besoins, a la strategie ou aux normes &amp; standards)<br /><br />Lister les ecarts, les motifs sont a preciser / detailles dans le paragraphe 2.2 (Ex: composants non standards, pas de virtualisation car xxxx)<br />Les exigences sont de 3 types:</p>\n<ul>\n<li>Besoins exprimes par la Maitrise d''oeuvre et le metier sur l''axe technique et securite</li>\n<li>Orientations strategiques GTS</li>\n<li>Normes et standards de l''exploitant</li>\n</ul>\n<p>F) Preconisations GTS non retenues</p>\n<p>G) Responsabilite Societale des Entreprises (RSE)<br /><br />Indiquer simplement si le projet va avoir un impact positif/negatif en consommation electrique.<br />Le detail est donne dans le paragraphe 2.2.2 E</p>', '1', '', '1.2.2', 351, 2, 5, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a31343a3237),
(354, 1, 'Resume technique de l''architecture', '<p>A) Mapping environnement / socles techniques :<br /><br />Rajoutez / Supprimez les environnements en fonction de l''expression de besoins</p>\n<table>\n<tbody>\n<tr>\n<td>Environnements fonctionnels</td>\n<td>Site</td>\n<td>VLAN</td>\n<td>CSR</td>\n<td>Nb @IP</td>\n</tr>\n<tr>\n<td>Sandbox</td>\n<td>Seclin2 - Tigery - Marcoussis DC</td>\n<td>Developpement / Homologation</td>\n<td>ex : CITS</td>\n<td>Ex : 10/VLAN</td>\n</tr>\n<tr>\n<td>Developpement</td>\n<td>Idem ci-dessus</td>\n<td>Idem</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Assemblage</td>\n<td>Idem ci-dessus</td>\n<td>Idem</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>IFO</td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem ci-dessus</span></td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem</span></td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Recette</td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem ci-dessus</span></td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem</span></td>\n<td>Ex: L1,CITS</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Benchmark</td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem ci-dessus</span></td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem</span></td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Production</td>\n<td>Tigery - Marcoussis DC - Valmy - Seclin1 JVE - Seclin1 STE</td>\n<td>Production Secours</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Secours</td>\n<td>Seclin2 - Tigery - Seclin1 STE - Seclin1 JVE</td>\n<td>Secours</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>B) Plan des capacites (nb serveurs)<br /><br />En Rouge gras souligne le nombre de serveurs ajoutes<br />En Bleu gras italique les serveurs upgrades (os,logiciels)<br />En Vert, les serveurs reconduits sans operations</p>\n<table>\n<tbody>\n<tr>\n<td rowspan="2">Environnements fonctionnels</td>\n<td style="text-align:center; vertical-align:middle;" colspan="4">X86<br />Virtualis&eacute; (NVG)</td>\n<td style="text-align:center; vertical-align:middle;" colspan="2">X86 physique</td>\n<td style="text-align:center; vertical-align:middle;" colspan="5">x86 virtualise (cloud GTS)</td>\n</tr>\n<tr>\n<td>Bronze</td>\n<td>Silver</td>\n<td>Gold</td>\n<td>Platinium</td>\n<td>Lames</td>\n<td>Pizza box</td>\n<td>Bronze</td>\n<td>Silver</td>\n<td>Gold</td>\n<td>Platinium S</td>\n<td>Platinium M</td>\n</tr>\n<tr>\n<td>Sandbox</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Developpement</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Assemblage</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>IFO</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Recette</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Benchmark</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Production</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Secours</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>X86/mutualise ne correspond pas a OMLX, gere par le capacity planning MDB</p>\n<table>\n<tbody>\n<tr>\n<td rowspan="2">Environnements fonctionnels</td>\n<td style="text-align:center; vertical-align:middle;" colspan="2">LPAR mutualis&eacute;</td>\n<td style="text-align:center; vertical-align:middle;" colspan="2">LPAR dedie</td>\n</tr>\n<tr>\n<td>core</td>\n<td>RAM</td>\n<td>core</td>\n<td>RAM</td>\n</tr>\n<tr>\n<td>Sandbox</td>\n<td>0.5</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Developpement</td>\n<td>0.5</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Assemblage</td>\n<td>0.5</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>IFO</td>\n<td>1</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Recette</td>\n<td>1</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Benchmark</td>\n<td>2</td>\n<td>16</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Production</td>\n<td>4</td>\n<td>32</td>\n<td>2</td>\n<td>8</td>\n</tr>\n<tr>\n<td>Secours</td>\n<td>2</td>\n<td>16</td>\n<td>1</td>\n<td>4</td>\n</tr>\n</tbody>\n</table>\n<p>Si necessaire, rajouter Teradata, PureSystem ou Oracle/solaris (non strategique)</p>\n<p>C) Plan de capacite Stockage en Go</p>\n<table>\n<tbody>\n<tr>\n<td>Environnements fonctionnels</td>\n<td style="text-align:center; vertical-align:middle;">SAN local</td>\n<td style="text-align:center; vertical-align:middle;">SAN asynchrone</td>\n<td style="text-align:center; vertical-align:middle;">SAN Dual room<br />(VPLEX metro)</td>\n<td style="text-align:center; vertical-align:middle;">SAN Dual room +<br /> replique sur site distant</td>\n<td style="text-align:center; vertical-align:middle;">NAS applicative (asynchrone)</td>\n</tr>\n<tr>\n<td>Sandbox</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Developpement</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Assemblage</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>IFO</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Recette</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Benchmark</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Production</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Secours</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>D) Ressources reseaux</p>\n<table>\n<tbody>\n<tr>\n<td>Ressources demandees</td>\n<td>Developpement</td>\n<td>Homologation</td>\n<td>Production</td>\n<td>Env. de secours</td>\n</tr>\n<tr>\n<td>DMZ (zone reseau)</td>\n<td>&nbsp;</td>\n<td>Ex: non</td>\n<td>Ex: oui dans I2BD, oui dans L3</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Besoin 10gbps LAN</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Ex: Oui 10 Go</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Impact Telco (ex riv@ge)</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Faible/Moyen/Fort ou N -A</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Load Balancing</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Oui (Nbre instances) / Non</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>GLSB</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Oui / Non [fonction geoloc,...]</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Nombre d''adresses IP/VLAN</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>SIPO/SIPO exotique</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Oui/Exotique/N-A</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Lien partenaire</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>VPN / LS / N-A</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Regles R WEB</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Ex: 1 (appel de script)</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>TestBed</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Ex: Oui</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>E) Responsabilite Societale des Entreprises (RSE)</p>\n<p>Exemple de projet candidat:</p>\n<ul>\n<li>Renouvellement du parc materiel : changement de serveurs grand systeme ou de baie de stockage</li>\n<li>Decomissionnement de materiel : physique vers virtualisation</li>\n</ul>\n<p>Prochaine version : tableau de synthese oriente MDB (ajouter OMLX)</p>', '1', '', '1.2.3', 351, 2, 6, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a34303a3030),
(355, 1, 'Etat d''avancement de l''etude', '<p>Liste des informations manquantes et necessaires pour la completude du DAH :</p>\n<p><br />Les chapitres necessaires mais qui n''auront pas pu etre completes sont listes ci-dessous:</p>', '1', '', '1.2.4', 351, 2, 7, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a34313a3336),
(356, 1, 'Lotissement de l''architecture', '<p>&nbsp;</p>\n<ul>\n<li>Architecture cible est decrite dans les paragraphes</li>\n<li>Architecture intermediaire est decrite dans les paragraphes</li>\n</ul>', '1', '', '1.2.5', 351, 2, 8, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a34323a3239),
(357, 1, 'Perspectives', '<p>Evolutions envisageables de l''architecture non planifiees</p>', '1', '', '1.2.6', 351, 2, 9, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a34333a3338),
(358, 1, 'Niveau de services des composants au socle GTS', '<p>Ex: Vision metier : reprendre les informations du QES (questionnaire d''evaluation de la sensibilite)</p>', '1', '', '2', 0, 0, 10, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a34373a3438),
(359, 1, 'Niveaux de services (SLA) demandes par le projet', '<p>DICP : etre vigilant que la maitrise d''oeuvre est founi un DICP base sur l''echelle groupe (de 0 a 3) et n''a pas repris un DICP correspondant a l''ancienne nomenclature</p>\n<table>\n<tbody>\n<tr>\n<td>Exigences techniques</td>\n<td>Demande par le projet</td>\n<td>Reponse GTS</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>Pr&eacute;sentation la disponibilite demande, le taux d''indisponibilite autorise Reprise de la feuille "description de l''application"<br />L''application en cas de crash, doit pouvoir recuperer les donnees de J-X (restauration des donnes de la veille)<br />il est demande un arret de service de X heures par mois au maximum en production.<br />Le service doit etre disponible de Xh a Yh, Zj/7<br />Pas d''inscription au plan de secours<br />En activit&eacute;, le service doit se conforter aux temps de reponse suivant:</p>\n<ul>\n<li>U s pour les enchainements d''ecrans standards</li>\n<li>V s pour des restitutions simples</li>\n<li>W s pour les restitutions moyennes</li>\n<li>X s pour les restitutions complexes en temps reel</li>\n<li>Un traitement batch doit etre prevu pour les restitutions dont la generation est superieure a Ys .</li>\n<li>Inferieur a Z s pour le transactionnel</li>\n</ul>', '1', '', '2.1', 358, 1, 11, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a35343a3136),
(360, 1, 'Reponses GTS', '<p>Detailler le paragraphe 1.2 en distinguant:</p>\n<ul>\n<li>Les conformites</li>\n<li>Les ecarts</li>\n<li>Les reserves</li>\n</ul>\n<p>C''est ici qu''on precise les motifs/ecarts listes dans le paragraphe 1.2.1 (Ex: composants non standards, pas de virtualisation car xxxx)</p>', '1', '', '2.2', 358, 1, 12, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a35353a3435),
(361, 1, 'Securite et Risques operationnels', '', '1', '', '3', 0, 0, 13, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a35363a3038),
(362, 1, 'Avis Securite', '<p>Cet avis est base sur la checklist "securite" en annexe.</p>\n<p>Preciser les motifs si non &nbsp;eligibilite a schengen ou cas d''exclusion a LogColCor</p>', '1', '', '3.1', 361, 1, 14, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a35373a3133),
(363, 1, 'OS (durcissement)', '', '1', '', '3.2', 361, 1, 15, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a35373a3430),
(364, 1, 'Exigences demandees', '', '1', '', '3.2.1', 363, 2, 16, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a35383a3037),
(365, 1, 'services founis et reserves', '', '1', '', '3.2.2', 363, 2, 17, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a35383a3335),
(366, 1, 'Collecte des logs et Correlation', '', '1', '', '3.3', 361, 1, 18, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031333a35393a3234),
(367, 1, 'Exigences demandees', '<p>Pour les serveutrs Unix et Windows, un agent de collecte des logs systemes est systematiquement installe conformement aux preconisations de l''audit pour l''environnement d''homologation et de production. L''agent envoie les logs vers un collecteur unique (LogColCor) afin de realiser les controles et d''alerter les equipes SEC-RETAIL.</p>\n<p>&nbsp;</p>\n<table>\n<tbody>\n<tr>\n<td>Zone Reseau</td>\n<td>Collecteur de log</td>\n<td>Protocole</td>\n<td>Port</td>\n<td>Remarques</td>\n</tr>\n<tr>\n<td>CITSv2</td>\n<td>logcolcortigprd01-ext.dns20.socgen</td>\n<td>UDP<br />TCP<br />TCP</td>\n<td>514<br />514<br />4514</td>\n<td>Syslog BSD (RFC 3164)<br />Syslog IETF (RFC 5424)<br />Syslog IETF (RFC 5434) over TLS</td>\n</tr>\n<tr>\n<td>CAZA</td>\n<td>logcolcortigprd03-ext.dns20.socgen</td>\n<td>UDP<br />TCP<br />TCP<br />TCP</td>\n<td>514<br />514<br />4514<br />6514</td>\n<td>Syslog BSD (RFC 3164)<br />Syslog IETF (RFC 5424)<br />Syslog IETF (RFC 5434) over TLS<br />Syslog IEFT (RFC 5434) over TLS/CDN</td>\n</tr>\n</tbody>\n</table>\n<p>Il s''agit de se premunir contre les risques suivants:<br />Non detection des connexions illicites sur les systemes d''informations</p>', '1', '', '3.3.1', 366, 2, 19, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031343a32393a3134),
(368, 1, 'Services fournis et reserves', '<p>Ces exigences sont toutes couvertes par l''outil LogColCor pour tous les risques identifes dans le 3.2.1<br />Rappel : LogColCor est inclus dans les masters serveurs</p>\n<p>Pr&eacute;ciser les nouveaux serveurs ou serveurs modifies presents dans ce DAH pour les environnements d''homologation et de production, ainsi que le collecteur de log en fonction des zones reseaux cibles</p>\n<table>\n<tbody>\n<tr>\n<td>Date</td>\n<td>Depuis la version DAH</td>\n<td>Nom du serveur</td>\n<td>Nom du collecteur</td>\n</tr>\n<tr>\n<td>06/2014</td>\n<td>1.0</td>\n<td>Serveur A</td>\n<td>&nbsp;Collecteur A</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>Dans la mesure ou les flux de collecte ne sont pas inclus dans un bouquet RET d''ouverture de route pour la zone d''hebergement du serveur, le tableau 1 reprend l''ensemble des chaines de liaisons</p>\n<table>\n<tbody>\n<tr>\n<td>N&deg;</td>\n<td>Type de flux</td>\n<td>Emmeteur</td>\n<td>Localisation</td>\n<td>Recepteur</td>\n<td>Dependance(source EBH)</td>\n<td>Informations complementaires</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>UDP/514</td>\n<td>Serveur A</td>\n<td>Tigery</td>\n<td>Collecteur A</td>\n<td>Obligatoire</td>\n<td>Mettre "non etudie" ou indiquer la taille de la collecte systeme<br />Ex : &lt; 5Mo/jour moyenne</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>TCP/514</td>\n<td>Serveur A</td>\n<td>Tigery</td>\n<td>Collecteur A</td>\n<td>Obligatoire</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>', '1', '', '3.3.2', 366, 2, 20, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031343a33343a3531),
(369, 1, 'Architecture Reseau', '', '1', '', '4', 0, 0, 21, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031343a33353a3139),
(370, 1, 'Schéma du reseau', '<p>S''assurer en debut de projet qu''un contact cote architecture reseau a ete designe sur le projet. (pas d''@ IP dans un document classe C1)</p>', '1', '', '4.1', 369, 1, 22, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031343a33363a3234),
(371, 1, 'Topologie, flux, protocole, port, matrice des flux', '<p>Rappel : Si le DICP est I2 ou I3, les flux doivent etre chiffres (ex SSL) pour preserver l''integrite des donnees.</p>\n<p>&nbsp;Tableau 1 : chaine de liaisons applicatives externes</p>\n<table>\n<tbody>\n<tr>\n<td>N&deg;</td>\n<td>Type de flux</td>\n<td>Emmeteur</td>\n<td>Localisation</td>\n<td>Recepteur</td>\n<td>Dependance (source EBH)</td>\n<td>Informations complementaires</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>HTTPS</td>\n<td>PdT Arpege</td>\n<td>Bengalore</td>\n<td>&nbsp;</td>\n<td>Obligatoire, mode degrade possible sur xx h/j/semaine</td>\n<td>Role du flux + volume * frequence pour avoir une estimation du debit</td>\n</tr>\n</tbody>\n</table>\n<p>Tableau 2 : Chaine de liaisons applicatives internes</p>\n<table>\n<tbody>\n<tr>\n<td>N&deg;</td>\n<td>Type de flux</td>\n<td>Emmeteur</td>\n<td>Recepteur</td>\n<td>Dependance (source EBH)</td>\n<td>Informations complementaires</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>HTTPS</td>\n<td>PdT Arpege</td>\n<td>&nbsp;</td>\n<td>obligatoire, mode degrade possible sur xx h/j/semaine</td>\n<td>role du flux + volume * frequence pour avoir une estimation du debit</td>\n</tr>\n</tbody>\n</table>\n<p>Tableau 3 : Chaine de liaisons techniques</p>\n<p>Ex: Pour Citrix</p>\n<ul>\n<li>Utilisateurs</li>\n<li>Nb &nbsp;d''utilisateurs simultanes utilisant l''application</li>\n<li>Compte utilisateurs et postes utilisateurs : ARPEGE / SGCIB / Filliales</li>\n<li>Types de connexions : Intranet / Extranet</li>\n</ul>', '1', '', '4.1.1', 370, 2, 23, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031343a34333a3436),
(372, 1, 'Architecture d''hebergement applicatif', '<p><img src="/source/templates/test/Penguins.jpg" alt="" width="1024" height="768" /></p>', '1', '', '5', 0, 0, 24, 1, 0x323031372d30312d33302031303a30303a3430, 0x323031372d30312d33302030393a30303a3430),
(373, 1, 'Description de l''architecture par environnement et dimensionnement', '<p>Donner / Rappeler les criteres ayant abouti au choix de solution technique. Justifier imperativement un choix de serveur non virtuel (bas&eacute; sur les contraintes de consommation de ressources - IOPs, mem,CPU,stockage - et eventuellement sur des contraintes editeur)</p>', '1', '', '5.1', 372, 1, 25, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031343a34363a3138),
(374, 1, 'Les environnements', '<p>Indiquez le nombre d''environnements</p>\n<p>Decrire de maniere synthetique les principes d''architecture de construction des environnements : ex: pour l''homologation, meme modele d''architecture de resilience que la production avec dimensionnement divise par ... etc</p>\n<p>Generalement, les principes sont les memes entre les environnements</p>\n<p>Decrire precisement les principes de construction de la production et du secours, et si les principes sont les memes, indiquez uniquement les differences &nbsp;(generalement, dimensionnement et nombre de serveurs, nature du CSR,etc)</p>', '1', '', '5.1.1', 373, 2, 26, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031343a34393a3236),
(375, 1, 'Composants', '<p>Representation de l''architecte GTS de l''architecture applicative</p>\n<p>Tableau 1 : vision application des composants</p>\n<p>&nbsp;</p>\n<table>\n<tbody>\n<tr>\n<td>Composants</td>\n<td>Description</td>\n<td>Cycle de fonctionnement</td>\n</tr>\n<tr>\n<td>Composant 1</td>\n<td>utilisation du composant dans le contexte du DAH<br />Indiquer quelles fonctions applicatives sont assurees par ce composant</td>\n<td>A remplir si non decrit dans le DAA ou l''EBH.A decrire par fonction applicative</td>\n</tr>\n<tr>\n<td>connect:eXpress</td>\n<td>Ex : installe sur chaque noeud des clusters xxx pour assurer la reception et des fichiers</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>Tableau 2 : fiche technique de composants</p>\n<table>\n<tbody>\n<tr>\n<td>Composants</td>\n<td>Comportement Infra</td>\n<td>Standard</td>\n<td>Ancienne version</td>\n<td>Nouvelle version</td>\n</tr>\n<tr>\n<td>Composant 1</td>\n<td>CPU Bound<br />Memory Bound<br />IO Bound</td>\n<td>Oui / non</td>\n<td>Version + fin de support standard + fin de support etendu</td>\n<td>Version + fin de support standard + fin de support etendue</td>\n</tr>\n<tr>\n<td>connect:eXpress</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>La strategie de migration est decrit dans le paragraphe 6 "orientation pour la production"</p>', '1', '', '5.1.2', 373, 2, 27, 1, 0x323031372d30312d32362031363a35343a3136, 0x323031362d31322d32312031343a35353a3233),
(409, 1, 'Recap', '<p><span style="text-decoration:underline; background-color:#ffcc00;"><em><strong>wxcwxcwxcwxcwxcwxc</strong></em></span></p>\n<p><span style="text-decoration:underline; background-color:#ffcc00;"><em><strong><img src="/source/templates/refarc%20test.png" alt="" width="588" height="365" /><br /></strong></em></span></p>\n<p>&nbsp;</p>', '1', '', '6', 0, 0, 28, 1, 0x323031372d30312d32362031363a35383a3534, 0x323031372d30312d32362031353a35383a3534),
(422, 2, '1', '<p><img src="/source/templates/IMG_0030.jpg" alt="" width="2448" height="3264" /></p>', '1', '', '1', 0, 0, 1, 1, 0x323031372d30312d32362031363a31363a3036, 0x323031372d30312d32362031363a31363a3036),
(423, 2, '2', '<p>dsfsdfsdfsdfsdf</p>', '1', '', '2', 0, 0, 2, 1, 0x323031372d30312d32362031363a34313a3133, 0x323031372d30312d32362031363a34313a3133),
(424, 2, '3', '<p>dsqfdsfsdfsdf</p>', '1', '', '3', 0, 0, 3, 1, 0x323031372d30312d32362031363a34323a3239, 0x323031372d30312d32362031363a34323a3239),
(431, 2, 'sqdqsd', '<p><img src="/source/templates/refarc%20test%201.png" alt="" width="29" height="24" />qsdqsdqsd</p>', '1', '', '4', 0, 0, 4, 1, 0x323031372d30312d32362031373a35323a3436, 0x323031372d30312d32362031363a35323a3436),
(435, 3, 'Synthèse', '<p>Fiche Synth&egrave;se du document</p>\n<table>\n<tbody>\n<tr>\n<td>IRT/ Trigramme</td>\n<td>AAAA / XYZ</td>\n</tr>\n<tr>\n<td>Applications</td>\n<td>Nom Application XXXX</td>\n</tr>\n<tr>\n<td>Code Ecolience</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Progiciel(s)</td>\n<td>Nom(s) + release utilisee pour l''application</td>\n</tr>\n<tr>\n<td>Typologie Architecture</td>\n<td>\n<p>Web Transactionnel C1 ou non standard</p>\n<p>Web D&eacute;cisionnel D1, D2 ou non standard</p>\n</td>\n</tr>\n<tr>\n<td>Preconisations de GTS non retenues par la ME</td>\n<td>\n<p>Statut : R&eacute;diger la vision synthetique de l''architecte</p>\n<p>Lister les preconisations non retenues de maniere synthetique :</p>\n<ul>\n<li>DDD</li>\n<li>AAA</li>\n</ul>\n<p>Les point sont detailles dans le prg 1.2 "vision de l''architecture"</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>Description de l''architecture de production</p>\n<table style="height:2732px;" width="1531">\n<tbody>\n<tr>\n<td style="width:298px;">Site primaire d''hebergement</td>\n<td style="width:1233px;">Tigery / Marcoussis DC02 / Seclin2 / Seclin1 / Valmy</td>\n</tr>\n<tr>\n<td style="width:298px;">Site secondaire</td>\n<td style="width:1233px;">Seclin2 / Marcoussis DC02</td>\n</tr>\n<tr>\n<td style="width:298px;">Modele d''architecture de resilience</td>\n<td style="width:1233px;">\n<ul>\n<li>1+0:A</li>\n<li>1+0:HA</li>\n<li>1+1:A+A</li>\n<li>1+1:A + Hot Standby</li>\n<li>1+1:A + Hot Standby croise</li>\n<li>1+1:A + Cold Standby</li>\n<li>1+1:HA + Cold Standby</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Mod&egrave;le de solution de resilience de l''ecolience</td>\n<td style="width:1233px;">\n<p>Bronze,Argent,Or,Saphir,Rubis,Emeraude</p>\n<p>Objectif de delai de retablissement GTS(panne) : 0h,4h,8h,24h</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Niveau d''exercices entre deuxi sites distans atteignables</td>\n<td style="width:1233px;">\n<ul>\n<li>Exercice unitaire hors charge (validation technique)</li>\n<li>Exercice hors charge de l''ecolience</li>\n<li>Exercice pleine charge de l''ecolience</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Couches m&eacute;tiers</td>\n<td style="width:1233px;">\n<p>Pour les couches/services ci-dessous, pr&eacute;ciser en gras les composants techniques associes a des fonctions applicatives vitales/critiques (par opposition aux fonctions non prioritaires ou secondaires) -&gt; impact direct sur le processus de prise en charge des incidents</p>\n<p>Ex: fournie en boite noire (realise autour du progiciel zz)</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Services d''echanges</td>\n<td style="width:1233px;">\n<ul>\n<li>WMQ R.m</li>\n<li>Connect: eXpress R.m</li>\n<li>SMTP</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Services d''application</td>\n<td style="width:1233px;">\n<ul>\n<li>Weblogic xxgRxx et dsk &amp;.5</li>\n<li>Informatica</li>\n<li>Tomcat</li>\n</ul>\n<p>&nbsp;La matrice de comptabilite impose une version &lt; &agrave; ...</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Services donnees</td>\n<td style="width:1233px;">\n<ul>\n<li>Oracle ww.x.y.z</li>\n<li>IBM DB2 w.x</li>\n<li>Microsoft SQL Server xxxx</li>\n</ul>\n<p>La matrice de comptabilite impose une version &lt; a ...</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">zone ordennancement</td>\n<td style="width:1233px;">\n<p>Control M</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Zones Cellules Securite Reseau</td>\n<td style="width:1233px;">\n<p>CITSv2 , L3 BSC Mutualise , PCMS , CAZA , TNU , GMS , PGN , PEPSY , MAIA</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Systemes d''exploitation</td>\n<td style="width:1233px;">\n<ul>\n<li>Linux Red Hat 6.6</li>\n<li>Windows 2012 SPxx</li>\n<li>AIX 6.1 TL3</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Classe de resilience du stockage</td>\n<td style="width:1233px;">SAN : M0,M1,L0,L1 + id du groupe de coh&eacute;rence</td>\n</tr>\n<tr>\n<td style="width:298px;">Conformit&eacute; standard et politique</td>\n<td style="width:1233px;">\n<p><span style="text-decoration:underline;">Durcissement OS</span></p>\n<p>Advanced / Premium / Premium +</p>\n<p>Plusieurs choix possibles en fonction de la sensibilit&eacute; de l''application (voir QES ou ASA) (le niveau de durcissement par serveur est formalise dans les paragraphes 4 par environnement)</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Features hors socle &agrave; installer</td>\n<td style="width:1233px;">\n<p>Features a installer hors socle ou ce qui est obligatoire (le detail prg 2)</p>\n<p>JVM Oracle dans la couche DB,OpenSSH</p>\n<p>Autres regles de durcissement Ex: JVM Oracle dans la douche DB,OpenSSH</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Ressources Techniques</td>\n<td style="width:1233px;">\n<p>3 choix possibles :</p>\n<ul>\n<li>Indiquer les paragraphes correspondants par environnement ex 4.1.2</li>\n<li>Mettre ici le tableau recapitulatif tout environnement</li>\n<li>ou en litteraire (ex: ci-dessous)</li>\n</ul>\n<p>[Environnement]<br />" fonction" (N/R/M): PxxxLX01 &agrave; 04: 4 standards x86, cluster VCS, xxx Go SAN ou NAS (ou DAS)</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Offres GTS</td>\n<td style="width:1233px;">\n<p>RET : OMLX, SQM,OMDG<br />TFO : SIPO [Exotique], etc<br />EUS : @PAC,...</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Servitudes</td>\n<td style="width:1233px;">\n<p>Sauvegarde standard TSM ou Lan Free Backup ou specifique (ex: networker sur valmy)<br />Supervision standard patrol</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Ressources reseaux</td>\n<td style="width:1233px;">\n<p>x lien 100 Mb | 1Gb | 10Gb</p>\n</td>\n</tr>\n<tr>\n<td style="width:298px;">Poste de travail</td>\n<td style="width:1233px;">Client lourd ou client web NDG ARPEGE IE8<br />International oui/non</td>\n</tr>\n<tr>\n<td style="width:298px;">Services d''acces</td>\n<td style="width:1233px;">CITRIX , PAX , TRAP , I2BD , GAIA , VPN , LS</td>\n</tr>\n<tr>\n<td style="width:298px;">Processus de livraison des packages applicatifs en production</td>\n<td style="width:1233px;">\n<p>Earth CDI<br />Non standard (scp,client lourd, etc)</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>Ecarts :</p>\n<table>\n<tbody>\n<tr>\n<td rowspan="7">Pricipaux ecarts par rapport a la strategie ou aux exigences GTS</td>\n<td>Domaine</td>\n<td>Ecart ?<br />Oui/non</td>\n</tr>\n<tr>\n<td>Securite</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Virtualisation comme 1er choix de hosting</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Capacite a realiser des exercices en pleine charge / ecosysteme de donnees et de flux definis et valides</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>RedCat</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Strategie DataCenter</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Processus de livraison standard</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Principaux ecarts par rapport aux besoins exprimes</td>\n<td colspan="2">Synthese : xxxxx<br />Lister les ecarts de maniere synthetique<br />\n<ul>\n<li>Ecart 1 : domaine / description synthetique</li>\n<li>ex SLA de disponibilite</li>\n<li>ex : couverture de risques</li>\n<li>...<br /><br />Les points sont detailles dans le paragraphe 1.2.2 "Vision Architecture"</li>\n</ul>\n</td>\n</tr>\n<tr>\n<td>Synthese de l''avis securite</td>\n<td colspan="2">Rappeler le niveau d''ISR indique en cartouche (page de garde)<br />Les points sont detailles dans le paragraphe 3.1 "Avis Securite Detaille"</td>\n</tr>\n</tbody>\n</table>\n<p>Dans le paragraphe 1.2.2, le recapitulatif des besoins declines par offre et par environnement et par site.<img src="/refarc/public/source/applications/bsc_poc.PNG" alt="" /></p>', '1', '', '1', 0, 0, 1, 1, 0x323031372d30312d32372031333a32323a3532, 0x323031372d30312d32372031333a32323a3532),
(436, 3, 'Contexte du projet', '<p>Cette version de DAH (version x.y) decrit les impacts suite a ces demandes.<br /><br />Le scenario de migration retenu est decrit dans le paragraphe 4.1.3</p>', '1', '', '1.1', 435, 1, 2, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(437, 3, 'Vision synthetique de l''architecture', '', '1', '', '1.2', 435, 1, 3, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(438, 3, 'Principes d''architecture SI appliques par GTS/RET', '<p>&nbsp;</p>\n<table>\n<tbody>\n<tr>\n<td>N&deg;</td>\n<td>Formulation simplifiee du principe, le document de reference reste le "livre blanc resilience GTS"</td>\n</tr>\n<tr>\n<td>1</td>\n<td>Les applications vitales et critiques sont regroupees en ecolience pour permettre la realisation d''exercices de robustesse ou de secours</td>\n</tr>\n<tr>\n<td>2</td>\n<td>GTS assure la resilience d''une ecolience soit par un dispositif de robustesse sur le meme site ou sur deux sites interregionnaux, eventuellement complete par un disposotif de secours a froid hors region (fonction de l''EBCA, Expression de Besoins de Continuite d''Activite exprimee par les Metiers Bancaires)<br />Les donnes d''une ecolience sont localisees sur un seul site si la coherence des donnees secourues est assuree par GTS<br /><br />Les 3 cas de risque d''indisponibilite couverts sont : panne de composant, perte de site et choc regional<br /><br />La couverture de perte de salle adresse en priorite les besoins de RBDF.</td>\n</tr>\n<tr>\n<td>3</td>\n<td>Le dispositif de robustesse ou de secours peut etre con&ccedil;u pour limiter l''impact d''une panne applicative ou materielle &agrave; tout ou partie des utilisateurs finaux<br /><br />La declinaison de ce principe est fonction des SLA exprimes et du budget.</td>\n</tr>\n<tr>\n<td>4</td>\n<td>Les applications de Reseaux France, exploitees par GTS/RET, sont localisees preferentiellement a TIGERY<br />Les applications Directions Centrales et GTPS, exploitees par GTS/RET, sont localises preferentiellement &agrave; Marcoussis DC02<br />Les applications de pilotage de GTS sont localises preferentiellement a Seclin2</td>\n</tr>\n<tr>\n<td>5</td>\n<td>En standard, le dispositif de secours est a froid, non robuste et non secouru<br />En standard, GTS ne couvre pas le cas de double-panne (panne du composant nominal et panne du dispositif assurant la resilience du composant)</td>\n</tr>\n<tr>\n<td>6</td>\n<td>Les environnements non production sont localises preferentiellement a Seclin2 (sauf le systeme zOs)</td>\n</tr>\n<tr>\n<td>7</td>\n<td>La DSI est responsable de l''integrite de la transaction fonctionnelle sur le site nominal.</td>\n</tr>\n<tr>\n<td>8</td>\n<td>Si le principe 2 (donnees) n''est pas respecte, le perimetre 8 n''est pas applicable, la DSI est responsable de l''integrite de la transaction sur les dispositifs distants (robustesse ou secours), notamment sur la coherence des copies de donnees<br /><br />a) En cas de sinistre d''une baie de stockage, GTS garantit la reprise applicative en se basant sur le dernier bloc de donnees ecrit sur le disque<br /><br />b) Toutes les donnees applicatives devant rester coherentes entre elles au sein d''une transaction, doivent suivre la meme strategie de replication GTS, et donc etre localisees sur le meme sute et dans le meme ilot de replication de donnees<br /><br />c) En cas de panne, si la solution GTS ne peut pas synchroniser / repliquer les donnees d''au moins une des applications de l''ilot de replication alors la synchronisation / replication de l''ensemble des applications de l''ilot est stoppee pour garantir la coherence des donnees</td>\n</tr>\n<tr>\n<td>9</td>\n<td>Pas d''engagement sur le delai de restauration des sauvegarde (best efforts)</td>\n</tr>\n</tbody>\n</table>', '1', '', '1.2.1', 437, 2, 4, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(439, 3, 'Caracteristiques de l''architecture', '<p>Essayer de faire tenir cette vision synthetique en 1/2 pages max : principaux messages a retenir et des principaux ecarts sur les dimensions suivantes (liste non exhaustive). Si pas de message/ecart, mettre RAS.<br /><br />A) Niveau de criticite de l''application vu par le metier<br /><br />Indiquer si non redige par le metier (ou non fourni par les RO).<br />Vision DSI : indiquez systematiquement si l''application a ete classe "sensible" par la DSI.<br /><br />B) Securite et couverture des risques operationnels (dont DICP)<br />La securite et la couverture de risques operationnels sont detailles dans la partie 3<br /><br />Preciser<br />DICP : etre vigilant que la Maitrise d''oeuvre a fourni un DICP base sur le l''echelle groupe (de 0 a 3) et n''a pas repris un DICP correspondant a l''ancienne nomenclature.<br />Ex : Preciser les motifs si non eligibilite a Schengen ou cas d''exclusion a LogColCor.</p>\n<p>C) Niveau de service attendu et atteint</p>\n<p>D) Identification des SPOFs applications ou physiques</p>\n<p>E) Ecarts identifies (obligatoire s''il existe un ecart identifie par rapport aux besoins, a la strategie ou aux normes &amp; standards)<br /><br />Lister les ecarts, les motifs sont a preciser / detailles dans le paragraphe 2.2 (Ex: composants non standards, pas de virtualisation car xxxx)<br />Les exigences sont de 3 types:</p>\n<ul>\n<li>Besoins exprimes par la Maitrise d''oeuvre et le metier sur l''axe technique et securite</li>\n<li>Orientations strategiques GTS</li>\n<li>Normes et standards de l''exploitant</li>\n</ul>\n<p>F) Preconisations GTS non retenues</p>\n<p>G) Responsabilite Societale des Entreprises (RSE)<br /><br />Indiquer simplement si le projet va avoir un impact positif/negatif en consommation electrique.<br />Le detail est donne dans le paragraphe 2.2.2 E</p>', '1', '', '1.2.2', 437, 2, 5, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533);
INSERT INTO `templates` (`id`, `id_template`, `text`, `text_stat`, `type`, `content`, `num_parag`, `parent`, `niv`, `ordre`, `user_id`, `created_at`, `updated_at`) VALUES
(440, 3, 'Resume technique de l''architecture', '<p>A) Mapping environnement / socles techniques :<br /><br />Rajoutez / Supprimez les environnements en fonction de l''expression de besoins</p>\n<table>\n<tbody>\n<tr>\n<td>Environnements fonctionnels</td>\n<td>Site</td>\n<td>VLAN</td>\n<td>CSR</td>\n<td>Nb @IP</td>\n</tr>\n<tr>\n<td>Sandbox</td>\n<td>Seclin2 - Tigery - Marcoussis DC</td>\n<td>Developpement / Homologation</td>\n<td>ex : CITS</td>\n<td>Ex : 10/VLAN</td>\n</tr>\n<tr>\n<td>Developpement</td>\n<td>Idem ci-dessus</td>\n<td>Idem</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Assemblage</td>\n<td>Idem ci-dessus</td>\n<td>Idem</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>IFO</td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem ci-dessus</span></td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem</span></td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Recette</td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem ci-dessus</span></td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem</span></td>\n<td>Ex: L1,CITS</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Benchmark</td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem ci-dessus</span></td>\n<td><span style="color:#828282; background-color:#fafafa;">Idem</span></td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Production</td>\n<td>Tigery - Marcoussis DC - Valmy - Seclin1 JVE - Seclin1 STE</td>\n<td>Production Secours</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Secours</td>\n<td>Seclin2 - Tigery - Seclin1 STE - Seclin1 JVE</td>\n<td>Secours</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>B) Plan des capacites (nb serveurs)<br /><br />En Rouge gras souligne le nombre de serveurs ajoutes<br />En Bleu gras italique les serveurs upgrades (os,logiciels)<br />En Vert, les serveurs reconduits sans operations</p>\n<table>\n<tbody>\n<tr>\n<td rowspan="2">Environnements fonctionnels</td>\n<td style="text-align:center; vertical-align:middle;" colspan="4">X86<br />Virtualis&eacute; (NVG)</td>\n<td style="text-align:center; vertical-align:middle;" colspan="2">X86 physique</td>\n<td style="text-align:center; vertical-align:middle;" colspan="5">x86 virtualise (cloud GTS)</td>\n</tr>\n<tr>\n<td>Bronze</td>\n<td>Silver</td>\n<td>Gold</td>\n<td>Platinium</td>\n<td>Lames</td>\n<td>Pizza box</td>\n<td>Bronze</td>\n<td>Silver</td>\n<td>Gold</td>\n<td>Platinium S</td>\n<td>Platinium M</td>\n</tr>\n<tr>\n<td>Sandbox</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Developpement</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Assemblage</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>IFO</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Recette</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Benchmark</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Production</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Secours</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>X86/mutualise ne correspond pas a OMLX, gere par le capacity planning MDB</p>\n<table>\n<tbody>\n<tr>\n<td rowspan="2">Environnements fonctionnels</td>\n<td style="text-align:center; vertical-align:middle;" colspan="2">LPAR mutualis&eacute;</td>\n<td style="text-align:center; vertical-align:middle;" colspan="2">LPAR dedie</td>\n</tr>\n<tr>\n<td>core</td>\n<td>RAM</td>\n<td>core</td>\n<td>RAM</td>\n</tr>\n<tr>\n<td>Sandbox</td>\n<td>0.5</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Developpement</td>\n<td>0.5</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Assemblage</td>\n<td>0.5</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>IFO</td>\n<td>1</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Recette</td>\n<td>1</td>\n<td>8</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Benchmark</td>\n<td>2</td>\n<td>16</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Production</td>\n<td>4</td>\n<td>32</td>\n<td>2</td>\n<td>8</td>\n</tr>\n<tr>\n<td>Secours</td>\n<td>2</td>\n<td>16</td>\n<td>1</td>\n<td>4</td>\n</tr>\n</tbody>\n</table>\n<p>Si necessaire, rajouter Teradata, PureSystem ou Oracle/solaris (non strategique)</p>\n<p>C) Plan de capacite Stockage en Go</p>\n<table>\n<tbody>\n<tr>\n<td>Environnements fonctionnels</td>\n<td style="text-align:center; vertical-align:middle;">SAN local</td>\n<td style="text-align:center; vertical-align:middle;">SAN asynchrone</td>\n<td style="text-align:center; vertical-align:middle;">SAN Dual room<br />(VPLEX metro)</td>\n<td style="text-align:center; vertical-align:middle;">SAN Dual room +<br /> replique sur site distant</td>\n<td style="text-align:center; vertical-align:middle;">NAS applicative (asynchrone)</td>\n</tr>\n<tr>\n<td>Sandbox</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Developpement</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Assemblage</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>IFO</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Recette</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Benchmark</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Production</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Secours</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>D) Ressources reseaux</p>\n<table>\n<tbody>\n<tr>\n<td>Ressources demandees</td>\n<td>Developpement</td>\n<td>Homologation</td>\n<td>Production</td>\n<td>Env. de secours</td>\n</tr>\n<tr>\n<td>DMZ (zone reseau)</td>\n<td>&nbsp;</td>\n<td>Ex: non</td>\n<td>Ex: oui dans I2BD, oui dans L3</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Besoin 10gbps LAN</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Ex: Oui 10 Go</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Impact Telco (ex riv@ge)</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Faible/Moyen/Fort ou N -A</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Load Balancing</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Oui (Nbre instances) / Non</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>GLSB</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Oui / Non [fonction geoloc,...]</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Nombre d''adresses IP/VLAN</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>SIPO/SIPO exotique</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Oui/Exotique/N-A</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Lien partenaire</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>VPN / LS / N-A</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>Regles R WEB</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Ex: 1 (appel de script)</td>\n<td>&nbsp;</td>\n</tr>\n<tr>\n<td>TestBed</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>Ex: Oui</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>E) Responsabilite Societale des Entreprises (RSE)</p>\n<p>Exemple de projet candidat:</p>\n<ul>\n<li>Renouvellement du parc materiel : changement de serveurs grand systeme ou de baie de stockage</li>\n<li>Decomissionnement de materiel : physique vers virtualisation</li>\n</ul>\n<p>Prochaine version : tableau de synthese oriente MDB (ajouter OMLX)</p>', '1', '', '1.2.3', 437, 2, 6, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(441, 3, 'Etat d''avancement de l''etude', '<p>Liste des informations manquantes et necessaires pour la completude du DAH :</p>\n<p><br />Les chapitres necessaires mais qui n''auront pas pu etre completes sont listes ci-dessous:</p>', '1', '', '1.2.4', 437, 2, 7, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(442, 3, 'Lotissement de l''architecture', '<p>&nbsp;</p>\n<ul>\n<li>Architecture cible est decrite dans les paragraphes</li>\n<li>Architecture intermediaire est decrite dans les paragraphes</li>\n</ul>', '1', '', '1.2.5', 437, 2, 8, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(443, 3, 'Perspectives', '<p>Evolutions envisageables de l''architecture non planifiees</p>', '1', '', '1.2.6', 437, 2, 9, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(444, 3, 'Niveau de services des composants au socle GTS', '<p>Ex: Vision metier : reprendre les informations du QES (questionnaire d''evaluation de la sensibilite)</p>', '1', '', '2', 0, 0, 10, 1, 0x323031372d30312d32372031333a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(445, 3, 'Niveaux de services (SLA) demandes par le projet', '<p>DICP : etre vigilant que la maitrise d''oeuvre est founi un DICP base sur l''echelle groupe (de 0 a 3) et n''a pas repris un DICP correspondant a l''ancienne nomenclature</p>\n<table>\n<tbody>\n<tr>\n<td>Exigences techniques</td>\n<td>Demande par le projet</td>\n<td>Reponse GTS</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>Pr&eacute;sentation la disponibilite demande, le taux d''indisponibilite autorise Reprise de la feuille "description de l''application"<br />L''application en cas de crash, doit pouvoir recuperer les donnees de J-X (restauration des donnes de la veille)<br />il est demande un arret de service de X heures par mois au maximum en production.<br />Le service doit etre disponible de Xh a Yh, Zj/7<br />Pas d''inscription au plan de secours<br />En activit&eacute;, le service doit se conforter aux temps de reponse suivant:</p>\n<ul>\n<li>U s pour les enchainements d''ecrans standards</li>\n<li>V s pour des restitutions simples</li>\n<li>W s pour les restitutions moyennes</li>\n<li>X s pour les restitutions complexes en temps reel</li>\n<li>Un traitement batch doit etre prevu pour les restitutions dont la generation est superieure a Ys .</li>\n<li>Inferieur a Z s pour le transactionnel</li>\n</ul>', '1', '', '2.1', 444, 1, 11, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(446, 3, 'Reponses GTS', '<p>Detailler le paragraphe 1.2 en distinguant:</p>\n<ul>\n<li>Les conformites</li>\n<li>Les ecarts</li>\n<li>Les reserves</li>\n</ul>\n<p>C''est ici qu''on precise les motifs/ecarts listes dans le paragraphe 1.2.1 (Ex: composants non standards, pas de virtualisation car xxxx)</p>', '1', '', '2.2', 444, 1, 12, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(447, 3, 'Securite et Risques operationnels', '', '1', '', '3', 0, 0, 13, 1, 0x323031372d30312d32372031333a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(448, 3, 'Avis Securite', '<p>Cet avis est base sur la checklist "securite" en annexe.</p>\n<p>Preciser les motifs si non &nbsp;eligibilite a schengen ou cas d''exclusion a LogColCor</p>', '1', '', '3.1', 447, 1, 14, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(449, 3, 'OS (durcissement)', '', '1', '', '3.2', 447, 1, 15, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(450, 3, 'Exigences demandees', '', '1', '', '3.2.1', 449, 2, 16, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(451, 3, 'services founis et reserves', '', '1', '', '3.2.2', 449, 2, 17, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(452, 3, 'Collecte des logs et Correlation', '', '1', '', '3.3', 447, 1, 18, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(453, 3, 'Exigences demandees', '<p>Pour les serveutrs Unix et Windows, un agent de collecte des logs systemes est systematiquement installe conformement aux preconisations de l''audit pour l''environnement d''homologation et de production. L''agent envoie les logs vers un collecteur unique (LogColCor) afin de realiser les controles et d''alerter les equipes SEC-RETAIL.</p>\n<p>&nbsp;</p>\n<table>\n<tbody>\n<tr>\n<td>Zone Reseau</td>\n<td>Collecteur de log</td>\n<td>Protocole</td>\n<td>Port</td>\n<td>Remarques</td>\n</tr>\n<tr>\n<td>CITSv2</td>\n<td>logcolcortigprd01-ext.dns20.socgen</td>\n<td>UDP<br />TCP<br />TCP</td>\n<td>514<br />514<br />4514</td>\n<td>Syslog BSD (RFC 3164)<br />Syslog IETF (RFC 5424)<br />Syslog IETF (RFC 5434) over TLS</td>\n</tr>\n<tr>\n<td>CAZA</td>\n<td>logcolcortigprd03-ext.dns20.socgen</td>\n<td>UDP<br />TCP<br />TCP<br />TCP</td>\n<td>514<br />514<br />4514<br />6514</td>\n<td>Syslog BSD (RFC 3164)<br />Syslog IETF (RFC 5424)<br />Syslog IETF (RFC 5434) over TLS<br />Syslog IEFT (RFC 5434) over TLS/CDN</td>\n</tr>\n</tbody>\n</table>\n<p>Il s''agit de se premunir contre les risques suivants:<br />Non detection des connexions illicites sur les systemes d''informations</p>', '1', '', '3.3.1', 452, 2, 19, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(454, 3, 'Services fournis et reserves', '<p>Ces exigences sont toutes couvertes par l''outil LogColCor pour tous les risques identifes dans le 3.2.1<br />Rappel : LogColCor est inclus dans les masters serveurs</p>\n<p>Pr&eacute;ciser les nouveaux serveurs ou serveurs modifies presents dans ce DAH pour les environnements d''homologation et de production, ainsi que le collecteur de log en fonction des zones reseaux cibles</p>\n<table>\n<tbody>\n<tr>\n<td>Date</td>\n<td>Depuis la version DAH</td>\n<td>Nom du serveur</td>\n<td>Nom du collecteur</td>\n</tr>\n<tr>\n<td>06/2014</td>\n<td>1.0</td>\n<td>Serveur A</td>\n<td>&nbsp;Collecteur A</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>Dans la mesure ou les flux de collecte ne sont pas inclus dans un bouquet RET d''ouverture de route pour la zone d''hebergement du serveur, le tableau 1 reprend l''ensemble des chaines de liaisons</p>\n<table>\n<tbody>\n<tr>\n<td>N&deg;</td>\n<td>Type de flux</td>\n<td>Emmeteur</td>\n<td>Localisation</td>\n<td>Recepteur</td>\n<td>Dependance(source EBH)</td>\n<td>Informations complementaires</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>UDP/514</td>\n<td>Serveur A</td>\n<td>Tigery</td>\n<td>Collecteur A</td>\n<td>Obligatoire</td>\n<td>Mettre "non etudie" ou indiquer la taille de la collecte systeme<br />Ex : &lt; 5Mo/jour moyenne</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>TCP/514</td>\n<td>Serveur A</td>\n<td>Tigery</td>\n<td>Collecteur A</td>\n<td>Obligatoire</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>', '1', '', '3.3.2', 452, 2, 20, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(455, 3, 'Architecture Reseau', '', '1', '', '4', 0, 0, 21, 1, 0x323031372d30312d32372031333a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(456, 3, 'Schéma du reseau', '<p>S''assurer en debut de projet qu''un contact cote architecture reseau a ete designe sur le projet. (pas d''@ IP dans un document classe C1)</p>', '1', '', '4.1', 455, 1, 22, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(457, 3, 'Topologie, flux, protocole, port, matrice des flux', '<p>Rappel : Si le DICP est I2 ou I3, les flux doivent etre chiffres (ex SSL) pour preserver l''integrite des donnees.</p>\n<p>&nbsp;Tableau 1 : chaine de liaisons applicatives externes</p>\n<table>\n<tbody>\n<tr>\n<td>N&deg;</td>\n<td>Type de flux</td>\n<td>Emmeteur</td>\n<td>Localisation</td>\n<td>Recepteur</td>\n<td>Dependance (source EBH)</td>\n<td>Informations complementaires</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>HTTPS</td>\n<td>PdT Arpege</td>\n<td>Bengalore</td>\n<td>&nbsp;</td>\n<td>Obligatoire, mode degrade possible sur xx h/j/semaine</td>\n<td>Role du flux + volume * frequence pour avoir une estimation du debit</td>\n</tr>\n</tbody>\n</table>\n<p>Tableau 2 : Chaine de liaisons applicatives internes</p>\n<table>\n<tbody>\n<tr>\n<td>N&deg;</td>\n<td>Type de flux</td>\n<td>Emmeteur</td>\n<td>Recepteur</td>\n<td>Dependance (source EBH)</td>\n<td>Informations complementaires</td>\n</tr>\n<tr>\n<td>&nbsp;</td>\n<td>HTTPS</td>\n<td>PdT Arpege</td>\n<td>&nbsp;</td>\n<td>obligatoire, mode degrade possible sur xx h/j/semaine</td>\n<td>role du flux + volume * frequence pour avoir une estimation du debit</td>\n</tr>\n</tbody>\n</table>\n<p>Tableau 3 : Chaine de liaisons techniques</p>\n<p>Ex: Pour Citrix</p>\n<ul>\n<li>Utilisateurs</li>\n<li>Nb &nbsp;d''utilisateurs simultanes utilisant l''application</li>\n<li>Compte utilisateurs et postes utilisateurs : ARPEGE / SGCIB / Filliales</li>\n<li>Types de connexions : Intranet / Extranet</li>\n</ul>', '1', '', '4.1.1', 456, 2, 23, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(458, 3, 'Architecture d''hebergement applicatif', '', '1', '', '5', 0, 0, 24, 1, 0x323031372d30312d32372031333a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(459, 3, 'Description de l''architecture par environnement et dimensionnement', '<p>Donner / Rappeler les criteres ayant abouti au choix de solution technique. Justifier imperativement un choix de serveur non virtuel (bas&eacute; sur les contraintes de consommation de ressources - IOPs, mem,CPU,stockage - et eventuellement sur des contraintes editeur)</p>', '1', '', '5.1', 458, 1, 25, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(460, 3, 'Les environnements', '<p>Indiquez le nombre d''environnements</p>\n<p>Decrire de maniere synthetique les principes d''architecture de construction des environnements : ex: pour l''homologation, meme modele d''architecture de resilience que la production avec dimensionnement divise par ... etc</p>\n<p>Generalement, les principes sont les memes entre les environnements</p>\n<p>Decrire precisement les principes de construction de la production et du secours, et si les principes sont les memes, indiquez uniquement les differences &nbsp;(generalement, dimensionnement et nombre de serveurs, nature du CSR,etc)</p>', '1', '', '5.1.1', 459, 2, 26, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(461, 3, 'Composants', '<p>Representation de l''architecte GTS de l''architecture applicative</p>\n<p>Tableau 1 : vision application des composants</p>\n<p>&nbsp;</p>\n<table>\n<tbody>\n<tr>\n<td>Composants</td>\n<td>Description</td>\n<td>Cycle de fonctionnement</td>\n</tr>\n<tr>\n<td>Composant 1</td>\n<td>utilisation du composant dans le contexte du DAH<br />Indiquer quelles fonctions applicatives sont assurees par ce composant</td>\n<td>A remplir si non decrit dans le DAA ou l''EBH.A decrire par fonction applicative</td>\n</tr>\n<tr>\n<td>connect:eXpress</td>\n<td>Ex : installe sur chaque noeud des clusters xxx pour assurer la reception et des fichiers</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>Tableau 2 : fiche technique de composants</p>\n<table>\n<tbody>\n<tr>\n<td>Composants</td>\n<td>Comportement Infra</td>\n<td>Standard</td>\n<td>Ancienne version</td>\n<td>Nouvelle version</td>\n</tr>\n<tr>\n<td>Composant 1</td>\n<td>CPU Bound<br />Memory Bound<br />IO Bound</td>\n<td>Oui / non</td>\n<td>Version + fin de support standard + fin de support etendu</td>\n<td>Version + fin de support standard + fin de support etendue</td>\n</tr>\n<tr>\n<td>connect:eXpress</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n<td>&nbsp;</td>\n</tr>\n</tbody>\n</table>\n<p>La strategie de migration est decrit dans le paragraphe 6 "orientation pour la production"</p>', '1', '', '5.1.2', 459, 2, 27, 1, 0x323031372d30312d32372031343a32323a3533, 0x323031372d30312d32372031333a32323a3533),
(462, 3, 'Recap', '<p><span style="text-decoration:underline; background-color:#ffcc00;"><em><strong>wxcwxcwxcwxcwxcwxc</strong></em></span></p>\n<p><span style="text-decoration:underline; background-color:#ffcc00;"><em><strong><img src="/source/templates/refarc%20test.png" alt="" width="588" height="365" /><br /></strong></em></span></p>\n<p>&nbsp;</p>', '1', '', '6', 0, 0, 28, 1, 0x323031372d30312d32372031333a32323a3533, 0x323031372d30312d32372031333a32323a3533);

-- --------------------------------------------------------

--
-- Structure de la table `templates_diff`
--

CREATE TABLE IF NOT EXISTS `templates_diff` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) CHARACTER SET utf8 NOT NULL,
  `entite` varchar(255) CHARACTER SET utf8 NOT NULL,
  `objet` varchar(255) CHARACTER SET utf8 NOT NULL,
  `id_user` int(11) NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `templates_diff`
--

INSERT INTO `templates_diff` (`id`, `nom`, `entite`, `objet`, `id_user`, `created_at`, `updated_at`) VALUES
(1, 'hammami wajdi', 'GTS/APS/BCO', 'validation', 1, 0x323031362d31322d3238, 0x323031362d31322d32382031303a34323a3337);

-- --------------------------------------------------------

--
-- Structure de la table `templates_interv`
--

CREATE TABLE IF NOT EXISTS `templates_interv` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) CHARACTER SET utf8 NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 NOT NULL,
  `resp_domain` varchar(255) CHARACTER SET utf8 NOT NULL,
  `entite` varchar(255) CHARACTER SET utf8 NOT NULL,
  `id_user` int(11) NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `templates_interv`
--

INSERT INTO `templates_interv` (`id`, `nom`, `email`, `resp_domain`, `entite`, `id_user`, `created_at`, `updated_at`) VALUES
(11, 'francois', 'f@gmail.com', 'Manager', 'RESG/VTS', 1, 0x323031362d31322d3239, 0x323031362d31322d32392031303a30393a3134),
(12, 'bijoi', 'bijo@gmail.com', 'Manager', 'RESG/GTS', 1, 0x323031362d31322d3239, 0x323031362d31322d32392031303a32333a3033);

-- --------------------------------------------------------

--
-- Structure de la table `templates_params`
--

CREATE TABLE IF NOT EXISTS `templates_params` (
  `id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `nbapps` int(11) NOT NULL DEFAULT '0',
  `valid` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `templates_params`
--

INSERT INTO `templates_params` (`id`, `version`, `comment`, `user_id`, `type`, `nbapps`, `valid`, `created_at`, `updated_at`) VALUES
(1, 1, 'vers 1', 1, 1, 0, 1, 0x323031372d30322d30312031353a31323a3035, 0x323031372d30322d30312031343a31323a3035);

-- --------------------------------------------------------

--
-- Structure de la table `typetpl`
--

CREATE TABLE IF NOT EXISTS `typetpl` (
  `id` int(11) NOT NULL,
  `type` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `typetpl`
--

INSERT INTO `typetpl` (`id`, `type`, `created_at`, `updated_at`) VALUES
(1, 'DAH', 0x323031362d31322d31342031353a30303a3531, 0x323031362d31322d31342031353a30303a3531);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `id_sesame` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `name`, `id_sesame`, `email`, `password`, `active`, `banned`, `register_ip`, `country_code`, `locale`, `activation_key`, `su`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Hammami Wajdi', '', 'hammami.ouajdi@gmail.com', '$2y$10$p1iNnPAuuHljzo9zk1zroOu25y.HkmQNlPAJcmn4XvS3JoLRYhz/C', 1, 0, '', 'FR', 'en', 'A772sNxQfXSTOX0gEDPzhceEd', 1, '9x0Ren4BkqJR7P0Z6nCBY5bUySVUBMAVLjm6YeXFYAwMyQRdeLFgOWX1KIIt', 0x323031362d31302d31302031323a33313a3539, 0x323031372d30312d33312031343a33353a3035),
(2, 'Francois LEVEL DE CURNIEU', '', 'francois.level-de-curnieu-ext@socgen.com', '$2y$10$p1iNnPAuuHljzo9zk1zroOu25y.HkmQNlPAJcmn4XvS3JoLRYhz/C', 1, 0, '192.32.34.209', '', '', 'XCTvupvpmzh3mbnrDBkMdAtSx', 1, 'yV6nuUXW5yDTS0dAbZM8z27PJqCb8NH0uKyWIMOiDUDyjsqrHZUjbDvYVV1b', 0x323031372d30312d31382031333a33363a3032, 0x323031372d30312d32372030393a34303a3534),
(3, 'Bijo SEBASTIAN', '', 'bijo.sebastian-ext@socgen.com', '$2y$10$p1iNnPAuuHljzo9zk1zroOu25y.HkmQNlPAJcmn4XvS3JoLRYhz/C', 1, 0, '192.32.34.209', '', '', 'PJpqFYcFsCmXVJIB6NBjy9pZy', 0, 'AV0wUsSRueaj0x43X2vFd18gF1m216uZ6IHWiXwXlg1AIzhzMICyIIOr7wbu', 0x323031372d30312d31382031333a34303a3236, 0x323031372d30312d33302031353a35303a3430),
(10, 'Stéphane GRAUBY', '', 'stephane.grauby@socgen.com', '$2y$10$oXeKgLNej7LOejcuxXyfeOxchfvzSsoN0MJUAZI./gwFo37Ag6YtG', 1, 0, '192.128.136.40', 'FR', '', 'JJ6Z8l97VdX1x4uitbJx8ARbB', 0, 'oDVsNP7pdvjgYe9EOiqIhFkuox5gUCuImPOuCw7uut41ri9fuUFI3aE1o9AM', 0x323031372d30312d32332031323a31313a3138, 0x323031372d30312d32342031343a31313a3136);

-- --------------------------------------------------------

--
-- Structure de la table `users_settings`
--

CREATE TABLE IF NOT EXISTS `users_settings` (
  `id` int(10) unsigned NOT NULL,
  `default_role` int(11) NOT NULL,
  `location` tinyint(1) NOT NULL COMMENT '0: off, 1: on',
  `register_enabled` tinyint(1) NOT NULL COMMENT '0: off, 1: on',
  `default_active` int(11) NOT NULL COMMENT '0: off, 1: email, 2: on',
  `welcome_email` tinyint(1) NOT NULL COMMENT '0: off, 1: on'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Contenu de la table `users_settings`
--

INSERT INTO `users_settings` (`id`, `default_role`, `location`, `register_enabled`, `default_active`, `welcome_email`) VALUES
(1, 3, 0, 1, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `version_apps`
--

CREATE TABLE IF NOT EXISTS `version_apps` (
  `id` int(45) NOT NULL,
  `id_app` int(45) DEFAULT NULL,
  `version` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `applications_content`
--
ALTER TABLE `applications_content`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `applications_params`
--
ALTER TABLE `applications_params`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `applications_planning`
--
ALTER TABLE `applications_planning`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `applications_version_history`
--
ALTER TABLE `applications_version_history`
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
-- Index pour la table `experiences`
--
ALTER TABLE `experiences`
  ADD PRIMARY KEY (`id`);

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
-- Index pour la table `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `templates_diff`
--
ALTER TABLE `templates_diff`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `templates_interv`
--
ALTER TABLE `templates_interv`
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
-- Index pour la table `version_apps`
--
ALTER TABLE `version_apps`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `applications_content`
--
ALTER TABLE `applications_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `applications_params`
--
ALTER TABLE `applications_params`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `applications_planning`
--
ALTER TABLE `applications_planning`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `applications_version_history`
--
ALTER TABLE `applications_version_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `diffusion`
--
ALTER TABLE `diffusion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `experiences`
--
ALTER TABLE `experiences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT pour la table `histo_applications`
--
ALTER TABLE `histo_applications`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `histo_projects`
--
ALTER TABLE `histo_projects`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `intervenants`
--
ALTER TABLE `intervenants`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT pour la table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT pour la table `permission_role`
--
ALTER TABLE `permission_role`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=133;
--
-- AUTO_INCREMENT pour la table `pictures`
--
ALTER TABLE `pictures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT pour la table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT pour la table `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=44;
--
-- AUTO_INCREMENT pour la table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `templates`
--
ALTER TABLE `templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=463;
--
-- AUTO_INCREMENT pour la table `templates_diff`
--
ALTER TABLE `templates_diff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `templates_interv`
--
ALTER TABLE `templates_interv`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT pour la table `templates_params`
--
ALTER TABLE `templates_params`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `typetpl`
--
ALTER TABLE `typetpl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT pour la table `users_settings`
--
ALTER TABLE `users_settings`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `version_apps`
--
ALTER TABLE `version_apps`
  MODIFY `id` int(45) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
