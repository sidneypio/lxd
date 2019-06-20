#!/bin/bash
# gera um container com ionic 
#  
echo "Criando o container ionic"
lxc copy debianPadrao ionic

echo "Copiando configuracao de rede"
lxc file push ./conf/ionic/interfaces ionic/etc/network/interfaces

echo "Iniciando container"
lxc start ionic

echo "Aguardando 5 segundos para inicialização"
sleep 5

### NGINX
echo "Instalando e configurando ionic"
lxc exec ionic -- apt update
lxc exec ionic -- apt upgrade -y

###
# redirecionando a porta 8080 para o servidor na porta 80 na maquina n1
lxc config device add ionic myport8080 proxy listen=tcp:0.0.0.0:8080 connect=tcp:localhost:80
