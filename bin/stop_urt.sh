#!/bin/bash

urt_home=/ssd/urt/UrbanTerror43
urt_stdout=/ssd/urt/logs/urt43_run.log

echo "$(date): Stopping UrT 4.3" >>${urt_stdout}

kill $(cat ${urt_home}/urt43.pid) >>${urt_stdout} 2>&1
rm -v ${urt_home}/urt43.pid >>${urt_stdout} 2>&1
