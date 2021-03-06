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

sudo mkdir -p /usr/local/nfs
sudo mkdir -p /usr/local/nfs/upload
sudo chmod -R 777 /usr/local/nfs

echo "/usr/local/nfs *(rw,all_squash,root_squash,anonuid=1001,anongid=1001)" | sudo tee -a /etc/exports > /dev/null
sudo exportfs -r
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
sudo firewall-cmd --permanent --add-port=111/udp
sudo firewall-cmd --permanent --add-port=54302/udp
sudo firewall-cmd --permanent --add-port=20048/udp
sudo firewall-cmd --permanent --add-port=2049/udp
sudo firewall-cmd --permanent --add-port=46666/udp
sudo firewall-cmd --permanent --add-port=42955/udp
sudo firewall-cmd --permanent --add-port=875/udp
sudo firewall-cmd --permanent --zone=public --add-service=nfs
sudo firewall-cmd --permanent --zone=public --add-service=mountd
sudo firewall-cmd --permanent --zone=public --add-service=rpc-bind
sudo firewall-cmd --reload

mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
yum install -y mdadm smartmontools hdparm gdisk
sudo systemctl restart sshd
