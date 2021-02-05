#!/bin/bash

urt_home=/ssd/game/UrbanTerror43_tourney
urt_stdout=/ssd/game/logs/urt43_tourney_run.log

echo "$(date): Stopping UrT 4.3" >>${urt_stdout}

kill $(cat /ssd/game/run/urt43_tourney.pid) >>${urt_stdout} 2>&1
rm -v /ssd/game/run/urt43_tourney.pid >>${urt_stdout} 2>&1
