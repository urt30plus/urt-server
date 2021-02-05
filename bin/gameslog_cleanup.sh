#!/bin/bash
GAMESLOG_FILE="/ssd/game/UrbanTerror43/q3ut4/games.log"
GAMESLOG_ARCHIVE_DIR="${HOME}/gdrive/backups/$(hostname)/game_logs"
GAMESLOG_ARCHIVE_FILE="${GAMESLOG_ARCHIVE_DIR}/games.log"

if [[ ! -e "${GAMESLOG_FILE}" ]]; then
    echo "$(date): games.log file not found: ${GAMESLOG_FILE}"
    exit 1
fi

echo "$(date): archiving ${GAMESLOG_FILE}"
cp --verbose --force --backup=simple --suffix=".old" "${GAMESLOG_FILE}" "${GAMESLOG_ARCHIVE_FILE}"

if [[ ! -e "/ssd/game/run/urt43.pid" ]]; then
    rm --verbose --force "${GAMESLOG_FILE}"
fi
