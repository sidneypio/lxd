#!/bin/bash
# gera um container com laravel e libera acesso para a porta xxxx
#  
echo "Criando a maquina l1"
lxc copy ubuntu1904Padrao l1

echo "Copiando configuracao de rede"
#lxc file push ./conf/l1/interfaces l1/etc/network/interfaces

echo "Iniciando container"
lxc start l1

echo "Aguardando 5 segundos para inicialização"
sleep 5

### php, mariadb,etc
echo "Instalando e configurando pacotes para laravel"
lxc exec l1 -- apt update
lxc exec l1 -- apt upgrade -y
lxc exec l1 -- apt install -y unzip zip php7.2 php7.2-mysql php7.2-fpm php7.2-mbstring php7.2-xml php7.2-curl mysql-client mysql-server


###
# redirecionando a porta 8080 para o servidor na porta 80 na maquina n1
#lxc config device add n1 myport8080 proxy listen=tcp:0.0.0.0:8080 connect=tcp:localhost:80
