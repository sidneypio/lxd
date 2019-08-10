#!/bin/bash
# instala ssh server nas maquinas e instala uma chave publica
#

# verifica o numero de argumentos 
if [ "$#" -ne 1 ]; then
    echo "Eh necessario indicar como argumento o arquivo que tem a chave publica"
    echo "./ssh.sh nome-do-arquivo-da-chave-publica"
    echo ""
    echo "Por exemplo, ./ssh.sh /home/sidney/.ssh/id_rsa.pub"
else
	# copiando a chave publica para o diretorio de configuracao
    cp $1 conf/chave_publica.pub

    for maq in A1 A2 R B1   
    do
        echo "Criando e configurando container " $maq
        lxc file push conf/chave_publica.pub $maq/root/.ssh/authorized_keys -p --uid 0 --gid 0 --mode 0600
        lxc exec $maq -- /usr/bin/apt install -y openssh-server
    done

    # removendo a chave publica  
    rm conf/chave_publica.pub
fi
