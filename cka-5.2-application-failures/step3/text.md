## Fix OOMKilled

The pod `oom-pod` is being killed because it tries to allocate 200MB of memory but has a limit of only 50Mi.

### Task

1. Diagnose the OOMKilled status
2. Fix the pod by increasing the memory limit to **256Mi**

```bash
# Diagnose
kubectl get pod oom-pod -n practice
kubectl describe pod oom-pod -n practice | grep -A5 "Last State"
# Look for: "OOMKilled" in the reason field
```

<details>
<summary>Hint: Fixing OOMKilled</summary>

Delete and recreate with adequate memory:

```bash
kubectl delete pod oom-pod -n practice
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: oom-pod
  namespace: practice
spec:
  containers:
  - name: stress
    image: polinux/stress:latest
    command: ["stress"]
    args: ["--vm", "1", "--vm-bytes", "200M", "--vm-hang", "1"]
    resources:
      limits:
        memory: "256Mi"
      requests:
        memory: "256Mi"
EOF
```
</details>
