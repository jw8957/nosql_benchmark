#!/bin/bash

if [ $# -lt 1 ];then
	echo "Usage: ./redis_test.sh opreation"
	exit 1
fi


BIN=redis-benchmark
# BIN=./mc-benchmark
payload=32
iterations=100000
keyspace=100000

max_clients=300
i=0
op=$1

set -x

rm -rf "./result_${op}"
while [ $i -le ${max_clients} ]
do
	i=`expr $i + 5`
	SPEED=0
	for dummy in 0 1 2
	do
		S=`$BIN -n $iterations -r $keyspace -d $payload -c $i -t $op | grep 'per second' | tail -1 | cut -f 1 -d'.'`
		if [ $(($S > $SPEED)) != "0" ]
		then
			SPEED=$S
		fi
	done
	echo "$i $SPEED" >> "./result_${op}"
done
