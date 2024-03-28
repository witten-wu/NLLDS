/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50742 (5.7.42)
 Source Host           : localhost:3306
 Source Schema         : NLLDS

 Target Server Type    : MySQL
 Target Server Version : 50742 (5.7.42)
 File Encoding         : 65001

 Date: 14/03/2024 10:57:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;


-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `pid` varchar(255) NOT NULL,
  `pname` varchar(255) NOT NULL,
  `createby` varchar(255) NOT NULL,
  `manageby` varchar(255) NOT NULL,
  `createdate` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `questionnaire` varchar(255) DEFAULT NULL,
  `qustable` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject` (
  `subjectid` varchar(255) NOT NULL,
  `subjectno` varchar(255) NOT NULL,
  `projectid` varchar(255) NOT NULL,
  `tasks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`subjectid`) USING BTREE,
  KEY `projectid` (`projectid`) USING BTREE,
  KEY `subjectno` (`subjectno`) USING BTREE,
  CONSTRAINT `subject_ibfk_1` FOREIGN KEY (`projectid`) REFERENCES `project` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `tid` int(10) NOT NULL AUTO_INCREMENT,
  `pid` varchar(255) NOT NULL,
  `tname` varchar(255) NOT NULL,
  `createby` varchar(255) NOT NULL,
  `createdate` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `fields_table` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tid`) USING BTREE,
  KEY `pid` (`pid`) USING BTREE,
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `project` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for taskfields
-- ----------------------------
DROP TABLE IF EXISTS `taskfields`;
CREATE TABLE `taskfields` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `fieldname` varchar(255) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `taskid` int(10) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `taskid` (`taskid`) USING BTREE,
  CONSTRAINT `taskfields_ibfk_1` FOREIGN KEY (`taskid`) REFERENCES `task` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `grade` int(10) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Triggers structure for table project
-- ----------------------------
DROP TRIGGER IF EXISTS `generate_pid`;
delimiter ;;
CREATE TRIGGER `generate_pid` BEFORE INSERT ON `project` FOR EACH ROW BEGIN
    SET NEW.pid = CONCAT(NEW.pname, '-', DATE_FORMAT(CURDATE(), '%Y%m%d'));
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table project
-- ----------------------------
DROP TRIGGER IF EXISTS `generate_pcreatedate`;
delimiter ;;
CREATE TRIGGER `generate_pcreatedate` BEFORE INSERT ON `project` FOR EACH ROW BEGIN
    SET NEW.createdate= CURDATE();
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table subject
-- ----------------------------
DROP TRIGGER IF EXISTS `generate_subjectid`;
delimiter ;;
CREATE TRIGGER `generate_subjectid` BEFORE INSERT ON `subject` FOR EACH ROW BEGIN
    SET NEW.subjectid = CONCAT(NEW.subjectno, '_', UNIX_TIMESTAMP());
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table task
-- ----------------------------
DROP TRIGGER IF EXISTS `generate_tcreatedate`;
delimiter ;;
CREATE TRIGGER `generate_tcreatedate` BEFORE INSERT ON `task` FOR EACH ROW BEGIN
    SET NEW.createdate= CURDATE();
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
