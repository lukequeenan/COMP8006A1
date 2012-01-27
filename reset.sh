#Clear all filters
iptables --flush --delete-chain

#Set everything to allow again
iptables --policy INPUT ACCEPT
iptables --policy FORWARD ACCEPT
iptables --policy OUTPUT ACCEPT

