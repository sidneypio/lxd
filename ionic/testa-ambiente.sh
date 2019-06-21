#!/bin/bash
# testa o ambiente ionic
echo "Verificando node"
lxc exec ionic -- node -v
echo "Verificando npm"
lxc exec ionic -- npm -v
echo "Verificando ionic"
lxc exec ionic -- ionic info
echo "Verificando usuario teste"
lxc exec ionic -- id teste