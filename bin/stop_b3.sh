#!/bin/bash

b3_stdout=/ssd/game/logs/b3_run.log

echo "$(date): Stopping b3" >>${b3_stdout}

kill $(cat /ssd/game/run/b3.pid) >>${b3_stdout} 2>&1
rm -v /ssd/game/run/b3.pid >>${b3_stdout} 2>&1
