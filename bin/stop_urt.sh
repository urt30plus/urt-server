#!/bin/bash

urt_home=/ssd/game/UrbanTerror43
urt_stdout=/ssd/game/logs/urt43_run.log

echo "$(date): Stopping UrT 4.3" >>${urt_stdout}

kill $(cat /ssd/game/run/urt43.pid) >>${urt_stdout} 2>&1
rm -v /ssd/game/run/urt43.pid >>${urt_stdout} 2>&1
