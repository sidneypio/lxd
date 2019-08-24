#!/bin/bash

for container in R1 R2 R3 A1 A2 B1 DNS
do
	lxc file push conf/DNS/resolv.conf-dns $container/etc/resolv.conf
done