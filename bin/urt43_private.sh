#!/bin/bash

urt_slot=${1}
urt_action=${2}

urt_base=/game/UrbanTerror43
urt_home=/game/servers/private
urt_port="279${urt_slot}"
urt_stdout=/game/logs/urt43_run_private_${urt_slot}.log
urt_pidfile=/game/run/urt43_private_${urt_slot}.pid
urt_games_log="games_${urt_slot}.log"
urt_cfg="server_${urt_slot}.cfg"
urt_cfg_path="${urt_home}/q3ut4/${urt_cfg}"

if [[ ! -e ${urt_cfg_path} ]]; then
   echo "invalid slot [${urt_slot}], server cfg not found: ${urt_cfg_path}"
   exit 1
fi

echo "$(date): UrT 4.3 private $urt_action" >${urt_stdout}

if [[ $urt_action == "stop" ]]; then
    if [[ ! -e $urt_pidfile ]]; then
        echo "pidfile not found: $urt_pidfile" >>${urt_stdout}
	exit 1
    fi
    kill $(cat $urt_pidfile) >>${urt_stdout} 2>&1
    rm -v $urt_pidfile >>${urt_stdout} 2>&1
    exit
fi

nohup ${urt_base}/Quake3-UrT-Ded.x86_64 \
	+set fs_game q3ut4 \
	+set fs_basepath ${urt_base} \
	+set fs_homepath ${urt_home} \
	+set dedicated 2 \
	+set net_port $urt_port \
	+set com_hunkmegs 512 \
	+set g_log "games_${urt_slot}.log" \
	+set ttycon 0 \
	+exec $urt_cfg >/dev/null 2>>${urt_stdout} &

echo $! >"${urt_pidfile}"
