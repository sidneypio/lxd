#!/bin/bash

echo "Inicializando ripd e ripngd nos roteadores"
for roteador in R1 R2 R3
do
	lxc exec $roteador -- systemctl start ripd
	lxc exec $roteador -- systemctl start ripngd
done