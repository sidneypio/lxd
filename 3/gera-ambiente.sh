#!/bin/bash
# gera o ambiente:
#
#   A1 --------------+----------- R --------------- B1
#      eth0          |       eth1   eth2       eth0
#      10.10         |     10.100   20.100    20.10 
#                    |
#                    |
#   A2 --------------+
#      eth0          |
#      (via dhcp)    |
#                    |
#   DHCP ------------+
#      eth0          
#      10.200
#
#
export CONF="/root/inf572/3/conf"
echo "Criando redes "
lxc network create redeAR ipv6.address=none ipv4.address=10.10.10.1/24 ipv4.nat=false ipv4.dhcp=false
lxc network create redeBR ipv6.address=none ipv4.address=10.10.20.1/24 ipv4.nat=false ipv4.dhcp=false

### A
for maq in A1 A2 DHCP
do
	echo "Criando e configurando container " $maq
	lxc copy debianPadrao $maq
	lxc network attach redeAR $maq eth0
	lxc file push $CONF/$maq/interfaces $maq/etc/network/interfaces
done

### B
echo "Criando a segunda maquina"
lxc copy debianPadrao B1
echo "Ligando interface na rede interna"
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
for maq in R A1 A2 B1 DHCP
do
	lxc start $maq
done

### DHCP
echo "Instalando e configurando isc-dhcp-server"
lxc exec DHCP -- /usr/bin/apt install -y isc-dhcp-server
lxc file push $CONF/DHCP/isc-dhcp-server DHCP/etc/default/isc-dhcp-server
lxc file push $CONF/DHCP/dhcpd.conf DHCP/etc/dhcp/dhcpd.conf
lxc file push $CONF/DHCP/dhcpd6.conf DHCP/etc/dhcp/dhcpd6.conf
lxc exec DHCP -- /usr/sbin/service isc-dhcp-server start
