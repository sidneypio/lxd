#!/bin/bash
# Cria a maquina padrao com alguns pacotes adicionais
echo "Criando a imagem"
lxc launch images:debian/stretch debianPadrao

echo "Esperando um pouco para a inicializacao..."
sleep 15

echo "Atualizando lista de pacotes"
lxc exec debianPadrao -- /usr/bin/apt update

echo "Instalando alguns pacotes uteis para a disciplina"
lxc exec debianPadrao -- /usr/bin/apt install -y tcpdump net-tools inetutils-ping traceroute iptables htop bind9-host dnsutils rsyslog

echo "Desligando a maquina"
lxc exec debianPadrao -- /sbin/poweroff
