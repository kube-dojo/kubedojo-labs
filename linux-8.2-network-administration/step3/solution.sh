#!/bin/bash
# Solution: Create firewall rules
# Flush existing rules
sudo iptables -F INPUT

# Allow loopback
sudo iptables -A INPUT -i lo -j ACCEPT

# Allow established connections
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Save rules
sudo iptables -L -n > "$HOME"/firewall-rules.txt
cat "$HOME"/firewall-rules.txt
