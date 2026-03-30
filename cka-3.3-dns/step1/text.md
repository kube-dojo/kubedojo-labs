## CoreDNS Configuration

CoreDNS is the default DNS server in Kubernetes. Its configuration is stored in a ConfigMap named `coredns` in the `kube-system` namespace.

### Task

1. View the CoreDNS ConfigMap and understand the Corefile structure
2. Add a custom DNS entry by adding a `hosts` plugin block to forward `custom.example.com` to `1.2.3.4`
3. Restart the CoreDNS pods to pick up the change

```bash
# View the current CoreDNS ConfigMap
kubectl get configmap coredns -n kube-system -o yaml

# View CoreDNS pods
kubectl get pods -n kube-system -l k8s-app=kube-dns
```

Edit the ConfigMap to add a `hosts` block inside the main server block (before the `ready` line):

```
hosts {
    1.2.3.4 custom.example.com
    fallthrough
}
```

Then restart CoreDNS:

```bash
kubectl rollout restart deployment coredns -n kube-system
kubectl rollout status deployment coredns -n kube-system
```

<details>
<summary>Hint: Editing CoreDNS ConfigMap</summary>

```bash
kubectl edit configmap coredns -n kube-system
```

The Corefile should look like:
```
.:53 {
    errors
    health {
       lameduck 5s
    }
    hosts {
        1.2.3.4 custom.example.com
        fallthrough
    }
    ready
    kubernetes cluster.local in-addr.arpa ip6.arpa {
       ...
    }
    ...
}
```
</details>
