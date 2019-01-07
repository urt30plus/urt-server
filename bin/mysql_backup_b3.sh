#!/bin/bash
BACKUP_DIR=/ssd/urt/backups/b3
ARCHIVE_DIR=${HOME}/backups/b3_db

if [[ -z $B3_DB_USER ]]; then
    echo "B3_DB_USER env var must be defined"
    exit 1
fi
if [[ -z $B3_DB_PASS ]]; then
    echo "B3_DB_PASS env var must be defined"
    exit 1
fi
if [[ -z $B3_DB_NAME ]]; then
    echo "B3_DB_NAME env var must be defined"
    exit 1
fi

dt=$(date +"%Y-%m-%d")
BACKUP_FILE=${BACKUP_DIR}/${B3_DB_NAME}_backup_${dt}.dump
LOG_FILE=${BACKUP_DIR}/${B3_DB_NAME}_backup_${dt}.log

echo "starting backup of ${B3_DB_NAME} into file ${BACKUP_FILE}" >${LOG_FILE}
mysqldump -u ${B3_DB_USER} -p${B3_DB_PASS} ${B3_DB_NAME} >${BACKUP_FILE} 2>>${LOG_FILE}

echo "delete old backup files"
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.dump' -mtime +14 -delete
find ${BACKUP_DIR}/ -mindepth 1 -type f -name '*.log' -mtime +14 -delete

echo "archiving backup"
tar cvfz "${ARCHIVE_DIR}/${B3_DB_NAME}_backup_${dt}.tar.gz" ${BACKUP_FILE} ${LOG_FILE}

echo "delete old archived backup files"
find ${ARCHIVE_DIR}/ -mindepth 1 -type f -name '*.tar.gz' -mtime +180 -delete
