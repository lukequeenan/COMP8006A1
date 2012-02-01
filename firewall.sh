#Clear any existing filter rules before setting ours
iptables --flush

#Set default policy to drop - DONE
iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP

#Create custom chains for keeping track of www and ssh traffic - DONE
iptables --new-chain sshIn
iptables --new-chain sshOut
iptables --new-chain wwwIn
iptables --new-chain wwwOut

#Drop all incoming packets from port 0 and inbound traffic to port 0 - DONE
iptables --append INPUT --protocol tcp -m multiport --ports 0 -j DROP

#Drop inbound traffic to port 80 from ports less than 1024 - DONE
iptables --append INPUT --protocol tcp --dport 80 --sport 0:1023 -j DROP

#Allow DNS traffic on all adaptors - DONE
iptables --append OUTPUT --protocol udp --dport 53 --sport 1024:65535 -j ACCEPT
iptables --append INPUT --protocol udp --sport 53 --dport 1024:65535 -j ACCEPT

#Allow DHCP traffic on all adaptors - DONE
iptables --append INPUT --protocol udp --dport 67:68 --sport 67:68 -j ACCEPT

#Send www and ssh traffic to custom chains - DONE
iptables --append INPUT --protocol tcp --dport 22 -j sshIn
iptables --append OUTPUT --protocol tcp --sport 22 -j sshOut
iptables --append INPUT --protocol tcp -m multiport --sports 80,443 -j wwwIn
iptables --append OUTPUT --protocol tcp -m multiport --dports 80,443 -j wwwOut

#Permit inbound and outbound ssh - DONE
iptables --append sshIn --protocol tcp --dport 22 -j ACCEPT
iptables --append sshOut --protocol tcp --sport 22 -j ACCEPT

#Permit inbound and outbound http and https - DONE
iptables --append wwwIn --protocol tcp -m multiport --sports 80,443 -j ACCEPT
iptables --append wwwOut --protocol tcp -m multiport --dports 80,443 -j ACCEPT




