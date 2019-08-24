#!/bin/bash

echo "Desligando as interfaces conectadas em R1R3 nos roteadores"

lxc exec R1 -- ip link set eth2 down
lxc exec R3 -- ip link set eth2 down