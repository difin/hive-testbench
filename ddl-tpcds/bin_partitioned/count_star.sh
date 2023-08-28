#!/bin/sh

JDBC_URL="jdbc:hive2://hs2-dfingerman-vw.dw-dw-team-env.xcu2-8y8x.dev.cldr.work/default;transportMode=http;httpPath=cliservice;socketTimeout=60;ssl=true;"
USER=csso_lbodor
PASS=asdQWE123-

REDUCERS=2500
DB=tpcds_partitioned_parquet_1000_iceberg

#$HIVE_HOME/bin/beeline -u ${JDBC_URL} -n ${USER} -p ${PASS} --hivevar DB=${DB} --hivevar REDUCERS=${REDUCERS} -f analyze.sql

# shellcheck disable=SC2116
for TABLE in $(echo call_center catalog_page catalog_returns catalog_sales customer customer_address customer_demographics date_dim household_demographics income_band inventory item promotion reason ship_mode store store_returns store_sales time_dim warehouse web_page web_returns web_sales web_site)
do
  $HIVE_HOME/bin/beeline -u ${JDBC_URL} -n ${USER} -p ${PASS} --hivevar DB=${DB} --hivevar TABLE=${TABLE} -f count_star.sql
done
