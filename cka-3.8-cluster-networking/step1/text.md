## Pod-to-Pod Communication

In Kubernetes, every pod gets its own IP address, and pods can communicate directly without NAT.

### Task

1. Get the IP addresses of all `web` deployment pods
2. From the `client` pod, curl each web pod's IP directly
3. Save the list of pod IPs to `/root/pod-ips.txt`

```bash
# Get pod IPs
kubectl get pods -n practice -l app=web -o wide

# Save IPs to file
kubectl get pods -n practice -l app=web -o jsonpath='{range .items[*]}{.status.podIP}{"\n"}{end}' > /root/pod-ips.txt

# Test direct pod-to-pod communication
for ip in $(cat /root/pod-ips.txt); do
  echo "Testing $ip..."
  kubectl exec client -n practice -- wget -qO- --timeout=3 http://$ip
done
```

Examine the network interfaces:

```bash
# Check the client pod's network config
kubectl exec client -n practice -- ip addr
kubectl exec client -n practice -- ip route
kubectl exec client -n practice -- cat /etc/resolv.conf
```

<details>
<summary>Hint: Pod networking fundamentals</summary>

- Each pod gets a unique IP from the pod CIDR
- Pods on the same node communicate via a virtual bridge
- Pods on different nodes communicate via the CNI overlay/underlay
- No NAT is needed for pod-to-pod communication
</details>
