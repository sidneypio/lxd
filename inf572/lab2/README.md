Topologia com um roteador interligando duas redes (rede A e rede B).
Os endereços são alocados estaticamente, exceto na máquina A2 que recebe a configuração IPv4 através de
um servidor DHCP ligado na rede A e o endereço IPv6 alocado estaticamente

Ambiente gerado:
```
   A1 ----------------------+---------------------- R ---------------------------------------------- B1
      eth0                  |                 eth1    eth2                     eth0
      10.10.10.10           |         10.10.10.100    10.10.20.100             10.10.20.10 
      2001:db8:2018:A::10   | 2001:db8:2018:A::100    2001:db8:2018:B::100     2001:db8:2018:B::10
                            |
   A2 ----------------------+
      eth0                  |
      IPv4: (via DHCP)      |
      IPv6: (via DHCPv6)    |
                            |
                            |
   DHCP --------------------+
      eth0          
      10.10.10.200
```
