#!/bin/bash

server=${1}
action=${2}

urt_gameslog=/game/servers/${server}/q3ut4/games.log
urt_env=/game/etc/urt43_${server}.env
b3_base=/game/b3
b3_stdout=/game/logs/b3_run_${server}.log
b3_pidfile=/game/run/b3_${server}.pid

if [[ ! -e ${urt_env} ]]; then
    echo "invalid server [${server}], missing env file: $urt_env"
    exit 1
fi

source "${urt_env}"

if [[ $action == "stop" ]]; then
    if [[ ! -e $b3_pidfile ]]; then
        echo "pidfile not found: $b3_pidfile" >>${b3_stdout}
        exit 1
    fi
    kill $(cat $b3_pidfile) >>${b3_stdout} 2>&1
    rm -v $b3_pidfile >>${b3_stdout} 2>&1
    exit
fi

echo "$(date): Starting B3 ${server}" >${b3_stdout}

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

echo "$(date): Checking RCON port ${URT_PORT}" >>${b3_stdout}
COUNTER=30
while [[  $COUNTER -gt 0 ]]; do
    udp_port=$(netstat -an | egrep -c "^udp.*0:${URT_PORT}")
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
nohup /game/b3/.venv/bin/python -B -u -m b3 -c ~/.b3/b3_${server}.ini >>${b3_stdout} 2>&1 &

B3_PID=$!
echo $B3_PID >${b3_pidfile}
