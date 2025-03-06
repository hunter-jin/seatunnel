
-- --------------------------------------
-- 测试
-- --------------------------------------
-- SeaTunnel测试表
DROP TABLE IF EXISTS dwd_seatunnel_test;

CREATE TABLE IF NOT EXISTS dwd_seatunnel_test (
  `item_id` BIGINT NOT NULL COMMENT '明细ID',
  `bill_time` TIMESTAMP(3) COMMENT '接单时间',
  `bill_id` BIGINT NOT NULL COMMENT '配货通知单ID',
  `tenant_id` BIGINT NOT NULL COMMENT '租户ID',
  `warehouse_id` BIGINT NOT NULL COMMENT 'WMS仓库ID',
  `org_id` BIGINT NOT NULL COMMENT '组织ID',
  `store_id` BIGINT NOT NULL COMMENT '店铺ID',
  `area_code` STRING COMMENT '地区ID',
  `channel_code` STRING COMMENT '订单渠道',
  `product_id` BIGINT NOT NULL COMMENT '商品ID',
  `sku_id` BIGINT NOT NULL COMMENT 'SKU ID',
  `discount` DECIMAL(8, 4) COMMENT '折扣',
  `qty` DECIMAL(14, 2) COMMENT '期初数量',
  `price` DECIMAL(14, 2) COMMENT '结算价格',
  `amt` DECIMAL(14, 2) COMMENT '期初结算金额',
  `tag_price` DECIMAL(14, 2) COMMENT '吊牌价',
  `tag_price_amt` DECIMAL(14, 2) COMMENT '期初吊牌价金额',
  `retail_price` DECIMAL(14, 2) COMMENT '零售价',
  `retail_price_amt` DECIMAL(14, 2) COMMENT '期初零售价金额',
  `dt` STRING COMMENT '快照日期',
  `etl_dt` TIMESTAMP(3) COMMENT '入湖时间',
  PRIMARY KEY (`item_id`, `dt`) NOT ENFORCED
) COMMENT 'B2C待发订单周期快照（日）' PARTITIONED BY (dt)
WITH
  (
    'connector' = 'paimon',
    'changelog-producer' = 'lookup',
    'partition.expiration-time' = '100 d',
    'partition.expiration-check-interval' = '1 d',
    'partition.timestamp-formatter' = 'yyyyMMdd',
    'partition.timestamp-pattern' = '$dt',
    'consumer.expiration-time' = '3 d'
  );
