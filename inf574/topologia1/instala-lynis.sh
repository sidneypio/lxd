#!/bin/bash
# instala o lynis na maquina passada como argumento

# verifica o numero de argumentos 
if [ "$#" -ne 1 ]; then
    echo "Eh necessario indicar como argumento o nome da maquina"
    echo "./instala-lynis.sh maquina"
    echo ""
    echo "Por exemplo, ./instala-lynis.sh A1"
else
    echo "Instalando o git na máquina " $1
    lxc exec $1 -- /usr/bin/apt install -y git
    echo "Instalando lynis usando git"
    lxc exec $1 -- git clone https://github.com/CISOfy/lynis.git
    echo "fim"
fi
