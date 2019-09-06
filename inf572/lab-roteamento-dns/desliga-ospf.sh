#!/bin/bash

echo "Desligando ospf nos roteadores"
for roteador in R1 R2 R3
do
	lxc exec $roteador -- systemctl stop ospfd
	#lxc exec $roteador -- systemctl stop ospf6d
done