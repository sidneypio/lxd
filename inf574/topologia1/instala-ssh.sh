#!/bin/bash
# instala ssh server nas maquinas e tambem fail2ban e autenticacao de 2 fatores

# verifica o numero de argumentos 
if [ "$#" -ne 1 ]; then
    echo "Eh necessario indicar como argumento o arquivo que tem a chave publica"
    echo "./instala-ssh.sh maquina"
    echo ""
    echo "Por exemplo, ./instala-ssh.sh A1"
else
    echo "Instalando pacotes no container " $1
    lxc exec $1 -- /usr/bin/apt install -y openssh-server fail2ban libpam-google-authenticator
    echo "Copiando arquivos de configuracao"
    lxc file push conf/$1/sshd_config $1/etc/ssh/sshd_config -p --uid 0 --gid 0 --mode 0644
    lxc file push conf/$1/sshd $1/etc/pam.d/sshd -p --uid 0 --gid 0 --mode 0644  
    echo "Reiniciando sshd"
    lxc exec $1 -- service sshd restart
    echo "fim"


fi
