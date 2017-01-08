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

# Instalar development tools
yum groupinstall -y "Development Tools"

yum install golang

# Compilar Docker
if [ ! -d /tmp/docker ]; then
    mkdir /tmp/docker
    cd /tmp/docker
    git clone https://github.com/docker/docker.git
    cd docker
    make build
    make binary
fi


echo "Ejecucion de $0 finalizada a las `date +%H:%M:%S`"

