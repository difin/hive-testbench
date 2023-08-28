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

create external table if not exists catalog_page(
      cp_catalog_page_sk bigint
,     cp_catalog_page_id char(16)
,     cp_start_date_sk bigint
,     cp_end_date_sk bigint
,     cp_department varchar(50)
,     cp_catalog_number int
,     cp_catalog_page_number int
,     cp_description varchar(100)
,     cp_type varchar(100)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/catalog_page"
${TABLE_PROPS}
;