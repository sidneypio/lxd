#!/bin/bash
# gera um container com nginx e libera acesso para a porta 8080
#  
echo "Criando a maquina n1"
lxc copy debianPadrao n1

echo "Copiando configuracao de rede"
lxc file push ./conf/n1/interfaces n1/etc/network/interfaces

echo "Iniciando container"
lxc start n1

echo "Aguardando 5 segundos para inicialização"
sleep 5

### NGINX
echo "Instalando e configurando nginx"
lxc exec n1 -- apt update
lxc exec n1 -- apt upgrade
lxc exec n1 -- apt install nginx

