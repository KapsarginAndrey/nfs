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

sudo mkdir /media/nfs_share
sudo mount -t nfs 192.168.50.10:/backup/nfs_otus/ /media/nfs_share/

echo "192.168.50.10:/backup/nfs_otus/ /media/nfs_share/ nfs rw,sync,hard,intr 0 0" | sudo tee -a /etc/fstab > /dev/null

mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
yum install -y mdadm smartmontools hdparm gdisk
sudo systemctl restart sshd
