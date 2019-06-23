#!/bin/bash
# testa o ambiente criado
#
echo "verificando conectidade IPv4 a partir de A2"
lxc exec A2 -- /bin/ping -c 3 10.10.10.10
lxc exec A2 -- /bin/ping -c 3 10.10.10.100
lxc exec A2 -- /bin/ping -c 3 10.10.20.100
lxc exec A2 -- /bin/ping -c 3 10.10.20.10
echo "==="

echo "verificando conectidade IPv6 a partir de A2"
lxc exec A2 -- /bin/ping6 -c 3 2001:db8:1970:a::10
lxc exec A2 -- /bin/ping6 -c 3 2001:db8:1970:a::100
lxc exec A2 -- /bin/ping6 -c 3 2001:db8:1970:b::100
lxc exec A2 -- /bin/ping6 -c 3 2001:db8:1970:b::10
echo "==="

echo "Traceroute usando IPv6 a partir de A2 ate B1"
lxc exec A2 -- /usr/sbin/traceroute 2001:db8:1970:b::10
echo "==="

echo "verificando DNS a partir de A2"
lxc exec A2 -- /usr/bin/host www.debian.org
echo "==="

echo "Conectando no servidor apache em B1"
lxc exec A2 -- links -dump http://[2001:db8:1970:b::10]
echo "==="
