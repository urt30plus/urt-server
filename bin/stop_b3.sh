#!/bin/bash

b3_stdout=/ssd/urt/logs/b3_run.log

echo "$(date): Stopping b3" >>${b3_stdout}

kill $(cat /ssd/urt/b3/logs/b3.pid) >>${b3_stdout} 2>&1
rm -v /ssd/urt/b3/logs/b3.pid >>${b3_stdout} 2>&1
