## Headless Services

A headless service (with `clusterIP: None`) does not allocate a cluster IP. Instead, DNS returns the individual pod IPs directly. This is essential for StatefulSets where clients need to reach specific pods.

### Task

1. Create a StatefulSet named `db` with **3** replicas using image `nginx:1.25` in the `practice` namespace
2. Create a headless service named `db-headless` that selects pods with label `app=db` and has `clusterIP: None`
3. Verify DNS resolution returns individual pod IPs

```bash
# After creating the StatefulSet and headless service, test DNS
kubectl run dns-test --image=busybox:1.36 --rm -it --restart=Never -n practice -- nslookup db-headless.practice.svc.cluster.local
```

<details>
<summary>Hint: Headless service with StatefulSet</summary>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: db-headless
  namespace: practice
spec:
  clusterIP: None
  selector:
    app: db
  ports:
  - port: 80
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
  namespace: practice
spec:
  serviceName: db-headless
  replicas: 3
  selector:
    matchLabels:
      app: db
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
```
</details>
