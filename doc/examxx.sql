/*
Navicat MySQL Data Transfer

Source Server         : server
Source Server Version : 50534
Source Host           : 218.244.144.149:3306
Source Database       : examxx

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2014-12-14 17:03:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `et_exam_paper`
-- ----------------------------
DROP TABLE IF EXISTS `et_exam_paper`;
CREATE TABLE `et_exam_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) DEFAULT '0',
  `pass_point` int(11) DEFAULT '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `summary` varchar(100) DEFAULT NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) DEFAULT NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) DEFAULT NULL COMMENT '创建人的账号',
  `paper_type` varchar(40) NOT NULL DEFAULT '1' COMMENT '0 真题 1 模拟 2 专家',
  `field_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试卷';

-- ----------------------------
-- Records of et_exam_paper
-- ----------------------------

-- ----------------------------
-- Table structure for `et_field`
-- ----------------------------
DROP TABLE IF EXISTS `et_field`;
CREATE TABLE `et_field` (
  `field_id` int(5) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(50) NOT NULL,
  `memo` varchar(100) DEFAULT NULL,
  `state` decimal(1,0) NOT NULL DEFAULT '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_field
-- ----------------------------
INSERT INTO `et_field` VALUES ('1', '岗位通用', '岗位通用', '1');
INSERT INTO `et_field` VALUES ('2', '窗口服务', '窗口服务', '1');
INSERT INTO `et_field` VALUES ('3', '业扩报装', '业扩报装', '1');
INSERT INTO `et_field` VALUES ('4', '电能计量', '电能计量', '1');

-- ----------------------------
-- Table structure for `et_group`
-- ----------------------------
DROP TABLE IF EXISTS `et_group`;
CREATE TABLE `et_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `group_level_id` int(11) NOT NULL COMMENT '班组级别',
  `parent` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_level_id` (`group_level_id`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='班组';

-- ----------------------------
-- Records of et_group
-- ----------------------------

-- ----------------------------
-- Table structure for `et_knowledge_point`
-- ----------------------------
DROP TABLE IF EXISTS `et_knowledge_point`;
CREATE TABLE `et_knowledge_point` (
  `point_id` int(5) NOT NULL AUTO_INCREMENT,
  `point_name` varchar(100) NOT NULL,
  `field_id` int(5) NOT NULL,
  `memo` varchar(100) DEFAULT NULL,
  `state` decimal(1,0) DEFAULT '1' COMMENT '1:正常 0：废弃',
  PRIMARY KEY (`point_id`),
  KEY `fk_knowledge_field` (`field_id`),
  CONSTRAINT `et_knowledge_point_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `et_field` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_knowledge_point
-- ----------------------------
INSERT INTO `et_knowledge_point` VALUES ('1', '电力法律、法规类', '1', '电力法律、法规类', '1');
INSERT INTO `et_knowledge_point` VALUES ('2', '企业文化类', '1', '企业文化类', '1');
INSERT INTO `et_knowledge_point` VALUES ('3', '服务规范类', '1', '服务规范类', '1');
INSERT INTO `et_knowledge_point` VALUES ('4', '供电服务类', '2', '供电服务类', '1');
INSERT INTO `et_knowledge_point` VALUES ('5', '营销业务知识类', '2', '营销业务知识类', '1');
INSERT INTO `et_knowledge_point` VALUES ('6', '营销专业综合类', '2', '营销专业综合类', '1');
INSERT INTO `et_knowledge_point` VALUES ('7', '业扩报装服务类', '3', '业扩报装服务类', '1');
INSERT INTO `et_knowledge_point` VALUES ('8', '业扩报装业务知识类', '3', '业扩报装业务知识类', '1');
INSERT INTO `et_knowledge_point` VALUES ('9', '业扩报装专业综合类', '3', '业扩报装专业综合类', '1');
INSERT INTO `et_knowledge_point` VALUES ('10', '营销计量服务类', '4', '营销计量服务类', '1');
INSERT INTO `et_knowledge_point` VALUES ('11', '计量业务知识类', '4', '计量业务知识类', '1');
INSERT INTO `et_knowledge_point` VALUES ('12', '计量专业综合类', '4', '计量专业综合类', '1');

-- ----------------------------
-- Table structure for `et_news`
-- ----------------------------
DROP TABLE IF EXISTS `et_news`;
CREATE TABLE `et_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titile` varchar(100) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_expire` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否过期',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 新闻， 1 系统信息',
  `group_id` int(11) NOT NULL DEFAULT '-1' COMMENT '此系统属于哪个组',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `et_news_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_news
-- ----------------------------

-- ----------------------------
-- Table structure for `et_practice_paper`
-- ----------------------------
DROP TABLE IF EXISTS `et_practice_paper`;
CREATE TABLE `et_practice_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) DEFAULT '0',
  `pass_point` int(11) DEFAULT '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `summary` varchar(100) DEFAULT NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) DEFAULT NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) DEFAULT NULL COMMENT '创建人的账号',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试卷';

-- ----------------------------
-- Records of et_practice_paper
-- ----------------------------

-- ----------------------------
-- Table structure for `et_question`
-- ----------------------------
DROP TABLE IF EXISTS `et_question`;
CREATE TABLE `et_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `question_type_id` int(11) NOT NULL COMMENT '题型',
  `duration` int(11) DEFAULT NULL COMMENT '试题考试时间',
  `points` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试题可见性',
  `create_time` timestamp NULL DEFAULT NULL,
  `creator` varchar(20) NOT NULL DEFAULT 'admin' COMMENT '创建者',
  `last_modify` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `answer` mediumtext NOT NULL,
  `expose_times` int(11) NOT NULL DEFAULT '2',
  `right_times` int(11) NOT NULL DEFAULT '1',
  `wrong_times` int(11) NOT NULL DEFAULT '1',
  `difficulty` int(5) NOT NULL DEFAULT '1',
  `analysis` mediumtext,
  `reference` varchar(1000) DEFAULT NULL,
  `examing_point` varchar(5000) DEFAULT NULL,
  `keyword` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_type_id` (`question_type_id`),
  KEY `et_question_ibfk_5` (`creator`),
  CONSTRAINT `et_question_ibfk_1` FOREIGN KEY (`question_type_id`) REFERENCES `et_question_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试题';

-- ----------------------------
-- Records of et_question
-- ----------------------------

-- ----------------------------
-- Table structure for `et_question_2_point`
-- ----------------------------
DROP TABLE IF EXISTS `et_question_2_point`;
CREATE TABLE `et_question_2_point` (
  `question_2_point_id` int(10) NOT NULL AUTO_INCREMENT,
  `question_id` int(10) DEFAULT NULL,
  `point_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`question_2_point_id`),
  KEY `fk_question_111` (`question_id`),
  KEY `fk_point_111` (`point_id`),
  CONSTRAINT `et_question_2_point_ibfk_1` FOREIGN KEY (`point_id`) REFERENCES `et_knowledge_point` (`point_id`),
  CONSTRAINT `et_question_2_point_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question_2_point
-- ----------------------------

-- ----------------------------
-- Table structure for `et_question_type`
-- ----------------------------
DROP TABLE IF EXISTS `et_question_type`;
CREATE TABLE `et_question_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `subjective` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='试题类型';

-- ----------------------------
-- Records of et_question_type
-- ----------------------------
INSERT INTO `et_question_type` VALUES ('1', '单选题', '0');
INSERT INTO `et_question_type` VALUES ('2', '多选题', '0');
INSERT INTO `et_question_type` VALUES ('3', '判断题', '0');
INSERT INTO `et_question_type` VALUES ('4', '填空题', '0');
INSERT INTO `et_question_type` VALUES ('5', '简答题', '1');
INSERT INTO `et_question_type` VALUES ('6', '论述题', '1');
INSERT INTO `et_question_type` VALUES ('7', '分析题', '1');

-- ----------------------------
-- Table structure for `et_reference`
-- ----------------------------
DROP TABLE IF EXISTS `et_reference`;
CREATE TABLE `et_reference` (
  `reference_id` int(5) NOT NULL AUTO_INCREMENT,
  `reference_name` varchar(200) NOT NULL,
  `memo` varchar(200) DEFAULT NULL,
  `state` decimal(10,0) NOT NULL DEFAULT '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY (`reference_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_reference
-- ----------------------------
INSERT INTO `et_reference` VALUES ('1', '中华人民共和国电力法', '1995年12月28日第八全国人民代表大会常务委员会第十七次会议通过，自1996月1日起施行', '1');
INSERT INTO `et_reference` VALUES ('2', '电力供应与使用条例', '1996年4月17日国务院令96 号发布，自1996年9月1日起施行', '1');
INSERT INTO `et_reference` VALUES ('3', '供电营业区划分及管理办法', '1996年5月19日电力部第5号令，自1996年9月1日起施行', '1');
INSERT INTO `et_reference` VALUES ('4', '居民用户家用电器损坏处理办法', '1996年8月21日电力部第7号令，自1996年9月1日起施行', '1');
INSERT INTO `et_reference` VALUES ('5', '供电营业规则', '1996年10月8日电力部第8号令发布并施行', '1');
INSERT INTO `et_reference` VALUES ('6', '承装（修、试）电力设施许可证管理办法', '电监会2009年第28号令', '1');
INSERT INTO `et_reference` VALUES ('7', '供电服务规范', 'GB/T 28583-2012', '1');
INSERT INTO `et_reference` VALUES ('8', '国家电网公司供电服务规范', '国家电网生〔2003〕477号', '1');
INSERT INTO `et_reference` VALUES ('9', '国家电网公司城市供电营业规范化服务窗口标准', null, '1');
INSERT INTO `et_reference` VALUES ('10', '国家电网公司供电客户服务提供标准', '国家电网科〔2011〕56 号', '1');
INSERT INTO `et_reference` VALUES ('11', '关于发布国家电网公司新“三个十条”的通知', '国家电网办〔2011〕1493号', '1');
INSERT INTO `et_reference` VALUES ('12', '国家电网公司供电服务质量标准', '国家电网科〔2010〕341号', '1');
INSERT INTO `et_reference` VALUES ('13', '国家电网公司供电营业厅标准化建设手册', '2010年', '1');
INSERT INTO `et_reference` VALUES ('14', '国家电网公司营销客户档案管理规范（试行）', '国家电网办〔2013〕71号', '1');
INSERT INTO `et_reference` VALUES ('15', '国家电网公司95598业务管理暂行办法', null, '1');
INSERT INTO `et_reference` VALUES ('16', '国家电网公司关于深化“你用电我用心”大力提升优质服务水平的意见', '国家电网营销〔2014〕104号', '1');
INSERT INTO `et_reference` VALUES ('17', '国家电网公司业扩报装工作规范（试行）和国家电网公司业扩供电方案编制导则', '国家电网营销〔2010〕1247号', '1');
INSERT INTO `et_reference` VALUES ('18', '水利电力部关于颁发《电、热价格》的通知', '水电财字第67号', '1');
INSERT INTO `et_reference` VALUES ('19', '功率因数调整电费办法', '〔83〕水电财字第 215 号', '1');
INSERT INTO `et_reference` VALUES ('20', '国民经济行业用电分类', '2004年版', '1');
INSERT INTO `et_reference` VALUES ('21', '电能计量装置技术管理规程', 'DL/T 448-2000', '1');
INSERT INTO `et_reference` VALUES ('22', '国家电网公司有序用电管理办法', '国家电网营销〔2012〕 38 号', '1');
INSERT INTO `et_reference` VALUES ('23', '关于全面深化治理整改工作坚决杜绝“三指定” 问题的意见', '国家电网营销〔2011〕 756 号', '1');
INSERT INTO `et_reference` VALUES ('24', '国家电网公司关于印发进一步简化业扩报装手续优化流程意见的通知', '国家电网营销〔2014〕168号', '1');
INSERT INTO `et_reference` VALUES ('25', '国家电网公司关于印发分布式电源并网相关意见和规范（修订版）的通知', '国家电网办〔2013〕1781号', '1');
INSERT INTO `et_reference` VALUES ('26', '国家电网公司关于印发分布式电源并网服务管理规则的通知', '国家电网营销〔2014〕174号', '1');
INSERT INTO `et_reference` VALUES ('27', '国家电网公司关于可再生能源电价附加补助资金管理有关意见的通知', '国家电网财〔2014〕2044号', '1');
INSERT INTO `et_reference` VALUES ('28', '国家电网公司营销服务培训题库', '中国电力出版社，国家电网公司营销部编，2013年1月', '1');
INSERT INTO `et_reference` VALUES ('29', '国家电网公司企业文化手册', '2010年版', '1');
INSERT INTO `et_reference` VALUES ('30', '建设和弘扬统一的企业文化宣传手册', null, '1');

-- ----------------------------
-- Table structure for `et_role`
-- ----------------------------
DROP TABLE IF EXISTS `et_role`;
CREATE TABLE `et_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authority` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of et_role
-- ----------------------------
INSERT INTO `et_role` VALUES ('1', 'ROLE_ADMIN', '超级管理员', 'admin');
INSERT INTO `et_role` VALUES ('2', 'ROLE_TEACHER', '教师', 'teacher');
INSERT INTO `et_role` VALUES ('3', 'ROLE_STUDENT', '学员', 'student');

-- ----------------------------
-- Table structure for `et_r_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `et_r_user_role`;
CREATE TABLE `et_r_user_role` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `et_r_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户_角色 关联表';

-- ----------------------------
-- Records of et_r_user_role
-- ----------------------------
INSERT INTO `et_r_user_role` VALUES ('4', '1');

-- ----------------------------
-- Table structure for `et_user`
-- ----------------------------
DROP TABLE IF EXISTS `et_user`;
CREATE TABLE `et_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `username` varchar(20) NOT NULL COMMENT '账号',
  `truename` varchar(10) DEFAULT NULL COMMENT '真实姓名',
  `password` char(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `add_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `expire_date` timestamp NULL DEFAULT NULL,
  `add_by` int(11) DEFAULT NULL COMMENT '创建人',
  `enabled` tinyint(1) DEFAULT '0' COMMENT '激活状态：0-未激活 1-激活',
  `field_id` int(10) NOT NULL,
  `last_login_time` timestamp NULL DEFAULT NULL,
  `login_time` timestamp NULL DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `company` varchar(40) DEFAULT NULL,
  `department` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of et_user
-- ----------------------------
INSERT INTO `et_user` VALUES ('4', 'admin', null, '1111111111', '1@1.1', null, '2014-12-14 17:03:26', null, null, '1', '1', '2011-08-08 23:09:18', '2014-08-08 23:11:46', '1', '2', '3');

-- ----------------------------
-- Table structure for `et_user_exam_history`
-- ----------------------------
DROP TABLE IF EXISTS `et_user_exam_history`;
CREATE TABLE `et_user_exam_history` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `exam_paper_id` int(10) NOT NULL,
  `content` mediumtext,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `answer_sheet` mediumtext,
  `duration` int(10) NOT NULL,
  `point_get` float(10,1) NOT NULL DEFAULT '0.0',
  `submit_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_exam_history
-- ----------------------------

-- ----------------------------
-- Table structure for `et_user_question_history_t`
-- ----------------------------
DROP TABLE IF EXISTS `et_user_question_history_t`;
CREATE TABLE `et_user_question_history_t` (
  `user_question_hist_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_question_hist` mediumtext NOT NULL,
  `modify_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_question_hist_id`),
  UNIQUE KEY `idx_u_q_hist_userid` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_question_history_t
-- ----------------------------

-- ----------------------------
-- Table structure for `t_c3p0`
-- ----------------------------
DROP TABLE IF EXISTS `t_c3p0`;
CREATE TABLE `t_c3p0` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_c3p0
-- ----------------------------
