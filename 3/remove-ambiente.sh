#!/bin/bash
# remove o primeiro ambiente:
# as duas maquinas e a rede
echo "Parando e removendo as maquinas"
for maq in A1 A2 B1 R DHCP
do
	lxc exec $maq -- /sbin/poweroff
	lxc delete $maq  
done

echo "Removendo as  redes "
for rede in redeAR redeBR
do
	lxc network delete $rede  
done

echo "Verificando como está a configuração"
lxc list
lxc network list
