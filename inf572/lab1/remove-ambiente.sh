#!/bin/bash
# remove o ambiente:
echo "Parando as maquinas"
lxc exec A1 -- /sbin/poweroff
lxc exec A2 -- /sbin/poweroff
lxc exec B1 -- /sbin/poweroff
lxc exec R -- /sbin/poweroff

echo "Removendo as maquinas"
lxc delete A1 
lxc delete A2
lxc delete B1 
lxc delete R

echo "Removendo as  redes "
lxc network delete redeAR 
lxc network delete redeBR 
