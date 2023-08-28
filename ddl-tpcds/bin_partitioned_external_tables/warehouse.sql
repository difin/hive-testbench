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

create external table if not exists warehouse(
      w_warehouse_sk bigint
,     w_warehouse_id char(16)
,     w_warehouse_name varchar(20)
,     w_warehouse_sq_ft int
,     w_street_number char(10)
,     w_street_name varchar(60)
,     w_street_type char(15)
,     w_suite_number char(10)
,     w_city varchar(60)
,     w_county varchar(30)
,     w_state char(2)
,     w_zip char(10)
,     w_country varchar(20)
,     w_gmt_offset decimal(5,2)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/warehouse"
${TABLE_PROPS}
;