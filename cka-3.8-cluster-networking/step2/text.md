## Pod-to-Service Communication

Services provide a stable virtual IP (ClusterIP) that load-balances traffic across backend pods. kube-proxy programs the node's networking rules to make this work.

### Task

1. Get the ClusterIP of the `web` service
2. From the `client` pod, access the service by ClusterIP, short name, and FQDN
3. Save the service ClusterIP to `/root/service-ip.txt`

```bash
# Get the service ClusterIP
kubectl get svc web -n practice

# Save it
kubectl get svc web -n practice -o jsonpath='{.spec.clusterIP}' > /root/service-ip.txt

# Test all three access methods from the client pod
SVC_IP=$(cat /root/service-ip.txt)

# Method 1: Direct ClusterIP
kubectl exec client -n practice -- wget -qO- --timeout=3 http://$SVC_IP

# Method 2: Short service name (same namespace)
kubectl exec client -n practice -- wget -qO- --timeout=3 http://web

# Method 3: FQDN
kubectl exec client -n practice -- wget -qO- --timeout=3 http://web.practice.svc.cluster.local
```

<details>
<summary>Hint: Service resolution flow</summary>

1. Pod sends request to `web` -> `/etc/resolv.conf` appends `practice.svc.cluster.local`
2. CoreDNS resolves `web.practice.svc.cluster.local` to the ClusterIP
3. kube-proxy's iptables rules DNAT the ClusterIP to a backend pod IP
4. Response returns via conntrack
</details>
