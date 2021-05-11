#!/bin/bash

urt_home=/game/UrbanTerror43_tourney
urt_stdout=/game/logs/urt43_tourney_run.log

echo "$(date): Stopping UrT 4.3" >>${urt_stdout}

kill $(cat /game/run/urt43_tourney.pid) >>${urt_stdout} 2>&1
rm -v /game/run/urt43_tourney.pid >>${urt_stdout} 2>&1
