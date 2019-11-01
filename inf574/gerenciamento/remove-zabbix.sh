#!/bin/bash
# remove o ambiente:
echo "Parando a maquina zabbix"
lxc exec zabbix -- /sbin/poweroff
 

for count in {9..0}; do printf "\rAguardando 10 segundos: %02d" "$count"; sleep 1; done ; echo ""

echo "Removendo as maquinas"
lxc delete zabbix
 
