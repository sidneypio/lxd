#!/bin/bash
# instala ssh server nas maquinas e instala uma chave publica
#
# copiando a chave publica para o diretorio de configuracao
cp /home/sidney/.ssh/id_sidneypio_rsa.pub conf/chave_publica.pub


for maq in A1 A2 R B1
do
	echo "Criando e configurando container " $maq
    lxc file push conf/chave_publica.pub $maq/root/.ssh/authorized_keys -p --uid 0 --gid 0 --mode 0600
    lxc exec $maq -- /usr/bin/apt install -y openssh-server
done

