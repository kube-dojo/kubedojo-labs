#!/bin/bash
# Solution: Create firewall rules
# Flush existing rules
iptables -F INPUT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Save rules
iptables -L -n > /root/firewall-rules.txt
cat /root/firewall-rules.txt
