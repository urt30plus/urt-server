#!/bin/bash

urt_rcon_port=27961
urt_gameslog=/game/UrbanTerror43/q3ut4/games.log
spunkybot_base=/game/spunkybot
spunkybot_stdout=/game/logs/spunkybot_run.log

echo "$(date): Starting Spunkybot" >${spunkybot_stdout}

echo "$(date): Checking for ${urt_gameslog}" >>${spunkybot_stdout}
COUNTER=30
while [[  $COUNTER -gt 0 ]]; do
    if [[ -e "${urt_gameslog}" ]]; then
        echo "$(date): games.log found" >>${spunkybot_stdout}
	break
    fi
    let COUNTER-=1
    echo "$(date): Waiting on games.log, count ${COUNTER}" >>${spunkybot_stdout}
    sleep 2
done

echo "$(date): Checking RCON port ${urt_rcon_port}" >>${spunkybot_stdout}
COUNTER=30
while [[  $COUNTER -gt 0 ]]; do
    udp_port=$(netstat -an | egrep -c "^udp.*0:${urt_rcon_port}")
    if [[ "${udp_port}" != "0" ]]; then
        echo "$(date): RCON port open" >>${spunkybot_stdout}
	sleep 5
	break
    fi
    let COUNTER-=1
    echo "$(date): Waiting on RCON port, count ${COUNTER}" >>${spunkybot_stdout}
    sleep 2
done

nohup python2 -B -u ${spunkybot_base}/spunky.py >>${spunkybot_stdout} 2>&1 &

SPUNKYBOT_PID=$!
echo $SPUNKYBOT_PID >/game/run/spunkybot.pid
