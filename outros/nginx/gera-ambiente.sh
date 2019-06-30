#!/bin/bash
# gera um container com nginx e libera acesso para a porta 8080
#  
echo "Criando o container nginx"
lxc copy debian9Padrao nginx

echo "Copiando configuracao de rede"
lxc file push ./conf/nginx/interfaces nginx/etc/network/interfaces

echo "Iniciando container"
lxc start nginx

echo "Aguardando 5 segundos para inicialização"
sleep 5

### NGINX
echo "Instalando e configurando nginx"
lxc exec nginx -- apt update
lxc exec nginx -- apt upgrade -y
lxc exec nginx -- apt install -y nginx

###
# redirecionando a porta 8080 para o servidor na porta 80 no container nginx
lxc config device add nginx myport8080 proxy listen=tcp:0.0.0.0:8080 connect=tcp:0.0.0.0:80
