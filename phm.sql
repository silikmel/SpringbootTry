/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50725
Source Host           : localhost:3306
Source Database       : phm

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2020-03-04 15:15:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bs_life_cycle
-- ----------------------------
DROP TABLE IF EXISTS `bs_life_cycle`;
CREATE TABLE `bs_life_cycle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '物料编码',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `design_life` int(11) DEFAULT NULL COMMENT '设计寿命',
  `design_life_unit` varchar(40) DEFAULT NULL COMMENT '单位类型，1：次数，2：公里数；3：时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bs_model_config
-- ----------------------------
DROP TABLE IF EXISTS `bs_model_config`;
CREATE TABLE `bs_model_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `model_use` char(1) DEFAULT NULL COMMENT '模型用途\r\n            1：预警模型\r\n            2：健康评估模型\r\n            3：TTF计算模型',
  `model_type` varchar(10) DEFAULT NULL COMMENT '模型类型\r\n            1-1：突变预警；1-2：趋势预警；\r\n            2-1：性能参数；2-2：实时可靠性；2-3：时间劣化度\r\n            3-1：劣化度拟合；3-2：相似性模型；3-3：带协变量的可靠性模型\r\n            ',
  `func_code` varchar(40) DEFAULT NULL COMMENT '模型函数',
  `target_ids` varchar(255) DEFAULT NULL COMMENT '性能指标ID，如果有多个用逗号分隔。主要用于健康评估配置',
  `value1` varchar(255) DEFAULT NULL COMMENT '值1',
  `value1_advice` varchar(40) DEFAULT NULL COMMENT '值1建议值',
  `value1_range` varchar(40) DEFAULT NULL COMMENT '值1数据范围',
  `value2` varchar(40) DEFAULT NULL COMMENT '值2',
  `value2_range` varchar(40) DEFAULT NULL COMMENT '值2数据范围',
  `value2_advice` varchar(40) DEFAULT NULL COMMENT '值2建议值',
  `run_config` varchar(40) DEFAULT NULL COMMENT '运行周期\r\n            0：继承，其他为cron表达式',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user_id` varchar(40) DEFAULT NULL COMMENT '更新用户ID',
  `update_user_name` varchar(40) DEFAULT NULL COMMENT '更新用户名',
  `is_enable` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8 COMMENT='模型配置';

-- ----------------------------
-- Table structure for bs_model_run_record
-- ----------------------------
DROP TABLE IF EXISTS `bs_model_run_record`;
CREATE TABLE `bs_model_run_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `model_type` varchar(3) DEFAULT NULL,
  `func_name` varchar(40) DEFAULT NULL COMMENT '函数名称',
  `ajust_input` varchar(400) DEFAULT NULL COMMENT '可调参数（JSON）',
  `eval_output` varchar(400) DEFAULT NULL COMMENT '评估参数（JSON）\r\n            1：告警\r\n            2：预警\r\n            3：人工录入',
  `target_tables` varchar(40) DEFAULT NULL COMMENT '结果记录表名',
  `target_ids` varchar(400) DEFAULT NULL COMMENT '结果记录ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `start_time` datetime DEFAULT NULL COMMENT '调用开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '调用结束时间',
  `duration` int(11) DEFAULT NULL COMMENT '运行时长(秒)',
  `trigger_method` char(1) DEFAULT NULL COMMENT '调用方式\r\n            0：系统自动触发\r\n            1：手动触发',
  `flag` char(1) DEFAULT NULL COMMENT '状态',
  `error_msg` varchar(400) DEFAULT NULL COMMENT '异常信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=183236 DEFAULT CHARSET=utf8 COMMENT='模型运行记录';

-- ----------------------------
-- Table structure for bs_pm_image
-- ----------------------------
DROP TABLE IF EXISTS `bs_pm_image`;
CREATE TABLE `bs_pm_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `map_id` int(11) DEFAULT NULL COMMENT '地图id',
  `name` varchar(40) DEFAULT NULL COMMENT '图片名',
  `path` varchar(200) DEFAULT NULL COMMENT '路径',
  `size` int(11) DEFAULT NULL COMMENT '大小',
  `suffix` varchar(10) DEFAULT NULL COMMENT '后缀',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_34` (`map_id`) USING BTREE,
  CONSTRAINT `FK_Reference_34` FOREIGN KEY (`map_id`) REFERENCES `bs_pm_map_config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for bs_sys_pre_template
-- ----------------------------
DROP TABLE IF EXISTS `bs_sys_pre_template`;
CREATE TABLE `bs_sys_pre_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) DEFAULT NULL COMMENT '模版名称',
  `order_num` int(11) DEFAULT NULL COMMENT '序号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Table structure for ft_diagnosis_feedback
-- ----------------------------
DROP TABLE IF EXISTS `ft_diagnosis_feedback`;
CREATE TABLE `ft_diagnosis_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自增',
  `repair_advice_id` int(11) DEFAULT NULL COMMENT '维修建议关联id',
  `source_type` char(1) DEFAULT NULL COMMENT '诊断来源类型，1：告警，2：预警，3：预测',
  `source_id` int(11) DEFAULT NULL COMMENT '诊断来源ID，用于存储告警ID、预警ID、预测ID、健康评估ID',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_name` varchar(40) DEFAULT NULL COMMENT '部件名称',
  `name` varchar(255) DEFAULT NULL COMMENT '名称或描述',
  `param_code` varchar(40) DEFAULT NULL COMMENT '参数code（如有）',
  `value` varchar(100) DEFAULT NULL COMMENT '回填值',
  `measurable` char(1) DEFAULT NULL COMMENT '是否可测量，0：不可测量，1：可测量',
  `collect_time` datetime DEFAULT NULL COMMENT '采集时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ft_diagnosis_result
-- ----------------------------
DROP TABLE IF EXISTS `ft_diagnosis_result`;
CREATE TABLE `ft_diagnosis_result` (
  `id` int(40) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `bei_type` char(1) DEFAULT NULL COMMENT '物料或BEI，0代表树节点，1代表物料',
  `bei` varchar(40) DEFAULT NULL COMMENT '物料编码/BEI',
  `bei_name` varchar(40) DEFAULT NULL COMMENT '物料名称/BEI名称',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商',
  `supplier_name` varchar(40) DEFAULT NULL COMMENT '供应商名称',
  `fault_code` varchar(40) DEFAULT NULL COMMENT '故障代码',
  `fault_name` varchar(200) DEFAULT NULL COMMENT '故障名称',
  `fault_mode_id` varchar(40) DEFAULT NULL COMMENT '故障模式id',
  `fault_mode_name` varchar(40) DEFAULT NULL COMMENT '故障模式名称',
  `fault_rate` decimal(10,5) DEFAULT NULL COMMENT '故障率',
  `maintenance_code` varchar(40) DEFAULT NULL COMMENT '维修需求id',
  `maintenance_name` varchar(200) DEFAULT NULL COMMENT '维修需求名称',
  `manual_id` varchar(100) DEFAULT NULL COMMENT '手册id',
  `manual_dmc` varchar(100) DEFAULT NULL,
  `manual_name` varchar(100) DEFAULT NULL,
  `repair_advice_id` int(11) DEFAULT NULL COMMENT '维修建议关联id',
  `source_type` char(1) DEFAULT NULL COMMENT '诊断来源类型，1：告警，2：预警，3：预测',
  `source_id` int(11) DEFAULT NULL COMMENT '诊断来源ID，用于存储告警ID、预警ID、预测ID、健康评估ID',
  `diagnosis_type` char(1) DEFAULT NULL COMMENT '诊断类型，\r\n            1：自动排故，2：交互式排故，3：原因排名，4：典型案例',
  `diagnosis_path` varchar(200) DEFAULT NULL COMMENT '诊断路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `push_time` datetime DEFAULT NULL COMMENT '推送时间',
  `status` varchar(2) DEFAULT NULL COMMENT '状态，0：初始状态，1：已采纳',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1603 DEFAULT CHARSET=utf8 COMMENT='诊断结果表';

-- ----------------------------
-- Table structure for ft_prognostics
-- ----------------------------
DROP TABLE IF EXISTS `ft_prognostics`;
CREATE TABLE `ft_prognostics` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一id',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `description` varchar(200) DEFAULT NULL COMMENT '预测描述',
  `lvl` varchar(2) DEFAULT NULL COMMENT '预测等级',
  `source_type` char(1) DEFAULT NULL COMMENT '预测来源\r\n1：健康评估,2:性能指标,\r3：剩余寿命',
  `create_time` datetime DEFAULT NULL COMMENT '预测时间',
  `status` varchar(1) DEFAULT NULL COMMENT '处理状态',
  `reason` varchar(255) DEFAULT NULL,
  `param_data3` varchar(255) DEFAULT NULL,
  `data_producer` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ft_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13043014 DEFAULT CHARSET=utf8 COMMENT='预警预测';

-- ----------------------------
-- Table structure for ft_rec
-- ----------------------------
DROP TABLE IF EXISTS `ft_rec`;
CREATE TABLE `ft_rec` (
  `id` varchar(36) NOT NULL COMMENT '唯一编码',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `fault_code` varchar(20) DEFAULT NULL COMMENT '故障CODE',
  `fault_time` datetime DEFAULT NULL COMMENT '故障时间',
  `fault_type` varchar(20) DEFAULT NULL COMMENT '故障类型',
  `fault_des` varchar(100) DEFAULT NULL COMMENT '故障描述',
  `fault_level` varchar(2) DEFAULT NULL COMMENT '故障等级',
  `mode_type` varchar(10) DEFAULT NULL COMMENT '故障模式',
  `fault_status` varchar(1) DEFAULT NULL COMMENT '故障状态',
  `occur_status` varchar(1) DEFAULT NULL COMMENT '发生状态\r\n0：恢复\r\n1：发生',
  `syscode` varchar(20) DEFAULT NULL COMMENT '功能分类系统Code',
  `sysname` varchar(50) DEFAULT NULL COMMENT '功能分类系统名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='故障表';

-- ----------------------------
-- Table structure for ft_warn_rec
-- ----------------------------
DROP TABLE IF EXISTS `ft_warn_rec`;
CREATE TABLE `ft_warn_rec` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一编码',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `warn_code` varchar(20) DEFAULT NULL COMMENT '虚警规则Code',
  `warn_name` varchar(500) DEFAULT NULL COMMENT '虚警规则名称',
  `warn_level` varchar(20) DEFAULT NULL COMMENT '虚警规则等级',
  `warn_time` datetime(3) DEFAULT NULL COMMENT '虚警告警时间',
  `expression1` varchar(4000) DEFAULT NULL COMMENT '虚警规则公式1',
  `param_data1` varchar(4000) DEFAULT NULL COMMENT '虚警规则公式1参数',
  `expression2` varchar(4000) DEFAULT NULL COMMENT '虚假规则公式2',
  `param_data2` varchar(4000) DEFAULT NULL COMMENT '虚警规则公式2参数',
  `warn_type` varchar(2) DEFAULT NULL COMMENT '预警类型 01、阈值；02、趋势；03、告警；\r\n            11：模型阈值；12：趋势阈值',
  `warn_remark` varchar(200) DEFAULT NULL COMMENT '虚警规则备注',
  `occur_status` varchar(1) DEFAULT NULL COMMENT '发生状态',
  `warn_status` varchar(1) DEFAULT NULL COMMENT '虚警状态',
  `occur_count` int(11) DEFAULT NULL COMMENT '发生次数',
  `occur_detail` blob COMMENT '发生恢复记录详情，格式\r\n[{\r\n  warnTime: 1531710422000, //时间戳，毫秒数\r\n  occurStatus : ''1'', //1发生 0恢复\r\n  paramData1:'''',\r\n  paramData2:''''\r\n}]',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `recInfo_Id` varchar(36) DEFAULT NULL COMMENT 'redis故障预警、告警记录ID',
  `reason` varchar(255) DEFAULT NULL,
  `param_data3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_ft_type` (`warn_type`),
  KEY `idx_ft_warn_time` (`warn_time`),
  KEY `idx_ft_sys_code` (`sys_code`),
  KEY `idx_ft_warn_lvl` (`warn_level`),
  KEY `idx_ft_occur_status` (`occur_status`),
  KEY `idx_ft_warn_status` (`warn_status`) USING BTREE,
  KEY `idx_ft_equip_type` (`equip_type`) USING BTREE,
  KEY `idx_ft_equip_sn` (`equip_sn`) USING BTREE,
  KEY `idx_ft_area_code` (`area_code`) USING BTREE,
  KEY `idx_ft_part_bei` (`part_bei`) USING BTREE,
  KEY `idx_ft_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9937873 DEFAULT CHARSET=utf8 COMMENT='告警&预警表';

-- ----------------------------
-- Table structure for ha_ttf
-- ----------------------------
DROP TABLE IF EXISTS `ha_ttf`;
CREATE TABLE `ha_ttf` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一id',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `service_life` decimal(12,2) DEFAULT NULL COMMENT '使用寿命',
  `design_life` decimal(12,2) DEFAULT NULL COMMENT '设计寿命',
  `ttf` decimal(12,2) DEFAULT NULL COMMENT '剩余寿命',
  `status` char(1) DEFAULT NULL COMMENT '状态',
  `confidence` tinyint(4) DEFAULT NULL COMMENT '置信度',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `model_type` char(3) DEFAULT NULL COMMENT '3-1劣化度拟合估计TTF\n3-2含协变量可靠性分析\n3-3相似性模型',
  `unit_type` char(1) DEFAULT NULL COMMENT '单位类型，1：次数，2：公里数；3：时间',
  `result_json` blob COMMENT '含协变量可靠性分析预测接口返回数组',
  `part_life` decimal(12,2) DEFAULT NULL COMMENT '部件使用寿命',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=441106 DEFAULT CHARSET=utf8 COMMENT='TTF';

-- ----------------------------
-- Table structure for he_part_health_index_cur
-- ----------------------------
DROP TABLE IF EXISTS `he_part_health_index_cur`;
CREATE TABLE `he_part_health_index_cur` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `batch_code` varchar(40) DEFAULT NULL COMMENT '评估批次号',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '设备位置号',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类',
  `area_code` varchar(40) DEFAULT NULL COMMENT '部件区域编号',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `health_index` decimal(4,2) DEFAULT NULL COMMENT '健康指数',
  `health_level` varchar(10) DEFAULT NULL COMMENT '健康等级',
  `index_val` text COMMENT '指标值',
  `model_config_id` int(11) DEFAULT NULL COMMENT '关联bs_model_config',
  `record_time` datetime DEFAULT NULL COMMENT '记录日期',
  `param_data3` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_equip_type` (`equip_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=67540 DEFAULT CHARSET=utf8 COMMENT='部件健康指数表（当前）';

-- ----------------------------
-- Table structure for he_pm_queuing
-- ----------------------------
DROP TABLE IF EXISTS `he_pm_queuing`;
CREATE TABLE `he_pm_queuing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '唯一id',
  `model_id` int(11) DEFAULT NULL COMMENT 'model_id',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `parent_id` int(11) DEFAULT NULL COMMENT 'parent_id',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `bei_remark` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `model_value` decimal(12,2) DEFAULT NULL COMMENT 'model_value',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '车组',
  `model_name` varchar(40) DEFAULT NULL COMMENT 'model_name',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `e1` varchar(255) DEFAULT NULL COMMENT '上限',
  `e2` varchar(255) DEFAULT NULL COMMENT '下限',
  `formula` varchar(255) DEFAULT NULL COMMENT '公式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='性能排队';

-- ----------------------------
-- Table structure for kb_fault_case_tmp
-- ----------------------------
DROP TABLE IF EXISTS `kb_fault_case_tmp`;
CREATE TABLE `kb_fault_case_tmp` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `part_name` varchar(40) DEFAULT NULL COMMENT '部件名称',
  `fault_code` varchar(40) DEFAULT NULL COMMENT '故障代码',
  `fault_desc` varchar(400) DEFAULT NULL COMMENT '故障描述',
  `fault_reason_desc` varchar(400) DEFAULT NULL COMMENT '故障原因描述',
  `fault_solution_desc` varchar(400) DEFAULT NULL COMMENT '维修方案描述',
  `report_code` varchar(40) DEFAULT NULL COMMENT '故障分析报告',
  `important` char(1) DEFAULT NULL COMMENT '是否安监报',
  `fault_count` int(11) DEFAULT NULL COMMENT '频率',
  `fault_rate` varchar(20) DEFAULT NULL COMMENT '故障率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for kb_fault_env
-- ----------------------------
DROP TABLE IF EXISTS `kb_fault_env`;
CREATE TABLE `kb_fault_env` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障知识库id',
  `param_id` int(11) DEFAULT NULL COMMENT '参数ID',
  `param_value` varchar(20) DEFAULT NULL COMMENT '参数值',
  `env_weight` tinyint(4) DEFAULT NULL COMMENT '影响因子',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_4` (`fault_id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`fault_id`) REFERENCES `kb_fault` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='故障知识库-运行参数';

-- ----------------------------
-- Table structure for kb_fault_material
-- ----------------------------
DROP TABLE IF EXISTS `kb_fault_material`;
CREATE TABLE `kb_fault_material` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障知识库id',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `mtr_number` int(11) DEFAULT NULL COMMENT '消耗数量',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_7` (`fault_id`),
  CONSTRAINT `FK_Reference_7` FOREIGN KEY (`fault_id`) REFERENCES `kb_fault` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='故障知识库-物料消耗';

-- ----------------------------
-- Table structure for kb_fault_reason
-- ----------------------------
DROP TABLE IF EXISTS `kb_fault_reason`;
CREATE TABLE `kb_fault_reason` (
  `id` char(32) NOT NULL COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障知识库id',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `fault_reason_code` varchar(40) DEFAULT NULL COMMENT '故障原因代码',
  `fault_mode_code` varchar(40) DEFAULT NULL COMMENT '故障模式代码',
  `weight` tinyint(4) DEFAULT NULL COMMENT '影响因子',
  `fault_reason_desc` varchar(100) DEFAULT NULL COMMENT '故障原因描述',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_1` (`fault_id`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`fault_id`) REFERENCES `kb_fault` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='故障知识库-原因';

-- ----------------------------
-- Table structure for kb_fault_solution
-- ----------------------------
DROP TABLE IF EXISTS `kb_fault_solution`;
CREATE TABLE `kb_fault_solution` (
  `id` char(32) NOT NULL COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障履历ID',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `fault_solution_code` varchar(40) DEFAULT NULL COMMENT '维修方案代码',
  `new_mtr_code` varchar(40) DEFAULT NULL COMMENT '新件物料号',
  `new_supplier_code` varchar(40) DEFAULT NULL COMMENT '新件供应商',
  `duration` decimal(10,2) DEFAULT NULL COMMENT '耗时',
  `sort_code` int(11) DEFAULT NULL COMMENT '排序CODE',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_2` (`fault_id`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`fault_id`) REFERENCES `kb_fault` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='故障知识库-处理方案';

-- ----------------------------
-- Table structure for kb_fault_solution_reason
-- ----------------------------
DROP TABLE IF EXISTS `kb_fault_solution_reason`;
CREATE TABLE `kb_fault_solution_reason` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `solution_id` char(32) NOT NULL COMMENT '处理方案ID',
  `reason_id` char(32) DEFAULT NULL COMMENT '故障原因ID',
  `fault_id` int(11) DEFAULT NULL COMMENT '故障知识库id',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_5` (`solution_id`),
  KEY `FK_Reference_6` (`reason_id`),
  CONSTRAINT `FK_Reference_5` FOREIGN KEY (`solution_id`) REFERENCES `kb_fault_solution` (`id`),
  CONSTRAINT `FK_Reference_6` FOREIGN KEY (`reason_id`) REFERENCES `kb_fault_reason` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='故障知识库-原因解决方案关联表';

-- ----------------------------
-- Table structure for md_interval_optimize_advice
-- ----------------------------
DROP TABLE IF EXISTS `md_interval_optimize_advice`;
CREATE TABLE `md_interval_optimize_advice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `optimize_type` char(1) DEFAULT NULL COMMENT '建议类型\r\n            1：按故障模式优化；2：按预警优化；0：优化最终结果',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备类型',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '系统部件',
  `repair_class_code` varchar(40) DEFAULT NULL COMMENT '修程',
  `repair_item` varchar(40) DEFAULT NULL COMMENT '维修项点',
  `fault_mode` varchar(40) DEFAULT NULL COMMENT '故障模式',
  `interval_orginal` decimal(15,2) DEFAULT NULL COMMENT '原维修间隔',
  `interval_advice` decimal(15,2) DEFAULT NULL COMMENT '建议维修间隔',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `push_time` datetime DEFAULT NULL COMMENT '推送时间',
  `confirm_user` varchar(40) DEFAULT NULL COMMENT '确认人',
  `confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  `advice_series` varchar(800) DEFAULT NULL COMMENT '维修间隔序列',
  `merge_flag` char(1) DEFAULT '0' COMMENT '合并优化结果标志位',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8 COMMENT='间隔优化建议';

-- ----------------------------
-- Table structure for md_interval_optimize_curve
-- ----------------------------
DROP TABLE IF EXISTS `md_interval_optimize_curve`;
CREATE TABLE `md_interval_optimize_curve` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `advice_id` int(11) DEFAULT NULL COMMENT '优化建议id',
  `pattern` char(1) DEFAULT NULL COMMENT '分布类型\r\n            1：威布尔分布',
  `param_value` decimal(10,2) DEFAULT NULL COMMENT '参数值',
  `curve_data` blob COMMENT '曲线值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='间隔优化曲线';

-- ----------------------------
-- Table structure for md_repair_advice
-- ----------------------------
DROP TABLE IF EXISTS `md_repair_advice`;
CREATE TABLE `md_repair_advice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `equip_position_code` varchar(40) DEFAULT NULL COMMENT '装备位置号',
  `area_code` varchar(40) DEFAULT NULL COMMENT '部件区域编号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `source_type` char(1) DEFAULT NULL COMMENT '建议来源类型，1：告警，2：预警，3：预测，4：健康评估',
  `source_id` int(11) DEFAULT NULL COMMENT '建议来源ID，用于存储告警ID、预警ID、预测ID、健康评估ID',
  `problem_describe` varchar(400) DEFAULT NULL COMMENT '问题描述',
  `advice_content` varchar(5000) DEFAULT NULL COMMENT '维修建议',
  `repair_item_code` varchar(40) DEFAULT NULL,
  `repair_class_code` varchar(40) DEFAULT NULL COMMENT '建议结合修程',
  `status` varchar(2) DEFAULT NULL COMMENT '状态',
  `advice_deal_date` date DEFAULT NULL COMMENT '建议处理日期',
  `advice_lvl` varchar(4) DEFAULT NULL COMMENT '建议等级',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `push_time` datetime DEFAULT NULL COMMENT '推送时间',
  `create_user_id` varchar(40) DEFAULT NULL COMMENT '更新用户ID',
  `create_user_name` varchar(40) DEFAULT NULL COMMENT '更新用户名',
  `data_target_id` varchar(40) DEFAULT NULL COMMENT '数据受体',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10164182 DEFAULT CHARSET=utf8 COMMENT='维修建议表';

-- ----------------------------
-- Table structure for md_repair_evaluate
-- ----------------------------
DROP TABLE IF EXISTS `md_repair_evaluate`;
CREATE TABLE `md_repair_evaluate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equip_type` varchar(40) DEFAULT NULL COMMENT '车型',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '车组号',
  `area_code` varchar(40) DEFAULT NULL COMMENT '车辆号',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件',
  `repair_item_code` varchar(40) DEFAULT NULL COMMENT '维修项点',
  `pre_repair` varchar(40) DEFAULT NULL COMMENT '上次修程',
  `pre_repair_date` date DEFAULT NULL COMMENT '上次修竣日期',
  `current_mileage` int(11) DEFAULT NULL COMMENT '当前行驶里程',
  `current_fault_count` int(11) DEFAULT NULL COMMENT '当前故障数统计',
  `status` varchar(2) DEFAULT NULL COMMENT '状态（0欠修   1正常）',
  `create_time` date DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='修程评价';

-- ----------------------------
-- Table structure for md_storage_advice_his
-- ----------------------------
DROP TABLE IF EXISTS `md_storage_advice_his`;
CREATE TABLE `md_storage_advice_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '物料编码',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `advice_purchase_date` date DEFAULT NULL COMMENT '建议采购日期',
  `advice_purchase_amount` int(11) DEFAULT NULL COMMENT '建议采购数量',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `push_time` datetime DEFAULT NULL COMMENT '推送日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=847 DEFAULT CHARSET=utf8 COMMENT='配件库存建议历史表';

-- ----------------------------
-- Table structure for re_fault
-- ----------------------------
DROP TABLE IF EXISTS `re_fault`;
CREATE TABLE `re_fault` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `fault_code` varchar(40) DEFAULT NULL COMMENT '故障代码',
  `fault_phenomenon` varchar(40) DEFAULT NULL COMMENT '故障现象代码',
  `fault_level` varchar(10) DEFAULT NULL COMMENT '故障等级',
  `fault_desc` varchar(2000) DEFAULT NULL COMMENT '故障描述',
  `occr_time` datetime DEFAULT NULL COMMENT '发生时间',
  `recover_time` datetime DEFAULT NULL COMMENT '恢复时间',
  `source_type` char(1) DEFAULT NULL COMMENT '来源类型\r\n            1：告警\r\n            2：预警\r\n            3：人工录入',
  `source_id` int(11) DEFAULT NULL COMMENT '来源ID',
  `equip_op_duration` decimal(10,2) DEFAULT NULL COMMENT '运营时长/里程',
  `part_op_duration` decimal(10,2) DEFAULT NULL COMMENT '运营时长/里程',
  `record_time` datetime DEFAULT NULL COMMENT '数据采集时间',
  `record_method` varchar(10) DEFAULT NULL COMMENT '数据录入方式',
  `record_source` varchar(40) DEFAULT NULL COMMENT '数据来源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=158360 DEFAULT CHARSET=utf8 COMMENT='故障履历';

-- ----------------------------
-- Table structure for re_fault_copy
-- ----------------------------
DROP TABLE IF EXISTS `re_fault_copy`;
CREATE TABLE `re_fault_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `fault_code` varchar(40) DEFAULT NULL COMMENT '故障代码',
  `fault_phenomenon` varchar(40) DEFAULT NULL COMMENT '故障现象代码',
  `fault_level` varchar(10) DEFAULT NULL COMMENT '故障等级',
  `fault_desc` varchar(2000) DEFAULT NULL COMMENT '故障描述',
  `occr_time` datetime DEFAULT NULL COMMENT '发生时间',
  `recover_time` datetime DEFAULT NULL COMMENT '恢复时间',
  `source_type` char(1) DEFAULT NULL COMMENT '来源类型\r\n            1：告警\r\n            2：预警\r\n            3：人工录入',
  `source_id` int(11) DEFAULT NULL COMMENT '来源ID',
  `equip_op_duration` decimal(10,2) DEFAULT NULL COMMENT '运营时长/里程',
  `part_op_duration` decimal(10,2) DEFAULT NULL COMMENT '运营时长/里程',
  `record_time` datetime DEFAULT NULL COMMENT '数据采集时间',
  `record_method` varchar(10) DEFAULT NULL COMMENT '数据录入方式',
  `record_source` varchar(40) DEFAULT NULL COMMENT '数据来源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118626 DEFAULT CHARSET=utf8 COMMENT='故障履历';

-- ----------------------------
-- Table structure for re_fault_env
-- ----------------------------
DROP TABLE IF EXISTS `re_fault_env`;
CREATE TABLE `re_fault_env` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障履历ID',
  `param_id` int(11) DEFAULT NULL COMMENT '参数ID',
  `param_value` varchar(20) DEFAULT NULL COMMENT '参数值',
  `env_weight` tinyint(4) DEFAULT NULL COMMENT '影响因子',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='故障运行参数';

-- ----------------------------
-- Table structure for re_fault_env_copy
-- ----------------------------
DROP TABLE IF EXISTS `re_fault_env_copy`;
CREATE TABLE `re_fault_env_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障履历ID',
  `param_id` int(11) DEFAULT NULL COMMENT '参数ID',
  `param_value` varchar(20) DEFAULT NULL COMMENT '参数值',
  `env_weight` tinyint(4) DEFAULT NULL COMMENT '影响因子',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='故障运行参数';

-- ----------------------------
-- Table structure for re_fault_material
-- ----------------------------
DROP TABLE IF EXISTS `re_fault_material`;
CREATE TABLE `re_fault_material` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障履历ID',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `mtr_number` int(11) DEFAULT NULL COMMENT '消耗数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1754 DEFAULT CHARSET=utf8 COMMENT='故障履历-物料消耗';

-- ----------------------------
-- Table structure for re_fault_material_copy
-- ----------------------------
DROP TABLE IF EXISTS `re_fault_material_copy`;
CREATE TABLE `re_fault_material_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障履历ID',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `mtr_number` int(11) DEFAULT NULL COMMENT '消耗数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8 COMMENT='故障履历-物料消耗';

-- ----------------------------
-- Table structure for re_fault_reason_copy
-- ----------------------------
DROP TABLE IF EXISTS `re_fault_reason_copy`;
CREATE TABLE `re_fault_reason_copy` (
  `id` char(32) NOT NULL COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障履历ID',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `fault_reason_code` varchar(40) DEFAULT NULL COMMENT '故障原因代码',
  `fault_mode_code` varchar(40) DEFAULT NULL COMMENT '故障模式代码',
  `weight` tinyint(4) DEFAULT NULL COMMENT '影响因子',
  `fault_reason_desc` varchar(100) DEFAULT NULL COMMENT '故障原因描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='故障履历-原因';

-- ----------------------------
-- Table structure for re_fault_solution
-- ----------------------------
DROP TABLE IF EXISTS `re_fault_solution`;
CREATE TABLE `re_fault_solution` (
  `id` char(32) NOT NULL COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障履历ID',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `fault_solution_code` varchar(40) DEFAULT NULL COMMENT '维修方案代码',
  `fault_solution_desc` varchar(400) DEFAULT NULL,
  `new_mtr_code` varchar(40) DEFAULT NULL COMMENT '新件物料号',
  `new_supplier_code` varchar(40) DEFAULT NULL COMMENT '新件供应商',
  `new_part_sn` varchar(40) DEFAULT NULL COMMENT '新件序列号',
  `duration` decimal(10,2) DEFAULT NULL COMMENT '耗时',
  `sort_code` int(11) DEFAULT NULL COMMENT '排序CODE',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='故障履历-处理方案';

-- ----------------------------
-- Table structure for re_fault_solution_copy
-- ----------------------------
DROP TABLE IF EXISTS `re_fault_solution_copy`;
CREATE TABLE `re_fault_solution_copy` (
  `id` char(32) NOT NULL COMMENT 'id',
  `fault_id` int(11) NOT NULL COMMENT '故障履历ID',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `fault_solution_code` varchar(40) DEFAULT NULL COMMENT '维修方案代码',
  `new_mtr_code` varchar(40) DEFAULT NULL COMMENT '新件物料号',
  `new_supplier_code` varchar(40) DEFAULT NULL COMMENT '新件供应商',
  `new_part_sn` varchar(40) DEFAULT NULL COMMENT '新件序列号',
  `duration` decimal(10,2) DEFAULT NULL COMMENT '耗时',
  `sort_code` int(11) DEFAULT NULL COMMENT '排序CODE',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='故障履历-处理方案';

-- ----------------------------
-- Table structure for re_fault_solution_reason
-- ----------------------------
DROP TABLE IF EXISTS `re_fault_solution_reason`;
CREATE TABLE `re_fault_solution_reason` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `solution_id` char(32) NOT NULL COMMENT '处理方案ID',
  `reason_id` char(32) DEFAULT NULL COMMENT '故障原因ID',
  `fault_id` int(11) DEFAULT NULL COMMENT '故障ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46709 DEFAULT CHARSET=utf8 COMMENT='故障履历-原因解决方案关联表';

-- ----------------------------
-- Table structure for re_operation_current
-- ----------------------------
DROP TABLE IF EXISTS `re_operation_current`;
CREATE TABLE `re_operation_current` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `operation_code` varchar(250) DEFAULT NULL COMMENT '当前交路/航段编号，当前非运营状态为''-''',
  `operation_name` varchar(3000) DEFAULT NULL COMMENT '当前交路/航段名称，当前非运营状态为''-''',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `op_duration_current` decimal(10,2) DEFAULT NULL COMMENT '当前交路/航段运营时长/里程',
  `op_duration` decimal(10,2) DEFAULT NULL COMMENT '累计运营时长/里程',
  `record_time` datetime DEFAULT NULL COMMENT '数据更新时间',
  `record_method` varchar(10) DEFAULT NULL COMMENT '数据录入方式',
  `record_source` varchar(40) DEFAULT NULL COMMENT '数据来源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1628 DEFAULT CHARSET=utf8 COMMENT='装备/部件当前运营信息';

-- ----------------------------
-- Table structure for re_operation_his
-- ----------------------------
DROP TABLE IF EXISTS `re_operation_his`;
CREATE TABLE `re_operation_his` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `equip_position` varchar(40) DEFAULT NULL COMMENT '装备位置',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `operation_code` varchar(250) DEFAULT NULL COMMENT '交路/航段编号',
  `operation_name` varchar(3000) DEFAULT NULL COMMENT '交路/航段名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `op_duration_current` decimal(10,2) DEFAULT NULL COMMENT '当前交路/航段运营时长/里程',
  `op_duration` decimal(10,2) DEFAULT NULL COMMENT '累计运营时长/里程',
  `record_time` datetime DEFAULT NULL COMMENT '数据采集时间',
  `record_method` varchar(10) DEFAULT NULL COMMENT '数据录入方式',
  `record_source` varchar(40) DEFAULT NULL COMMENT '数据来源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=585130 DEFAULT CHARSET=utf8 COMMENT='装备/部件运营履历';

-- ----------------------------
-- Table structure for re_part_change
-- ----------------------------
DROP TABLE IF EXISTS `re_part_change`;
CREATE TABLE `re_part_change` (
  `id` int(11) NOT NULL COMMENT 'id',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `change_type` char(1) DEFAULT NULL COMMENT '变更类型\r\n            1：更换\r\n            2：安装\r\n            3：拆卸',
  `new_sys_code` varchar(40) DEFAULT NULL COMMENT '新件功能分类编码',
  `new_mtr_code` varchar(40) DEFAULT NULL COMMENT '新件物料号',
  `new_area_code` varchar(40) DEFAULT NULL COMMENT '新件区域编码',
  `new_part_bei` varchar(40) DEFAULT NULL COMMENT '新件部件bei',
  `new_part_sn` varchar(40) DEFAULT NULL COMMENT '新件序列号',
  `op_duration` decimal(10,2) DEFAULT NULL COMMENT '运营时长/里程',
  `record_time` datetime DEFAULT NULL COMMENT '数据采集时间',
  `record_method` varchar(10) DEFAULT NULL COMMENT '数据录入方式',
  `record_source` varchar(40) DEFAULT NULL COMMENT '数据来源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置变更履历';

-- ----------------------------
-- Table structure for re_repair_copy
-- ----------------------------
DROP TABLE IF EXISTS `re_repair_copy`;
CREATE TABLE `re_repair_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `repair_class_code` varchar(40) DEFAULT NULL COMMENT '修程\r\n            1：更换\r\n            2：安装\r\n            3：拆卸',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `op_duration` decimal(10,2) DEFAULT NULL COMMENT '运营时长/里程',
  `record_time` datetime DEFAULT NULL COMMENT '数据采集时间',
  `record_method` varchar(10) DEFAULT NULL COMMENT '数据录入方式',
  `record_source` varchar(40) DEFAULT NULL COMMENT '数据来源',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1296 DEFAULT CHARSET=utf8 COMMENT='检修履历';

-- ----------------------------
-- Table structure for re_repair_item
-- ----------------------------
DROP TABLE IF EXISTS `re_repair_item`;
CREATE TABLE `re_repair_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `repair_id` int(11) NOT NULL COMMENT '检修履历ID',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `repair_item` varchar(40) DEFAULT NULL COMMENT '维修项点',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='检修履历-维修项点';

-- ----------------------------
-- Table structure for re_repair_item_copy
-- ----------------------------
DROP TABLE IF EXISTS `re_repair_item_copy`;
CREATE TABLE `re_repair_item_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `repair_id` int(11) NOT NULL COMMENT '检修履历ID',
  `sys_code` varchar(40) DEFAULT NULL COMMENT '功能分类编码',
  `mtr_code` varchar(40) DEFAULT NULL COMMENT '部件物料号',
  `supplier_code` varchar(40) DEFAULT NULL COMMENT '供应商编码',
  `area_code` varchar(40) DEFAULT NULL COMMENT '区域编码',
  `part_bei` varchar(40) DEFAULT NULL COMMENT '部件bei',
  `part_sn` varchar(40) DEFAULT NULL COMMENT '部件序列号',
  `repair_item` varchar(40) DEFAULT NULL COMMENT '维修项点',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='检修履历-维修项点';

-- ----------------------------
-- Table structure for sm_equipment
-- ----------------------------
DROP TABLE IF EXISTS `sm_equipment`;
CREATE TABLE `sm_equipment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `equip_type` varchar(40) DEFAULT NULL COMMENT '装备型号',
  `equip_sn` varchar(40) DEFAULT NULL COMMENT '装备序列号',
  `pos_x` decimal(20,8) DEFAULT NULL COMMENT '位置X',
  `pos_y` decimal(20,8) DEFAULT NULL COMMENT '位置Y',
  `online` char(1) DEFAULT NULL COMMENT '在线状态',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=316799230 DEFAULT CHARSET=utf8 COMMENT='设备状态';

-- ----------------------------
-- Table structure for sm_expload_hotspot
-- ----------------------------
DROP TABLE IF EXISTS `sm_expload_hotspot`;
CREATE TABLE `sm_expload_hotspot` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `view_id` int(11) NOT NULL COMMENT '爆炸图ID',
  `part_bei` varchar(40) NOT NULL COMMENT '部件BEI',
  `name` varchar(40) NOT NULL COMMENT '热点名称',
  `pos_x` decimal(10,0) NOT NULL COMMENT '位置X',
  `pos_y` decimal(10,0) NOT NULL COMMENT '位置Y',
  `param_config` varchar(4000) NOT NULL COMMENT '参数配置，格式如下：\r\n            [{\r\n              code: '''',\r\n              name: '''',\r\n              rule: ''''\r\n            }]',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(40) DEFAULT NULL COMMENT '创建用户',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_28` (`view_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='爆炸图热点';
