#!/bin/bash

# Este script se encarga de instalar Docker en una maquina CentOS 7

echo "Ejecutando $0 a las `date +%H:%M:%S`"

# En caso de error, no seguir con la ejecucion
set -e

# Comprobamos usuario
if [ "$UID" != "0" ]; then
    echo "Es necesario ejecutar este script como el usuario 'root'."
    exit 1
fi

# Actualizar paquetes con yum
# yum -y update

# Instalar dependencias
yum -y install git tar wget epel-release

# Para instalar maven
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo

# Para instalar subversion devel (>1.8)
cat > /etc/yum.repos.d/wandisco-svn.repo <<EOF
[WANdiscoSVN]
name=WANdisco SVN Repo 1.9
enabled=1
baseurl=http://opensource.wandisco.com/centos/7/svn-1.9/RPMS/\$basearch/
gpgcheck=1
gpgkey=http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco
EOF

# Actualizar systemd
SYSTEMD_VERSION=$(systemctl --version | grep systemd | awk '{ print $2 }')
if [ "$SYSTEMD_VERSION" -lt 218 ]; then
    echo "Version de systemd menor a 218: $SYSTEMD_VERSION"
    exit 1
fi
echo "Version de systemd valida: $SYSTEMD_VERSION"

# Instalar development tools
yum groupinstall -y "Development Tools"

# Instalar Maven y otras dependencias de Mesos
for LIB in apache-maven python-devel java-1.8.0-openjdk-devel zlib-devel libcurl-devel openssl-devel cyrus-sasl-devel cyrus-sasl-md5 apr-devel subversion-devel apr-util-devel apr-1.4.8-3.el7.i686 apr-devel curl-devel cyrus-sasl subversion-devel; do
    yum install -y $LIB
done

# Compilar mesos
if [ ! -d /opt/mesos ]; then
    mkdir /opt/mesos
    cd /tmp
    wget http://www.apache.org/dist/mesos/1.1.0/mesos-1.1.0.tar.gz
    tar xzf mesos-1.1.0.tar.gz -C /opt/mesos
fi

# Compilar e instalar Mesos
cd /opt/mesos/mesos-1.1.0
./bootstrap
./configure
make

#export JAVA_HOME=/usr/lib/jvm/java-1.8.0/bin
#export PATH=$PATH:$JAVA_HOME/bin

echo "Ejecucion de $0 finalizada a las `date +%H:%M:%S`"

