#!/bin/bash
kubectl get pods -n practice -l app=web -o jsonpath='{range .items[*]}{.status.podIP}{"\n"}{end}' > "$HOME"/pod-ips.txt
for ip in $(cat "$HOME"/pod-ips.txt); do
  echo "Testing $ip..."
  kubectl exec client -n practice -- wget -qO- --timeout=3 http://$ip 2>/dev/null | head -3
done
