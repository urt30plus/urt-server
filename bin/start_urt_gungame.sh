#!/bin/bash

urt_base=/game/servers/base434
urt_home=/game/servers/gungame_d3mod
urt_stdout=/game/logs/urt43_run_gungame.log

echo "$(date): Starting UrT 4.3" >${urt_stdout}

#URT_EXE="${urt_home}/Quake3-UrT-Ded.x86_64"
URT_EXE="/game/ioq3urt-d3mod/Quake3-UrT-Ded.x86_64"

nohup ${URT_EXE} \
	+set fs_game q3ut4 \
	+set fs_basepath ${urt_base} \
	+set fs_homepath ${urt_home} \
	+set dedicated 2 \
	+set net_port 27963 \
	+set com_hunkmegs 512 \
	+set ttycon 0 \
	+exec server.cfg >/dev/null 2>>${urt_stdout} &

URT_PID=$!
echo $URT_PID >/game/run/urt43_gungame.pid
