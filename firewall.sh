#Clear any existing filter rules before setting ours
iptables --flush

#Set default policy to drop - DONE
iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP

#Allow DNS traffic on all adaptors - DONE
iptables --append OUTPUT --protocol udp --dport 53 --sport 1024:65535 -j ACCEPT
iptables --append INPUT --protocol udp --sport 53 --dport 1024:65535 -j ACCEPT

#Allow DHCP traffic on all adaptors - DONE
iptables --append INPUT --protocol udp --dport 67:68 --sport 67:68 -j ACCEPT

#Permit inbound and outbound ssh - DONE
iptables --append INPUT --protocol tcp --dport 22 -j ACCEPT
iptables --append OUTPUT --protocol tcp --sport 22 -j ACCEPT

#Permit inbound and outbound www
iptables --append INPUT --protocol tcp --dport 80 -j ACCEPT

#Drop inbound traffic to port 80 from ports less than 1024

#Drop all incoming packets from reserved port 0 as well as inbound traffic to
#port 0

#Keep track of www and ssh traffic versus the rest of the traffic on the system
