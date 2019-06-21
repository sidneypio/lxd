#!/bin/bash
# testa o ambiente criado
#
echo "verificando conectidade a partir de A1"
lxc exec A1 -- /bin/ping -c 3 10.10.10.11
lxc exec A1 -- /bin/ping -c 3 10.10.10.100
lxc exec A1 -- /bin/ping -c 3 10.10.20.100
lxc exec A1 -- /bin/ping -c 3 10.10.20.10
echo "verificando DNS"
lxc exec A1 -- /usr/bin/host www.debian.org
