#!/bin/bash
kubectl get svc web -n practice -o jsonpath='{.spec.clusterIP}' > "$HOME"/service-ip.txt
SVC_IP=$(cat "$HOME"/service-ip.txt)
echo "=== ClusterIP access ==="
kubectl exec client -n practice -- wget -qO- --timeout=3 http://$SVC_IP 2>/dev/null | head -3
echo "=== Short name access ==="
kubectl exec client -n practice -- wget -qO- --timeout=3 http://web 2>/dev/null | head -3
echo "=== FQDN access ==="
kubectl exec client -n practice -- wget -qO- --timeout=3 http://web.practice.svc.cluster.local 2>/dev/null | head -3
