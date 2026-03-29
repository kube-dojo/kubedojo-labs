## Step 1: Expose a Deployment with ClusterIP

A **ClusterIP** service is the default type. It gives your pods a stable internal IP that other pods in the cluster can reach.

### See what's running

The setup created a `web` deployment with 2 nginx replicas:

```bash
kubectl get deployment web
kubectl get pods -l app=web
```

### How services work

Without a service, you'd need to know each pod's IP — and those change every time a pod restarts. A service provides:

- A **stable IP** (ClusterIP) that never changes
- A **DNS name** (e.g., `web-svc.default.svc.cluster.local`)
- **Load balancing** across all matching pods

### Expose with kubectl

```bash
kubectl expose deployment web --name=web-svc --port=80 --target-port=80
```

This creates a ClusterIP service that:
- Listens on port **80**
- Forwards to port **80** on the pods
- Selects pods with label `app=web`

### Verify

```bash
kubectl get svc web-svc
```

You should see `TYPE: ClusterIP` and a `CLUSTER-IP` address.

### Your task

If you followed along, the service already exists. If not, create a ClusterIP service named `web-svc` that exposes the `web` deployment on port 80.

<details>
<summary>Hint</summary>

```bash
kubectl expose deployment web --name=web-svc --port=80 --target-port=80
```

Verify:

```bash
kubectl get svc web-svc
```
</details>
