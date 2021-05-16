#!/bin/bash

sudo yum install -y nfs-utils nfs-utils-lib

sudo systemctl enable rpcbind 
sudo systemctl enable nfs-server
sudo systemctl enable nfs-lock
sudo systemctl enable nfs-idmap
sudo systemctl start rpcbind
sudo systemctl start nfs-server
sudo systemctl start nfs-lock
sudo systemctl start nfs-idmap

sudo mkdir -p /backup/nfs_otus
sudo chmod -R 777 /backup/nfs_otus
sudo chown -R nfsnobody:nfsnobody /backup/nfs_otus
sudo mkdir -p /backup/nfs_otus/upload

echo "/backup/nfs_otus 192.168.50.0/24 (rw,sync,no_root_squash,no_all_squash)" | sudo tee -a /etc/exports > /dev/null

sudo systemctl restart nfs-server
sudo systemctl enable firewalld
sudo systemctl start firewalld

sudo firewall-cmd --permanent --add-port=111/tcp
sudo firewall-cmd --permanent --add-port=54302/tcp
sudo firewall-cmd --permanent --add-port=20048/tcp
sudo firewall-cmd --permanent --add-port=2049/tcp
sudo firewall-cmd --permanent --add-port=46666/tcp
sudo firewall-cmd --permanent --add-port=42955/tcp
sudo firewall-cmd --permanent --add-port=875/tcp
sudo firewall-cmd --permanent --zone=public --add-service=nfs
sudo firewall-cmd --permanent --zone=public --add-service=mountd
sudo firewall-cmd --permanent --zone=public --add-service=rpc-bind
sudo firewall-cmd --reload

mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
yum install -y mdadm smartmontools hdparm gdisk
sudo systemctl restart sshd
