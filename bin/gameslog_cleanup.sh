#!/bin/bash

server=${1}

if [[ $server != "ctf" && $server != "ts" ]]; then
    echo "invalid server: $server"
    exit 1
fi

GAMESLOG_FILE="$HOME/servers/${server}/q3ut4/games.log"
GAMESLOG_ARCHIVE_DIR="$HOME/logs"
GAMESLOG_ARCHIVE_FILE="${GAMESLOG_ARCHIVE_DIR}/games_${server}.log"

if [[ ! -e "${GAMESLOG_FILE}" ]]; then
    echo "$(date): games.log file not found: ${GAMESLOG_FILE}"
    exit 1
fi

echo "$(date): archiving ${GAMESLOG_FILE}"
cp --verbose --force --backup=simple --suffix=".old" "${GAMESLOG_FILE}" "${GAMESLOG_ARCHIVE_FILE}"
