#!/bin/bash
# remove o ambiente:
#
echo "Parando os containers"
for maq in A1 A2 B1 R1 R2 R3 DNS
do
	echo "Parando $maq"
	lxc exec $maq -- /sbin/poweroff
done

for count in {9..0}; do printf "\rAguardando 10 segundos para a finalizacao dos containers: %02d" "$count"; sleep 1; done ; echo ""

for maq in A1 A2 B1 R1 R2 R3 DNS
do
	echo "Removendo $maq"
	lxc delete $maq  
	sleep 1
done

echo "Removendo as redes "
for rede in redeAR1 redeR3B redeR1R2 redeR2R3 redeR1R3
do
	lxc network delete $rede  
done

echo "Verificando como está a configuração"
lxc list
lxc network list
