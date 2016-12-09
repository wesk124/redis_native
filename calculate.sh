#!/bin/bash

# set -euo pipefail

# results data processing and  calculate the average and standard
# deviation.


POSTFIX=".dat"
TEMP="temp"
CURRENT_PATH=`pwd`

#echo -n "" > set_temp$1$POSTFIX;
#echo -n "" > get_temp$1$POSTFIX;
echo -n "" > result$1".csv";

# First need to process data file
for i in `seq 0 $1`; do
	cat $CURRENT_PATH/"data"$1/sev$i.csv | grep "SET" | cut -d "," -f 2 | cut -d "\"" -f 2 >> $CURRENT_PATH/data$1/"set_temp$1$POSTFIX";
done


for j  in `seq 0 $1`; do
	cat $CURRENT_PATH/"data"$1/sev$j.csv | grep "GET" | cut -d "," -f 2 | cut -d "\"" -f 2 >> $CURRENT_PATH/data$1/"get_temp$1$POSTFIX"
done



cat $CURRENT_PATH/data$1/set_temp$1$POSTFIX | awk  '{sum += $1; sumsq += ($1 * $1) } END {sqd = sumsq / NR - (sum / NR)^2; if(sqd < 10^-8) sqd = 0; print "set"  ", "sum / NR ", " sqrt(sqd)}' >> "result"$1".csv"


cat $CURRENT_PATH/data$1/get_temp$1$POSTFIX | awk  '{sum += $1; sumsq += ($1 * $1) } END {sqd = sumsq / NR - (sum / NR)^2; if(sqd < 10^-8) sqd = 0; print "get"  ", "sum / NR ", " sqrt(sqd)}' >> "result"$1".csv"


echo "please check the result in result$1.csv"
