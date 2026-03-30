## Liveness and Readiness Probes

- **Liveness probes** detect if a container is dead-locked or stuck — kubelet restarts the container
- **Readiness probes** detect if a container is ready to serve traffic — controls endpoint inclusion

### Task

Create a pod named `probe-pod` in the `practice` namespace with:

- Image: `nginx:1.25`
- Container name: `nginx`
- **Liveness probe**: HTTP GET on port 80, path `/`, initial delay 5s, period 10s
- **Readiness probe**: HTTP GET on port 80, path `/`, initial delay 3s, period 5s

Verify the pod is Running **and** Ready:

```bash
kubectl get pod probe-pod -n practice
kubectl describe pod probe-pod -n practice | grep -A5 "Liveness\|Readiness"
```

<details>
<summary>Hint: Probe configuration</summary>

```yaml
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
    livenessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 10
    readinessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 3
      periodSeconds: 5
```

Refer to: https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/
</details>
