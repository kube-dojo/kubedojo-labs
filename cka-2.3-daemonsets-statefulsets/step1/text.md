## DaemonSet — One Pod Per Node

A DaemonSet ensures that a copy of a pod runs on every node (or a subset of nodes). Common uses include log collectors, monitoring agents, and network plugins.

### Task

Create a DaemonSet named `log-collector` in the `practice` namespace with:

- Image: `fluentd:v1.16-1`
- Container name: `fluentd`
- Labels: `app: log-collector`

```bash
# There is no kubectl create daemonset shortcut, so write the YAML manually
cat > /root/daemonset.yaml << 'EOF'
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
      # Add tolerations to schedule on control-plane nodes too
      tolerations:
      - key: node-role.kubernetes.io/control-plane
        operator: Exists
        effect: NoSchedule
      containers:
      - name: fluentd
        image: fluentd:v1.16-1
EOF
```

Apply and verify:
```bash
kubectl apply -f /root/daemonset.yaml
kubectl get daemonset log-collector -n practice
```

<details>
<summary>Hint: DaemonSet desired vs available</summary>

`kubectl get ds log-collector -n practice` shows DESIRED, CURRENT, READY, and AVAILABLE columns. DESIRED should equal the number of nodes, and AVAILABLE should match DESIRED when all pods are running.
</details>
