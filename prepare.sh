#!/bin/bash
#
#
#
#

NUM_OF_SERVERS=32
PORT_BASE=5000
for i in `seq 0 $((NUM_OF_SERVERS-1))`; do
	taskset -c $((1+$i)) redis-3.2.3/src/redis-server --daemonize yes --port $((5000+$i)) --protected-mode no & 
	wait
done



