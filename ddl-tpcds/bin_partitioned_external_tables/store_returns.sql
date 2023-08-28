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

create external table store_returns
(
      sr_return_time_sk bigint
,     sr_item_sk bigint
,     sr_customer_sk bigint
,     sr_cdemo_sk bigint
,     sr_hdemo_sk bigint
,     sr_addr_sk bigint
,     sr_store_sk bigint
,     sr_reason_sk bigint
,     sr_ticket_number bigint
,     sr_return_quantity int
,     sr_return_amt decimal(7,2)
,     sr_return_tax decimal(7,2)
,     sr_return_amt_inc_tax decimal(7,2)
,     sr_fee decimal(7,2)
,     sr_return_ship_cost decimal(7,2)
,     sr_refunded_cash decimal(7,2)
,     sr_reversed_charge decimal(7,2)
,     sr_store_credit decimal(7,2)
,     sr_net_loss decimal(7,2)
)
partitioned by (sr_returned_date_sk bigint)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/store_returns"
${TABLE_PROPS};

MSCK REPAIR TABLE store_returns;
