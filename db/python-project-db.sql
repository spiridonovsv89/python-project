-- Adminer 4.8.1 MySQL 5.5.5-10.11.2-MariaDB-1:10.11.2+maria~ubu2204 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE TABLE `Articles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `magazines_id` int(11) NOT NULL,
  `article_type_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `magazines_id` (`magazines_id`),
  KEY `article_type_id` (`article_type_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `Articles_ibfk_1` FOREIGN KEY (`magazines_id`) REFERENCES `magazines` (`id`),
  CONSTRAINT `Articles_ibfk_2` FOREIGN KEY (`article_type_id`) REFERENCES `article_types` (`id`),
  CONSTRAINT `Articles_ibfk_3` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `Articles` (`id`, `magazines_id`, `article_type_id`, `author_id`) VALUES
(1,	1,	2,	3),
(2,	3,	3,	2),
(3,	2,	2,	4),
(4,	1,	1,	1);

CREATE TABLE `article_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `article_types` (`id`, `type`) VALUES
(1,	'news'),
(2,	'tech'),
(3,	'entertainment');

CREATE TABLE `author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `author` (`id`, `author`) VALUES
(1,	'Chappie'),
(2,	'Wall-e'),
(3,	'Atom'),
(4,	'T1000');

CREATE TABLE `magazines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `magazines` (`id`, `name`) VALUES
(1,	'it herald'),
(2,	'IT STORIES'),
(3,	'IT with kids');

-- 2023-03-09 11:50:29
