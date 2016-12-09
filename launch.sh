#! /bin/bash

#
#
#
#


NUM_OF_TOTAL_SERVERS=4;
IP_BASE=127.0.0.1;
PORT_BASE=5000;
PREFIX="sev"

#for j in `seq 0 $NUM_OF_SERVERS`; do
#	taskset -c 0 ./redis-3.2.3/src/redis-benchmark -t set,get --csv -h 127.0.0.1 -p $((5000+$j))  > temp$j.csv &
#done


function run_benchmark {
	printf "please enter how many server you want for this run:\n";
	read num_of_servers;
	if [ $num_of_servers -gt $NUM_OF_TOTAL_SERVERS ]; then
		echo "number of servers cannot be greater than number of total servers."
		exit
	fi
	printf "Running $num_of_servers server(s) benchmark will start in 3 secs...\n"
	sleep 3;
	mkdir "data"$((num_of_servers-1))
	for i in `seq 0 $((num_of_servers-1))`; do
		taskset -c 0 ./redis-3.2.3/src/redis-benchmark -t set,get --csv -h $IP_BASE -p $((PORT_BASE+$i)) > `pwd`'/'data$((num_of_servers-1))'/'$PREFIX"$i".csv &
	done
	wait
	printf "this set of experiment finish...\n"
	printf "calculate result...\n"
	./calculate.sh $((num_of_servers-1))
}



echo "start experiment..."
rm -r data*
rm result*.csv
wait
echo "clean old data..."

while true ;
do
	read -p "Continue experiement? (y/n)" answer
		case ${answer:0:1} in 
		y|Y )
			echo Yes;
			run_benchmark;;
		* )
			echo No;
			break;;
		esac

done




