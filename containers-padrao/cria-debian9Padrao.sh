#!/bin/bash
# Cria a maquina padrao com alguns pacotes adicionais
echo "Criando a imagem"
lxc launch images:debian/stretch debian9Padrao

echo "Esperando um pouco para a inicializacao..."
sleep 15

echo "Atualizando lista de pacotes"
lxc exec debian9Padrao -- /usr/bin/apt update

echo "Instalando alguns pacotes uteis para a disciplina"
lxc exec debian9Padrao -- /usr/bin/apt install -y tcpdump net-tools inetutils-ping traceroute iptables htop bind9-host dnsutils rsyslog links man

echo "Ajustando o timezone para America/Sao_Paulo"
lxc exec debian9Padrao -- timedatectl set-timezone "America/Sao_Paulo"

echo "Desligando a maquina"
lxc exec debian9Padrao -- /sbin/poweroff
