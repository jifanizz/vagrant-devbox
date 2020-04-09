#!/usr/bin/env bash
echo "Updating System"
apt-get -qq update

echo "Installing Python3"
add-apt-repository -y ppa:deadsnakes/ppa
apt-get -qq update
apt-get install -qq python3.6
apt-get install -qq python3-pip
apt-get install -qq python3.6-venv
apt-get install -qq python3.6-dev


echo "Install Additional Packages"
apt-get install -qq build-essential
apt-get install -qq git
apt-get install -qq python-pip
apt-get install -qq python-virtualenv

echo "Fix SSH Issue"
sed -i s/'PasswordAuthentication no'/'PasswordAuthentication yes'/g /etc/ssh/sshd_config
systemctl restart sshd

echo "Install Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get -qq update
apt-get install -qq docker-ce
usermod -aG docker vagrant

echo "Install Samba"
apt-get install -qq samba
cat /home/vagrant/samba-update.conf >> /etc/samba/smb.conf
service smbd restart
## need to perform smbpasswd -a username

echo "Update Prompt"
cat /home/vagrant/git-prompt >> /home/vagrant/.bashrc

echo "NSO Installation"
apt-get -qq install openjdk-8-jdk
apt-get -qq install ant
apt-get -qq install xsltproc
apt-get -qq install make
echo JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 >> /etc/environment
sh nso-5.3.1.linux.x86_64.installer.bin --local-install nso-5.3
chown vagrant /home/vagrant/nso-5.3
chgrp vagrant /home/vagrant/nso-5.3
chown vagrant -R /home/vagrant/nso-5.3/*
chgrp vagrant -R /home/vagrant/nso-5.3/*


echo "Ansible Installation"
apt-get -qq update
apt-get install -qq software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt-get -qq install ansible

echo "Ready!"
