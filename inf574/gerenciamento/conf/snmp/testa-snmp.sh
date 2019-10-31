#!/bin/bash

echo "Executando exemplos de consultas via snmpwalk"
echo ""
echo "Exemplo 1"
snmpwalk -c public -v 2c 10.10.20.10 

echo ""
echo "Pressione ENTER para continuar..."
read

echo "Exemplo 2"
snmpwalk -c public -v 2c 10.10.20.10 

echo ""
echo "Pressione ENTER para continuar..."
read