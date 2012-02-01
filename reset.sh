#Clear all filters
echo "Flushing filters and deleting user chains"
iptables --flush 
iptables --delete-chain

#Set everything to allow again
echo "Setting default policy to ALLOW"
iptables --policy INPUT ACCEPT
iptables --policy FORWARD ACCEPT
iptables --policy OUTPUT ACCEPT

