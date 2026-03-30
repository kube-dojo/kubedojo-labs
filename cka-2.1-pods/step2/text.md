## Init Containers

Init containers run **before** the main containers start. They are commonly used to wait for dependencies, run setup tasks, or pre-populate volumes.

### Task

Create a pod named `init-pod` in the `practice` namespace with:

1. An **init container** named `wait-for-svc` (image: `busybox:1.36`) that waits for a service called `myservice` to be resolvable via DNS:
   ```
   until nslookup myservice.practice.svc.cluster.local; do echo waiting; sleep 2; done
   ```
2. A **main container** named `app` (image: `nginx:1.25`)

After creating the pod, observe that it stays in `Init:0/1` state. Then create the service to unblock it:

```bash
kubectl create service clusterip myservice --tcp=80:80 -n practice
```

Wait for the pod to become Running.

<details>
<summary>Hint: Init container spec</summary>

Init containers go in `spec.initContainers[]`, separate from `spec.containers[]`:

```yaml
spec:
  initContainers:
  - name: wait-for-svc
    image: busybox:1.36
    command: ['sh', '-c', 'until nslookup myservice.practice.svc.cluster.local; do echo waiting; sleep 2; done']
  containers:
  - name: app
    image: nginx:1.25
```
</details>
