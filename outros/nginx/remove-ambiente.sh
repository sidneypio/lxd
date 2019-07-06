#!/bin/bash
# remove o primeiro ambiente:
# as duas maquinas e a rede
echo "Parando a maquina nginx"
lxc exec nginx -- /sbin/poweroff

echo "Aguardando 5 segundos para remover"
sleep 5

echo "Removendo a  maquina  nginx"
lxc delete nginx  

echo "Removendo a o redirecionamento"
lxc config device remove nginx myport8080
