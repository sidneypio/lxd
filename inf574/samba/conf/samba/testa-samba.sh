#!/bin/bash

echo "Verificando DNS"
host -t A inf500.org
host -t SRV _kerberos._udp.inf500.org
host -t SRV _ldap._tcp.inf500.org

echo "Verificando kerberos"
kinit administrator@INF500.ORG
klist

