#!/bin/bash
# Cria a maquina padrao com alguns pacotes adicionais
echo "Criando a imagem"
lxc init images:debian/10 debian10padrao

echo "Copiando arquivo de configuracao do dhcp (client)"
lxc file push dhclient.conf debian10padrao/etc/dhcp/dhclient.conf  

echo "Copiando arquivo de configuracao para forçar uso do IPv4 via apt"
lxc file push 99force-ipv4 debian10padrao/etc/apt/apt.conf.d/99force-ipv4  

echo "Inicializando o container"
lxc start debian10padrao

echo "Esperando um pouco para a inicializacao..."
sleep 15

echo "Atualizando lista de pacotes"
lxc exec debian10padrao -- /usr/bin/apt update

echo "Instalando alguns pacotes uteis para a disciplina"
lxc exec debian10padrao -- /usr/bin/apt install -y telnet tcpdump apt-utils aptitude net-tools inetutils-ping traceroute iptables htop bind9-host dnsutils rsyslog links man nano
# pacotes para a parte de roteamento
lxc exec debian10padrao -- /usr/bin/apt install -y quagga quagga-doc quagga-core quagga-ripd quagga-ripngd quagga-ospfd quagga-ospf6d

echo "Ajustando o timezone para America/Sao_Paulo"
lxc exec debian10padrao -- timedatectl set-timezone "America/Sao_Paulo"

echo "Desligando o container"
lxc exec debian10padrao -- /sbin/poweroff
