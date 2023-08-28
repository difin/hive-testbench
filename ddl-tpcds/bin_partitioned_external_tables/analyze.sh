#!/bin/sh

JDBC_URL="jdbc:hive2://hs2-dfingerman-vw.dw-dw-team-env.xcu2-8y8x.dev.cldr.work/default;transportMode=http;httpPath=cliservice;socketTimeout=60;ssl=true;"
USER=csso_lbodor
PASS=asdQWE123-

FORMAT=parquet
TARGET_DB=tpcds_partitioned_${FORMAT}_1000_external
REDUCERS=2500

$HIVE_HOME/bin/beeline -u ${JDBC_URL} -n ${USER} -p ${PASS} --hivevar DB=${TARGET_DB} --hivevar REDUCERS=${REDUCERS} -f analyze.sql
