#!/bin/bash

b3_stdout=/game/logs/b3_run_scrim.log

echo "$(date): Stopping b3 Scrim" >>${b3_stdout}

kill $(cat /game/run/b3_scrim.pid) >>${b3_stdout} 2>&1
rm -v /game/run/b3_scrim.pid >>${b3_stdout} 2>&1
