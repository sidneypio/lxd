#!/bin/bash
# gera o ambiente
#
#

echo "Criando redes "
lxc network create redeAR ipv6.address=none ipv4.address=10.10.10.1/24 ipv4.nat=false ipv4.dhcp=false
lxc network create redeBR ipv6.address=none ipv4.address=10.10.20.1/24 ipv4.nat=false ipv4.dhcp=false

### A1
echo "Criando o container A1"
lxc copy debian9padrao A1
echo "Ligando interface eth0 na rede interna"
lxc network attach redeAR A1 eth0
echo "Copiando configuracao de rede"
lxc file push ./conf/A1/interfaces A1/etc/network/interfaces


### B1
echo "Criando o container B1"
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

echo "Iniciando containers"
lxc start R
lxc start A1
lxc start B1

echo "Criando os devices para tuneis gre e sit"
lxc config set A1 linux.kernel_modules sit
lxc config set A1 linux.kernel_modules ip_gre
lxc config set A1 linux.kernel_modules nf_conntrack_proto_gre
lxc config set B1 linux.kernel_modules sit
lxc config set B1 linux.kernel_modules ip_gre
lxc config set B1 linux.kernel_modules nf_conntrack_proto_gre