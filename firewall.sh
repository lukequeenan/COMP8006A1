#Clear any existing filter rules before setting ours
iptables --flush

#Set default policy to drop - DONE
iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP

#Create custom chains for keeping track of www and ssh traffic
iptables --new-chain sshTraffic
iptables --new-chain wwwTraffic 

#Allow DNS traffic on all adaptors - DONE
iptables --append OUTPUT --protocol udp --dport 53 --sport 1024:65535 -j ACCEPT
iptables --append INPUT --protocol udp --sport 53 --dport 1024:65535 -j ACCEPT

#Allow DHCP traffic on all adaptors - DONE
iptables --append INPUT --protocol udp --dport 67:68 --sport 67:68 -j ACCEPT

#Permit inbound and outbound ssh - DONE
iptables --append INPUT --protocol tcp --dport 22 -j ACCEPT
iptables --append OUTPUT --protocol tcp --sport 22 -j ACCEPT

#Permit inbound and outbound http and https - DONE
iptables --append INPUT --protocol tcp -m multiport --sports 80,443 -j ACCEPT
iptables --append OUTPUT --protocol tcp -m multiport --dports 80,443 -j ACCEPT

#Drop inbound traffic to port 80 from ports less than 1024 - DONE
iptables --append INPUT --protocol tcp --dport 80 --sport 0:1023 -j DROP

#Drop all incoming packets from port 0 as well as inbound traffic to port 0
iptables --append INPUT --protocol tcp -m multiport --ports 0 -j DROP

#Keep track of www and ssh traffic versus the rest of the traffic on the system
