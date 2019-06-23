#!/bin/bash
#
if [ $# -eq 1 ]
	then
    	echo "Instalando apache e php em $1"
		lxc exec $1 -- /usr/bin/apt install -y apache2 php

		echo "Apagando arquivo index.html em $1"
		lxc file delete $1/var/www/html/index.html
		echo "Copiando arquivos exemplo para $1"
		lxc file push ./conf/exemplos/index.php $1/var/www/html/index.php
		lxc file push ./conf/exemplos/1.php $1/var/www/html/1.php
	else
		echo "Sintaxe: install-apache-php.sh nome-do-container"
fi
