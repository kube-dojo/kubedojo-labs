## Node Resource Pressure

When a node runs low on resources, Kubernetes applies taints and may evict pods. Understanding resource allocation helps prevent issues.

### Task

1. Check current resource usage on the node using `kubectl top`
2. Examine the node's capacity vs allocatable resources
3. List all pods and their resource requests/limits, save to `/root/resource-report.txt`

```bash
# Install metrics-server if not available (kubectl top requires it)
kubectl top nodes 2>/dev/null || echo "metrics-server not available"

# Check capacity vs allocatable
echo "=== Capacity ===" > /root/resource-report.txt
kubectl get node -o jsonpath='{range .items[*]}Capacity: CPU={.status.capacity.cpu} Memory={.status.capacity.memory}{"\n"}Allocatable: CPU={.status.allocatable.cpu} Memory={.status.allocatable.memory}{"\n"}{end}' >> /root/resource-report.txt

# Check resource requests from running pods
echo "" >> /root/resource-report.txt
echo "=== Pod Resource Requests ===" >> /root/resource-report.txt
kubectl get pods --all-namespaces -o jsonpath='{range .items[*]}{.metadata.namespace}/{.metadata.name}: CPU={.spec.containers[0].resources.requests.cpu} Memory={.spec.containers[0].resources.requests.memory}{"\n"}{end}' >> /root/resource-report.txt

# Check for any taints that might prevent scheduling
echo "" >> /root/resource-report.txt
echo "=== Node Taints ===" >> /root/resource-report.txt
kubectl describe node | grep -A5 "Taints:" >> /root/resource-report.txt
```

<details>
<summary>Hint: Resource pressure handling</summary>

When pressure is detected:
- **DiskPressure**: kubelet evicts pods to free disk
- **MemoryPressure**: kubelet evicts pods based on QoS class (BestEffort first)
- **PIDPressure**: too many processes

Check eviction thresholds:
```bash
grep -i eviction /var/lib/kubelet/config.yaml
```
</details>
