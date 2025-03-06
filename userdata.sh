#!/bin/bash

sudo yum update -y
sudo yum search docker
sudo yum info docker
sudo yum install -y docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl status docker.service
docker --version
sudo yum install git -y
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version


sudo useradd ansible
echo "user is created"
echo "ansible:1234" | sudo chpasswd 
sudo sed -i '/^root\s\+ALL=(ALL)\s\+ALL/a ansible ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
service sshd restart
echo "worker node configuration is done"
