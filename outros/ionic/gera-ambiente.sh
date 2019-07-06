#!/bin/bash
# gera um container com ionic 
#  
echo "Criando o container ionic"
lxc copy debian9padrao ionic

echo "Copiando configuracao de rede"
lxc file push ./conf/ionic/interfaces ionic/etc/network/interfaces

echo "Iniciando container"
lxc start ionic

echo "Aguardando 5 segundos para inicialização"
sleep 5

### Instalando repositorio para para instalacao do nodejs e ionic
echo "Instalando e configurando ionic"
lxc exec ionic -- apt update
lxc exec ionic -- apt upgrade -y
lxc exec ionic -- apt install -y curl software-properties-common openssh-server
lxc exec ionic -- bash -c "curl -sL https://deb.nodesource.com/setup_10.x | bash -"
lxc exec ionic -- apt install -y nodejs
lxc exec ionic -- npm install -g ionic cordova

### criando um usuario chamado teste com senha 123456
lxc exec ionic -- /usr/sbin/useradd -m -p $(openssl passwd -1 123456) -s /bin/bash teste
