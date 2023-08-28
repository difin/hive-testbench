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

create external table catalog_returns
(
      cr_returned_time_sk bigint
,     cr_item_sk bigint
,     cr_refunded_customer_sk bigint
,     cr_refunded_cdemo_sk bigint
,     cr_refunded_hdemo_sk bigint
,     cr_refunded_addr_sk bigint
,     cr_returning_customer_sk bigint
,     cr_returning_cdemo_sk bigint
,     cr_returning_hdemo_sk bigint
,     cr_returning_addr_sk bigint
,     cr_call_center_sk bigint
,     cr_catalog_page_sk bigint
,     cr_ship_mode_sk bigint
,     cr_warehouse_sk bigint
,     cr_reason_sk bigint
,     cr_order_number bigint
,     cr_return_quantity int
,     cr_return_amount decimal(7,2)
,     cr_return_tax decimal(7,2)
,     cr_return_amt_inc_tax decimal(7,2)
,     cr_fee decimal(7,2)
,     cr_return_ship_cost decimal(7,2)
,     cr_refunded_cash decimal(7,2)
,     cr_reversed_charge decimal(7,2)
,     cr_store_credit decimal(7,2)
,     cr_net_loss decimal(7,2)
)
partitioned by (cr_returned_date_sk bigint)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/catalog_returns"
${TABLE_PROPS};

MSCK REPAIR TABLE catalog_returns;