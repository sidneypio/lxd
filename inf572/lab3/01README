Topologia com um roteador interligando duas redes (rede A e rede B).
Os endereços são alocados estaticamente, exceto na máquina A2 que:
- recebe a configuração IPv4 através de um servidor DHCP ligado na rede A e 
- recebe a configuração IPv6 através do radvd instalado em R 

Além disso, temos o script install-apache-php.sh que instala um servidor apache integrado com php.


Ambiente gerado:

   A1 ----------------------+---------------------- R ---------------------- B1
      eth0                  |                 eth1    eth2                     eth0
      10.10.10.10           |         10.10.10.100    10.10.20.100             10.10.20.10 
      2001:db8:1970:A::10   | 2001:db8:1970:A::100    2001:db8:1970:B::100     2001:db8:1970:B::10
                            |
   A2 ----------------------+
      eth0                  |
      10.10.10.20 (via DHCP)|
      IPv6 via radvd        |
                            |
                            |
   DHCP --------------------+
      eth0          
      10.10.10.200
