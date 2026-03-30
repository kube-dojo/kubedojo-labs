#!/bin/bash
kubectl get pods -n investigation -o wide > /root/pod-list.txt
kubectl exec suspicious-pod -n investigation -- ps aux > /root/processes.txt 2>&1 || echo "Cannot exec" > /root/processes.txt
kubectl exec suspicious-pod -n investigation -- ls -la /tmp/ > /root/suspicious-files.txt 2>&1 || echo "Cannot list" > /root/suspicious-files.txt
kubectl exec suspicious-pod -n investigation -- ss -tlnp > /root/network-connections.txt 2>&1 || kubectl exec suspicious-pod -n investigation -- netstat -tlnp > /root/network-connections.txt 2>&1 || echo "Cannot check network" > /root/network-connections.txt
