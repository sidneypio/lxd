#!/bin/bash
# testa o ambiente criado
#
echo "verificando conectidade a partir de A1"
lxc exec A1 -- /bin/ping -c 3 10.10.10.1
lxc exec A1 -- /bin/ping6 -c 3 2001:db8:2018:a::1

echo "verificando conectidade a partir de R1"
lxc exec R1 -- /bin/ping -c 3 10.100.12.2
lxc exec R1 -- /bin/ping6 -c 3 2001:db8:2018:12::2

lxc exec R1 -- /bin/ping -c 3 10.100.13.3
lxc exec R1 -- /bin/ping6 -c 3 2001:db8:2018:13::3

lxc exec R1 -- /bin/ping -c 3 10.10.10.10
lxc exec R1 -- /bin/ping6 -c 3 2001:db8:2018:a::10

echo "verificando conectidade a partir de R2"
lxc exec R2 -- /bin/ping -c 3 10.100.12.1
lxc exec R2 -- /bin/ping6 -c 3 2001:db8:2018:12::1

lxc exec R2 -- /bin/ping -c 3 10.100.23.3
lxc exec R2 -- /bin/ping6 -c 3 2001:db8:2018:23::3

echo "verificando conectidade a partir de R3"
lxc exec R3 -- /bin/ping -c 3 10.100.23.2
lxc exec R3 -- /bin/ping6 -c 3 2001:db8:2018:23::2

lxc exec R3 -- /bin/ping -c 3 10.100.13.1
lxc exec R3 -- /bin/ping6 -c 3 2001:db8:2018:13::1

lxc exec R3 -- /bin/ping -c 3 10.10.20.10
lxc exec R3 -- /bin/ping6 -c 3 2001:db8:2018:B::10

echo "verificando conectidade a partir de B1"
lxc exec B1 -- /bin/ping -c 3 10.10.20.1
lxc exec B1 -- /bin/ping6 -c 3 2001:db8:2018:B::1

echo "verificando roteamento a partir de A1"
lxc exec A1 -- /bin/ping -c 3 10.10.20.10
lxc exec A1 -- /bin/ping6 -c 3 2001:db8:2018:B::10
