#!/bin/bash

urt_base=/game/UrbanTerror43
urt_home=/game/servers/scrim
urt_stdout=/game/logs/urt43_run_scrim.log

echo "$(date): Stopping UrT 4.3" >>${urt_stdout}

kill $(cat /game/run/urt43_scrim.pid) >>${urt_stdout} 2>&1
rm -v /game/run/urt43_scrim.pid >>${urt_stdout} 2>&1
