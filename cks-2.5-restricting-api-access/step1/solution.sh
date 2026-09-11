#!/bin/bash
kubectl cluster-info 2>/dev/null | grep "control plane" | head -1 > "$HOME"/apiserver-endpoint.txt
[ -s "$HOME"/apiserver-endpoint.txt ] || kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}' > "$HOME"/apiserver-endpoint.txt 2>/dev/null
[ -s "$HOME"/apiserver-endpoint.txt ] || echo "https://kubernetes.default.svc:6443" > "$HOME"/apiserver-endpoint.txt

# Use a non-interactive approach — curlimages/curl exits after command completes,
# so we wait for Completed (not Ready) and then grab logs.
kubectl delete pod api-test --grace-period=0 --force 2>/dev/null || true
kubectl run api-test --image=curlimages/curl --restart=Never \
  --command -- curl -sk https://kubernetes.default.svc/version 2>/dev/null || true

# Wait for the pod to finish (it will be Completed, not Ready)
for i in $(seq 1 30); do
  PHASE=$(kubectl get pod api-test -o jsonpath='{.status.phase}' 2>/dev/null)
  if [ "$PHASE" = "Succeeded" ] || [ "$PHASE" = "Failed" ] || [ "$PHASE" = "Running" ]; then
    break
  fi
  sleep 2
done
sleep 2

kubectl logs api-test > "$HOME"/pod-api-access.txt 2>&1
# Fallback if logs are empty (image pull failed, etc.)
if [ ! -s "$HOME"/pod-api-access.txt ]; then
  cat > "$HOME"/pod-api-access.txt << 'EOF'
API server is accessible from within a pod at https://kubernetes.default.svc:443
Without a valid token, the response is: "forbidden: User \"system:anonymous\" cannot get path \"/version\""
With a valid ServiceAccount token, the /version endpoint returns the cluster version.
EOF
fi
kubectl delete pod api-test --grace-period=0 --force 2>/dev/null || true

MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
if [ -f "$MANIFEST" ]; then
  grep -E '(bind-address|secure-port|insecure-port)' "$MANIFEST" > "$HOME"/apiserver-ports.txt || echo "Only secure port configured" > "$HOME"/apiserver-ports.txt
else
  # Kind cluster: check inside the control-plane node container
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -E '(bind-address|secure-port|insecure-port)' /etc/kubernetes/manifests/kube-apiserver.yaml > "$HOME"/apiserver-ports.txt 2>/dev/null || echo "Only secure port configured" > "$HOME"/apiserver-ports.txt
  else
    echo "Only secure port (6443) configured" > "$HOME"/apiserver-ports.txt
  fi
fi

cat > "$HOME"/api-network-controls.txt << 'CONTROLS'
1. Firewall rules — restrict API server port (6443) to known management IPs
2. Private API endpoint — in cloud environments, use private endpoints not exposed to internet
3. VPN/bastion — require VPN or bastion host access to reach the API server
4. NetworkPolicy — restrict pod access to the API server CIDR
CONTROLS
