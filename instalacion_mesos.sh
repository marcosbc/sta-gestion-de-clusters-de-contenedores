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

sudo rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
sudo yum install -y mesos marathon

echo "Ejecucion de $0 finalizada a las `date +%H:%M:%S`"

