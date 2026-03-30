#!/bin/bash
iptables -L -n -v > /root/iptables-before.txt 2>&1

cat > /root/iptables-rules.txt << 'RULES'
# Allow established and related connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT

# Allow SSH from anywhere
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow K8s API server
iptables -A INPUT -p tcp --dport 6443 -j ACCEPT

# Allow kubelet from local network only
iptables -A INPUT -p tcp --dport 10250 -s 10.0.0.0/8 -j ACCEPT

# Allow etcd from local network only
iptables -A INPUT -p tcp --dport 2379:2380 -s 10.0.0.0/8 -j ACCEPT

# Allow scheduler and controller-manager from localhost only
iptables -A INPUT -p tcp --dport 10259 -s 127.0.0.1 -j ACCEPT
iptables -A INPUT -p tcp --dport 10257 -s 127.0.0.1 -j ACCEPT

# Drop all other input
iptables -A INPUT -j DROP
RULES

cat > /root/firewall-best-practices.txt << 'BEST'
1. Default deny all inbound traffic, then allow only required ports
2. Restrict kubelet and etcd ports to cluster-internal CIDR only
3. Allow API server from management networks and load balancers only
4. Use cloud security groups or firewall rules in addition to host iptables
5. Monitor and log dropped packets for intrusion detection
6. Regularly audit firewall rules for stale or overly permissive entries
BEST
