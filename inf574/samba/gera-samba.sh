#!/bin/bash
# gera maquina samba: Controlador de dominio
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
echo "Copiando o script de teste do samba"
lxc file push ./conf/samba/testa-samba.sh samba/root/testa-samba.sh --mode 0755

echo "Iniciando container"
lxc start samba

echo "Agora logue no container samba e rode o script instala-samha.sh"
echo "Boa Sorte !"
