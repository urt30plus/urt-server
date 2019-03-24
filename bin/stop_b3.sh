#!/bin/bash

b3_stdout=/game/logs/b3_run.log

echo "$(date): Stopping b3" >>${b3_stdout}

kill $(cat /game/run/b3.pid) >>${b3_stdout} 2>&1
rm -v /game/run/b3.pid >>${b3_stdout} 2>&1
