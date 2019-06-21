#!/bin/bash
# testa o ambiente criado
#
echo "verificando conectidade IPv4 a partir de A2"
lxc exec A2 -- /bin/ping -c 3 10.10.10.10
lxc exec A2 -- /bin/ping -c 3 10.10.10.100
lxc exec A2 -- /bin/ping -c 3 10.10.20.100
lxc exec A2 -- /bin/ping -c 3 10.10.20.10

echo "verificando DNS a partir de A2"
lxc exec A2 -- /usr/bin/host www.debian.org
