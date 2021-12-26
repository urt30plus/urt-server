#!/bin/bash

urt_stdout=/game/logs/urt43_run_main.log

echo "$(date): Stopping UrT 4.3" >>${urt_stdout}

kill $(cat /game/run/urt43_main.pid) >>${urt_stdout} 2>&1
rm -v /game/run/urt43_main.pid >>${urt_stdout} 2>&1
