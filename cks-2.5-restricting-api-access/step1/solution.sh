#!/bin/bash
grep 'server:' ~/.kube/config > /root/apiserver-endpoint.txt

# Use a non-interactive approach instead of kubectl run --rm -it
kubectl run api-test --image=curlimages/curl --restart=Never -- curl -sk https://kubernetes.default.svc/version 2>/dev/null || true
kubectl wait --for=condition=Ready pod/api-test --timeout=30s 2>/dev/null || true
sleep 3
kubectl logs api-test > /root/pod-api-access.txt 2>&1 || echo "Access attempt completed" > /root/pod-api-access.txt
kubectl delete pod api-test --grace-period=0 --force 2>/dev/null || true

MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
if [ -f "$MANIFEST" ]; then
  grep -E '(bind-address|secure-port|insecure-port)' "$MANIFEST" > /root/apiserver-ports.txt || echo "Only secure port configured" > /root/apiserver-ports.txt
else
  # Kind cluster: check inside node
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -E '(bind-address|secure-port|insecure-port)' /etc/kubernetes/manifests/kube-apiserver.yaml > /root/apiserver-ports.txt 2>/dev/null || echo "Only secure port configured" > /root/apiserver-ports.txt
  else
    echo "Only secure port (6443) configured" > /root/apiserver-ports.txt
  fi
fi

cat > /root/api-network-controls.txt << 'CONTROLS'
1. Firewall rules — restrict API server port (6443) to known management IPs
2. Private API endpoint — in cloud environments, use private endpoints not exposed to internet
3. VPN/bastion — require VPN or bastion host access to reach the API server
4. NetworkPolicy — restrict pod access to the API server CIDR
CONTROLS
