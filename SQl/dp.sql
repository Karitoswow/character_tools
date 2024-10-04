/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.4.32-MariaDB 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `character_tools_free` (
	`id` int (11),
	`name` varchar (450),
	`type` varchar (450),
	`amount` varchar (450),
	`active` int (11)
); 
insert into `character_tools_free` (`id`, `name`, `type`, `amount`, `active`) values('1','name_change','dp','200','1');
insert into `character_tools_free` (`id`, `name`, `type`, `amount`, `active`) values('2','race_change','dp','100','1');
insert into `character_tools_free` (`id`, `name`, `type`, `amount`, `active`) values('3','faction_change','dp','100','1');
insert into `character_tools_free` (`id`, `name`, `type`, `amount`, `active`) values('4','appearance_change','dp','100','1');
