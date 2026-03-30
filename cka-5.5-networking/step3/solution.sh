#!/bin/bash
POD_A_IP=$(kubectl get pod pod-a -n practice -o jsonpath='{.status.podIP}')
kubectl expose pod pod-a -n practice --port=80 2>/dev/null || true
sleep 3
echo "Direct IP test: $POD_A_IP" > /root/connectivity.txt
kubectl exec pod-b -n practice -- wget -qO- --timeout=3 http://$POD_A_IP >> /root/connectivity.txt 2>&1
echo "---" >> /root/connectivity.txt
echo "Service test:" >> /root/connectivity.txt
kubectl exec pod-b -n practice -- wget -qO- --timeout=3 http://pod-a >> /root/connectivity.txt 2>&1
cat /root/connectivity.txt | head -10
