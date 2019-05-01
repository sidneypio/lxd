#!/bin/bash
# remove o primeiro ambiente:
# as duas maquinas e a rede
echo "Parando a maquina n1"
lxc exec n1 -- /sbin/poweroff

echo "Removendo a  maquina  n1"
lxc delete n1  

echo "Removendo a o redirecionamento"
lxc config device remove n1 myport8080
