#!/bin/bash
# instala o agente zabbix  nas maquinas 

# verifica o numero de argumentos 
if [ "$#" -ne 1 ]; then
    echo "Eh necessario indicar como argumento o arquivo que tem a chave publica"
    echo "./instala-agente-zabbix.sh maquina"
    echo ""
    echo "Por exemplo, ./instala-agente-zabbix.sh A1"
else
    echo "Atualizando pacotes e instalando wget no container " $1
    lxc exec $1 -- /usr/bin/apt update
    lxc exec $1 -- /usr/bin/apt upgrade -y
    lxc exec $1 -- /usr/bin/apt install -y wget

    echo "Adicionando repositorio zabbix 4.4 no container " $1
    lxc exec $1 --  wget https://repo.zabbix.com/zabbix/4.4/debian/pool/main/z/zabbix-release/zabbix-release_4.4-1+stretch_all.deb
    lxc exec $1 --  dpkg -i zabbix-release_4.4-1+stretch_all.deb
    lxc exec $1 -- rm zabbix-release_4.4-1+stretch_all.deb
    lxc exec $1 -- /usr/bin/apt update

    echo "Instalando agente zabbix no container " $1
    lxc exec $1 --  /usr/bin/apt install -y zabbix-agent

    echo "Habilitando agente zabbix para inicilizar automaticamente no container " $1
    lxc exec $1 --  update-rc.d zabbix-agent enable

    echo "Copiando o arquivo de configuracao zabbix_server.conf"
    lxc file push ./conf/zabbix/zabbix_agentd.conf $1/etc/zabbix/zabbix_agentd.conf --mode 0644

    echo "Iniciando agente zabbix no container " $1
    lxc exec $1 -- service zabbix-agent start
    echo "fim"


fi
