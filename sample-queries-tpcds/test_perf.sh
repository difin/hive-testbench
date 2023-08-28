#!/bin/sh

JDBC_URL="jdbc:hive2://hs2-dfingerman-vw.dw-dw-team-env.xcu2-8y8x.dev.cldr.work/default;transportMode=http;httpPath=cliservice;socketTimeout=60;ssl=true;"
USER=csso_lbodor
PASS=asdQWE123-

DB=tpcds_partitioned_parquet_1000_iceberg

rm -fr $DB
mkdir $DB

RAW_TIMING_OUT=$DB/raw_timing.txt
REPORT=$DB/report.csv
rm -fr $RAW_TIMING_OUT

# shellcheck disable=SC2116
#for QUERY in `ls -1 query*.sql`
for QUERY in `ls -1 \
query1.sql  query2.sql  query3.sql  query4.sql  query5.sql  query6.sql  query7.sql  query8.sql  query9.sql \
query10.sql query11.sql query12.sql query13.sql query14.sql query15.sql query16.sql query17.sql query18.sql query19.sql \
query20.sql query21.sql query22.sql query23.sql query24.sql query25.sql query26.sql query27.sql query28.sql query29.sql \
query30.sql query31.sql query32.sql query33.sql query34.sql query35.sql query36.sql query37.sql query38.sql query39.sql \
query40.sql query41.sql query42.sql query43.sql query44.sql query45.sql query46.sql query47.sql query48.sql query49.sql \
query50.sql query51.sql query52.sql query53.sql query54.sql query55.sql query56.sql query57.sql query58.sql query59.sql \
query60.sql query61.sql query62.sql query63.sql query64.sql query65.sql query66.sql query67.sql query68.sql query69.sql \
query70.sql query71.sql query72.sql query73.sql query74.sql query75.sql query76.sql query77.sql query78.sql query79.sql \
query80.sql query81.sql query82.sql query83.sql query84.sql query85.sql query86.sql query87.sql query88.sql query89.sql \
query90.sql query91.sql query92.sql query93.sql query94.sql query95.sql query96.sql query97.sql query98.sql query99.sql`
do
  tmp=$DB/tmp.sql
  echo "use $DB;" > $tmp
  echo "set hive.query.results.cache.enabled=false; set hive.tez.bloom.filter.merge.threads=0; set mapreduce.input.fileinputformat.list-status.num-threads=50; set hive.disable.unsafe.external.table.operations=false;" >> $tmp

  cat ${QUERY} >> $tmp
  QUERY_NUM=`echo ${QUERY} | cut -d "y" -f 2 | cut -d "." -f 1`

  for ITERATION in `echo 1 2 3 4`
  do
      OUTPUT=${DB}/${QUERY}.${ITERATION}

      ${HIVE_HOME}/bin/beeline -u ${JDBC_URL} -n ${USER} -p ${PASS} -f $tmp > ${OUTPUT} 2>&1
      status=$?

      if [ $status -ne 0 ]
      then
        echo Query ${QUERY} failed!
        echo "Query: ${QUERY_NUM}; iteration: ${ITERATION}; FAILED!" >> $RAW_TIMING_OUT
      else
        RUN_DAG=`cat ${OUTPUT} | grep "Run DAG" | tr -s ' ' | cut -d " " -f 5`
        TOTAL_TIME=`cat ${OUTPUT} | grep "rows selected" | tr -s ' ' | cut -d "(" -f 2 | cut -d " " -f 1`

        if [ -z "${TOTAL_TIME}" ]
        then
          TOTAL_TIME=`cat ${OUTPUT} | grep "row selected" | tr -s ' ' | cut -d "(" -f 2 | cut -d " " -f 1`
        fi

        echo "Query: ${QUERY_NUM}; iteration: ${ITERATION}; Run Dag: ${RUN_DAG}; Total time: ${TOTAL_TIME}" >> $RAW_TIMING_OUT
      fi
  done

  rm -f $tmp

done

echo "Query, run 1, run 2, run 3, run 4" > $REPORT
cat $RAW_TIMING_OUT | \
  grep "Query\|Total" | \
  sed 's/FAILED!/Run Dag: FAILED; Total time: FAILED/g' | \
  awk -F\; 'BEGIN{OFS=";"; q=""; iter="";} {if ($0 !~ /Total time/) {q=$1; iter=$2; $1=$1"a";print $0"; Total time: 0;"} else if (q != ""){print q"b;"iter"; Run Dag\: "$0; q=""} else {print $0;}}' | \
  sort | \
  sed "s/Query: //g" | cut -d ";" -f 1,3 | sed "s/Run Dag: //g" | datamash -t ";" groupby 1 collapse 2 | sed 's/;/,/g' | sed 's/s//g' | \
  sort -k1n -t\, \
  >> $REPORT