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

# Instalamos etcd
yum -y install etcd kubernetes

echo "Ejecucion de $0 finalizada a las `date +%H:%M:%S`"
