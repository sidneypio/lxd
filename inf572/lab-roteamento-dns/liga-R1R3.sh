#!/bin/bash
echo "Ligando as interfaces conectadas em R1R3 nos roteadores"

lxc exec R1 -- ip link set eth2 up
lxc exec R3 -- ip link set eth2 up