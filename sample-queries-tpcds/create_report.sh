#!/bin/sh

RAW_TIMING_OUT=raw_timing.txt
REPORT=report.csv

echo "Query, run 1, run 2, run 3, run 4" > $REPORT
cat $RAW_TIMING_OUT | \
  grep "Query\|Total" | \
  sed 's/FAILED!/Run Dag: FAILED; Total time: FAILED/g' | \
  awk -F\; 'BEGIN{OFS=";"; q=""; iter="";} {if ($0 !~ /Total time/) {q=$1; iter=$2; $1=$1"a";print $0"; Total time: 0;"} else if (q != ""){print q"b;"iter"; Run Dag\: "$0; q=""} else {print $0;}}' | \
  sort | \
  sed "s/Query: //g" | cut -d ";" -f 1,3 | sed "s/Run Dag: //g" | datamash -t ";" groupby 1 collapse 2 | sed 's/;/,/g' | sed 's/s//g' | \
  sort -k1n -t\, \
  >> $REPORT