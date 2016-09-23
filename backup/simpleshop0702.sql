/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : simpleshop

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-07-02 17:33:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth` (
  `uid` tinyint(3) NOT NULL AUTO_INCREMENT,
  `level` int(8) NOT NULL DEFAULT '2',
  `username` varchar(255) CHARACTER SET latin1 NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`uid`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth
-- ----------------------------
INSERT INTO `auth` VALUES ('1', '1', 'admin', '291760f98414679e3fd3f9051b19b6f7');
INSERT INTO `auth` VALUES ('2', '2', 'admin2', '895785cfa5d8157f4d33c58ae0f55123');
INSERT INTO `auth` VALUES ('3', '2', 'guest', 'bdce026566b584302dc0b5da550ecf0e');
INSERT INTO `auth` VALUES ('4', '2', 'Bob', 'd862f26b564bdc46a71137f6498a084e');
INSERT INTO `auth` VALUES ('6', '2', 'Alex', 'bdce026566b584302dc0b5da550ecf0e');
INSERT INTO `auth` VALUES ('7', '2', 'Cabin', '175c289523246d70ec4c60f2f317dc09');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `gid` tinyint(3) DEFAULT NULL,
  `cid` tinyint(3) DEFAULT NULL,
  `ctime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  KEY `gid` (`gid`),
  CONSTRAINT `gid` FOREIGN KEY (`gid`) REFERENCES `goods` (`id`),
  CONSTRAINT `cid` FOREIGN KEY (`cid`) REFERENCES `auth` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_mysql500_ci;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for chitchat
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
-- Table structure for classify
-- ----------------------------
DROP TABLE IF EXISTS `classify`;
CREATE TABLE `classify` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `cname` varchar(25) NOT NULL,
  `cleval` smallint(5) NOT NULL,
  `uplv` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of classify
-- ----------------------------
INSERT INTO `classify` VALUES ('1', 'digital', '1', '0');
INSERT INTO `classify` VALUES ('2', 'clothes', '1', '0');
INSERT INTO `classify` VALUES ('3', 'food', '1', '0');
INSERT INTO `classify` VALUES ('4', 'mobile phone', '2', '1');
INSERT INTO `classify` VALUES ('5', 'desktop computer', '2', '1');
INSERT INTO `classify` VALUES ('6', 'tablet', '2', '1');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `oid` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `content` text NOT NULL,
  `degree` tinyint(1) NOT NULL,
  `ctime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', '4', '3', 'Comment here for you.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('2', '5', '3', 'Comment here for you.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('3', '6', '3', 'Comment here for you.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('4', '7', '3', 'Comment here for you.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('5', '8', '3', 'Comment here for you.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('6', '9', '3', 'Comment here for you.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('7', '5', '3', 'Comment here for you.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('11', '1', '3', '习大大说得对!', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('12', '2', '2', '习大大说得对!', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('13', '2', '3', 'go go go.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('14', '2', '1', 'go go go.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('15', '1', '1', 'good job.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('16', '1', '1', 'seems aswem', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('17', '3', '1', '习大大说得对!', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('18', '3', '1', 'no', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('19', '4', '1', 'You are right!', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('20', '3', '1', 'you are right.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('21', '3', '1', 'good', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('22', '2', '2', 'Success finally.', '4', '0000-00-00 00:00:00');
INSERT INTO `comment` VALUES ('23', '7', '1', '看看新闻，关心国家大事。', '4', '0000-00-00 00:00:00');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` tinyint(3) NOT NULL,
  `sid` smallint(5) NOT NULL,
  `lvid` smallint(5) NOT NULL,
  `gname` varchar(25) NOT NULL,
  `gdesc` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `stock` smallint(5) NOT NULL COMMENT '库存数量',
  `gdetails` varchar(255) DEFAULT NULL,
  `gimg` varchar(255) DEFAULT NULL,
  `addtime` int(11) NOT NULL,
  `dtime` int(11) DEFAULT NULL COMMENT '截止时间',
  `ftime` int(11) DEFAULT NULL COMMENT '预售时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '1', '0', 'iphone', 'iPhone，是美国苹果公司研发的智能手机，它搭载iOS操作系统。', '3000', '5', '第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于2014年9月10日发布，中国大陆地区销售时间定为10月17日。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('2', '2', '0', 'ipad', '北京时间2015年9月10日，iPhone 6s/iPhone 6s Plus正式发布，已于2015年9月12日15时开始接受预约，', '2000', '5', '并于2015年9月25日正式开售，中国是首发国家之一。[2] \r\n北京时间2016年3月21日22时，iPhone SE正式发布，已于2016年3月24日开始接受预约，并于2016年3月31日正式开售，中国是首发国家之一。[3-4]  第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('3', '3', '0', 'ipod', '2004年，苹果公司召集了1000多名内部员工组成研发iPhone团队，', '1000', '5', '开始了被\r\n为什么iPhone就是那么不一样\r\n为什么iPhone就是那么不一样\r\n列为高度机密的项目，订名为“Project Purple”，当中包括iPhone的幕后设计师Jonathan Ive。当时苹果公司的首席执行官史蒂夫·乔布斯从原本的重点如iPad的平板电脑偏离至转向手机。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('4', '4', '0', 'itouch', '苹果公司跟AT&T秘密合作创造了一些硬件和软件设备—当时的Cingular无线网络—AT&T并给予苹果公司投资及很大自由度，', '1000', '5', '在30个月动用了约$1.5亿美元。作为交换条件，苹果公司保证在4年内，在美国出售的iPhone将交由AT&T独家发售。2007年1月9日，乔布斯在旧金山马士孔尼会展中心的苹果公司全球软件开发者年会2007中透露推出第一代iPhone。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于2', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('5', '5', '0', 'idea', '苹果首次进入手机市场是在2005年，当时苹果与摩托罗拉合作推出了一款iTunes手机——Motorola Rockr。', '1000', '5', '两个最初型号分别是售价为$499的4GB和$599的8GB版本，于当地时间2007年6月29日下午6时正在美国正式发售，全美的苹果公司销售商店外有数百名苹果粉丝为了抢购而提早排队购买。由于刚推出的iPhone上市后引发热潮及销情反应热烈，部分媒体誉为“上帝手机”。第一代iPhone于2007年11月在英国、法国及德国发售，而爱尔兰及奥地利则在2008年的春季开售。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('6', '6', '0', '华为荣耀畅玩5C', '荣耀品牌在2013年推出，是一个主打性价比的互联网手机品牌', '999', '5', '荣耀畅玩5C搭载了海思最新的麒麟650处理器，4x2.0GHz A53 4x1.7GHz A53的八核心架构，采用了16nm FinFET 工艺制程。  此外，荣耀畅玩5C还内置了i5协处理器，能在较低功耗情况下提供熄屏计步功能。  其它方面，配备了2GB RAM 16GB ROM的内存组合，采用5.2英寸1080P分辨率屏幕，前置800万像素摄像头 后置1300W像素摄像头，内置3000mAh容量电池，双卡双待，运行Andorid 6.0版本的系统。  除了配置大升级外，荣耀畅玩5C还配备了不少的主流功', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('7', '7', '0', '中兴手机', '中兴手机于1998年开始从事手机产品的研发和生产，是全球少数有能力研发、制造2G、3G、3.5G、4G全系列终端产品的高科技企业之一，能够根据运营商的网络特点和业务特点，提供手机、移动宽带终端、家庭桌面式融合终端等全系列产品的个性化定制服务', '899', '5', '与世界同步的研发水准 中兴通讯在深圳、南京、上海、西安等重要城市设有研发中心，并设有独立的软硬件支撑平台、工业设计平台、研发测试平台等。中兴通讯每年将收入的10%用于研发。截止2012年12月底，中兴通讯手机产品体系拿到申请号的中国专利申请数量为7575件，国际专利申请数量为3101件。中兴通讯是全球少数有能力研发2G、3G、4G、手机、无线网卡、监控器、无线固话等九大品类全系列移动终端产品的厂商之一，现已掌握了除部分核心芯片开发之外的所有其他手机核心技术。能够根据运营商的网络特点和业务特点定制个性化的终', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('8', '8', '0', 'iphone', 'iPhone，是美国苹果公司研发的智能手机，它搭载iOS操作系统。', '3000', '5', '第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于2014年9月10日发布，中国大陆地区销售时间定为10月17日。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('9', '9', '0', 'ipad', '北京时间2015年9月10日，iPhone 6s/iPhone 6s Plus正式发布，已于2015年9月12日15时开始接受预约，', '2000', '5', '并于2015年9月25日正式开售，中国是首发国家之一。[2] \r\n北京时间2016年3月21日22时，iPhone SE正式发布，已于2016年3月24日开始接受预约，并于2016年3月31日正式开售，中国是首发国家之一。[3-4]  第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('10', '10', '0', 'ipod', '2004年，苹果公司召集了1000多名内部员工组成研发iPhone团队，', '1000', '5', '开始了被\r\n为什么iPhone就是那么不一样\r\n为什么iPhone就是那么不一样\r\n列为高度机密的项目，订名为“Project Purple”，当中包括iPhone的幕后设计师Jonathan Ive。当时苹果公司的首席执行官史蒂夫·乔布斯从原本的重点如iPad的平板电脑偏离至转向手机。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('11', '11', '0', 'itouch', '苹果公司跟AT&T秘密合作创造了一些硬件和软件设备—当时的Cingular无线网络—AT&T并给予苹果公司投资及很大自由度，', '1000', '5', '在30个月动用了约$1.5亿美元。作为交换条件，苹果公司保证在4年内，在美国出售的iPhone将交由AT&T独家发售。2007年1月9日，乔布斯在旧金山马士孔尼会展中心的苹果公司全球软件开发者年会2007中透露推出第一代iPhone。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于2', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('12', '12', '0', 'idea', '苹果首次进入手机市场是在2005年，当时苹果与摩托罗拉合作推出了一款iTunes手机——Motorola Rockr。', '1000', '5', '两个最初型号分别是售价为$499的4GB和$599的8GB版本，于当地时间2007年6月29日下午6时正在美国正式发售，全美的苹果公司销售商店外有数百名苹果粉丝为了抢购而提早排队购买。由于刚推出的iPhone上市后引发热潮及销情反应热烈，部分媒体誉为“上帝手机”。第一代iPhone于2007年11月在英国、法国及德国发售，而爱尔兰及奥地利则在2008年的春季开售。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('13', '13', '0', '华为荣耀畅玩5C', '荣耀品牌在2013年推出，是一个主打性价比的互联网手机品牌', '999', '5', '荣耀畅玩5C搭载了海思最新的麒麟650处理器，4x2.0GHz A53 4x1.7GHz A53的八核心架构，采用了16nm FinFET 工艺制程。  此外，荣耀畅玩5C还内置了i5协处理器，能在较低功耗情况下提供熄屏计步功能。  其它方面，配备了2GB RAM 16GB ROM的内存组合，采用5.2英寸1080P分辨率屏幕，前置800万像素摄像头 后置1300W像素摄像头，内置3000mAh容量电池，双卡双待，运行Andorid 6.0版本的系统。  除了配置大升级外，荣耀畅玩5C还配备了不少的主流功', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('14', '14', '0', 'iphone', 'iPhone，是美国苹果公司研发的智能手机，它搭载iOS操作系统。', '3000', '5', '第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于2014年9月10日发布，中国大陆地区销售时间定为10月17日。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('15', '15', '0', 'ipad', '北京时间2015年9月10日，iPhone 6s/iPhone 6s Plus正式发布，已于2015年9月12日15时开始接受预约，', '2000', '5', '并于2015年9月25日正式开售，中国是首发国家之一。[2] \r\n北京时间2016年3月21日22时，iPhone SE正式发布，已于2016年3月24日开始接受预约，并于2016年3月31日正式开售，中国是首发国家之一。[3-4]  第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('16', '16', '0', 'ipod', '2004年，苹果公司召集了1000多名内部员工组成研发iPhone团队，', '1000', '5', '开始了被\r\n为什么iPhone就是那么不一样\r\n为什么iPhone就是那么不一样\r\n列为高度机密的项目，订名为“Project Purple”，当中包括iPhone的幕后设计师Jonathan Ive。当时苹果公司的首席执行官史蒂夫·乔布斯从原本的重点如iPad的平板电脑偏离至转向手机。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('17', '17', '0', 'itouch', '苹果公司跟AT&T秘密合作创造了一些硬件和软件设备—当时的Cingular无线网络—AT&T并给予苹果公司投资及很大自由度，', '1000', '5', '在30个月动用了约$1.5亿美元。作为交换条件，苹果公司保证在4年内，在美国出售的iPhone将交由AT&T独家发售。2007年1月9日，乔布斯在旧金山马士孔尼会展中心的苹果公司全球软件开发者年会2007中透露推出第一代iPhone。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于2', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('18', '18', '0', 'idea', '苹果首次进入手机市场是在2005年，当时苹果与摩托罗拉合作推出了一款iTunes手机——Motorola Rockr。', '1000', '5', '两个最初型号分别是售价为$499的4GB和$599的8GB版本，于当地时间2007年6月29日下午6时正在美国正式发售，全美的苹果公司销售商店外有数百名苹果粉丝为了抢购而提早排队购买。由于刚推出的iPhone上市后引发热潮及销情反应热烈，部分媒体誉为“上帝手机”。第一代iPhone于2007年11月在英国、法国及德国发售，而爱尔兰及奥地利则在2008年的春季开售。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('19', '19', '0', '华为荣耀畅玩5C', '荣耀品牌在2013年推出，是一个主打性价比的互联网手机品牌', '999', '5', '荣耀畅玩5C搭载了海思最新的麒麟650处理器，4x2.0GHz A53 4x1.7GHz A53的八核心架构，采用了16nm FinFET 工艺制程。  此外，荣耀畅玩5C还内置了i5协处理器，能在较低功耗情况下提供熄屏计步功能。  其它方面，配备了2GB RAM 16GB ROM的内存组合，采用5.2英寸1080P分辨率屏幕，前置800万像素摄像头 后置1300W像素摄像头，内置3000mAh容量电池，双卡双待，运行Andorid 6.0版本的系统。  除了配置大升级外，荣耀畅玩5C还配备了不少的主流功', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('20', '20', '0', '中兴手机', '中兴手机于1998年开始从事手机产品的研发和生产，是全球少数有能力研发、制造2G、3G、3.5G、4G全系列终端产品的高科技企业之一，能够根据运营商的网络特点和业务特点，提供手机、移动宽带终端、家庭桌面式融合终端等全系列产品的个性化定制服务', '899', '5', '与世界同步的研发水准 中兴通讯在深圳、南京、上海、西安等重要城市设有研发中心，并设有独立的软硬件支撑平台、工业设计平台、研发测试平台等。中兴通讯每年将收入的10%用于研发。截止2012年12月底，中兴通讯手机产品体系拿到申请号的中国专利申请数量为7575件，国际专利申请数量为3101件。中兴通讯是全球少数有能力研发2G、3G、4G、手机、无线网卡、监控器、无线固话等九大品类全系列移动终端产品的厂商之一，现已掌握了除部分核心芯片开发之外的所有其他手机核心技术。能够根据运营商的网络特点和业务特点定制个性化的终', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('21', '21', '0', 'iphone', 'iPhone，是美国苹果公司研发的智能手机，它搭载iOS操作系统。', '3000', '5', '第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于2014年9月10日发布，中国大陆地区销售时间定为10月17日。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('22', '22', '0', 'ipad', '北京时间2015年9月10日，iPhone 6s/iPhone 6s Plus正式发布，已于2015年9月12日15时开始接受预约，', '2000', '5', '并于2015年9月25日正式开售，中国是首发国家之一。[2] \r\n北京时间2016年3月21日22时，iPhone SE正式发布，已于2016年3月24日开始接受预约，并于2016年3月31日正式开售，中国是首发国家之一。[3-4]  第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('23', '23', '0', 'ipod', '2004年，苹果公司召集了1000多名内部员工组成研发iPhone团队，', '1000', '5', '开始了被\r\n为什么iPhone就是那么不一样\r\n为什么iPhone就是那么不一样\r\n列为高度机密的项目，订名为“Project Purple”，当中包括iPhone的幕后设计师Jonathan Ive。当时苹果公司的首席执行官史蒂夫·乔布斯从原本的重点如iPad的平板电脑偏离至转向手机。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('24', '24', '0', 'itouch', '苹果公司跟AT&T秘密合作创造了一些硬件和软件设备—当时的Cingular无线网络—AT&T并给予苹果公司投资及很大自由度，', '1000', '5', '在30个月动用了约$1.5亿美元。作为交换条件，苹果公司保证在4年内，在美国出售的iPhone将交由AT&T独家发售。2007年1月9日，乔布斯在旧金山马士孔尼会展中心的苹果公司全球软件开发者年会2007中透露推出第一代iPhone。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone 5s和iPhone 5c于2013年9月10日发布，同年9月20日正式发售。第八代的iPhone 6和iPhone6 Plus于2', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('25', '25', '0', 'idea', '苹果首次进入手机市场是在2005年，当时苹果与摩托罗拉合作推出了一款iTunes手机——Motorola Rockr。', '1000', '5', '两个最初型号分别是售价为$499的4GB和$599的8GB版本，于当地时间2007年6月29日下午6时正在美国正式发售，全美的苹果公司销售商店外有数百名苹果粉丝为了抢购而提早排队购买。由于刚推出的iPhone上市后引发热潮及销情反应热烈，部分媒体誉为“上帝手机”。第一代iPhone于2007年11月在英国、法国及德国发售，而爱尔兰及奥地利则在2008年的春季开售。第一代iPhone于2007年1月9日由苹果公司前首席执行官史蒂夫·乔布斯发布，并在2007年6月29日正式发售[1]  。第七代的iPhone', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);
INSERT INTO `goods` VALUES ('26', '26', '0', '华为荣耀畅玩5C', '荣耀品牌在2013年推出，是一个主打性价比的互联网手机品牌', '999', '5', '荣耀畅玩5C搭载了海思最新的麒麟650处理器，4x2.0GHz A53 4x1.7GHz A53的八核心架构，采用了16nm FinFET 工艺制程。  此外，荣耀畅玩5C还内置了i5协处理器，能在较低功耗情况下提供熄屏计步功能。  其它方面，配备了2GB RAM 16GB ROM的内存组合，采用5.2英寸1080P分辨率屏幕，前置800万像素摄像头 后置1300W像素摄像头，内置3000mAh容量电池，双卡双待，运行Andorid 6.0版本的系统。  除了配置大升级外，荣耀畅玩5C还配备了不少的主流功', '/static/upload/2016/05/29/13/44/11/iPhone7-01.png', '0', null, null);
INSERT INTO `goods` VALUES ('27', '27', '0', '360手机N4', '互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。', '999', '5', '互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网品牌手机，主打性价比。互联网', '/static/upload/2016/05/29/14/39/20/iPhone7-02.png', '0', null, null);

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `ctime` datetime NOT NULL,
  `gid` tinyint(3) NOT NULL,
  `number` int(11) NOT NULL,
  `reciever` varchar(255) NOT NULL,
  `adress` varchar(255) NOT NULL,
  `tel` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gidd` (`gid`),
  KEY `cidd` (`cid`),
  CONSTRAINT `cidd` FOREIGN KEY (`cid`) REFERENCES `auth` (`uid`),
  CONSTRAINT `gidd` FOREIGN KEY (`gid`) REFERENCES `goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('1', '3', '0000-00-00 00:00:00', '4', '2', 'wendy', 'japan', '4294967295');
INSERT INTO `order` VALUES ('2', '2', '0000-00-00 00:00:00', '1', '1', 'jack', 'America', '4294967295');
INSERT INTO `order` VALUES ('3', '1', '0000-00-00 00:00:00', '5', '3', '杨杰刚', '安徽省芜湖市鸠江区官陡镇', '4294967295');

-- ----------------------------
-- Table structure for profile
-- ----------------------------
DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `nick` varchar(255) NOT NULL,
  `age` smallint(5) NOT NULL,
  `gender` tinyint(1) NOT NULL,
  `uname` varchar(255) NOT NULL,
  `degree` tinyint(1) NOT NULL,
  `ctime` int(11) NOT NULL,
  `mtime` int(11) NOT NULL,
  `motto` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of profile
-- ----------------------------
