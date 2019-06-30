#!/bin/bash
# gera um container com nginx e libera acesso para a porta 8080
#  
echo "Criando o container ngnix"
lxc copy debian9Padrao ngnix

echo "Copiando configuracao de rede"
lxc file push ./conf/ngnix/interfaces ngnix/etc/network/interfaces

echo "Iniciando container"
lxc start ngnix

echo "Aguardando 5 segundos para inicialização"
sleep 5

### NGINX
echo "Instalando e configurando nginx"
lxc exec ngnix -- apt update
lxc exec ngnix -- apt upgrade -y
lxc exec ngnix -- apt install -y nginx

###
# redirecionando a porta 8080 para o servidor na porta 80 no container ngnix
lxc config device add ngnix myport8080 proxy listen=tcp:0.0.0.0:8080 connect=tcp:0.0.0.0:80
