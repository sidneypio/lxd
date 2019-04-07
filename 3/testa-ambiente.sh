#!/bin/bash
# testa o ambiente criado
# duas maquinas ligadas em um roteador 
#
#   A1 -------------------------- R --------------- B1
#      eth1          |       eth1   eth2       eth1
#      10.10         |     10.100   20.100    20.10 
#                    |
#                    |
#   A2 ---------------
#      eth1
#      10.11
#
echo "verificando conectidade a partir de A1"
lxc exec A1 -- /bin/ping -c 3 10.10.10.11
lxc exec A1 -- /bin/ping -c 3 10.10.10.100
lxc exec A1 -- /bin/ping -c 3 10.10.20.100
lxc exec A1 -- /bin/ping -c 3 10.10.20.10
echo "verificando DNS"
lxc exec A1 -- /usr/bin/host www.debian.org
