#!/bin/bash

export GOROOT=/usr/local/go
export GOPATH=/opt/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Este script se encarga de instalar kubernetes y sus dependencias

echo "Ejecutando $0 a las `date +%H:%M:%S`"

# En caso de error, no seguir con la ejecucion
set -e

# Comprobamos usuario
if [ "$UID" != "0" ]; then
    echo "Es necesario ejecutar este script como el usuario 'root'."
    exit 1
fi

for HOMEDIR in /home/dit /root; do
    if [ -f "$HOMEDIR/.bashrc" ]; then
        if ! grep -q GOPATH=$GOPATH "$HOMEDIR/.bashrc"; then
            echo "export GOPATH=$GOPATH
export PATH=\$PATH:$GOROOT/bin:\$GOPATH/bin" >> "$HOMEDIR/.bashrc"
        fi
    fi
done

# Instalar Mercurial
yum -y install mercurial

# Instalar Go
if [ ! -d /usr/local/go ]; then
    cd /tmp
    wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.7.3.linux-amd64.tar.gz
    rm go1.7.3.linux-amd64.tar.gz
fi

# Nos aseguramos que Go esta presente
which go

# Instalar godep
go get -u github.com/tools/godep
go get -u github.com/jteeuwen/go-bindata/go-bindata

# Nos aseguramos que godep este presente
godep version

# Desactivamos el firewall para evitar problemas con reglas de iptables de Docker
systemctl stop firewalld
systemctl disable firewalld

# Instalamos ntp
yum -y install ntp
systemctl start ntpd
systemctl enable ntpd

# Instalamos etcd
yum -y install etcd

# Obtener el codigo fuente de Kubernetes
if [ ! -d "$GOPATH/src/k8s.io" ]; then
    mkdir -p $GOPATH/src/k8s.io
    cd $GOPATH/src/k8s.io
    git clone https://github.com/kubernetes/kubernetes.git
fi

# Construimos Kubernetes desde el codigo fuente
# Esto se debe a que ... TODO
cd $GOPATH/src/k8s.io/kubernetes
make clean
make
make install

echo "Ejecucion de $0 finalizada a las `date +%H:%M:%S`"
