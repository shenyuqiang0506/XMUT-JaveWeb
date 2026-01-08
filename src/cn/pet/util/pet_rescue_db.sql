/*
 Navicat Premium Dump SQL

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80406 (8.4.6)
 Source Host           : localhost:3306
 Source Schema         : pet_rescue_db

 Target Server Type    : MySQL
 Target Server Version : 80406 (8.4.6)
 File Encoding         : 65001

 Date: 08/01/2026 12:42:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_apply
-- ----------------------------
DROP TABLE IF EXISTS `t_apply`;
CREATE TABLE `t_apply` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '申请人ID',
  `pet_id` int NOT NULL COMMENT '申请的宠物ID',
  `reason` text NOT NULL COMMENT '申请理由/养宠条件',
  `apply_status` int NOT NULL DEFAULT '0' COMMENT '状态: 0-审核中, 1-通过, 2-驳回',
  `apply_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_apply_user` (`user_id`),
  KEY `fk_apply_pet` (`pet_id`),
  CONSTRAINT `fk_apply_pet` FOREIGN KEY (`pet_id`) REFERENCES `t_pet` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_apply_user` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='领养申请记录表';

-- ----------------------------
-- Records of t_apply
-- ----------------------------
BEGIN;
INSERT INTO `t_apply` (`id`, `user_id`, `pet_id`, `reason`, `apply_status`, `apply_time`) VALUES (1, 2, 1, '家里有院子，以前养过狗，有经验。', 1, '2025-11-21 13:42:14');
INSERT INTO `t_apply` (`id`, `user_id`, `pet_id`, `reason`, `apply_status`, `apply_time`) VALUES (2, 4, 2, '有钱', 1, '2025-11-21 14:22:26');
INSERT INTO `t_apply` (`id`, `user_id`, `pet_id`, `reason`, `apply_status`, `apply_time`) VALUES (3, 4, 3, '有钱', 1, '2025-11-21 14:23:39');
INSERT INTO `t_apply` (`id`, `user_id`, `pet_id`, `reason`, `apply_status`, `apply_time`) VALUES (4, 4, 7, '有钱 包养', 1, '2025-11-21 21:57:04');
INSERT INTO `t_apply` (`id`, `user_id`, `pet_id`, `reason`, `apply_status`, `apply_time`) VALUES (5, 1, 8, 'sdada', 1, '2025-12-15 22:56:00');
INSERT INTO `t_apply` (`id`, `user_id`, `pet_id`, `reason`, `apply_status`, `apply_time`) VALUES (6, 4, 18, '**', 1, '2025-12-29 14:30:01');
COMMIT;

-- ----------------------------
-- Table structure for t_pet
-- ----------------------------
DROP TABLE IF EXISTS `t_pet`;
CREATE TABLE `t_pet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pet_name` varchar(50) NOT NULL COMMENT '宠物昵称',
  `type` varchar(10) NOT NULL COMMENT '类型: 猫/狗/其他',
  `sex` varchar(5) DEFAULT '未知' COMMENT '性别',
  `age` varchar(20) DEFAULT NULL COMMENT '年龄描述',
  `description` text COMMENT '详细描述(健康状况、性格等)',
  `image` varchar(255) DEFAULT 'default.jpg' COMMENT '图片路径',
  `status` int NOT NULL DEFAULT '0' COMMENT '状态: 0-待审核, 1-待领养, 2-已领养',
  `publisher_id` int NOT NULL COMMENT '发布人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_pet_user` (`publisher_id`),
  CONSTRAINT `fk_pet_user` FOREIGN KEY (`publisher_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流浪宠物表';

-- ----------------------------
-- Records of t_pet
-- ----------------------------
BEGIN;
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (1, '小白', '狗', '公', '3个月', '非常活泼，已打第一针疫苗，求好心人带走。', 'dog1.jpg', 2, 1, '2025-11-21 13:42:14');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (2, '咪咪', '猫', '母', '1岁', '性格温顺，捡到时腿部有轻伤，已包扎。', 'cat1.jpg', 2, 2, '2025-11-21 13:42:14');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (3, '旺财', '狗', '公', '2岁', '中华田园犬，看家护院一把好手。', 'dog2.jpg', 2, 1, '2025-11-21 13:42:14');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (4, '小花', '狗', '母', '2岁', '好', '7ebcec36-2462-4394-b9a0-5984ffa9dcb3.jpg', 1, 1, '2025-11-21 14:14:02');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (7, 'w', '其他', '未知', '21岁', '啊啊', '4ca4e83a-f298-447f-9f9f-964c73c17dc0.jpg', 2, 4, '2025-11-21 21:56:34');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (8, '小花', '狗', '母', '2岁', 'hao ', '36f252d1-fa52-4dbe-8f08-c3b1b53e4cbe.jpeg', 2, 1, '2025-12-14 19:29:49');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (9, '小白', '猫', '公', '2个月', '大**', '2c231b76-91ea-4c05-b7d3-a3469db029a0.jpg', 1, 6, '2025-12-15 22:53:45');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (10, '白白', '猫', '未知', '2个月', '性格温和\r\n', '7a367e77-86dd-46d6-a122-be37d3a16783.jpg', 1, 4, '2025-12-18 09:08:45');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (12, '小洛', '狗', '母', '1岁', '非常棒', '28d6d756-6a9b-44ec-bdbd-436bebc72c59.jpg', 1, 1, '2025-12-25 11:22:48');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (13, '牛奶', '狗', '母', '2个月', '好', '4d36b1ab-3b84-436b-bb56-cafe176943c0.jpg', 1, 1, '2025-12-25 11:23:11');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (14, '布丁', '猫', '母', '1岁', '非常棒\r\n', '9f4016c1-542c-4f97-8faf-2b24e331b286.jpg', 1, 1, '2025-12-25 11:24:19');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (15, '可可', '猫', '未知', '未知', '1111111', 'b5ef4f5a-def2-4337-a931-04657e4aabe9.jpg', 1, 1, '2025-12-25 11:25:17');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (16, '毛毛', '猫', '未知', '未知', '很乖\r\n', 'fae6b6d0-2e9a-4c6b-812d-36f2adb80390.jpg', 1, 1, '2025-12-25 11:25:50');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (18, 'syrgw', '猫', '未知', '未知', '好', '0b8e333d-7dcb-44dd-88cb-2754bed6c07f.jpg', 2, 1, '2025-12-27 17:02:45');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (19, '白白', '猫', '公', '2岁', '好', '022287ed-a0ee-4184-b7e4-f381a01f6156.jpg', 1, 4, '2025-12-29 14:30:43');
INSERT INTO `t_pet` (`id`, `pet_name`, `type`, `sex`, `age`, `description`, `image`, `status`, `publisher_id`, `create_time`) VALUES (20, '牛奶', '狗', '母', '2岁', '好的', '9097d165-a294-4c3a-950c-5b7f4fb93f74.jpeg', 1, 1, '2026-01-03 15:37:29');
COMMIT;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(50) NOT NULL COMMENT '用户名(登录账号)',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `role` int NOT NULL DEFAULT '0' COMMENT '角色: 0-普通用户, 1-管理员',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
INSERT INTO `t_user` (`id`, `username`, `password`, `real_name`, `phone`, `role`, `create_time`) VALUES (1, 'admin', '123456', '系统管理员', '13800000000', 1, '2025-11-21 13:42:14');
INSERT INTO `t_user` (`id`, `username`, `password`, `real_name`, `phone`, `role`, `create_time`) VALUES (2, 'zhangsan', '123456', '张三', '13911112222', 0, '2025-11-21 13:42:14');
INSERT INTO `t_user` (`id`, `username`, `password`, `real_name`, `phone`, `role`, `create_time`) VALUES (3, 'lisi', '123456', '李四', '13933334444', 0, '2025-11-21 13:42:14');
INSERT INTO `t_user` (`id`, `username`, `password`, `real_name`, `phone`, `role`, `create_time`) VALUES (4, 'shen', '123456', 's', '111111111111', 0, '2025-11-21 14:08:57');
INSERT INTO `t_user` (`id`, `username`, `password`, `real_name`, `phone`, `role`, `create_time`) VALUES (5, 's', '123456', 's', '15345579277', 0, '2025-12-14 19:30:51');
INSERT INTO `t_user` (`id`, `username`, `password`, `real_name`, `phone`, `role`, `create_time`) VALUES (6, 'test', '123456', 'Li', '13288889999', 0, '2025-12-15 22:51:13');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
