#!/bin/bash
B3_DB_FILE="/game/run/b3_db.sqlite"
BACKUP_DIR="/game/backups/b3_db"
GDRIVE_BACKUP_DIR="${HOME}/gdrive/backups/$(hostname)/b3_db"

dt=$(date +"%Y-%m-%d")
BACKUP_FILE="${BACKUP_DIR}/b3_db_${dt}.sqlite"
LOG_FILE="${BACKUP_DIR}/b3_db_${dt}.log"

echo "starting backup of ${B3_DB_FILE} into file ${BACKUP_FILE}" >${LOG_FILE}
sqlite3 "${B3_DB_FILE}" ".backup '${BACKUP_FILE}'" &>>${LOG_FILE}

echo "delete old backup files"
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.sqlite' -mtime +60 -delete
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.log' -mtime +60 -delete

echo "archiving backup to Google Drive"
cp --verbose "${BACKUP_FILE}" "${GDRIVE_BACKUP_DIR}/b3_db.sqlite"
