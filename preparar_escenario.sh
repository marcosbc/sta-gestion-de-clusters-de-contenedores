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

pip install aws

# Instalar ecs-cli
sudo curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-linux-amd64-latest
echo "Configura tus claves ECS con el comando: ecs-cli configure --region us-west-2 --access-key \$AWS_ACCESS_KEY_ID --secret-key \$AWS_SECRET_ACCESS_KEY --cluster ecs-cli-demo"


