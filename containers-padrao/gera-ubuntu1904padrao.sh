#!/bin/bash
# Cria a maquina padrao com alguns pacotes adicionais
echo "Criando a imagem"
lxc launch images:ubuntu/disco ubuntu1904padrao

echo "Esperando um pouco para a inicializacao..."
sleep 15

echo "Atualizando lista de pacotes"
lxc exec ubuntu1904padrao -- /usr/bin/apt update

echo "Instalando alguns pacotes uteis para a disciplina"
lxc exec ubuntu1904padrao -- /usr/bin/apt install -y tcpdump net-tools  traceroute iptables htop bind9-host dnsutils

echo "Desligando a maquina"
lxc exec ubuntu1904padrao -- /sbin/poweroff