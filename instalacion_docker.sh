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
yum -y update

# Aniadir el repositorio de Docker
tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

# Instalamos docker-engine
yum -y install docker-engine

# Activamos el servicio
systemctl enable docker.service

# Iniciamos el servicio
systemctl start docker

# Probar la ejecucion de contenedores
docker run --rm hello-world

# Configurar docker para el usuario dit
if ! grep -q docker /etc/group; then
    groupadd docker
fi
usermod -aG docker dit

# Probar docker en el usuario dit
su dit -c "docker run --rm hello-world"

# Configuramos Docker para que se inicie al arrancar
systemctl enable docker

echo "Ejecucion de $0 finalizada a las `date +%H:%M:%S`"

