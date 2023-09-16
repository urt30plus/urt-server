#!/bin/bash

server=${1}

if [[ $server != "main" && $server != "ts" ]]; then
    echo "invalid server: $server"
    exit 1
fi

DB_FILE="/game/run/b3_db_${server}.sqlite"
BACKUP_DIR="/game/backups/b3_db"
GDRIVE_BACKUP_DIR="${HOME}/gdrive/backups/$(hostname)/b3_db"

dt=$(date +"%Y-%m-%d")
BACKUP_FILE="${BACKUP_DIR}/b3_db_${server}_${dt}.sqlite"
LOG_FILE="${BACKUP_DIR}/b3_db_${server}_${dt}.log"

echo "starting backup of ${DB_FILE} into file ${BACKUP_FILE}" >${LOG_FILE}
sqlite3 "${DB_FILE}" ".backup '${BACKUP_FILE}'" &>>${LOG_FILE}

echo "delete old backup files"
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.sqlite' -mtime +60 -delete
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.log' -mtime +60 -delete

echo "archiving backup to Google Drive"
cp --verbose "${BACKUP_FILE}" "${GDRIVE_BACKUP_DIR}/b3_db_${server}.sqlite"
