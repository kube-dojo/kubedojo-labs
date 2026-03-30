#!/bin/bash
cat > /root/metadata-endpoints.txt << 'ENDPOINTS'
AWS: 169.254.169.254
GCP: metadata.google.internal (169.254.169.254)
Azure: 169.254.169.254
ENDPOINTS
kubectl exec test-pod -n metadata-lab -- curl -s --connect-timeout 3 http://169.254.169.254/ > /root/metadata-test-before.txt 2>&1 || echo "Connection timeout (expected in non-cloud)" > /root/metadata-test-before.txt
kubectl get pod test-pod -n metadata-lab -o jsonpath='{.spec.nodeName}' > /root/pod-node.txt
