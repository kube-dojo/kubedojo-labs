#!/bin/bash
SVC_IP=$(kubectl get svc web -n practice -o jsonpath='{.spec.clusterIP}')
echo "=== Service ClusterIP: $SVC_IP ===" > /root/iptables-rules.txt
echo "" >> /root/iptables-rules.txt
echo "=== KUBE-SERVICES entries ===" >> /root/iptables-rules.txt
iptables -t nat -L KUBE-SERVICES -n | grep "$SVC_IP" >> /root/iptables-rules.txt 2>/dev/null
echo "" >> /root/iptables-rules.txt
echo "=== Full NAT rules matching web ===" >> /root/iptables-rules.txt
iptables -t nat -L -n | grep -A5 "web" >> /root/iptables-rules.txt 2>/dev/null
cat /root/iptables-rules.txt
