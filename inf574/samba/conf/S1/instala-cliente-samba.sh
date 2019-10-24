#!/bin/bash

echo "Instalando pacotes"
apt -y install winbind libpam-winbind libnss-winbind krb5-config resolvconf

echo " "
echo "Verificando diferenças dos arquivos de configuracao"
diff hosts /etc/hosts
diff smb.conf  /etc/samba/smb.conf
diff nsswitch.conf /etc/nsswitch.conf
diff common-session /etc/pam.d/common-session
diff interfaces-possamba /etc/network/interfaces


echo "Pressione ENTER para realizar a copia dos arquivos..."
read

echo "Copiando arquivos de configuracao"
cp hosts /etc/hosts
cp smb.conf  /etc/samba/smb.conf
cp nsswitch.conf /etc/nsswitch.conf
cp common-session /etc/pam.d/common-session
cp interfaces-possamba /etc/network/interfaces

echo " "
echo "Arquivos copiados. Proximos passos:"
echo "- Reinicialize o container (reboot)"
echo "- Junte-se ao dominio: net ads join -U Administrator"
echo "- Mais um reboot para o winbind inicializar"
echo "- Para testar, verifique o winbind rodando com o comando ps -ef"
echo "- E depois teste com o wbinfo -u"

