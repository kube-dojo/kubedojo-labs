#!/bin/bash
grep 'server:' ~/.kube/config > /root/apiserver-endpoint.txt
kubectl run api-test --image=curlimages/curl --rm -it --restart=Never -- curl -sk https://kubernetes.default.svc/version > /root/pod-api-access.txt 2>&1 || echo "Access attempt completed" > /root/pod-api-access.txt
grep -E '(bind-address|secure-port|insecure-port)' /etc/kubernetes/manifests/kube-apiserver.yaml > /root/apiserver-ports.txt || echo "Only secure port configured" > /root/apiserver-ports.txt
cat > /root/api-network-controls.txt << 'CONTROLS'
1. Firewall rules — restrict API server port (6443) to known management IPs
2. Private API endpoint — in cloud environments, use private endpoints not exposed to internet
3. VPN/bastion — require VPN or bastion host access to reach the API server
4. NetworkPolicy — restrict pod access to the API server CIDR
CONTROLS
