# Homework_3 Пакети, сервіси та журнали

## Завдання 1. Менеджери пакетів
 
```
Оновлення списку пакетів

sudo apt update

Встановлення пакета tree

sudo apt install tree

Перевірка встановлення та версії

tree --version

dpkg -l | grep tree

Видалення пакета

sudo apt remove tree

dpkg -l | grep tree
```
### Результат

Було оновлено список пакетів системи, встановлено пакет tree, перевірено його версію та наявність у системі. Після цього пакет було успішно видалено.

![Скріншот](scr\hw4\1.1.jpg)
![](scr\hw4\1.2.jpg)


## Завдання 2. Керування сервісами через systemctl

```
Перевірка статусу сервісу cron

systemctl status cron

Зупинка сервісу

sudo systemctl stop cron

systemctl status cron

Запуск сервісу

sudo systemctl start cron

systemctl status cron

Додавання в автозавантаження

sudo systemctl enable cron

systemctl is-enabled cron
```
### Результат

Було перевірено статус сервісу cron, виконано його зупинку та повторний запуск. Також сервіс було додано до автозавантаження системи.

![Скріншот](scr\hw4\2.1.jpg)
![](scr\hw4\2.2.jpg)

## Завдання 3. Робота з логами
```
Перегляд останніх записів журналу

cd /var/log

tail -n 10 syslog

Перегляд системних помилок

journalctl -p err -n 20

Пошук записів про сервіс cron

journalctl -u cron -n 20
```
### Результат

Було переглянуто останні записи системного журналу, отримано список повідомлень рівня помилок та знайдено записи про запуск і роботу сервісу cron.

![Скріншот](scr\hw4\3.1.jpg)
![](scr\hw4\3.2.jpg)

## Завдання 4. Створення власного сервісу


### Створення Bash-скрипта

Файл myscript.sh:
```bash
#!/bin/bash

while true
do
    date >> /home/tamara/myscript_output.txt
    sleep 1
done
```
### Надання прав на виконання:
```
chmod +x ~/myscript.sh
Створення systemd-сервісу
```
Файл /etc/systemd/system/myscript.service:
```bash
[Unit]
Description=My custom date logging script

[Service]
ExecStart=/home/tamara/myscript.sh
Restart=always
User=tamara

[Install]
WantedBy=multi-user.target
```
```
Перезапуск конфігурації systemd

sudo systemctl daemon-reload

Запуск сервісу

sudo systemctl start myscript.service

systemctl status myscript.service

Перевірка роботи сервісу

tail -n 10 ~/myscript_output.txt

sleep 3

tail -n 10 ~/myscript_output.txt

Додавання сервісу в автозавантаження

sudo systemctl enable myscript.service

systemctl is-enabled myscript.service
```
### Результат

Було створено власний Bash-скрипт, який щосекунди записує поточну дату та час у текстовий файл. Для автоматичного запуску скрипта створено сервіс myscript.service. Після запуску сервісу було перевірено його статус та підтверджено, що дані успішно записуються у файл. Сервіс також додано до автозавантаження системи.

![Скріншот](scr\hw4\4.1.jpg)
![](scr\hw4\4.2.jpg)

