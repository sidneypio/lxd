#!/bin/bash
# remove o primeiro ambiente:
# as duas maquinas e a rede
echo "Parando o container ionic"
lxc exec ionic -- /sbin/poweroff

echo "Aguardando 5 segundos para remover"
sleep 5

echo "Removendo o container ionic"
lxc delete ionic  

echo "Removendo a o redirecionamento"
lxc config device remove ionic myport8080
