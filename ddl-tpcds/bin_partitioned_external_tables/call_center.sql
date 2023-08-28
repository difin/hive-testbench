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

drop table if exists call_center;

create external table if not exists call_center(
      cc_call_center_sk bigint
,     cc_call_center_id char(16)
,     cc_rec_start_date date
,     cc_rec_end_date date
,     cc_closed_date_sk bigint
,     cc_open_date_sk bigint
,     cc_name varchar(50)
,     cc_class varchar(50)
,     cc_employees int
,     cc_sq_ft int
,     cc_hours char(20)
,     cc_manager varchar(40)
,     cc_mkt_id int
,     cc_mkt_class char(50)
,     cc_mkt_desc varchar(100)
,     cc_market_manager varchar(40)
,     cc_division int
,     cc_division_name varchar(50)
,     cc_company int
,     cc_company_name char(50)
,     cc_street_number char(10)
,     cc_street_name varchar(60)
,     cc_street_type char(15)
,     cc_suite_number char(10)
,     cc_city varchar(60)
,     cc_county varchar(30)
,     cc_state char(2)
,     cc_zip char(10)
,     cc_country varchar(20)
,     cc_gmt_offset decimal(5,2)
,     cc_tax_percentage decimal(5,2)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/call_center"
${TABLE_PROPS}
;