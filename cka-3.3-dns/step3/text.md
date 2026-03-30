## DNS Debugging

When DNS resolution fails, you need systematic debugging tools. The `dnsutils` image provides `dig` and `nslookup`, and you can check CoreDNS logs for errors.

### Task

1. Deploy a DNS debugging pod named `dnsutils` in the `frontend` namespace using image `registry.k8s.io/e2e-test-images/agnhost:2.39` with command `sleep 3600`
2. From the pod, run `nslookup kubernetes.default` and save the output to `/root/dns-debug.txt`
3. Check CoreDNS logs for any errors and save the last 20 lines to `/root/coredns-logs.txt`

```bash
# Deploy debug pod
kubectl run dnsutils --image=registry.k8s.io/e2e-test-images/agnhost:2.39 -n frontend -- sleep 3600
kubectl wait --for=condition=Ready pod/dnsutils -n frontend --timeout=60s

# Run DNS lookup from inside the pod
kubectl exec dnsutils -n frontend -- nslookup kubernetes.default > /root/dns-debug.txt

# Get CoreDNS logs
COREDNS_POD=$(kubectl get pods -n kube-system -l k8s-app=kube-dns -o jsonpath='{.items[0].metadata.name}')
kubectl logs $COREDNS_POD -n kube-system --tail=20 > /root/coredns-logs.txt
```

<details>
<summary>Hint: Common DNS debugging steps</summary>

1. Check if CoreDNS pods are running: `kubectl get pods -n kube-system -l k8s-app=kube-dns`
2. Check CoreDNS service: `kubectl get svc kube-dns -n kube-system`
3. Verify pod DNS config: `kubectl exec <pod> -- cat /etc/resolv.conf`
4. Test resolution: `kubectl exec <pod> -- nslookup kubernetes.default`
5. Check logs: `kubectl logs -n kube-system -l k8s-app=kube-dns`
</details>
