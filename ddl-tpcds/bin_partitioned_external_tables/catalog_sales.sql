set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.max.dynamic.partitions.pernode=100000;
set hive.exec.max.dynamic.partitions=100000;
set hive.exec.max.created.files=1000000;
set hive.exec.parallel=true;
set hive.exec.reducers.max=${REDUCERS};
set hive.stats.autogather=true;
set hive.optimize.sort.dynamic.partition=true;
set hive.optimize.sort.dynamic.partition=true;
set tez.runtime.empty.partitions.info-via-events.enabled=true;
set tez.runtime.report.partition.stats=true;
set hive.tez.auto.reducer.parallelism=true;
set hive.tez.min.partition.factor=0.01; 
set hive.optimize.sort.dynamic.partition.threshold=0;
set iceberg.mr.schema.auto.conversion=true;

create database if not exists ${DB};
use ${DB};

create external table catalog_sales
(
      cs_sold_time_sk bigint
,     cs_ship_date_sk bigint
,     cs_bill_customer_sk bigint
,     cs_bill_cdemo_sk bigint
,     cs_bill_hdemo_sk bigint
,     cs_bill_addr_sk bigint
,     cs_ship_customer_sk bigint
,     cs_ship_cdemo_sk bigint
,     cs_ship_hdemo_sk bigint
,     cs_ship_addr_sk bigint
,     cs_call_center_sk bigint
,     cs_catalog_page_sk bigint
,     cs_ship_mode_sk bigint
,     cs_warehouse_sk bigint
,     cs_item_sk bigint
,     cs_promo_sk bigint
,     cs_order_number bigint
,     cs_quantity int
,     cs_wholesale_cost decimal(7,2)
,     cs_list_price decimal(7,2)
,     cs_sales_price decimal(7,2)
,     cs_ext_discount_amt decimal(7,2)
,     cs_ext_sales_price decimal(7,2)
,     cs_ext_wholesale_cost decimal(7,2)
,     cs_ext_list_price decimal(7,2)
,     cs_ext_tax decimal(7,2)
,     cs_coupon_amt decimal(7,2)
,     cs_ext_ship_cost decimal(7,2)
,     cs_net_paid decimal(7,2)
,     cs_net_paid_inc_tax decimal(7,2)
,     cs_net_paid_inc_ship decimal(7,2)
,     cs_net_paid_inc_ship_tax decimal(7,2)
,     cs_net_profit decimal(7,2)
)
partitioned by (cs_sold_date_sk bigint)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/catalog_sales"
${TABLE_PROPS};

MSCK REPAIR TABLE catalog_sales;