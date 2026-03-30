## Diagnose Pod Connectivity

Verify that pods in the same namespace can communicate directly via IP and through services.

### Task

1. Get the IP of `pod-a` and test connectivity from `pod-b`
2. Create a service for `pod-a` and test service-level connectivity
3. Save the connectivity test results to `/root/connectivity.txt`

```bash
# Get pod-a IP
POD_A_IP=$(kubectl get pod pod-a -n practice -o jsonpath='{.status.podIP}')

# Test direct pod-to-pod
kubectl exec pod-b -n practice -- wget -qO- --timeout=3 http://$POD_A_IP

# Create a service for pod-a
kubectl expose pod pod-a -n practice --port=80

# Test service-level connectivity
kubectl exec pod-b -n practice -- wget -qO- --timeout=3 http://pod-a.practice.svc.cluster.local

# Save results
echo "Direct IP test: $POD_A_IP" > /root/connectivity.txt
kubectl exec pod-b -n practice -- wget -qO- --timeout=3 http://$POD_A_IP >> /root/connectivity.txt 2>&1
echo "---" >> /root/connectivity.txt
echo "Service test:" >> /root/connectivity.txt
kubectl exec pod-b -n practice -- wget -qO- --timeout=3 http://pod-a >> /root/connectivity.txt 2>&1
```

<details>
<summary>Hint: Connectivity debugging</summary>

```bash
# Check if pod-a is listening on port 80
kubectl exec pod-a -n practice -- ss -tlnp

# Check from pod-b
kubectl exec pod-b -n practice -- ping -c2 $POD_A_IP
kubectl exec pod-b -n practice -- wget -qO- --timeout=3 http://$POD_A_IP
```
</details>
