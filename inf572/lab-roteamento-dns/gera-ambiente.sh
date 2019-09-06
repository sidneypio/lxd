#!/bin/bash
#
echo "Criando redes "
lxc network create redeAR1  ipv6.address=none ipv4.address=10.10.10.100/24 ipv4.nat=false ipv4.dhcp=false
lxc network create redeR1R2 ipv6.address=none ipv4.address=10.100.12.100/24 ipv4.nat=false ipv4.dhcp=false
lxc network create redeR2R3 ipv6.address=none ipv4.address=10.100.23.100/24 ipv4.nat=false ipv4.dhcp=false
lxc network create redeR1R3 ipv6.address=none ipv4.address=10.100.13.100/24 ipv4.nat=false ipv4.dhcp=false
lxc network create redeR3B  ipv6.address=none ipv4.address=10.10.20.100/24 ipv4.nat=false ipv4.dhcp=false

### A
for maq in A1 A2 DNS
do
	echo "Criando e configurando container " $maq
	lxc copy debian9padrao $maq
	lxc network attach redeAR1 $maq eth0
	lxc file push ./conf/$maq/interfaces $maq/etc/network/interfaces
done

### B
echo "Criando a segunda maquina"
lxc copy debian9padrao B1
echo "Ligando interface na rede interna"
lxc network attach redeR3B B1 eth0
echo "Copiando configuracao de rede"
lxc file push ./conf/B1/interfaces B1/etc/network/interfaces 

### R1
echo "Criando roteador"
lxc copy debian9padrao R1
echo "Ligando interfaces"
lxc network attach redeR1R2 R1 eth1
lxc network attach redeR1R3 R1 eth2
lxc network attach redeAR1  R1 eth3

### R2
echo "Criando roteador"
lxc copy debian9padrao R2
echo "Ligando interfaces"
lxc network attach redeR1R2 R2 eth1
lxc network attach redeR2R3 R2 eth2

### R3
echo "Criando roteador"
lxc copy debian9padrao R3
echo "Ligando interfaces"
lxc network attach redeR2R3 R3 eth1
lxc network attach redeR1R3 R3 eth2
lxc network attach redeR3B  R3 eth3

echo "Copiando configuracoes"
for roteador in R1 R2 R3
do
	lxc file push ./conf/$roteador/interfaces  $roteador/etc/network/interfaces 
	lxc file push ./conf/$roteador/sysctl.conf $roteador/etc/sysctl.conf
	lxc file push ./conf/$roteador/rc.local    $roteador/etc/rc.local
	#lxc file push ./conf/R/radvd.conf R/etc/radvd.conf
done

echo "Iniciando containers"
for maq in  A1 A2 B1 R1 R2 R3 DNS
do
	echo "Iniciando container " $maq
	lxc start $maq
done

for count in {9..0}; do printf "\rAguardando 10 segundos para a  inicializacao dos containers: %02d" "$count"; sleep 1; done ; echo ""

echo "Copiando configuração dos roteadores e inicializando os daemons"
for roteador in R1 R2 R3
do
	lxc file push ./conf/$roteador/zebra.conf   $roteador/etc/quagga/zebra.conf
	lxc file push ./conf/$roteador/ripd.conf   $roteador/etc/quagga/ripd.conf
	lxc file push ./conf/$roteador/ripngd.conf   $roteador/etc/quagga/ripngd.conf
	lxc file push ./conf/$roteador/ospfd.conf   $roteador/etc/quagga/ospfd.conf
	lxc exec $roteador -- chown -R quagga /etc/quagga
	lxc exec $roteador -- systemctl start zebra
	lxc exec $roteador -- systemctl start ripd
	lxc exec $roteador -- systemctl start ripngd
done

echo "instalando pacotes e configurando DNS"
lxc exec DNS -- apt install -y bind9 bind9-host bind9-doc bind9utils

lxc file push ./conf/DNS/10-10.rev DNS/etc/bind/master/10-10.rev -p
lxc file push ./conf/DNS/2001-db8-2018.rev DNS/etc/bind/master/2001-db8-2018.rev -p
lxc file push ./conf/DNS/inf500.zone DNS/etc/bind/master/inf500.zone -p
lxc file push ./conf/DNS/named.conf.local DNS/etc/bind/named.conf.local -p
lxc file push ./conf/DNS/named.conf.options DNS/etc/bind/named.conf.options -p
lxc exec DNS -- touch /var/log/querylog 
lxc exec DNS -- chown bind /var/log/querylog
lxc exec DNS -- chown -R bind /etc/bind
