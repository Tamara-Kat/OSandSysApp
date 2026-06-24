# Homework_5 Мережа, SSH та копіювання файлів

## Завдання 1. Мережева діагностика

### Виконані команди
```bash
ip a
ping -c 4 8.8.8.8
ss -tulpn
```

### Коментар до результату:
```
Команда ip a показала мережеві інтерфейси та локальну IP-адресу системи. Команда ping -c 4 8.8.8.8 підтвердила наявність доступу до інтернету. Команда ss -tulpn показала listening-порти та сервіси, які їх використовують.
```

![Скріншот](scr\hw5\1.2.jpg)
![](scr\hw5\1.1.jpg)

## Завдання 2. SSH-доступ з ключами та config

### Виконані команди

```bash
ls -la ~/.ssh
ssh-keygen
ssh-copy-id tamara@localhost
nano ~/.ssh/config
chmod 600 ~/.ssh/config
ssh myserver
```
### Вміст файлу ~/.ssh/config:
```
Host myserver
    HostName localhost
    User tamara
    IdentityFile ~/.ssh/id_ed25519
```
### Коментар до результату:

```
Було створено SSH-ключ id_ed25519 та скопійовано публічний ключ на локальний SSH-сервер за допомогою ssh-copy-id. У файлі ~/.ssh/config створено Host-запис myserver, після чого підключення виконувалося короткою командою ssh myserver без запиту пароля.
```

![Скріншот](scr\hw5\2.jpg)
![](scr\hw5\2.1.jpg)
![](scr\hw5\2.2.jpg)

## Завдання 3. Копіювання файлів між машинами

### Виконані команди

```bash
echo "test" > test.txt

scp test.txt myserver:/home/tamara/test.txt

ssh myserver "mkdir -p /home/tamara/sync_dir"

mkdir -p local_sync
echo "file for rsync" > local_sync/rsync_test.txt

rsync -av local_sync/ myserver:/home/tamara/sync_dir/

sftp myserver

```
### Команди всередині sftp:

```
ls
cd sync_dir
ls
bye

```
### Коментар до результату

Файл test.txt було створено локально та передано на сервер за допомогою scp у каталог /home/tamara/. Після цього було створено директорію /home/tamara/sync_dir та синхронізовано локальну папку local_sync з сервером через rsync. Перевірка наявності файлів виконувалась через sftp.

### Шлях до файлів на сервері:
```
/home/tamara/test.txt
/home/tamara/sync_dir/rsync_test.txt
Команда для перевірки
sftp myserver
```
![Скріншот](scr\hw5\3.1.jpg)
![](scr\hw5\3.2.jpg)

### Висновок

```
У ході виконання роботи було виконано базову мережеву діагностику, налаштовано SSH-доступ за ключами без введення пароля, створено SSH Host-запис у конфігураційному файлі та перевірено передачу файлів між машинами за допомогою scp, rsync і sftp.

```