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

BUILD_DIR=/tmp/rkt_install

if [ ! -d "$BUILD_DIR" ]; then
    mkdir -p $BUILD_DIR
    cd $BUILD_DIR
    # Instalacion de requisitos para construir imagenes de contenedores
    yum install -y golang git
    # Instalar acbuild
    git clone https://github.com/containers/build.git
    cd build
    ./build
    mv bin/acbuild /usr/bin
fi

# Instalacion de paquete RPM de rkt
# https://coreos.com/rkt/docs/latest/distributions.html#rpm-based
if ! which rkt; then
    cd $BUILD_DIR
    wget https://github.com/coreos/rkt/releases/download/v1.21.0/rkt-1.21.0-1.x86_64.rpm
    sudo rpm -Uvh rkt-1.21.0-1.x86_64.rpm
fi

echo "Ejecucion de $0 finalizada a las `date +%H:%M:%S`"

