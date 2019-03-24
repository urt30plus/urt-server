#!/bin/bash

urt_home=/game/UrbanTerror43
urt_stdout=/game/logs/urt43_run.log

echo "$(date): Stopping UrT 4.3" >>${urt_stdout}

kill $(cat /game/run/urt43.pid) >>${urt_stdout} 2>&1
rm -v /game/run/urt43.pid >>${urt_stdout} 2>&1
