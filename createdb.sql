/*
  sql script to create db structure
*/


-- `id` bigint(20) unsigned not null auto_increment;

--
-- create table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
CREATE TABLE `files` (
  `bkname` varchar(100) not null,
  `linenr` int(10) not null,
  `filename` varchar(500) NOT NULL,
  `size` bigint(20) NOT NULL,
  `blocks` bigint(19) unsigned NOT NULL,
  `type` varchar(10) NOT NULL,
  `uid` int(10) NOT NULL,
  `gid` int(10) NOT NULL,
  `device` varchar (10) not null,
  `inode` int(15) not null,
  `links` int(8) not null,
  `uid2` int(10) NOT NULL,
  `gid2` int(10) NOT NULL,
  `access_d` datetime null,
  `modify_d` datetime null,
  `change_d` datetime null,
  `ioblock` int(15) not null
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes für die Tabelle `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`bkname`,`linenr`);

