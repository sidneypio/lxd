#!/bin/bash

echo "Desligando ripd e ripngd nos roteadores"
for roteador in R1 R2 R3
do
	lxc exec $roteador -- systemctl stop ripd
	lxc exec $roteador -- systemctl stop ripngd
done