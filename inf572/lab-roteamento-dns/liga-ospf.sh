#!/bin/bash

echo "Inicializando ospf nos roteadores"
for roteador in R1 R2 R3
do
	lxc exec $roteador -- systemctl start ospfd
	#lxc exec $roteador -- systemctl start ospf6d
done