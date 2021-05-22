#!/bin/bash

sudo yum install -y nfs-utils nfs-utils-lib net-tools
sudo systemctl enable rpcbind
sudo systemctl enable nfs-server
sudo systemctl enable nfs-lock
sudo systemctl enable nfs-idmap
sudo systemctl start rpcbind
sudo systemctl start nfs-server
sudo systemctl start nfs-lock
sudo systemctl start nfs-idmap

sudo mkdir -p /media/nfs_share
sudo mount -t nfs -o vers=3,udp 192.168.50.10:/usr/local/nfs /media/nfs_share/

echo "192.168.50.10:/usr/local/nfs /media/nfs_share/ nfs rw,vers=3,sync,proto=udp,rsize=32768,wsize=32768 0 0" | sudo tee -a /etc/fstab > /dev/null

sudo systemctl restart remote-fs.target

mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
yum install -y mdadm smartmontools hdparm gdisk
sudo systemctl restart sshd
