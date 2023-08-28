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

create external table if not exists item(
      i_item_sk bigint
,     i_item_id char(16)
,     i_rec_start_date date
,     i_rec_end_date date
,     i_item_desc varchar(200)
,     i_current_price decimal(7,2)
,     i_wholesale_cost decimal(7,2)
,     i_brand_id int
,     i_brand char(50)
,     i_class_id int
,     i_class char(50)
,     i_category_id int
,     i_category char(50)
,     i_manufact_id int
,     i_manufact char(50)
,     i_size char(20)
,     i_formulation char(20)
,     i_color char(20)
,     i_units char(10)
,     i_container char(10)
,     i_manager_id int
,     i_product_name char(50)
)
${STORED_BY}
stored as ${FILE}
location "s3a://${DB_PATH}.db/item"
${TABLE_PROPS}
;