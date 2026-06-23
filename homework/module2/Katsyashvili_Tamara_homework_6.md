# Homework_6 Bash-скрипт для бекапу логів

## Варіант A — Скрипт бекапу логів.

### Скрипт запускається:

```bash
./backup.sh /path/to/logs /path/to/backup
```
### Код скрипта backup.sh

```bash
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

# Перевірка, що обидва аргументи є існуючими каталогами
if [ ! -d "$LOG_DIR" ] || [ ! -d "$BACKUP_DIR" ]; then
    echo "Usage: ./backup.sh <log_dir><backup_dir>"
    exit 1
fi

# Перевірка lock-файлу
if [ -f "$LOCK_FILE" ]; then
    echo "Backup already running"
    exit 1
fi

# Створення lock-файлу
touch "$LOCK_FILE"

# Видалення lock-файлу при завершенні скрипта
trap 'rm -f "$LOCK_FILE"' EXIT

# Формування імені архіву з датою та часом
DATE=$(date +"%Y-%m-%d_%H-%M")
ARCHIVE_NAME="logs_backup_${DATE}.tar.gz"
ARCHIVE_PATH="${BACKUP_DIR}/${ARCHIVE_NAME}"

# Створення архіву з файлами логів
tar -czf "$ARCHIVE_PATH" -C "$LOG_DIR" .

# Перевірка результату архівації
if [ "$?" -ne 0 ]; then
    echo "Backup failed"
    exit 2
fi

# Отримання повного шляху до архіву
FULL_PATH=$(realpath "$ARCHIVE_PATH")

echo "Backup created: $FULL_PATH"

```

### Короткий опис роботи скрипта:

```
Скрипт backup.sh створює архів із файлами логів.

Спочатку він перевіряє, що користувач передав рівно два аргументи: каталог із логами та каталог для збереження бекапу. Якщо аргументи неправильні або один із каталогів не існує, скрипт виводить повідомлення:

Usage: ./backup.sh <log_dir><backup_dir>

і завершує роботу з кодом 1.

Далі скрипт перевіряє наявність lock-файлу:

/tmp/backup.lock

Якщо такий файл уже існує, скрипт виводить:

Backup already running

і завершує роботу. Це захищає від паралельного запуску кількох копій скрипта.

Після цього скрипт створює архів у форматі .tar.gz. Назва архіву містить дату і час створення:

logs_backup_YYYY-MM-DD_HH-MM.tar.gz

Якщо архівація завершилася з помилкою, скрипт виводить:

Backup failed

і завершується з кодом 2.

Якщо архів створено успішно, скрипт виводить повний шлях до створеного файлу:

Backup created: /full/path/to/archive
```

## Перевірка роботи скрипта

### Створення тестових каталогів
```bash
mkdir -p ~/test_logs
mkdir -p ~/test_backup
```

### Створення тестових логів

```bash
echo "Log line 1" > ~/test_logs/app.log
echo "Error line 1" > ~/test_logs/error.log
```
### Надання прав на виконання скрипта

```bash
chmod +x backup.sh
```
![Скріншот](scr\hw6\1.1.jpg)

### Запуск скрипта з правильними аргументами

```bash
./backup.sh ~/test_logs ~/test_backup
```

### Результат:

```bash
Backup created:  /home/tamara/test_backup/logs_backup_2026-06-23_16-54.tar.gz
```

### Перевірка створеного архіву

```bash
ls -l ~/test_backup
```
![Скріншот](scr\hw6\1.2.jpg)
## Перевірка помилкових сценаріїв
### Запуск без аргументів

```bash
./backup.sh
```

### Очікуваний результат:

```bash
Usage: ./backup.sh <log_dir><backup_dir>

```
### Запуск з неіснуючим каталогом

```bash
./backup.sh ~/wrong_logs ~/test_backup

```
### Очікуваний результат:

```bash
Usage: ./backup.sh <log_dir><backup_dir>
```
## Перевірка захисту від паралельного запуску

```bash
touch /tmp/backup.lock
./backup.sh ~/test_logs ~/test_backup
rm /tmp/backup.lock
```

### Очікуваний результат:

```bash
Backup already running
```

![Скріншот](scr\hw6\1.3.jpg)

### Висновок
```
У роботі було створено Bash-скрипт для резервного копіювання логів. Скрипт перевіряє аргументи, використовує lock-файл для захисту від паралельного запуску, створює архів із датою та часом у назві, а також перевіряє успішність виконання архівації.

```
