#!/bin/bash
# copia arquivos para cliente do samba - S1
#

### cliente do samba - S1
echo "Criando a maquina samba"
lxc copy debian9padrao S1
echo "Ligando interface eth0 na rede interna"
lxc network attach redeAR S1 eth0
echo "Copiando configuracao de rede"
lxc file push ./conf/S1/interfaces S1/etc/network/interfaces

echo "Copiando arquivos para instalacao e configuracao do cliente S1"
lxc file push ./conf/S1/instala-cliente-samba.sh S1/root/instala-cliente-samba.sh --mode 0755

lxc file push ./conf/S1/common-session S1/root/common-session --mode 0755
lxc file push ./conf/S1/nsswitch.conf S1/root/nsswitch.conf  
lxc file push ./conf/S1/hosts S1/root/hosts  
lxc file push ./conf/S1/interfaces-possamba S1/root/interfaces-possamba  
lxc file push ./conf/S1/smb.conf S1/root/smb.conf 

echo "Iniciando containers"
lxc start S1

