## StatefulSet Basics

StatefulSets manage stateful applications. Each pod gets a stable, unique name (e.g., `web-0`, `web-1`, `web-2`) and pods are created in order.

### Task

1. First, create a headless service (required by StatefulSets):
   ```bash
   kubectl create service clusterip sts-svc --clusterip="None" --tcp=80:80 -n practice
   ```

2. Create a StatefulSet named `web-sts` in the `practice` namespace with:
   - Replicas: `3`
   - Service name: `sts-svc`
   - Image: `nginx:1.25`
   - Container name: `nginx`

3. Verify pods are created with ordered names:
   ```bash
   kubectl get pods -n practice -l app=web-sts
   ```

You should see `web-sts-0`, `web-sts-1`, `web-sts-2`.

<details>
<summary>Hint: StatefulSet spec</summary>

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web-sts
  namespace: practice
spec:
  serviceName: "sts-svc"
  replicas: 3
  selector:
    matchLabels:
      app: web-sts
  template:
    metadata:
      labels:
        app: web-sts
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
```
</details>
