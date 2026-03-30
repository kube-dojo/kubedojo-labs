## CNI Troubleshooting

When the CNI plugin fails, pods get stuck in `ContainerCreating` state. Common issues include missing binaries, misconfigured IPAM, and wrong CIDR ranges.

### Task

1. Create a pod named `network-test` using `nginx:1.25` in the `practice` namespace and verify it gets an IP address
2. Examine the pod's network namespace details
3. Save the pod's IP address to `/root/pod-ip.txt`

```bash
# Create a test pod
kubectl run network-test --image=nginx:1.25 -n practice
kubectl wait --for=condition=Ready pod/network-test -n practice --timeout=60s

# Get the pod IP
kubectl get pod network-test -n practice -o wide

# Save the IP
kubectl get pod network-test -n practice -o jsonpath='{.status.podIP}' > /root/pod-ip.txt

# Check the network namespace (from the node)
CONTAINER_ID=$(crictl ps --name network-test -q 2>/dev/null | head -1)
if [ -n "$CONTAINER_ID" ]; then
  crictl inspect $CONTAINER_ID | grep -A5 "namespaces" | head -10
fi
```

Verify that the pod IP is within the expected CIDR range:

```bash
POD_IP=$(cat /root/pod-ip.txt)
NODE_CIDR=$(kubectl get node -o jsonpath='{.items[0].spec.podCIDR}')
echo "Pod IP: $POD_IP"
echo "Node CIDR: $NODE_CIDR"
```

<details>
<summary>Hint: CNI troubleshooting steps</summary>

If pods are stuck in ContainerCreating:
1. `kubectl describe pod <name>` — check events for CNI errors
2. `journalctl -u kubelet | grep cni` — check kubelet logs
3. `ls /opt/cni/bin/` — verify binaries exist
4. `ls /etc/cni/net.d/` — verify config exists
5. Check CNI pod logs in kube-system
</details>
