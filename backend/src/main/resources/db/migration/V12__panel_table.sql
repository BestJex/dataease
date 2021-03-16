SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for panel_group
-- ----------------------------
DROP TABLE IF EXISTS `panel_group`;
CREATE TABLE `panel_group` (
  `id` varchar(50) NOT NULL,
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `pid` varchar(255) DEFAULT NULL COMMENT '父级id',
  `level` int(10) DEFAULT NULL COMMENT '层级',
  `node_type` varchar(255) DEFAULT NULL COMMENT '节点类型  folder or panel 目录或者文件夹',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` bigint(13) DEFAULT NULL COMMENT '创建时间',
  `panel_type` varchar(255) DEFAULT NULL COMMENT '仪表盘类型 system 系统内置 self 用户自建 ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for panel_view
-- ----------------------------
DROP TABLE IF EXISTS `panel_view`;
CREATE TABLE `panel_view` (
  `id` varchar(50) NOT NULL,
  `panel_group_id` varchar(50) DEFAULT NULL COMMENT 'panel_group_id',
  `content` blob COMMENT '内容',
  `create_by` varchar(255) DEFAULT NULL COMMENT '创建人',
  `create_time` bigint(13) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) DEFAULT NULL COMMENT '更新人',
  `update_time` bigint(13) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS = 1;



DROP function IF EXISTS GET_PANEL_CHILDREN_CHILDREN;
DELIMITER $$
CREATE  FUNCTION `GET_PANEL_CHILDREN_CHILDREN`(parentId varchar(8000)) RETURNS varchar(8000) CHARSET utf8
READS SQL DATA
BEGIN
    DECLARE oTemp VARCHAR(8000);
    DECLARE oTempChild VARCHAR(8000);
    SET oTemp = '';
    SET oTempChild = CAST(parentId AS CHAR);
    WHILE oTempChild IS NOT NULL
        DO
        SET oTemp = CONCAT(oTemp,',',oTempChild);
        SELECT GROUP_CONCAT(id) INTO oTempChild FROM panel_group WHERE FIND_IN_SET(pid,oTempChild) > 0;
    END WHILE;
    RETURN oTemp;
END $$
DELIMITER ;