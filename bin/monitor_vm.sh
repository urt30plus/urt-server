#!/bin/bash

while :
do
    vmstat --unit M --timestamp 2 5
    top -b -n 1 |head -n 14 |tail -n 8
    netstat -anus
    sleep 5
done
