# Задание
NFS:
vagrant up должен поднимать 2 виртуалки: сервер и клиент на сервер должна быть расшарена директория на клиента она должна автоматически монтироваться при старте (fstab или autofs) в шаре должна быть папка upload с правами на запись
требования для NFS: NFSv3 по UDP, включенный firewall
Настроить аутентификацию через KERBEROS (NFSv4)

# Описание

Для проверки задание необходимо Vagrant up
Будут развернуты две веритальные машины.
во время разворачивание будут запускаться скрипты nfsc_script.sh и nfss_script.sh 
Результатом будет выполнено монтирование HFS шары nfss на nfsc   

