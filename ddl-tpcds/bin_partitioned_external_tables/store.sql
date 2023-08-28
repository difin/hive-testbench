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

create external table if not exists store(
      s_store_sk bigint
,     s_store_id char(16)
,     s_rec_start_date date
,     s_rec_end_date date
,     s_closed_date_sk bigint
,     s_store_name varchar(50)
,     s_number_employees int
,     s_floor_space int
,     s_hours char(20)
,     S_manager varchar(40)
,     S_market_id int
,     S_geography_class varchar(100)
,     S_market_desc varchar(100)
,     s_market_manager varchar(40)
,     s_division_id int
,     s_division_name varchar(50)
,     s_company_id int
,     s_company_name varchar(50)
,     s_street_number varchar(10)
,     s_street_name varchar(60)
,     s_street_type char(15)
,     s_suite_number char(10)
,     s_city varchar(60)
,     s_county varchar(30)
,     s_state char(2)
,     s_zip char(10)
,     s_country varchar(20)
,     s_gmt_offset decimal(5,2)
,     s_tax_percentage decimal(5,2)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/store"
${TABLE_PROPS}
;
