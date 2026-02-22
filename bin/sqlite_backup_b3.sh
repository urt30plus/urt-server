#!/bin/bash

DB_FILE="$HOME/.config/b3.sqlite"
BACKUP_DIR="${HOME}/backups/$(hostname)/b3_db"

mkdir -p ${BACKUP_DIR}

dt=$(date +"%Y-%m-%d")
BACKUP_FILE="${BACKUP_DIR}/b3_${dt}.sqlite"
LOG_FILE="${BACKUP_DIR}/b3_${dt}.sqlite.log"

echo "starting backup of ${DB_FILE} into file ${BACKUP_FILE}" >${LOG_FILE}
sqlite3 "${DB_FILE}" ".backup '${BACKUP_FILE}'" &>>${LOG_FILE}

echo "delete old backup files"
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.sqlite' -mtime +60 -delete
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.log' -mtime +60 -delete
