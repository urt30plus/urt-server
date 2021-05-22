#!/bin/bash
GAMESLOG_FILE="/game/UrbanTerror43/q3ut4/games.log"
GAMESLOG_ARCHIVE_DIR="/game/logs"
GAMESLOG_ARCHIVE_FILE="${GAMESLOG_ARCHIVE_DIR}/games.log"

if [[ ! -e "${GAMESLOG_FILE}" ]]; then
    echo "$(date): games.log file not found: ${GAMESLOG_FILE}"
    exit 1
fi

echo "$(date): archiving ${GAMESLOG_FILE}"
cp --verbose --force --backup=simple --suffix=".old" "${GAMESLOG_FILE}" "${GAMESLOG_ARCHIVE_FILE}"

if [[ ! -e "/game/run/urt43.pid" ]]; then
    cat /dev/null >"${GAMESLOG_FILE}"
fi
