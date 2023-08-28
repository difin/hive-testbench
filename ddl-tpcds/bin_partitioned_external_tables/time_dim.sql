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

create external table if not exists time_dim(
      t_time_sk bigint
,     t_time_id char(16)
,     t_time int
,     t_hour int
,     t_minute int
,     t_second int
,     t_am_pm char(2)
,     t_shift char(20)
,     t_sub_shift char(20)
,     t_meal_time char(20)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/time_dim"
${TABLE_PROPS}
;