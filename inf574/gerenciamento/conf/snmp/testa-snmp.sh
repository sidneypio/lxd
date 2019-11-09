#!/bin/bash

echo "Executando exemplo de consultas via snmpwalk"
echo ""
echo "Exemplo 1"
snmpwalk -c public -v 2c 10.10.20.10 

