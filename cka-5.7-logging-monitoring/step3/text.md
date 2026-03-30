## Resource Usage Monitoring

Monitoring CPU and memory usage helps identify performance issues and right-size resource requests and limits.

### Task

1. Install the metrics-server (if not already present)
2. Check node and pod resource usage with `kubectl top`
3. Save resource usage to `/root/resource-usage.txt`

```bash
# Install metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
# Patch for single-node cluster (disable TLS verification)
kubectl patch deployment metrics-server -n kube-system --type='json' -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'

# Wait for metrics-server
kubectl wait --for=condition=Ready pod -l k8s-app=metrics-server -n kube-system --timeout=120s

# Give metrics time to be collected
sleep 30

# Check node usage
kubectl top nodes

# Check pod usage
kubectl top pods -n practice
kubectl top pods --all-namespaces --sort-by=memory | head -10

# Save results
echo "=== Node Resource Usage ===" > /root/resource-usage.txt
kubectl top nodes >> /root/resource-usage.txt 2>&1
echo "" >> /root/resource-usage.txt
echo "=== Pod Resource Usage (practice) ===" >> /root/resource-usage.txt
kubectl top pods -n practice >> /root/resource-usage.txt 2>&1
echo "" >> /root/resource-usage.txt
echo "=== Top Memory Consumers ===" >> /root/resource-usage.txt
kubectl top pods --all-namespaces --sort-by=memory >> /root/resource-usage.txt 2>&1
```

<details>
<summary>Hint: Node-level monitoring</summary>

Even without metrics-server, you can check resource usage on the node:
```bash
# CPU and memory
free -h
top -bn1 | head -5
df -h

# Container-level
crictl stats
```
</details>
