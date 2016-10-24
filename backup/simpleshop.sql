/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : simpleshop

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-06-27 16:00:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `chitchat`
-- ----------------------------
DROP TABLE IF EXISTS `chitchat`;
CREATE TABLE `chitchat` (
  `id` int(11) NOT NULL,
  `uid` smallint(5) NOT NULL,
  `ctime` int(11) NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of chitchat
-- ----------------------------

-- ----------------------------
-- Table structure for `classify`
-- ----------------------------
DROP TABLE IF EXISTS `classify`;
CREATE TABLE `classify` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `cname` varchar(25) NOT NULL,
  `fid` smallint(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classify
-- ----------------------------

-- ----------------------------
-- Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `oid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `content` text NOT NULL,
  `degree` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------

-- ----------------------------
-- Table structure for `goods`
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` smallint(5) NOT NULL,
  `gname` varchar(25) NOT NULL,
  `gdesc` varchar(255) NOT NULL,
  `cid` smallint(5) NOT NULL,
  `price` int(11) NOT NULL,
  `sid` smallint(5) NOT NULL,
  `stock` smallint(5) NOT NULL COMMENT '库存数量',
  `addtime` int(11) NOT NULL,
  `dtime` int(11) DEFAULT NULL COMMENT '截止时间',
  `ftime` int(11) DEFAULT NULL COMMENT '预售时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` smallint(5) NOT NULL,
  `sid` smallint(5) NOT NULL,
  `ctime` int(11) NOT NULL,
  `gid` smallint(5) NOT NULL,
  `number` int(11) NOT NULL,
  `total` int(11) NOT NULL COMMENT '总价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `nick` varchar(255) NOT NULL,
  `age` smallint(3) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `uname` varchar(255) NOT NULL,
  `degree` tinyint(1) NOT NULL,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `motto` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
