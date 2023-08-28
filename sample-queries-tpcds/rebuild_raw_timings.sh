#!/bin/sh

DB=tpcds_partitioned_parquet_1000_iceberg_bk

cd $DB
RAW_TIMING_OUT=raw_timing.txt
rm -fr $RAW_TIMING_OUT

for OUTPUT in `ls -1 query*`
do
  
    QUERY_NUM=`echo $OUTPUT | cut -d "." -f 1 | sed 's/query//g'`
    ITERATION=`echo $OUTPUT | cut -d "." -f 3`
  
    RUN_DAG=`cat ${OUTPUT} | grep "Run DAG" | tr -s ' ' | cut -d " " -f 5`
    TOTAL_TIME=`cat ${OUTPUT} | grep "rows selected" | tr -s ' ' | cut -d "(" -f 2 | cut -d " " -f 1`
    
    if [ -z "${TOTAL_TIME}" ]
    then
      TOTAL_TIME=`cat ${OUTPUT} | grep "row selected" | tr -s ' ' | cut -d "(" -f 2 | cut -d " " -f 1`
    fi
    
    echo "Query: ${QUERY_NUM}; iteration: ${ITERATION}; Run Dag: ${RUN_DAG}; Total time: ${TOTAL_TIME}" >> $RAW_TIMING_OUT
done
