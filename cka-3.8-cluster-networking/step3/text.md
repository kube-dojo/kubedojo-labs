## iptables Rules and kube-proxy

kube-proxy watches the Kubernetes API for Service and Endpoint changes and programs iptables rules to implement service routing.

### Task

1. Check the kube-proxy mode (iptables or IPVS)
2. Examine the iptables rules for the `web` service
3. Save the relevant KUBE-SVC chain rules to `/root/iptables-rules.txt`

```bash
# Check kube-proxy mode
kubectl get configmap kube-proxy -n kube-system -o yaml | grep mode

# Check kube-proxy logs
kubectl logs -n kube-system -l k8s-app=kube-proxy --tail=10

# Get the ClusterIP
SVC_IP=$(kubectl get svc web -n practice -o jsonpath='{.spec.clusterIP}')

# List iptables rules related to the service
iptables -t nat -L KUBE-SERVICES -n | grep $SVC_IP

# Find the specific chain and trace the full path
CHAIN=$(iptables -t nat -L KUBE-SERVICES -n | grep $SVC_IP | awk '{print $1}')
iptables -t nat -L $CHAIN -n 2>/dev/null

# Save rules
iptables -t nat -L -n | grep -A5 "web" > /root/iptables-rules.txt 2>/dev/null
```

<details>
<summary>Hint: Understanding iptables service routing</summary>

The flow through iptables for a ClusterIP service:
1. `KUBE-SERVICES` — matches the ClusterIP:port, jumps to `KUBE-SVC-xxxx`
2. `KUBE-SVC-xxxx` — randomly selects a backend using probability rules
3. `KUBE-SEP-xxxx` — DNATs to the actual pod IP:port

```bash
# Trace the full chain
iptables -t nat -L KUBE-SERVICES -n -v | grep $SVC_IP
```
</details>
