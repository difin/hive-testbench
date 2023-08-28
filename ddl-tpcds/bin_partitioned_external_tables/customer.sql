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

create external table if not exists customer(
      c_customer_sk bigint
,     c_customer_id char(16)
,     c_current_cdemo_sk bigint
,     c_current_hdemo_sk bigint
,     c_current_addr_sk bigint
,     c_first_shipto_date_sk bigint
,     c_first_sales_date_sk bigint
,     c_salutation char(10)
,     c_first_name char(20)
,     c_last_name char(30)
,     c_preferred_cust_flag char(1)
,     c_birth_day int
,     c_birth_month int
,     c_birth_year int
,     c_birth_country varchar(20)
,     c_login char(13)
,     c_email_address char(50)
,     c_last_review_date_sk bigint
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/customer"
${TABLE_PROPS}
;
