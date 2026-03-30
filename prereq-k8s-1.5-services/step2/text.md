## Step 2: Test Service Connectivity

Let's prove the service actually works by sending traffic to it.

### Get the service ClusterIP

```bash
kubectl get svc web-svc -o jsonpath='{.spec.clusterIP}'
```

### Curl from inside the cluster

Since ClusterIP is only reachable from within the cluster, you can curl directly from the node (which is part of the cluster):

```bash
CLUSTER_IP=$(kubectl get svc web-svc -o jsonpath='{.spec.clusterIP}')
curl -s $CLUSTER_IP
```

You should see the nginx welcome page HTML.

### Use the DNS name

Kubernetes creates DNS entries for every service. From inside a pod, you could reach this service at:

- `web-svc` (same namespace)
- `web-svc.default` (explicit namespace)
- `web-svc.default.svc.cluster.local` (fully qualified)

### Your task

Curl the `web-svc` ClusterIP and save the response to:

```
/root/curl-output.txt
```

<details>
<summary>Hint</summary>

```bash
CLUSTER_IP=$(kubectl get svc web-svc -o jsonpath='{.spec.clusterIP}')
curl -s --retry 5 --retry-delay 2 --retry-connrefused $CLUSTER_IP > /root/curl-output.txt
```
</details>
