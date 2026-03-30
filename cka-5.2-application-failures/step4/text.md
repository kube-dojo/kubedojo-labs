## Fix Failing Readiness Probe

The pod `readiness-pod` is Running but not Ready because the readiness probe checks port 8080, while nginx listens on port 80. The service `readiness-svc` has no endpoints.

### Task

1. Diagnose the readiness failure
2. Fix the pod so the readiness probe checks the correct port (80)
3. Verify the service has endpoints after the fix

```bash
# Diagnose
kubectl get pod readiness-pod -n practice
kubectl describe pod readiness-pod -n practice | grep -A10 "Readiness"
kubectl get endpoints readiness-svc -n practice
# Note: endpoints will be empty because the pod is not Ready
```

<details>
<summary>Hint: Fixing readiness probe</summary>

```bash
kubectl delete pod readiness-pod -n practice
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: readiness-pod
  namespace: practice
  labels:
    app: readiness-test
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
    readinessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 5
EOF
```
</details>
