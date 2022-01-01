#!/bin/bash

urt_gameslog=/game/servers/main/q3ut4/games.log
urt_rcon_port=27961
b3_base=/game/b3
b3_stdout=/game/logs/b3_run.log

echo "$(date): Starting B3" >${b3_stdout}

echo "$(date): Checking for ${urt_gameslog}" >>${b3_stdout}
COUNTER=30
while [[  $COUNTER -gt 0 ]]; do
    if [[ -e "${urt_gameslog}" ]]; then
        echo "$(date): games.log found" >>${b3_stdout}
	break
    fi
    let COUNTER-=1
    echo "$(date): Waiting on games.log, count ${COUNTER}" >>${b3_stdout}
    sleep 2
done

echo "$(date): Checking RCON port ${urt_rcon_port}" >>${b3_stdout}
COUNTER=30
while [[  $COUNTER -gt 0 ]]; do
    udp_port=$(netstat -an | egrep -c "^udp.*0:${urt_rcon_port}")
    if [[ "${udp_port}" != "0" ]]; then
        echo "$(date): RCON port open" >>${b3_stdout}
	sleep 5
	break
    fi
    let COUNTER-=1
    echo "$(date): Waiting on RCON port, count ${COUNTER}" >>${b3_stdout}
    sleep 2
done

TERM=vt100
cd ${b3_base}
nohup ./venv/bin/python3.9 -B -u -m b3 -c ~/.b3/b3.ini >>${b3_stdout} 2>&1 &

B3_PID=$!
echo $B3_PID >/game/run/b3.pid
