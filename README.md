## Distributed systems of data storage lab work 2

### Задание

Цель работы - на выделенном узле создать и сконфигурировать новый кластер БД Postgres, саму БД, табличные пространства и новую роль, а также произвести наполнение базы в соответствии с заданием. Отчёт по работе должен содержать все команды по настройке, скрипты, а также измененные строки конфигурационных файлов.

#### Этап 1. Инициализация кластера БД

* Директория кластера: `$HOME/quo58`
* Кодировка: ANSI1251
* Локаль: русская
* Параметры инициализации задать через аргументы команды

#### Этап 2. Конфигурация и запуск сервера БД

* Способ подключения: сокет TCP/IP, только localhost
* Номер порта: `9113`
* Остальные способы подключений запретить.
* Способ аутентификации клиентов: по паролю SHA-256
* Настроить следующие параметры сервера БД:
  * `max_connections` 
  * `shared_buffers` 
  * `temp_buffers` 
  * `work_mem` 
  * `checkpoint_timeout` 
  * `effective_cache_size` 
  * `fsync` 
  * `commit_delay`
* Параметры должны быть подобраны в соответствии со сценарием OLAP: 9 одновременных пользователей, пакетная запись/чтение данных по 64МБ. 
* Директория WAL файлов: `$PGDATA/pg_wal `
* Формат лог-файлов: `.log`
* Уровень сообщений лога: `NOTICE` 
* Дополнительно логировать: контрольные точки и попытки подключения

#### Этап 3. Дополнительные табличные пространства и наполнение базы

* Создать новые табличные пространства для временных объектов: `$HOME/hqa17`, `$HOME/hfh15`
* На основе `template1` создать новую базу: `bigbluedisk`
* Создать новую роль, предоставить необходимые права, разрешить подключение к базе.
* От имени новой роли (не администратора) произвести наполнение ВСЕХ созданных баз тестовыми наборами данных. ВСЕ табличные пространства должны использоваться по назначению.
* Вывести список всех табличных пространств кластера и содержащиеся в них объекты.


### Структура

* [search_objects.sql](./search_objects.sql) - скрипт для вывода всех табличных пространств кластера и содержащихся в них объектах
* [search_objects_notice.sql](./search_objects_notice.sql) - альтернативная версия скрипта с печатью в стандартный поток вывода
* [script.sh](./script.sh) - bash-скрипт, запускающий sql-скрипт и выводящий результат его выполнения в стандартный поток вывода


### Использование

```bash
./sсript.sh
```