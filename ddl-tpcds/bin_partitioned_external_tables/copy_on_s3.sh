#!/bin/sh

# shellcheck disable=SC2116
for TABLE in $(echo call_center catalog_page catalog_returns catalog_sales customer customer_address customer_demographics date_dim household_demographics income_band inventory item promotion reason ship_mode store store_sales store_returns time_dim warehouse web_page web_returns web_sales web_site)
do
  echo copying $TABLE
  
  aws s3 sync s3://dfingerman-bucket/my-dl/warehouse/tablespace/external/hive/tpcds_partitioned_parquet_1000_external.db/${TABLE} s3://dw-team-bucket/data/warehouse/tablespace/external/hive/tpcds_partitioned_parquet_1000_external.db/${TABLE} --copy-props none
done
