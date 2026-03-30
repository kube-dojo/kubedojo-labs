## Service Discovery Patterns

Kubernetes DNS provides several ways to discover services. You can use short names within the same namespace, or FQDNs for cross-namespace access.

### Task

1. From a pod in the `frontend` namespace, resolve the `api` service in the `backend` namespace using the FQDN
2. Save the DNS resolution results to `/root/dns-results.txt`
3. Create a service named `cross-ns-test` in the `frontend` namespace of type ExternalName pointing to `api.backend.svc.cluster.local`

```bash
# Test cross-namespace DNS resolution
kubectl run dns-test --image=busybox:1.36 --rm -it --restart=Never -n frontend -- nslookup api.backend.svc.cluster.local

# Save results
kubectl run dns-test2 --image=busybox:1.36 --rm -it --restart=Never -n frontend -- nslookup api.backend.svc.cluster.local > /root/dns-results.txt 2>&1
```

Then create the ExternalName service for cross-namespace shortcut:

```bash
kubectl create service externalname cross-ns-test --external-name=api.backend.svc.cluster.local -n frontend
```

<details>
<summary>Hint: DNS naming patterns</summary>

- Same namespace: `<service-name>` (e.g., `web`)
- Cross namespace: `<service-name>.<namespace>` (e.g., `api.backend`)
- FQDN: `<service-name>.<namespace>.svc.cluster.local`
- Pod DNS: `<pod-ip-dashed>.<namespace>.pod.cluster.local`
</details>
