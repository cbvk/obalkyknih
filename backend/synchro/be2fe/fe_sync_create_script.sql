
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Databáze: `obalky`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `fe_list`
--

CREATE TABLE IF NOT EXISTS `fe_list` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `fe_group` varchar(50) NOT NULL,
  `hostname` varchar(50) NOT NULL,
  `ip_addr` varchar(15) NOT NULL,
  `port` smallint(5) unsigned NOT NULL,
  `flag_active` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `hostname` (`hostname`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='List of all frontend servers' AUTO_INCREMENT=2 ;

--
-- Vypisuji data pro tabulku `fe_list`
--

INSERT INTO `fe_list` (`id`, `fe_group`, `hostname`, `ip_addr`, `port`, `flag_active`) VALUES
(1, 'cache', 'cache1.obalkyknih.cz', '195.113.145.14', 1337, 1);

-- --------------------------------------------------------

--
-- Struktura tabulky `fe_sync`
--

CREATE TABLE IF NOT EXISTS `fe_sync` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fe_instance` tinyint(3) unsigned NOT NULL,
  `fe_sync_type` tinyint(3) unsigned NOT NULL,
  `flag_synced` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `retry_date` datetime DEFAULT NULL,
  `retry_count` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fe_instance` (`fe_instance`),
  KEY `fe_sync_type` (`fe_sync_type`),
  KEY `flag_sync` (`flag_synced`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Front-end sync event to specifict FE instance' AUTO_INCREMENT=1 ;

--
-- Spouště `fe_sync`
--
DROP TRIGGER IF EXISTS `TRG_retry_date`;
DELIMITER //
CREATE TRIGGER `TRG_retry_date` BEFORE INSERT ON `fe_sync`
 FOR EACH ROW SET NEW.retry_date = NOW()
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabulky `fe_sync2param`
--

CREATE TABLE IF NOT EXISTS `fe_sync2param` (
  `id_sync` int(10) unsigned NOT NULL,
  `id_sync_param` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (`id_sync`,`id_sync_param`),
  KEY `id_sync_param` (`id_sync_param`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Relational table. Params assigned to defined sync';

-- --------------------------------------------------------

--
-- Struktura tabulky `fe_sync_param`
--

CREATE TABLE IF NOT EXISTS `fe_sync_param` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `param_name` varchar(50) NOT NULL,
  `param_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `param_name` (`param_name`,`param_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Params for sync event';

-- --------------------------------------------------------

--
-- Struktura tabulky `fe_sync_type`
--

CREATE TABLE IF NOT EXISTS `fe_sync_type` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `sync_type_code` varchar(50) NOT NULL,
  `sync_type_description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sync_type_code` (`sync_type_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Vypisuji data pro tabulku `fe_sync_type`
--

INSERT INTO `fe_sync_type` (`id`, `sync_type_code`, `sync_type_description`) VALUES
(1, 'metadata_changed', 'Triggers when any information for specific book changed');

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `fe_sync`
--
ALTER TABLE `fe_sync`
  ADD CONSTRAINT `fe_sync_ibfk_1` FOREIGN KEY (`fe_instance`) REFERENCES `fe_list` (`id`),
  ADD CONSTRAINT `fe_sync_ibfk_2` FOREIGN KEY (`fe_sync_type`) REFERENCES `fe_sync_type` (`id`);

--
-- Omezení pro tabulku `fe_sync2param`
--
ALTER TABLE `fe_sync2param`
  ADD CONSTRAINT `fe_sync2param_ibfk_1` FOREIGN KEY (`id_sync`) REFERENCES `fe_sync` (`id`),
  ADD CONSTRAINT `fe_sync2param_ibfk_2` FOREIGN KEY (`id_sync_param`) REFERENCES `fe_sync_param` (`id`);

