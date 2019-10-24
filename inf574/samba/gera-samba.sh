#!/bin/bash
# gera maquina samba
#
#
 

### samba
echo "Criando a maquina samba"
lxc copy debian9padrao samba
echo "Ligando interface eth0 na rede interna"
lxc network attach redeAR samba eth0
echo "Copiando configuracao de rede"
lxc file push ./conf/samba/interfaces samba/etc/network/interfaces
echo "Copiando configuracao /etc/hosts"
lxc file push ./conf/samba/hosts samba/etc/hosts
echo "Copiando o script de instalacao do samba"
lxc file push ./conf/samba/instala-samba.sh samba/root/instala-samba.sh --mode 0755
echo "Copiando o script de instalacao do samba"
lxc file push ./conf/samba/testa-samba.sh samba/root/testa-samba.sh --mode 0755

echo "Iniciando containers"
lxc start samba

#echo "Aguardando 10 segundos para garantir que R esta no ar"
#sleep 10

#echo "Instalando radvd em R"
#lxc exec R -- /usr/bin/apt install -y radvd
#lxc exec R -- /usr/sbin/update-rc.d radvd enable
