#!/bin/bash
kubectl get pods -n investigation -o wide > /root/pod-list.txt 2>&1

# Wait for suspicious-pod to be ready
for i in $(seq 1 15); do
  kubectl get pod suspicious-pod -n investigation &>/dev/null && break
  sleep 2
done

kubectl exec suspicious-pod -n investigation -- ps aux > /root/processes.txt 2>&1 || echo "Cannot exec into pod (may not exist or not running)" > /root/processes.txt
kubectl exec suspicious-pod -n investigation -- ls -la /tmp/ > /root/suspicious-files.txt 2>&1 || echo "Cannot list /tmp (pod may not be accessible)" > /root/suspicious-files.txt
kubectl exec suspicious-pod -n investigation -- ss -tlnp > /root/network-connections.txt 2>&1 || \
  kubectl exec suspicious-pod -n investigation -- netstat -tlnp > /root/network-connections.txt 2>&1 || \
  echo "Cannot check network connections" > /root/network-connections.txt
