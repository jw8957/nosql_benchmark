#!/bin/bash

killall -9 memcached
./memcached -d -m 1024 -c 10000
