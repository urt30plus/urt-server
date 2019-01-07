#!/bin/bash
URT_HOME=/ssd/urt/UrbanTerror43
GAMESLOG_ARCHIVE_DIR=${HOME}/backups/game_logs

GAMESLOG_FILE=${URT_HOME}/q3ut4/games.log
ARCHIVE_FILE=${GAMESLOG_ARCHIVE_DIR}/gameslog_backup_$(date +"%Y-%m-%d").tar.gz

if [[ ! -e "${GAMESLOG_FILE}" ]]; then
    echo "$(date): games.log file not found: ${GAMESLOG_FILE}"
    exit 1
fi

echo "$(date): archiving backup to ${ARCHIVE_FILE}"
tar cvfz "${ARCHIVE_FILE}" "${GAMESLOG_FILE}"

echo "$(date): deleting games.log"
rm -vf "${GAMESLOG_FILE}"

echo "$(date): delete old archived backup files"
find ${GAMESLOG_ARCHIVE_DIR}/ -mindepth 1 -type f -name '*.tar.gz' -mtime +180 -delete
