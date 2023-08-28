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

create external table if not exists web_page(
      wp_web_page_sk bigint
,     wp_web_page_id char(16)
,     wp_rec_start_date date
,     wp_rec_end_date date
,     wp_creation_date_sk bigint
,     wp_access_date_sk bigint
,     wp_autogen_flag char(1)
,     wp_customer_sk bigint
,     wp_url varchar(100)
,     wp_type char(50)
,     wp_char_count int
,     wp_link_count int
,     wp_image_count int
,     wp_max_ad_count int
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/web_page"
${TABLE_PROPS}
;