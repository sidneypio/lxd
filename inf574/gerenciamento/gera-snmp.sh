#!/bin/bash
# gera maquina snmp
#

### snmp
echo "Criando a maquina snmp"
lxc copy debian9padrao snmp
echo "Ligando interface eth0 na rede interna"
lxc network attach redeBR snmp eth0
echo "Copiando configuracao de rede"
lxc file push ./conf/snmp/interfaces snmp/etc/network/interfaces

echo "Copiando sources.list com repositorios non-free"
lxc file push ./conf/snmp/sources.list snmp/etc/apt/sources.list --mode 0755


echo "Iniciando container"
lxc start snmp

echo "Instalando pacotes"
lxc exec snmp -- /usr/bin/apt update
lxc exec snmp -- /usr/bin/apt upgrade -y
lxc exec snmp -- /usr/bin/apt install -y snmp snmp-mibs-downloader

echo "Copiando o arquivo de configuracao snmp.conf"
lxc file push ./conf/snmp/snmp.conf snmp/etc/snmp/snmp.conf --mode 0755

echo "Copiando o arquivo testa-snmp.sh"
lxc file push ./conf/snmp/testa-snmp.sh snmp/root/testa-snmp.sh --mode 0755
