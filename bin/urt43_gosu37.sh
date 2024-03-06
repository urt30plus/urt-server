#!/bin/bash

server=gosu37
action=${1}

urt_base=/game/UrbanTerror43
urt_home=/game/servers/${server}
urt_env=/game/etc/urt43_${server}.env
urt_stdout=/game/logs/urt43_run_${server}.log
urt_pidfile=/game/run/urt43_${server}.pid

if [[ ! -d ${urt_home} ]]; then
    echo "invalid server [${server}], missing home: $urt_home"
    exit 1
fi

if [[ ! -e ${urt_env} ]]; then
    echo "missing env file: $urt_env"
    exit 1
fi

source "${urt_env}"

if [[ $action == "stop" ]]; then
    if [[ ! -e $urt_pidfile ]]; then
        echo "pidfile not found: $urt_pidfile" >>${urt_stdout}
        exit 1
    fi
    kill $(cat $urt_pidfile) >>${urt_stdout} 2>&1
    rm -v $urt_pidfile >>${urt_stdout} 2>&1
    exit
fi

echo "$(date): Starting UrT 4.3 ${server}" >${urt_stdout}

if [[ -z $URT_EXE ]]; then
    URT_EXE="${urt_base}/Quake3-UrT-Ded.x86_64"
    echo "$(date): env var URT_EXE not set defaulting to [${URT_EXE}]" >>${urt_stdout}
else
    echo "$(date): env var URT_EXE set to [${URT_EXE}]" >>${urt_stdout}
fi

nohup ${URT_EXE} \
	+set fs_game q3ut3 \
	+set fs_basepath ${urt_base} \
	+set fs_homepath ${urt_home} \
	+set dedicated 2 \
	+set net_port ${URT_PORT} \
	+set com_hunkmegs 512 \
	+set ttycon 0 \
	+exec server.cfg >/dev/null 2>>${urt_stdout} &

URT_PID=$!
echo $URT_PID >${urt_pidfile}
