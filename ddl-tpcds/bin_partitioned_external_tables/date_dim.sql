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

create external table if not exists date_dim(
      d_date_sk bigint
,     d_date_id char(16)
,     d_date date
,     d_month_seq int
,     d_week_seq int
,     d_quarter_seq int
,     d_year int
,     d_dow int
,     d_moy int
,     d_dom int
,     d_qoy int
,     d_fy_year int
,     d_fy_quarter_seq int
,     d_fy_week_seq int
,     d_day_name char(9)
,     d_quarter_name char(6)
,     d_holiday char(1)
,     d_weekend char(1)
,     d_following_holiday char(1)
,     d_first_dom int
,     d_last_dom int
,     d_same_day_ly int
,     d_same_day_lq int
,     d_current_day char(1)
,     d_current_week char(1)
,     d_current_month char(1)
,     d_current_quarter char(1)
,     d_current_year char(1)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/date_dim"
${TABLE_PROPS}
;
