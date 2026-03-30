#!/bin/bash
# DNAT for external traffic
iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to-destination 127.0.0.1:80

# DNAT for local traffic (same host)
iptables -t nat -A OUTPUT -p tcp --dport 8080 -j DNAT --to-destination 127.0.0.1:80
