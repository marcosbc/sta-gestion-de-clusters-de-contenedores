#!/bin/bash

# Este script se encarga de instalar kubernetes y sus dependencias

echo "Ejecutando $0 a las `date +%H:%M:%S`"

# En caso de error, no seguir con la ejecucion
set -e

# Comprobamos usuario
if [ "$UID" != "0" ]; then
    echo "Es necesario ejecutar este script como el usuario 'root'."
    exit 1
fi

# Desactivamos SELinux
set +e
setenforce 0
set -e

# Instalamos Kubeadm, Kubelet, etc.
echo "[kubernetes]
name=Kubernetes
baseurl=http://yum.kubernetes.io/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg" > /etc/yum.repos.d/kubernetes.repo
yum install -y kubelet kubeadm kubectl kubernetes-cni
systemctl enable kubelet && systemctl start kubelet

echo "Ejecucion de $0 finalizada a las `date +%H:%M:%S`"
