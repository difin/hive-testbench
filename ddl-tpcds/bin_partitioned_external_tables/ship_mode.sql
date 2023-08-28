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

create external table if not exists ship_mode(
      sm_ship_mode_sk bigint
,     sm_ship_mode_id char(16)
,     sm_type char(30)
,     sm_code char(10)
,     sm_carrier char(20)
,     sm_contract char(20)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/ship_mode"
${TABLE_PROPS}
;
