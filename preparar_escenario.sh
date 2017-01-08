#!/bin/bash

# Este script se encarga de preparar el segundo escenario (ECS)

echo "Ejecutando $0 a las `date +%H:%M:%S`"

# En caso de error, no seguir con la ejecucion
set -e

# Comprobamos usuario
if [ "$UID" != "0" ]; then
    echo "Es necesario ejecutar este script como el usuario 'root'."
    exit 1
fi

# Instalar PIP
if ! which pip; then
	wget https://bootstrap.pypa.io/get-pip.py
	python get-pip.py
fi

# Configurar credenciales AWS (caducan el 09/01/2017)
# TODO


