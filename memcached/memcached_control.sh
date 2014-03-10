#!/bin/bash

BIN=$1

killall -9 memcached
${BIN} -d -m 1024 -c 10000
