#!/bin/bash
# gera o primeiro ambiente:
# duas maquinas ligadas em uma rede interna
#
#   d1 ----------- d2
#
#
#
#
echo "Criando rede interna"
lxc network create reded1d2 ipv6.address=none ipv4.address=10.20.19.1/24 ipv4.nat=false ipv4.dhcp=false

echo "Criando a primeira maquina"
lxc copy debianPadrao d1

echo "Ligando interface eth1 na rede interna"
lxc network attach reded1d2 d1 default eth1

echo "Copiando configuracao de rede"
lxc file push ./conf/d1/interfaces d1/etc/network/interfaces

echo "Criando a segunda maquina"
lxc copy debianPadrao d2

echo "Ligando interface eth1 na rede interna"
lxc network attach reded1d2 d2 default eth1

echo "Copiando configuracao de rede"
lxc file push ./conf/d2/interfaces d2/etc/network/interfaces 

echo "Iniciando containers"
lxc start d1
lxc start d2
