#!/bin/bash
DB_FILE="/game/spunkybot/data.sqlite"
BACKUP_DIR="/game/backups/spunkybot_db"
ARCHIVE_DIR="${HOME}/backups/spunkybot_db"
GDRIVE_BACKUP_DIR="${HOME}/gdrive/backups/$(hostname)/spunkybot_db"

dt=$(date +"%Y-%m-%d")
BACKUP_FILE="${BACKUP_DIR}/spunkybot_db_${dt}.sqlite"
LOG_FILE="${BACKUP_DIR}/spunkybot_db_${dt}.log"

echo "starting backup of ${DB_FILE} into file ${BACKUP_FILE}" >${LOG_FILE}
sqlite3 "${DB_FILE}" ".backup '${BACKUP_FILE}'" &>>${LOG_FILE}

echo "delete old backup files"
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.sqlite' -mtime +14 -delete
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.log' -mtime +14 -delete

echo "archiving backup"
ARCHIVE_FILE="${ARCHIVE_DIR}/spunkybot_db_${dt}.sqlite.tar.gz"
tar -czvf "${ARCHIVE_FILE}" -C "${BACKUP_DIR}" $(basename ${BACKUP_FILE}) $(basename ${LOG_FILE})

echo "delete old archived backup files"
find ${ARCHIVE_DIR}/ -mindepth 1 -type f -name '*.sqlite.tar.gz' -mtime +180 -delete

echo "archiving backup to Google Drive"
cp --verbose "${ARCHIVE_FILE}" "${GDRIVE_BACKUP_DIR}/spunkybot_db.sqlite.tar.gz"
