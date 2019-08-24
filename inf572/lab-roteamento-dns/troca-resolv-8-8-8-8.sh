#!/bin/bash

for container in R1 R2 R3 A1 A2 B1 DNS
do
	lxc file push conf/DNS/resolv.conf-8.8.8.8 $container/etc/resolv.conf
done