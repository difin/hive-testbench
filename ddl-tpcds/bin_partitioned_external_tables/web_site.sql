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

create external table if not exists web_site(
      web_site_sk bigint
,     web_site_id char(16)
,     web_rec_start_date date
,     web_rec_end_date date
,     web_name varchar(50)
,     web_open_date_sk bigint
,     web_close_date_sk bigint
,     web_class varchar(50)
,     web_manager varchar(40)
,     web_mkt_id int
,     web_mkt_class varchar(50)
,     web_mkt_desc varchar(100)
,     web_market_manager varchar(40)
,     web_company_id int
,     web_company_name char(50)
,     web_street_number char(10)
,     web_street_name varchar(60)
,     web_street_type char(15)
,     web_suite_number char(10)
,     web_city varchar(60)
,     web_county varchar(30)
,     web_state char(2)
,     web_zip char(10)
,     web_country varchar(20)
,     web_gmt_offset decimal(5,2)  
,     web_tax_percentage decimal(5,2)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/web_site"
${TABLE_PROPS}
;