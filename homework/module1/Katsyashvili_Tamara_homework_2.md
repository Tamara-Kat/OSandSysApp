# Homework_2 Файлова система і права доступу
## Завдання 1. Ієрархія каталогів Linux
### Виконані команди
```bash
cd /
ls

cd /etc
ls

cd /home
ls

```
![Скріншот](scr\hw2\1.1.jpg)

![](scr\hw2\1.2.jpg)

## Завдання 2. Файли, каталоги та посилання
### Виконані команди

```bash
cd ~ mkdir lab2
cd lab2 echo "Homework_2" > file.txt 
cp file.txt file_copy.txt
mv file_copy.txt renamed.txt
ln -s file.txt symlink.txt 
cd ~ find . -name file.txt
```
### Результат

```
./lab2/file.txt
```
![Скріншот](scr\hw2\2.1.jpg)


## Завдання 3. Права доступу

### Виконані команди

```bash
cd ~/lab2
ls -l file.txt
chmod 444 file.txt
chmod u+w file.txt
umask
umask 022
umask
```
![Скріншот](scr\hw2\3.1.jpg)

## Завдання 4. Користувачі

### Виконані команди

```
Було виконано спробу створення нового користувача та додавання його до групи sudo.
```
### Використані команди:

```bash
sudo useradd -m trainee

sudo usermod -aG sudo trainee

grep trainee /etc/passwd
```

```
Під час виконання виникли системні помилки:

bash: /usr/bin/sudo: Input/output error
bash: /usr/sbin/useradd: Input/output error
Bus error

Додаткова перевірка показала, що аналогічні помилки виникають і для інших системних утиліт (which, file, dmesg), що свідчить про проблему середовища Lubuntu у VirtualBox.

Через пошкодження системних утиліт створення користувача завершити не вдалося.
```
![Скріншот](scr\hw2\4.1.jpg)


