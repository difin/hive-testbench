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

create external table if not exists customer_demographics(
      cd_demo_sk bigint
,     cd_gender char(1)
,     cd_marital_status char(1)
,     cd_education_status char(20)
,     cd_purchase_estimate int
,     cd_credit_rating char(10)
,     cd_dep_count int
,     cd_dep_employed_count int
,     cd_dep_college_count int
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/customer_demographics"
${TABLE_PROPS}
;
