#!/bin/bash

urt_home=/ssd/urt/UrbanTerror43
urt_stdout=/ssd/urt/logs/urt43_run.log

echo "$(date): Stopping UrT 4.3" >>${urt_stdout}

kill $(cat /ssd/urt/run/urt43.pid) >>${urt_stdout} 2>&1
rm -v /ssd/urt/run/urt43.pid >>${urt_stdout} 2>&1
