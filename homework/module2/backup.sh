#!/bin/bash

# Lock-файл для захисту від паралельного запуску
LOCK_FILE="/tmp/backup.lock"

# Перевірка кількості аргументів
if [ "$#" -ne 2 ]; then
    echo "Usage: ./backup.sh <log_dir><backup_dir>"
    exit 1
fi

LOG_DIR="$1"
BACKUP_DIR="$2"

# Перевірка існування каталогів
if [ ! -d "$LOG_DIR" ] || [ ! -d "$BACKUP_DIR" ]; then
    echo "Usage: ./backup.sh <log_dir><backup_dir>"
    exit 1
fi

# Захист від паралельного запуску
if [ -f "$LOCK_FILE" ]; then
    echo "Backup already running"
    exit 1
fi

# Створення lock-файлу
touch "$LOCK_FILE"

# Автоматичне видалення lock-файлу при завершенні
trap 'rm -f "$LOCK_FILE"' EXIT

# Формування імені архіву
DATE=$(date +"%Y-%m-%d_%H-%M")
ARCHIVE_NAME="logs_backup_${DATE}.tar.gz"
ARCHIVE_PATH="${BACKUP_DIR}/${ARCHIVE_NAME}"

# Створення архіву
tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" .

# Перевірка результату
if [ $? -ne 0 ]; then
    echo "Backup failed"
    exit 2
fi

FULL_PATH=$(realpath "$ARCHIVE_PATH")

echo "Backup created: $FULL_PATH"