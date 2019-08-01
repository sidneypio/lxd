#!/bin/bash
# gera o ambiente
#
echo "Criando redes "
lxc network create redeAR ipv6.address=2001:db8:2018:A::1/64 ipv4.address=10.10.10.1/24 ipv4.nat=false ipv4.dhcp=false
lxc network create redeBR ipv6.address=2001:db8:2018:B::1/64 ipv4.address=10.10.20.1/24 ipv4.nat=false ipv4.dhcp=false

### A1
echo "Criando a maquina A1"
lxc copy debian9padrao A1
echo "Ligando interface eth0 na rede interna"
lxc network attach redeAR A1 eth0
echo "Copiando configuracao de rede"
lxc file push ./conf/A1/interfaces A1/etc/network/interfaces

### A2
echo "Criando a maquina A2"
lxc copy debian9padrao A2
echo "Ligando interface eth0 na rede interna"
lxc network attach redeAR A2 eth0
echo "Copiando configuracao de rede"
lxc file push ./conf/A2/interfaces A2/etc/network/interfaces

### B
echo "Criando a segunda B1"
lxc copy debian9padrao B1
echo "Ligando interface eth1 na rede interna"
lxc network attach redeBR B1 eth0
echo "Copiando configuracao de rede"
lxc file push ./conf/B1/interfaces B1/etc/network/interfaces 

### R
echo "Criando roteador R"
lxc copy debian9padrao R
echo "Ligando interfaces"
lxc network attach redeAR R eth1
lxc network attach redeBR R eth2

echo "Copiando configuracoes"
lxc file push ./conf/R/interfaces R/etc/network/interfaces 
lxc file push ./conf/R/sysctl.conf R/etc/sysctl.conf
lxc file push ./conf/R/rc.local R/etc/rc.local
lxc file push ./conf/R/radvd.conf R/etc/radvd.conf

echo "Iniciando containers"
lxc start R
lxc start A1
lxc start A2
lxc start B1

echo "Instalando radvd em R"
lxc exec R -- /usr/bin/apt install -y radvd
lxc exec R -- /usr/sbin/update-rc.d radvd enable