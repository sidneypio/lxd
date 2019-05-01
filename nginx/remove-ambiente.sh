#!/bin/bash
# remove o primeiro ambiente:
# as duas maquinas e a rede
echo "Parando a primeira maquina"
lxc exec d1 -- /sbin/poweroff

echo "Parando a segunda maquina"
lxc exec d2 -- /sbin/poweroff

echo "Removendo a primeira maquina"
lxc delete d1  

echo "Removendo a segunda maquina"
lxc delete d2 

echo "Removendo a  rede reded1d2"
lxc network delete reded1d2 
