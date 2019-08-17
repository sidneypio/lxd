#!/bin/bash
# testa o ambiente criado
#
echo "Verificando conectidade IPv4 a partir de A1"
lxc exec A1 -- /bin/ping -c 3 10.10.10.20
lxc exec A1 -- /bin/ping -c 3 10.10.10.100
lxc exec A1 -- /bin/ping -c 3 10.10.20.100
lxc exec A1 -- /bin/ping -c 3 10.10.20.10

echo "Traceroute (IPv4) para B1 a partir de A1"
lxc exec A1 -- /usr/sbin/traceroute -n 10.10.20.10

echo "Verificando conectidade IPv6 a partir de A1"
lxc exec A1 -- /bin/ping6 -c 3 2001:db8:2018:A::20
lxc exec A1 -- /bin/ping6 -c 3 2001:db8:2018:A::100
lxc exec A1 -- /bin/ping6 -c 3 2001:db8:2018:B::100
lxc exec A1 -- /bin/ping6 -c 3 2001:db8:2018:B::10

echo "Traceroute (IPv6) para B1 a partir de A1"
lxc exec A1 -- /usr/sbin/traceroute -n 2001:db8:2018:B::10