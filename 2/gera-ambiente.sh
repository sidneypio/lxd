#!/bin/bash
# gera o ambiente:
# duas maquinas ligadas em um roteador 
#
#   A1 -------------------------- R --------------- B1
#      eth1                  eth1   eth2       eth1
#      10.10               10.100   20.100    20.10 
#
#
export CONF="/root/inf572/2/conf"
echo "Criando redes "
lxc network create redeAR ipv6.address=none ipv4.address=10.10.10.1/24 ipv4.nat=false ipv4.dhcp=false
lxc network create redeBR ipv6.address=none ipv4.address=10.10.20.1/24 ipv4.nat=false ipv4.dhcp=false

### A1
echo "Criando a primeira maquina"
lxc copy debianPadrao A1
echo "Ligando interface eth1 na rede interna"
lxc network attach redeAR A1 eth0
echo "Copiando configuracao de rede"
lxc file push $CONF/A1/interfaces A1/etc/network/interfaces

### B
echo "Criando a segunda maquina"
lxc copy debianPadrao B1
echo "Ligando interface eth1 na rede interna"
lxc network attach redeBR B1 eth0
echo "Copiando configuracao de rede"
lxc file push $CONF/B1/interfaces B1/etc/network/interfaces 

### R
echo "Criando roteador"
lxc copy debianPadrao R
echo "Ligando interfaces"
lxc network attach redeAR R eth1
lxc network attach redeBR R eth2

echo "Copiando configuracoes"
lxc file push $CONF/R/interfaces R/etc/network/interfaces 
lxc file push $CONF/R/sysctl.conf R/etc/sysctl.conf
lxc file push $CONF/R/rc.local R/etc/rc.local

echo "Iniciando containers"
lxc start R
lxc start A1
lxc start B1
