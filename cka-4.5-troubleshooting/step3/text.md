## Fix Mount Failure — Wrong PVC Name

The pod `broken-mount-pod` cannot start because it references a PVC named `wrong-pvc-name` which does not exist. The correct PVC is `correct-pvc`.

### Task

1. Diagnose the pod failure
2. Fix the pod by deleting it and recreating it with the correct PVC name

```bash
# Diagnose
kubectl get pod broken-mount-pod -n practice
kubectl describe pod broken-mount-pod -n practice
# Look for: "persistentvolumeclaim "wrong-pvc-name" not found"
```

<details>
<summary>Hint: Fix the PVC reference</summary>

```bash
kubectl delete pod broken-mount-pod -n practice
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: broken-mount-pod
  namespace: practice
spec:
  containers:
  - name: app
    image: nginx:1.25
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: correct-pvc
EOF
```
</details>
