#!/bin/bash
kubectl get pods -n investigation -o wide > "$HOME"/pod-list.txt 2>&1

# Wait for suspicious-pod to be ready
for i in $(seq 1 15); do
  kubectl get pod suspicious-pod -n investigation &>/dev/null && break
  sleep 2
done

kubectl exec suspicious-pod -n investigation -- ps aux > "$HOME"/processes.txt 2>&1 || echo "Cannot exec into pod (may not exist or not running)" > "$HOME"/processes.txt
kubectl exec suspicious-pod -n investigation -- ls -la /tmp/ > "$HOME"/suspicious-files.txt 2>&1 || echo "Cannot list /tmp (pod may not be accessible)" > "$HOME"/suspicious-files.txt
kubectl exec suspicious-pod -n investigation -- ss -tlnp > "$HOME"/network-connections.txt 2>&1 || \
  kubectl exec suspicious-pod -n investigation -- netstat -tlnp > "$HOME"/network-connections.txt 2>&1 || \
  echo "Cannot check network connections" > "$HOME"/network-connections.txt
