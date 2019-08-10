#!/bin/bash
# remove o ambiente:
#
echo "Parando os containers"
for maq in A1 A2 B1 R DHCP
do
	echo "Parando $maq"
	lxc exec $maq -- /sbin/poweroff
done

for count in {9..0}; do printf "\rAguardando 10 segundos para a finalizacao dos containers: %02d" "$count"; sleep 1; done ; echo ""

for maq in A1 A2 B1 R DHCP
do
	echo "Removendo $maq"
	lxc delete $maq  
	sleep 1
done

echo "Removendo as redes "
for rede in redeAR redeBR
do
	lxc network delete $rede  
done

echo "Verificando como está a configuração"
lxc list
lxc network list
