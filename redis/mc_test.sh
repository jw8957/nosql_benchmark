#!/bin/bash

source config.sh

# config items
# BIN=redis-benchmark
# BIN=/home/jw8957/jiwei03/github/mc_benchmark/mc-benchmark/mc-benchmark
# BIN=/home/jw8957/jiwei03/github/mc_benchmark/mc-benchmark/mc-benchmark
# payload=32
# iterations=100000
# keyspace=100000
# max_clients=300


if [ $# -lt 1 ];then
	echo "Usage: ./mc_test.sh"
	exit 1
fi

i=0
op=$1

set -x

rm -rf "./result_mc_${op}"
while [ $i -le ${max_clients} ]
do
	i=`expr $i + 5`
	SPEED=0
	for dummy in 0 1 2
	do
		#./mc_benchmark/mc-benchmark -n 100000 -r 100000 -d 32 -c 10 -t get
		# S=`$BIN -n $iterations -r $keyspace -d $payload -c $i -t $op | grep 'per second'`
		S=`$BIN -n $iterations -d $payload -c $i -t $op | grep 'per second'`
		SPEED=`echo ${S} | awk '{a=$1;if(a>'${SPEED}') print a;else print '${SPEED}'}'`
	done
	echo "$i $SPEED" >> "./result_mc_${op}"
done
