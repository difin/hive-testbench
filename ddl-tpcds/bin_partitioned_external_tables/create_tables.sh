#!/bin/sh

JDBC_URL="jdbc:hive2://hs2-dfingerman-vw.dw-dw-team-env.xcu2-8y8x.dev.cldr.work/default;transportMode=http;httpPath=cliservice;socketTimeout=60;ssl=true"
USER=csso_lbodor
PASS=asdQWE123-
DB=tpcds_partitioned_parquet_1000_external
DB_PATH=dw-team-bucket/data/warehouse/tablespace/external/hive/tpcds_partitioned_parquet_1000_external
REDUCERS=2500
PROPS="TBLPROPERTIES ('engine.hive.enabled'='true', 'format-version'='2')"

ICEBERG=false
if [ `echo ${DB} | grep iceberg | wc -l` -gt 0 ]
then
  ICEBERG=false
fi

# shellcheck disable=SC2116
for SQL_FILE in ls $(echo call_center.sql catalog_page.sql catalog_returns.sql catalog_sales.sql customer.sql customer_address.sql customer_demographics.sql date_dim.sql household_demographics.sql income_band.sql inventory.sql item.sql promotion.sql reason.sql ship_mode.sql store.sql store_returns.sql store_sales.sql time_dim.sql warehouse.sql web_page.sql web_returns.sql web_sales.sql web_site.sql)
do
  if [ "${ICEBERG}" == "false" ] 
  then
    $HIVE_HOME/bin/beeline -u ${JDBC_URL} -n ${USER} -p ${PASS} --hivevar FILE=parquet --hivevar DB=${DB} --hivevar DB_PATH=${DB_PATH} --hivevar REDUCERS=${REDUCERS} --hivevar STORED_BY="" --hivevar TABLE_PROPS="" -f $SQL_FILE
  else
    cat $SQL_FILE | sed -e "s/varchar(.*)/string/g" | sed -e "s/char(.*)/string/g" > tmp.sql
    $HIVE_HOME/bin/beeline -u ${JDBC_URL} -n ${USER} -p ${PASS} --hivevar FILE=parquet --hivevar DB=${DB} --hivevar DB_PATH=${DB_PATH} --hivevar REDUCERS=${REDUCERS} --hivevar STORED_BY="STORED BY ICEBERG" --hivevar TABLE_PROPS="${PROPS}" -f tmp.sql
    rm -f tmp.sql
  fi
done
