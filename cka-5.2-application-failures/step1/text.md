## Fix CrashLoopBackOff

The pod `crash-pod` is stuck in CrashLoopBackOff because its command exits with code 1.

### Task

1. Diagnose the issue by checking logs and pod description
2. Fix the pod so its container runs a command that keeps it alive

```bash
# Diagnose
kubectl get pod crash-pod -n practice
kubectl logs crash-pod -n practice
kubectl describe pod crash-pod -n practice | grep -A3 "Last State"
```

Delete the pod and recreate it with a command that runs indefinitely (e.g., `sleep 3600`).

<details>
<summary>Hint: Fixing CrashLoopBackOff</summary>

```bash
kubectl delete pod crash-pod -n practice
kubectl run crash-pod --image=busybox:1.36 -n practice -- sleep 3600
```

Or use YAML:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: crash-pod
  namespace: practice
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["/bin/sh", "-c", "sleep 3600"]
```
</details>
