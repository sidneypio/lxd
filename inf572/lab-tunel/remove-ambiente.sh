#!/bin/bash
# remove o ambiente:
echo "Parando os containers"
lxc exec A1 -- /sbin/poweroff
lxc exec B1 -- /sbin/poweroff
lxc exec R -- /sbin/poweroff

for count in {9..0}; do printf "\rAguardando 10 segundos: %02d" "$count"; sleep 1; done ; echo ""

echo "Removendo os containers"
lxc delete A1 
lxc delete B1 
lxc delete R

echo "Removendo as redes "
lxc network delete redeAR 
lxc network delete redeBR 
