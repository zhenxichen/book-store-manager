/*
 Navicat MySQL Data Transfer

 Source Server         : cdb-csf20mte.cd.tencentcdb.com_10099
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : cdb-csf20mte.cd.tencentcdb.com:10099
 Source Schema         : bookstore

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 02/06/2020 22:30:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `ISBN` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书籍的ISBN号',
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书名',
  `author` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '作者',
  `type` tinyint(1) NOT NULL COMMENT '类别：0表示报刊，1表示书籍',
  `number` int(11) NOT NULL COMMENT '库存',
  `price` float NOT NULL COMMENT '价格',
  PRIMARY KEY (`ISBN`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book
-- ----------------------------
INSERT INTO `book` VALUES ('9787040449518', '计算机网络——自顶向下方法', 'James F. Kurose', 1, 37, 89);
INSERT INTO `book` VALUES ('9787111400868', '数据库系统概念', 'Abraham Silberschatz', 1, 55, 69);

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `cid` int(11) NOT NULL COMMENT '顾客id',
  `name` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '顾客姓名',
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '顾客住址',
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (0, '路人', NULL);
INSERT INTO `customer` VALUES (333, '张三', NULL);
INSERT INTO `customer` VALUES (123456, 'feng', NULL);

-- ----------------------------
-- Table structure for operator
-- ----------------------------
DROP TABLE IF EXISTS `operator`;
CREATE TABLE `operator`  (
  `username` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of operator
-- ----------------------------
INSERT INTO `operator` VALUES ('fyl666', '123', 'fyl');
INSERT INTO `operator` VALUES ('lisi', 'lisi', '李四');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `OrderID` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单号',
  `OperatorID` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作员id',
  `amount` float NOT NULL COMMENT '金额',
  `cid` int(11) NOT NULL COMMENT '顾客id',
  `time` datetime(0) NOT NULL COMMENT '销售时间',
  PRIMARY KEY (`OrderID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('202005231600351', 'fyl666', 89, 0, '2020-05-23 08:00:35');
INSERT INTO `order` VALUES ('202005231611309', 'fyl666', 89, 0, '2020-05-23 16:11:31');
INSERT INTO `order` VALUES ('202005280118599', 'fyl666', 158, 0, '2020-05-28 01:19:00');
INSERT INTO `order` VALUES ('202005280132208', 'fyl666', 65, 123456, '2020-05-28 01:32:21');
INSERT INTO `order` VALUES ('202005280135502', 'fyl666', 65, 123456, '2020-05-28 01:35:50');
INSERT INTO `order` VALUES ('202005280148547', 'fyl666', 69, 0, '2020-05-28 01:48:54');
INSERT INTO `order` VALUES ('202005291917326', 'fyl666', 50, 0, '2020-05-29 19:17:32');

-- ----------------------------
-- Table structure for rent
-- ----------------------------
DROP TABLE IF EXISTS `rent`;
CREATE TABLE `rent`  (
  `OrderID` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单号',
  `OperatorID` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '操作员ID',
  `ISBN` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '书本ISBN号',
  `rent_time` datetime(0) NOT NULL COMMENT '借出时间',
  `Return_date` date NULL DEFAULT NULL COMMENT '归还日期（若为NULL即未还）',
  `due_date` date NOT NULL COMMENT '应还日期',
  `cid` int(11) NOT NULL COMMENT '顾客id',
  PRIMARY KEY (`OrderID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rent
-- ----------------------------
INSERT INTO `rent` VALUES ('202005232119477', 'fyl666', '9787040449518', '2020-05-23 21:19:48', '2020-05-23', '2020-06-22', 123456);
INSERT INTO `rent` VALUES ('202005232137262', 'fyl666', '9787040449518', '2020-05-23 21:37:27', '2020-05-28', '2020-06-22', 123456);
INSERT INTO `rent` VALUES ('202005281827401', 'fyl666', '9787111400868', '2020-05-28 18:27:40', NULL, '2020-06-27', 123456);

-- ----------------------------
-- Table structure for sell
-- ----------------------------
DROP TABLE IF EXISTS `sell`;
CREATE TABLE `sell`  (
  `key` int(255) NOT NULL AUTO_INCREMENT,
  `ISBN` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cid` int(11) NOT NULL,
  `OrderID` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `OperatorID` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `time` datetime(0) NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sell
-- ----------------------------
INSERT INTO `sell` VALUES (1, '9787040449518', 0, '202005231600351', 'fyl666', '2020-05-23 08:00:35');
INSERT INTO `sell` VALUES (2, '9787040449518', 0, '202005231611309', 'fyl666', '2020-05-23 16:11:31');
INSERT INTO `sell` VALUES (3, '9787040449518', 0, '202005280118599', 'fyl666', '2020-05-28 01:19:00');
INSERT INTO `sell` VALUES (4, '9787111400868', 0, '202005280118599', 'fyl666', '2020-05-28 01:19:00');
INSERT INTO `sell` VALUES (5, '9787111400868', 123456, '202005280132208', 'fyl666', '2020-05-28 01:32:21');
INSERT INTO `sell` VALUES (6, '9787111400868', 123456, '202005280135502', 'fyl666', '2020-05-28 01:35:50');
INSERT INTO `sell` VALUES (7, '9787111400868', 0, '202005280148547', 'fyl666', '2020-05-28 01:48:54');
INSERT INTO `sell` VALUES (8, '9787040449518', 0, '202005291917326', 'fyl666', '2020-05-29 19:17:32');

SET FOREIGN_KEY_CHECKS = 1;
