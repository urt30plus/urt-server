#!/bin/bash

urt_stdout=/game/logs/urt43_run_gungame.log

echo "$(date): Stopping UrT 4.3" >>${urt_stdout}

kill $(cat /game/run/urt43_gungame.pid) >>${urt_stdout} 2>&1
rm -v /game/run/urt43_gungame.pid >>${urt_stdout} 2>&1
