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

# Instalacion de paquete RPM
# https://coreos.com/rkt/docs/latest/distributions.html#rpm-based
gpg --recv-key 18AD5014C99EF7E3BA5F6CE950BDD3E0FC8A365E
wget https://github.com/coreos/rkt/releases/download/v1.21.0/rkt-1.21.0-1.x86_64.rpm
wget https://github.com/coreos/rkt/releases/download/v1.21.0/rkt-1.21.0-1.x86_64.rpm.asc
gpg --verify rkt-1.21.0-1.x86_64.rpm.asc
sudo rpm -Uvh rkt-1.21.0-1.x86_64.rpm

echo "Ejecucion de $0 finalizada a las `date +%H:%M:%S`"

