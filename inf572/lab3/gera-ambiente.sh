#!/bin/bash
#
echo "Criando redes "
lxc network create redeAR ipv6.address=none ipv4.address=10.10.10.1/24 ipv4.nat=false ipv4.dhcp=false
lxc network create redeBR ipv6.address=none ipv4.address=10.10.20.1/24 ipv4.nat=false ipv4.dhcp=false

### A
for maq in A1 A2 DHCP
do
	echo "Criando e configurando container " $maq
	lxc copy debian9padrao $maq
	lxc network attach redeAR $maq eth0
	lxc file push ./conf/$maq/interfaces $maq/etc/network/interfaces
done

### B
echo "Criando a segunda maquina"
lxc copy debian9padrao B1
echo "Ligando interface na rede interna"
lxc network attach redeBR B1 eth0
echo "Copiando configuracao de rede"
lxc file push ./conf/B1/interfaces B1/etc/network/interfaces 

### R
echo "Criando roteador"
lxc copy debian9padrao R
echo "Ligando interfaces"
lxc network attach redeAR R eth1
lxc network attach redeBR R eth2



echo "Copiando configuracoes para R"
lxc file push ./conf/R/interfaces R/etc/network/interfaces 
lxc file push ./conf/R/sysctl.conf R/etc/sysctl.conf
lxc file push ./conf/R/rc.local R/etc/rc.local
lxc file push ./conf/R/radvd.conf R/etc/radvd.conf


echo "Iniciando containers"
for maq in R A1 B1 DHCP
do
	echo "Iniciando container " $maq
	lxc start $maq
done

echo "Instalando radvd em R"
lxc exec R -- /usr/bin/apt install -y radvd
lxc exec R -- /usr/sbin/update-rc.d radvd enable

### DHCP
echo "Instalando e configurando isc-dhcp-server"
lxc exec DHCP -- /usr/bin/apt install -y isc-dhcp-server
lxc file push ./conf/DHCP/isc-dhcp-server DHCP/etc/default/isc-dhcp-server
lxc file push ./conf/DHCP/dhcpd.conf DHCP/etc/dhcp/dhcpd.conf
lxc exec DHCP -- /usr/sbin/service isc-dhcp-server start

echo ""
echo "O container A2 deve ser inicializado manualmente para podermos acompanhar os logs do DHCP e radvd"
echo "O comando utilizado é:"
echo "lxc start A2"
