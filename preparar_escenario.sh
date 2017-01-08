#!/bin/bash

# Instalar VirtualBox
cd /etc/yum.repos.d
wget http://download.virtualbox.org/virtualbox/rpm/rhel/virtualbox.repo
yum --enablerepo=epel install -y dkms
yum install -y VirtualBox-5.1


# Instalar Docker machine
if [ ! -f /usr/local/bin/docker-machine ]; then
    curl -L https://github.com/docker/machine/releases/download/v0.9.0-rc2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
      chmod +x /tmp/docker-machine &&
      sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
fi
