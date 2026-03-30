#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: log-collector
  namespace: practice
spec:
  selector:
    matchLabels:
      app: log-collector
  template:
    metadata:
      labels:
        app: log-collector
    spec:
      tolerations:
      - key: node-role.kubernetes.io/control-plane
        operator: Exists
        effect: NoSchedule
      containers:
      - name: fluentd
        image: fluentd:v1.16-1
EOF

# Wait for DaemonSet pods to be ready
for i in $(seq 1 30); do
  DESIRED=$(kubectl get daemonset log-collector -n practice -o jsonpath='{.status.desiredNumberScheduled}' 2>/dev/null)
  AVAILABLE=$(kubectl get daemonset log-collector -n practice -o jsonpath='{.status.numberAvailable}' 2>/dev/null)
  [ -n "$DESIRED" ] && [ "$DESIRED" -gt 0 ] && [ "$DESIRED" = "$AVAILABLE" ] && break
  sleep 2
done
