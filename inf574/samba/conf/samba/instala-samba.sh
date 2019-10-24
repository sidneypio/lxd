#!/bin/bash
#
echo "Instalando pacotes"
apt -y install samba krb5-user winbind smbclient ldap-utils acl attr ntp

echo "Parando o samba e zerando o arquivo de configuracao"
systemctl stop smbd nmbd winbind
systemctl disable smbd nmbd winbind
systemctl mask smbd nmbd winbind
systemctl unmask samba-ad-dc
systemctl enable samba-ad-dc
mv /etc/samba/smb.conf /etc/samba/smb.conf-original

echo "Provisionando"
#samba-tool domain provision --use-rfc2307 --interactive
samba-tool domain provision \
    --use-rfc2307 \
    --server-role=dc \
    --dns-backend=SAMBA_INTERNAL \
    --realm="INF500.ORG" \
    --domain="INF500" \
    --adminpass="inf500@2019"

echo "Ajustando kerberos"
cp /var/lib/samba/private/krb5.conf /etc/krb5.conf

echo "Ajustando resolv.conf"
sed -i s/"8.8.8.8"/"10.10.10.40"/g /etc/resolv.conf 

echo "Inicializando"
systemctl start samba-ad-dc


