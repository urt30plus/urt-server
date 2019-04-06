#!/bin/bash

urt_home=/game/UrbanTerror43
urt_stdout=/game/logs/urt43_run.log

if [[ -z $URT_EXE ]]; then
    URT_EXE="${urt_home}/Quake3-UrT-Ded.x86_64"
    echo "$(date): env var URT_EXE not set, defaulting to [${URT_EXE}]" >${urt_stdout}
else
    echo "$(date): env var URT_EXE set to [${URT_EXE}]" >${urt_stdout}
fi

echo "$(date): Starting UrT 4.3" >${urt_stdout}

nohup ${URT_EXE} \
	+set fs_game q3ut4 \
	+set fs_basepath ${urt_home} \
	+set fs_homepath ${urt_home} \
	+set dedicated 2 \
	+set net_port 27961 \
	+set com_hunkmegs 128 \
	+set ttycon 0 \
	+exec server.cfg >/dev/null 2>>${urt_stdout} &

echo $! >/game/run/urt43.pid
