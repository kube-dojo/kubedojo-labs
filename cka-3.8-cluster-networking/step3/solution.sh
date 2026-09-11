#!/bin/bash
SVC_IP=$(kubectl get svc web -n practice -o jsonpath='{.spec.clusterIP}')
echo "=== Service ClusterIP: $SVC_IP ===" > "$HOME"/iptables-rules.txt
echo "" >> "$HOME"/iptables-rules.txt
echo "=== KUBE-SERVICES entries ===" >> "$HOME"/iptables-rules.txt
sudo iptables -t nat -L KUBE-SERVICES -n | grep "$SVC_IP" >> "$HOME"/iptables-rules.txt 2>/dev/null
echo "" >> "$HOME"/iptables-rules.txt
echo "=== Full NAT rules matching web ===" >> "$HOME"/iptables-rules.txt
sudo iptables -t nat -L -n | grep -A5 "web" >> "$HOME"/iptables-rules.txt 2>/dev/null
cat "$HOME"/iptables-rules.txt
