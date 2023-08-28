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

create external table if not exists promotion(
      p_promo_sk bigint
,     p_promo_id char(16)
,     p_start_date_sk bigint
,     p_end_date_sk bigint
,     p_item_sk bigint
,     p_cost decimal(15,2)
,     p_response_target int
,     p_promo_name char(50)
,     p_channel_dmail char(1)
,     p_channel_email char(1)
,     p_channel_catalog char(1)
,     p_channel_tv char(1)
,     p_channel_radio char(1)
,     p_channel_press char(1)
,     p_channel_event char(1)
,     p_channel_demo char(1)
,     p_channel_details varchar(100)
,     p_purpose char(15)
,     p_discount_active char(1)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/promotion"
${TABLE_PROPS}
;