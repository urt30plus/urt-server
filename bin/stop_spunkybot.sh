#!/bin/bash

spunkybot_stdout=/game/logs/spunkybot_run.log

echo "$(date): Stopping Spunkybot" >>${spunkybot_stdout}

kill $(cat /game/run/spunkybot.pid) >>${spunkybot_stdout} 2>&1
rm -v /game/run/spunkybot.pid >>${spunkybot_stdout} 2>&1
